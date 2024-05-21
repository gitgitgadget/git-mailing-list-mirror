Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6E4B5CD
	for <git@vger.kernel.org>; Tue, 21 May 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272618; cv=none; b=fObnEGN0UBmy7Hi26f9bIppLmt78jQ0eE6ZAT9nGFw2NyTnsIBG6oQwu+4OAlRhkb0OR6RDA/B3CwMrR7bp3n94kILRwhOsiHmJa1lsE5DfX8I7wW+1uqg0OOlDqgBySUrrx6m5203ZjCptfL9LeGt8oilsqBYqc9V8KJe0AM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272618; c=relaxed/simple;
	bh=hqDA/xMETdEJoUTitVxoUTUdQSdCJalwVMhk8bNZeJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/gM75WOfBj3KLkwFQpN3cTk67goZKimsGMkdD4j0rO8DmAr/FgpbOTOddIj4BsmFgrrC8l0zYWOeFV1GGy58wuQ7IxLTSgiKr+O8QAlHNC7DZuTH0yX5aSiozzzaNWoEMV1QsXrPXDBCjovzKEvDkPhvzp5oVXuIoK1SCAst7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nEbZ9HkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bEA4GTd1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nEbZ9HkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEA4GTd1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5D3EC1380151;
	Tue, 21 May 2024 02:23:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 21 May 2024 02:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716272616; x=1716359016; bh=EiREzL1TZ4
	kG53f9Ftqzz2X/sxp4l9VFUP6P1rsjELc=; b=nEbZ9HkTeKk5Xx7C0IVKIL5gS7
	vkfG7vLotHeeAB1+VCFCYGbjYehXX+hiqX4Z59SnX/VBtPwzu6LaZYt4lepDMU3n
	rnCYJQKlwMd5fyPt5fy2UUhFCpDvrYKRNGf1TCYV2hNciMGYyEJfOjwaMq2F2uGx
	QvuoakqdchZGSnTjQNRr+Pw1o/2YSjMo49teIz0JV4iWm/Qg0RhzK04jD05gXcxc
	SrDyaMZqTEv2mwKM5Hhg1dkwsQSigpESVhGEk7eJX1QZdZe8aZO74bTi6MHwUEsF
	7X66yIzFOPcLqTr9jFEtydfJEFarcFxmF+5Uxy3oP6zj2xeb3ySeZbT3CbBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716272616; x=1716359016; bh=EiREzL1TZ4kG53f9Ftqzz2X/sxp4
	l9VFUP6P1rsjELc=; b=bEA4GTd1KZGtcpQPtGZO6fLTI9oVpe5ZzGmh4/9VzTiA
	jfdDNMGWv2ok7605d8D7Bny/3RLKYZIeRuEPI5yR5oT5ugDMzSAPWg6gjfMPKuja
	cm6rmZ3vILU39O+CjHmtHKEaSxbESjXKoM+WT10z78V1e3+aeep7fiSsVndiGDmi
	P30qDTkgicSeIbKHr+GsVPX0NlLHLSqaxdg58XClIErUG7Bqn8Ih7cT87dMosPbc
	TlF8qXG+kFrplErZJ7GMfEOcsjOghN1rLh8UnSEk8NjLmViqo+za2cII0bAxCJK0
	/pICafktIbKMeCnSdnzJzt4DDa2oh7eAk6VBVcd7zw==
X-ME-Sender: <xms:6D1MZkM0siDkZ2gzhYDPZf3DLWftIj6Wt_7tyJQYlBYnHioyuqZEbA>
    <xme:6D1MZq-OjpZp3kGlnw2F7lcUeY_OVFFh6V5yX9SnU2Dwegwmc4vlIfjt-gJpzcNk5
    146rltKNwvCnuEvow>
