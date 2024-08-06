Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DC1BC089
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924811; cv=none; b=owWLANqdaOlk/+50tKsKOk2ISZm+0B5w65OWPbhZtsZ9X8BEytCXBQxwzkQv4wlbo8Ehq8ToljV7dNkugswQcYAuH3OC3+fJJlceG2JHX/3vyP95U+NhbwHg+DNwjn0DUJRcjWOLiyRqUkIRCEKCiKmn0oyAuYIUArRROsGRHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924811; c=relaxed/simple;
	bh=h7OK9vumTUWVC+CCqeaKI4UokHXXvC0JqmSfnDAsO7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+e/TRkhpumi1h2FmWwfxE7Gll+QzbIjgvfQZQJqaLkQ5Sa+jXWfltTrJr8fC//ZTGBk+sltPUlUs1PGezT/9s1R8K6ju/f/bwQ6IjsP9tCJtjYrIDDXJVlFuYpPekpa2DUIJeEcMs/+wLIl69TMMFsKfqQvXOz2XnWBzI4NoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SdHiwry1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEXiCHH6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SdHiwry1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEXiCHH6"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A64C114FBCB;
	Tue,  6 Aug 2024 02:13:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 02:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722924807; x=1723011207; bh=Wr0OfYXnbb
	9Es54fcrHXFn9s8T6+C+83lJmakroe5So=; b=SdHiwry1g+9LHGEdT0V9Pl45oV
	R8A9niMcszOoglwrJhVcsP4ZoRtblZuzrspw2ZFohbds3uXurdFf4g9DhI0+r0eF
	YVfBuiKAMNLt80yzgyjKWRi/Raz2Tyj8nrq9zsrKCMGYgyfsx2IMZ4m5C+YcCbWj
	oYAxUPShCLakjGrWM7UqzR+0P5t5F5Tbs9R/A5CCFlqIu0o7S+F2UaJ4XCWKJ4OO
	lKpyELvWntDWlKB2i2qCle8CQoSMOr2q1rO0WYrZCItGjpqD//Cxda+1TY/IGJ5Q
	l07d/tJw+YCB8QD3zzyv5m5GqxSNMkc5E7GtRLg5SfFCxLZzKGY0fp5CwMfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722924807; x=1723011207; bh=Wr0OfYXnbb9Es54fcrHXFn9s8T6+
	C+83lJmakroe5So=; b=AEXiCHH6490pECZWCNahzIxoGjMei4gVF6NDzBYpaEDh
	0TNwxxd//5sbpodrOBXRNLYY0Lnpg/74pqVGYTYwERLEdJ/EHLSMzlYcat/ll3b1
	/f/NgsKIWBzTToBkcaOfl5exWee6OC3ZFZoYl5zNoxBArCg//b4wjhlynfvWR0uG
	1Oz03HP6IynxPvpiqsyGWmQpDl3nlhj0ZqlB/bPkT07b58FC5zCgbuzTF0RMkviR
	SV0wCKHJGaQyBjHSosGg+yrvtbiWdzm/0KGk8US5sjFgOsNtkDN8K7liNy96dHd/
	MahyKagyBdlQ2CCKjy+82UueYUjfMx5Os6bjF2Hs1Q==
X-ME-Sender: <xms:B7-xZpTsjvkoP_iWJNvKLA0PqbflsRv8c9txSkz5mcKb-YespYjS-w>
    <xme:B7-xZizPzWJwA3gsqhnbfnfTYlSwWS3zGLetomuIDjr0vdUTATebbpXXFKXpudZv7
    e9z_L9TJCiNarnHuQ>
