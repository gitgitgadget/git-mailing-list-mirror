Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEC18C332
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574540; cv=none; b=oV+HMn0VIES25BFFAUUGsc5fPTVJgJhYpKaI5wEso5+e0iFkJORVSBWldVAOLnygy2CYC35ksE4Ku7B7NM0aEDdg8Ott3oMHrk8iiJfzIqcZWtSg0mwFxfnM2xx5fHt9WNdA396vQbZqqdUDtBPaLpeX2TPgDduzs4rhtWEFsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574540; c=relaxed/simple;
	bh=isUhiF8/zTb6lJ+e+1Jh/t9XMqMzy/c6fKIzZLUO6nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm6mr/OKBGlmYtR/OWqjz8skgqsWY4TvBfAT/iX7qYaOH+vOiETsVf63F/yomGBIPH2ivcqq2UrwSDeryTZ0IIvHhW1cf+egt98BmBVjFfMir4cVUa27CB9HeeAetK2SHqX3tCzimz4JJO9tCIuqjCgxapYYliVcLM+4DrntFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBumjrA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d12juWEj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBumjrA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d12juWEj"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9F0D6114021C;
	Wed,  5 Jun 2024 04:02:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717574537; x=1717660937; bh=fSid6awieR
	56qe6NWkmAf53aN/eA5TYwbKb5WfR8zeA=; b=IBumjrA4RRIu+s+p3TpyJsZocv
	Apm5wszVjgKOoq2UH9HFcrdZdqXP1ek0pzMfRPnKfSqEK7fntS8z4vZEpqVMbyts
	F0eehBcF6DxgzI3eoavO2Zff6gT52g1PzjBy6Z1wRqh04qirODm//Mr6bvxKwzpL
	aK+agaQKHcmNF0zHA3CvV2DOTyasgpOOIkdb/TK30RruCWKVEBhzvtG2N4m97JtJ
	gl9/4rpm4hOTYSyTi6fWGe9uvR0afM+M2BQHvkTKPbR8/i8KWsBfuPsvdg9hfRma
	of8Vv7Et0Y+Uaiw4HFge+ZSDcyIEFmYmJwoXEkc3iPkq7k/WgOeAtD4bkI3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717574537; x=1717660937; bh=fSid6awieR56qe6NWkmAf53aN/eA
	5TYwbKb5WfR8zeA=; b=d12juWEjpCPOdRRq7UOsK4e+J0Q5n5NRCCrPBecfqcim
	QRPGZq2VoKnH2zlVydIg8Al4FPdoceIv6Bc+zXsegTy5b7GSIjAFpvCAa7sC2bDS
	cTcjzkVI3s2RC9QaUBKI3UReDaljaPWDmKnwcEuZUnbejU3MvteDzRRxruwNA2Vh
	XhGgn65bx46KvAuEBmJeJ1xB+XF0vMCo2+dogFOGumr3DWy5x65uF4G/Zk0OBsH8
	diQhluKQKRjF76dKqlEQScCJg87YG02WV9/v0bkezCFDmfvwDs8a3/pnFSXcvxi4
	+7DglxYVWLa2bJAgDJrka0NlDDGRUYJ2OyIpqPZGpw==
X-ME-Sender: <xms:iRtgZogt0qxmAWBvNbm4k6aek5snV5MP1ysijK_ZhnhodxWxQQp_IQ>
    <xme:iRtgZhCvu5sBO2IiAx1A59_8VuBVHoKDTlupcceIwQy4DpI5WX3i_5PdgFwhhSryo
    ybz-h-VOzTG7MgE7A>
X-ME-Received: <xmr:iRtgZgFCUiidKwswhcbJqKdXgqhlbNm6JU2L7iibC-j1Y8cbYfaQnKuHYts-cW01fwT3JT2Igp-u_AatynMODaQJwRSsgT13Y-rvsVwD4N4-8T31FGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:iRtgZpRsIg5BECvue0SdX-aUaC36HsZsQo9zHVwewzyAGm6Tr4U4gw>
    <xmx:iRtgZlz36J65PS8CLQ2D1b4giDlH92gCDQmhYj9jBUH-GYBHzYBSlg>
    <xmx:iRtgZn6WJEkdkKwF5R5vLCr5dYfdOVF_4Hog4wB1YA3qSLRgnKFH6A>
    <xmx:iRtgZizZjnYcO79z05cZgcTHGr31B_a_QIrWB7VlqML0lYowSsI1EQ>
    <xmx:iRtgZt8NDg_vkrMO5voO6myJr_9va7Z64530AvcjxA9EuEs249575Ne_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 04:02:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 23247860 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 08:01:47 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:02:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 4/6] update-ref: add support for 'symref-create'
 command
Message-ID: <ZmAbhTN0mbGO5t8x@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240530120940.456817-5-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9UcpvuXQ3MvVMp+z"
Content-Disposition: inline
In-Reply-To: <20240530120940.456817-5-knayak@gitlab.com>


--9UcpvuXQ3MvVMp+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 03:09:38PM +0300, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> diff --git a/refs.h b/refs.h
> index a054a4f998..1a58764298 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -708,6 +708,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *new_oid,
> +			   const char *new_target,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);

Here, the `new_target` is in the expected place right next to `new_oid`.

Patrick

--9UcpvuXQ3MvVMp+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZgG4UACgkQVbJhu7ck
PpRlhw//aU/aBiNZptGqKguSMukuXGcnfbBfu1k05ugYmh/FBdSxESIpLVcX6zhU
I83LgelFUZNYatkNrp/pcgVivoLa0rAlhDTswR4Vg706LYqQKtHgRA1P/sFoBb2x
PqQv76S4aXOq/GEeESMJZyZAON19gziccGZvOYu7vDRUe2IiiO2ZDVz9I4aY/gN8
gzH6cv6zxCjJtwYoQcMNDwQD5kxfwv80RxFodeJO/bcMFaYPq5ZktLEjXt9yLTGU
5C2MViEto/Faw6RwbZCo4CmwQP/apYsOruSk50XquwmZKPNCA8PeBJ5Itx8gnfeI
sAKu21C5a56pqHyJwZuTgPKzw8TNoj5FOct9CMBVlOqEjx8zD5CH9Kk25o7BzYsV
sAUfDDkVrZevPXc/nNaosg2poC6ZhD2D4Sk3C/7anyGhTFOOyjLomF/sqv6uRmIW
JlmPrDoJoV59A4C870d7m/9ClubCsHbSHVYEiWI8tEjvHSLttoo4ugwpajDFD6Ev
Itx3FtkzwqnLGzkmwudz1Ty9rgJl4jY7TEm0VmFOaB9MbeJkMz8YwPKDWPXjRWPM
yuNgLM0RMTyF8dh/lNRmHKQ+HFBnW0HD2oomP3JONm2vyCrP/Kjp+EaDTHhUuE9I
flfoMNCB4uZmE6nbJD9nX1tBbZQZh6dm6rRfAtu6GezZr5LmuNk=
=JI1x
-----END PGP SIGNATURE-----

--9UcpvuXQ3MvVMp+z--