X-ME-Received: <xmr:6D1MZrRSmHE17PgwBtseepSJcH8_ZD_h31XAuCa6ARhbSyw8-Z2l9zXxV0967wdl0jF6KVcaEXTcUuN6bKZ7bBe5QD5Uhv6VdHHYX6GiJ5FutEIF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeek
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6D1MZsta_NLe4Mu-Ke6L4H4TYL3G6Jqr9WZ7hDIiSB8XfFioqEON1A>
    <xmx:6D1MZsfObIjulmCMs32v8OcFuG06OCcR0_PzSStVux3uPpueo2fgCg>
    <xmx:6D1MZg1xdYo8TGPd53SGcr3m0D_u4q-W5RDCnf21DnFumiwiTgTCYQ>
    <xmx:6D1MZg9iLGicCI0m3eq38hLGGy7Pn7CYx3QCoFkSyQplSKRzswzfxg>
    <xmx:6D1MZk4L5BlmzuoG70_u9qu5zkHNhl5_woY-NeUSgvcpAmv_hl-Wx-ra>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 02:23:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id db093b29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 06:23:32 +0000 (UTC)
Date: Tue, 21 May 2024 08:23:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: adapt git-config(1) to complete
 subcommands
Message-ID: <Zkw95Ev9DRhCWLq1@tanuki>
References: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
 <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>
 <c48488d1-3135-493d-a9e8-2f787bdd2b4c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EUaBtX7o3GLFrxKy"
Content-Disposition: inline
In-Reply-To: <c48488d1-3135-493d-a9e8-2f787bdd2b4c@gmail.com>


--EUaBtX7o3GLFrxKy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 06:27:54PM +0200, Rub=E9n Justo wrote:
> On Fri, May 17, 2024 at 08:13:36AM +0200, Patrick Steinhardt wrote:
[snip]
> I wonder, if we might consider the possibility of having "list" as
> a default command:
>=20
> -	subcommand=3D"$(__git_find_subcommand "$subcommands")"
> +	subcommand=3D"$(__git_find_subcommand "$subcommands" list)"
>=20
> These lines are only meant to express the idea, as other changes are
> also necessary and the documentation needs to be updated.  Of course, it
> could be done in a future series.
>=20
> I think that "git config -h" is an intuitive enough way to offer the
> help text and that using 'git config' as a shortcut for 'git config
> list' can be convenient.

Hm. I don't really know whether it is sensible to second-guess what the
user wants to do. They may want to list variables, but they may just as
well not want to do that. I myself use tab completion to learn about
which subcommands exist quite often, even though there is `-h` to do
that for me. So I think I lean more towards not having a default
subcommand here.

> By the way, having used '__git_find_subcommand' instead of
> '__git_find_on_cmdline' is reassuring when it comes to having a default
> subcommand :-)
>=20
> Anyway, as I said, this series looks good to me.  Thanks!

Thanks for your review!

Patrick

--EUaBtX7o3GLFrxKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMPeMACgkQVbJhu7ck
PpSk/w//XsqY2LovaHM3MH2MfgeJbU6CGALRdBusSjt6COEwRdcNC8wltlGWJIup
sPa3LFAR5zJ/M8hl3KD5nFVh/DM9PIa1SPZg/zHvvYeFgrNc8k+pEBoF3dLoh6KN
jv8ybBe+YiG35QEDbbjdfO/+RuTgXG9qZ+Sk1Wgb3Jup7XmH4Unf8G/vX6oD4Vwf
cV3xypM/QCoaSMCCoW5OlgspjmnaspIeQ7BpMaytDAWkVGiwZrFYUnfR7i5Eex3j
taa3HcB8QM69vsqwUJcXetUfX54zvM3cB96MQdAt2/OWzedwJ2XlanJd2SPSrgGp
D35dtM1sIz+t77z0GZMbd0Q8UvMrItPVmZQIDDbSEDz8kBhbceN5dtHVxvX1/x2d
1VF+WFBj7Wl11+OMjzEQ3JCrmkt7CKs8mZSc/FxdBb9Trm2eLWqS1lBB2VrE23XN
9btDzlMjA8YLhrdMo9oh4Nl8ZP0xgdfHKpsIoVgc9QXHD2W7VGSBCzZhmrTqBRjX
cD6ri6vhCs+uuI3/M+8U6JeQ3buHgkJBjsFImpTJUz2E5ttKZ9SgvJDQpg/6ezfd
NtNLpV5e5zw+5U6yUEeASjPJ3id+fkuabPpenswud/WV15CRF/MvLC1eO+42UvcP
sfa7LBXFUlYyGQKpziwy6uXwkmqmB8aKr3Wp88OjZT8hkT+LIdk=
=uxV+
-----END PGP SIGNATURE-----

--EUaBtX7o3GLFrxKy--
