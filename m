Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5F23741
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636060; cv=none; b=mCGfht0ZAUzRgKoX2orXVVbRQWzdJLUBuuuiuzxx1hqJFoQYyKTGoUeM5H4b7/P89r6VUIl8CdztxEsrfdfb2Lg3RQxDLpwRBaUIAgpcVYEi9u4sanTq856VIqS+bO497KvobR15dO9+61drwISxmo7BnXEi/pP5dEegmOjwcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636060; c=relaxed/simple;
	bh=LiZjkWOkPd8Jxq5ZHWlwyFvRF83rzpyMCntJG5MyHXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0gn/ttKDPJ5FtaSfWSqc6X5Nt0p5khgzCe9i3Sh14IHjrl9jj0P90zgt6X+8hWlJwaQJtLAiQwnwTsnIiNa9PXwjU/KkgiQIZUYWEOZuJdm0ifEUYa3wAhV//H7/ykRjqkTYZ8kfCNvwoc5LvsV/BKH8yoGe54403At+7Qe5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=STf16tyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isQvEF9U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="STf16tyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isQvEF9U"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D9E9A1140134;
	Thu,  2 May 2024 03:47:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 May 2024 03:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714636057; x=1714722457; bh=LiZjkWOkPd
	8Jxq5ZHWlwyFvRF83rzpyMCntJG5MyHXs=; b=STf16tylNxP5C9DV898OM4TkQ2
	E9bhhQVcrwsqWr9uozrSD/fg3zXwzolg7EL/PmAQ2gGZEQuNyn85eJgVDmbRheOw
	/MrMjv3EAbYl1OERqcSQKHfP2STrfqSRC87MD75+6lWV7NPv+a+CHwFDL7zilsZ2
	JpLcOE5AU/6S2H32/nAhVo1AMITPHWGYuIyJtGavIhsPExIX/8pBzigSI9dRI71T
	ZtamID6V+ZEKYdbmf6R1WVWP8wXsma475XO0Yqpm12bS3AE/t9tX0aDzjXiNTno6
	PlXNNjDo2vDwajviHLPSSJgXpNAnlMqLb8TpBX8faux7pUGOSHZYplWrfl+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714636057; x=1714722457; bh=LiZjkWOkPd8Jxq5ZHWlwyFvRF83r
	zpyMCntJG5MyHXs=; b=isQvEF9UTRT4t2hEoZ7wU4BXTHw9ZdCt+MdrXMkFwjwn
	califmrVN9mKi3vDd4o9sY8Os2Mh3DdS8Sw0vpGUlI+Ad2i0vLCJH8TW1dYtu+Wl
	kwLJj0K1iARtXXQ6DM27cYca8c0W7Be/DGYU0Udvdtpi6d9hVMqqlcc11zEJwm4Y
	uRwUwvBv6NGo29AAgA84YD3rI9EiGghWl6jodTFc5XlYMpV7VhDvQ9HWuQ7OKUkK
	kc5ndlSggC5GNMBmsww/pCxan91gqG/U7wkYcBd7vMvST118QF+VjQgarVgzd2ih
	XYtPfuMpP0X0wCeEQ38PGdu3jTSKinbEUv6lFkQY1A==
X-ME-Sender: <xms:GUUzZq4kgAxRJO0QL_R2lT2JOMfrQBjpBHOwumA9oKoIZ5oHik6YAQ>
    <xme:GUUzZj4O4m_-rIjItEbD-tuEHa_Fsf0zHE42PLlM4e2E4JyFfywPa9AOeeep6Kw3e
    ONeyyW25S5cwiA5mQ>
X-ME-Received: <xmr:GUUzZpcclJiR3LlO7X3-kftJDKBv9URWc3nkm16uMzr67qGT7ksIPOPBEeKsH1yKJnSfrZPr-gNQVo78M3e8f6mhVYc3u8_YdgEs5FB5sb08XfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:GUUzZnJC15rfnmumIq8b8EQo7CuseUFmGTyxIT_LiBwdUCOnaGpcFA>
    <xmx:GUUzZuJ6tayfEWzRoQY7fYEFkLHpBM56W41BgMB4DdLZnEGFh8fXJA>
    <xmx:GUUzZoz66lpaYRDnbm1On13hz0TDCdE_-tRBAct00Q63HgzrvBQnng>
    <xmx:GUUzZiIH1KbhCRV_CQHI_ODjjTy5XAo52ZNRnM06jIcfOS1Uw6e3SQ>
    <xmx:GUUzZjGYnqxxeyp94lBZhuYWFGxSpZEOVn_ghkfANok-01f2o2NsJibD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 03:47:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be6346ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 07:47:11 +0000 (UTC)
Date: Thu, 2 May 2024 09:47:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 6/7] refs: rename `refs_create_symref()` to
 `refs_update_symref()`
Message-ID: <ZjNFFreAkolYMCd_@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-7-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GjPCsohqlEnH/4db"
Content-Disposition: inline
In-Reply-To: <20240501202229.2695774-7-knayak@gitlab.com>


--GjPCsohqlEnH/4db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:22:28PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The `refs_create_symref()` function is used to update/create a symref.
> But it doesn't check the old target of the symref, if existing. It force
> updates the symref. In this regard, the name `refs_create_symref()` is a
> bit misleading. So let's rename it to `refs_update_symref()`. This is
> akin to how 'git-update-ref(1)' also allows us to create apart from
> update.

Arguably, as we are already updating all callsites anyway, I don't see a
reason why we shouldn't also update the function to accept the old OID
or old target so that callers can make raceless updates.

The only problem is that we don't have any users yet, and consequently
we have no way to verify that it works as intended. So maybe this is
better left for a future patch series, unless we have places where we
can reasonably update the callers to pass in the old value, as well.

Patrick

--GjPCsohqlEnH/4db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzRRUACgkQVbJhu7ck
PpSqTw//cTD3+wT1azX4RH8s81BceObMEvT5GWu90TM+DH4qt/LtJFxD3KycGw0X
HwhQsIMvP0pOF8OrqGt9M9O8C6U56B4LpR+JGxsh17ID2pOjWXtU0OHfO0+AtAgB
ecF3DTEIzMyz5LR7mJ1h6G46Xs3v0NZ0rrQZBLZElivxctHz9sD8R+T3FdRyxZGV
ZiBemWT7CwwqXwoepiGSw68QOD9kKOnXxSnXMc09rkV/r2WmP0dcXBt6x/z7ZCAK
Ty7XNdpv5BXzSvTtvK8WyQN1GqurwGjBWimuMukArn8aGFGsO/6fqUxzENnyeMZB
azXSVD9Esaa3U6QwhdhEE2FPmSEf4DZjysy/lEuuROya4lHY377fcd0g3rUmhLf+
BTZWXt+23u3M4sOsOJ3PPFnLckRWcadx125MZclJXurq4Mpjf/9JBGQ72vzL69qI
0dcITB7yG5YtT5B3J1ubWs/zEA01CGULm0CKq94AfDl/vyIegWP+y/Tn8t9sESB5
Ii1uoxuMY6ZpSm788Ep0noZxZHd/fRUtDK4Fe8/sVJzDdMu77lQ0gYtfU9jhxUJX
d55D8gyAO0EevaEF38RlAKD0oA0US6s4xP46xLrKmgCR0TW6IW8MnNI4LD5PpI22
d3fIVBapMYd4Kk10XhsSzm/7uhzTPYjLbkjml4anTDGeugxaxuI=
=PU51
-----END PGP SIGNATURE-----

--GjPCsohqlEnH/4db--