X-ME-Received: <xmr:B7-xZu0VsxXs2VtI3dTnB47hxl_aQfTexZ9UZ_ATsl_fNik_V26UZcQJq8DzPq_Kyt34VpcwESgnecGcjKAbW8yfs9nsJAdZRVZaQSjNPJwu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:B7-xZhCwUiRrGdqtIa38AnuY1A44WTA4scxhT2loug2uCiKCkIgDZg>
    <xmx:B7-xZigbZywMDhOIsGD4_vcUCsT67cLJNEqAk_ube9sdoFwH5oSKcQ>
    <xmx:B7-xZlocE8TnH3aJyyUscVbYDBmnBdyz0yIbDHH3qdB3ATU05w1YOw>
    <xmx:B7-xZth_MUkPapLPvNDj0QPG8kdDnVFm31MC4N06002cYe3dBWvvvw>
    <xmx:B7-xZltlu0QAGO3fpZ7sFa5V_7nwkNWYFTLa2fy2fz_LdGiCH_-t6dNg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:13:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 425add86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:13:23 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:13:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/4] refs: avoid "too many arguments"
Message-ID: <ZrG_A3UQk56aYJ_m@tanuki>
References: <20240806003539.3292562-1-gitster@pobox.com>
 <20240806003539.3292562-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7eNDGHNIEW56jMrz"
Content-Disposition: inline
In-Reply-To: <20240806003539.3292562-2-gitster@pobox.com>


--7eNDGHNIEW56jMrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2024 at 05:35:36PM -0700, Junio C Hamano wrote:
> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
> index f7c0783d30..b32e740001 100755
> --- a/t/t1460-refs-migrate.sh
> +++ b/t/t1460-refs-migrate.sh
> @@ -31,9 +31,10 @@ test_expect_success "superfluous arguments" '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	test_must_fail git -C repo refs migrate foo 2>err &&
> -	cat >expect <<-EOF &&
> -	usage: too many arguments
> -	EOF
> +	{
> +		printf "fatal: unknown argument: ${SQ}foo${SQ}\n\n" &&
> +		( git -C repo refs migrate -h || : )
> +	} >expect &&

I always have to wonder how helpful it really is to print the usage
information in such a context. I feel that it is too distracting because
in many cases, we end up printing dozens of lines of options that drown
out the single line of information that the user actually cares for,
namely why the command has failed.

In this case here it is somewhat manageable, because only 4/5th of the
output are unnecessary noise. But the picture changes as commands grow
more options over time, making the output less and less usable.

So while I think that it is a big improvement to explicitly point out
the unknown argument, I think it is step backwards to also print the
usage info.

Patrick

--7eNDGHNIEW56jMrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxvwIACgkQVbJhu7ck
PpS1aA//TnJebQKIqv8VnmO5ELdbUZTY4FC8P8/LM0KxDbdYtwkM0VrWKirMdpnQ
MLL2gp92QS3GkjTJupdEbxzGND/3ZTvAVHsg+KowoLiOH88hoSEmo+Mp8QGPNmiA
/0zrm8q4p2CgZre99YDoEtoy/0GmzaCl342nhQO0fw1/KKUPY+oGP8nrsqJWo9xR
XikOkpktax65d3zi8K+3TB1exoTEBVcA1l+JcwnURV9VTaal45hpCEDV7DLx17Mj
K3MxifKb7sICqOC5KV/eAbS+H4zYVM2WXpHMtflNviPXlZxagUyHKdy5GZCPouvx
zTtQdy1+x10hHz+WJIwYkMDfpsbQL2JLyixwnUF6wO+aTGHXds67XSqwQfFfVbnL
B3Z4A7Yl2yxjeKK5+mhMGHFaK61CMnxOQqKPtiFUPTjybtY+at3EFFMmEXJwpxR2
GUtHYdwVOIJcqw0VjKdFT93r+VW3ym68PBBWzdrM9vnOQ9FM/1hsyXef4dCWO1b1
7GS9u0qik85y+R0errFeyO03z3MX8kXRvGl4ZkFPdT0Lz9/fFoT/4gN3rqMiPPE9
kAOnt6EmuS/l7tiNrhqO+1s1MyOEIumwKmKAThcShfXfNNbJkIJjlY3BTK8jIs4o
F7L0W5UP4hqfPMdkFeCe5+v9wiXGIifTioHKtq687m2vFEXedm0=
=v8FU
-----END PGP SIGNATURE-----

--7eNDGHNIEW56jMrz--
