Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9EE57E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996565; cv=none; b=CQlm60MAJlHAWPcz2BygQuxD2c3LJHcUkf2MigWhaRpVnHXQ0mlkINerOrh7knutC40stXKJfRdSEtyqtxB4wmAiNI2mDqg78f7IfZr+o0dStarQLz6i3UJkdlplZBUmP2fHvcRVpjIsjKaDWklGauB4vsKK3BUmPqW8uSSNqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996565; c=relaxed/simple;
	bh=Rsx5oJKDIUfDV+YVBQn4gfSe98BcDGyxsHCY4Q4F6+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIr+YyCaJ5rHudBKiJmFdzb1wjS/D+xiyAU56qgqADyD97yNYKdY1phYtO7ycpkNul5YYgh0+bfQtyCFrNByivoVQygCJchdl/CCcOZQGj2J4bCqG6rsGX1zgZIB1Zom56ysBX+/y9/cRwWxgvfdYOwaqiHF6ahArgKk0aP9ZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mH0znI20; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t401Lh4a; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mH0znI20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t401Lh4a"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BBB9D114018D;
	Fri, 26 Jul 2024 08:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 08:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996562; x=1722082962; bh=/JpQv8thsO
	kB21aAMPBSpKOCd8lGUZnDzA9s78xioTA=; b=mH0znI20pHx1ZkZIk4iIQ9YoVA
	YebjJKnuRbD8xjmXKnG2fVLRTURLWOfdXZuKFGBesgCYdmqz2pcugMpH4Ogn5csA
	xJcGUwOiQUdWkEDTOpRo0IWuQMyFfjaFkO8bUa3OjplDy5JZx/2lAKqa6byB2uCG
	3QC6oNMsf+AMrUlgDFoVOPVR0WEOz2kWbJ613XuDIopB0PaHotiqDksFa/ptnv8i
	gJa4/01ZKFYwRStgOPWxTfaTVEwMNod5GOhIJevsJPT/LvcFJYAIGH7iIvlolbi3
	mBLhge3jbUvtLxtLm4GIfPqRKJ3f8K7pHM/KpSeyQKA8A9vhNZj1X/mbazKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996562; x=1722082962; bh=/JpQv8thsOkB21aAMPBSpKOCd8lG
	UZnDzA9s78xioTA=; b=t401Lh4aCrH5SU66iL5hXyoiZYPlNIXhx6d1/LgnUwrz
	3ikvtLT7nhf5iWTHbZF/8nU99DNFrNqxWPU61g7D5iENsKctTH+Xi2BP8xPTTayy
	y+RUfATsT7LY5jxmZHDFFeUoFqAkFMue0B6Hkb2tNxOrmq2KWskDsoTCjB9shTU6
	IPM/fw5g2B8srU3AZFtbkiNTPIspFD80tCd819lBS3Q8WdEE0BxvHTw9x1ev683T
	ZPlfMqBOSl+p3+KPBSzWCkH1hIvjFH3CjoElVSTxipxlt49E+lHMZFxoH4HExxkT
	xkG1V1LbF1EC7OXqyDq7o3xC+BCVLJ5rqNqPXu4vEg==
X-ME-Sender: <xms:EpWjZmNfYGrZLAdEtMXk1jrjPD9_m2LnRNVEPhTf0c_lqM0jX5O-0Q>
    <xme:EpWjZk-r9fHumApVb8kOZ__mIby3qBBD-vV2af_YbNmMbuQEkh7fKqFECT-yyUdvu
    9NiVTrWpRsPTYoLKQ>
X-ME-Received: <xmr:EpWjZtRCtyNrxFTz0QKgpXLli1H6PdllCqo79K4EbXWEcSUjQnlipdFuU5dw4KG-ngw7cgAIK3CGWgteAD0XfXDzk8Vo6zv8TqB2U8D5AkUgae3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EpWjZmtYZZMly6ilm8YaQAWWsoN5m4KrnbynYjD3CRidyvByqodW4w>
    <xmx:EpWjZueLflgRkF4zHk35vg0sbsZ6-dzBCynpvLlva-HP-zSkordSzw>
    <xmx:EpWjZq23bSuCQGUPr_3Nwh0Og5BwzYXoT46VzStCsOr86ig_ozmQug>
    <xmx:EpWjZi801txlZL0FMuaUluDIc535M1saTiwwd-ne8O7pCXj91I7W3A>
    <xmx:EpWjZt55wpJHrHhPehvBdvrkoNDLit2sW3UC98hVuv5R2ca0SAetZQ_Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 08:22:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1b47f72d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jul 2024 12:21:20 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:22:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] ReviewingGuidelines: encourage positive reviews more
Message-ID: <ZqOVC_F4fdQUognX@tanuki>
References: <xmqqsevysdaa.fsf@gitster.g>
 <xmqqle1pjwtt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jVCUyjb+dBoyEsBl"
Content-Disposition: inline
In-Reply-To: <xmqqle1pjwtt.fsf@gitster.g>


--jVCUyjb+dBoyEsBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 08:49:34AM -0700, Junio C Hamano wrote:
> I saw some contributors hesitate to give a positive review on
> patches by their coworkers.  When written well, a positive review
> does not have to be a hollow "looks good" that rubber stamps an
> useless approval on a topic that is not interesting to others.
>=20
> Let's add a few paragraphs to encourage positive reviews, which is a
> bit harder to give than a review to point out things to improve.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This version looks good to me (well, the first version already did).
Thanks!

Patrick

--jVCUyjb+dBoyEsBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlQYACgkQVbJhu7ck
PpTfzhAArWa/PxjLK4zxK6gvVo+1VCP5Gou06JOXE6JBsqm3oBvVnwWPDTxqr5Of
DWLnLj3MD0e2VhMvP7ojgYqeWOhbnZRJMuiRL7+yVIACkCRq8vk1no6aQP6DywRi
5WDdtWdxhbh5wPpt1V2V4DlSwjiPayC7Mp1jK00HTKcR6HDS4zvcRyYi2VHyEBpI
upsxZRh67ef27iYxiOWBgXTi7xxFUn2ZAlYMM+YRgI6OEPDdGNy5+1p8ehrdlRvh
Mml6WZRGXmHV54PlmXv+peSTv8XJWGVLJqmOPyTaQfBp0jaWkKaibWNQf9EQ1MKk
S5nhsc5nKCQHlgRZUMjDWLW5ot1cmIfFvUhaDZffooGs+/m5yYLrDjTsOv4J3p1j
o22cVWn65LHCIrfS4GIDxb1Kk/aY7P1WUzdnPK1+8Bib50hhdTR/SxaUVwR+GWbp
kjhgr7dUUioY7yujrexd3F4Wv3XzUFOkZDytp0QydA0qcN7tfFyY8ZskEY9ucjLE
V/bUb59Jf49AiixP2Bde6548qDOpmt9P/FvfDpQ9SXi/KFjyg14XVgJA2KJixdeQ
7/QGtyT+UngmF/9iGdIOa6bUbEgY45lVwGIuI+cKPH0lspZo5wR0+ilc8QjL5pr3
2EodQw02uXvckaD+ap1oVOEEseucPvdVWdWOFc0Sgxm+1NGviQY=
=xtH/
-----END PGP SIGNATURE-----

--jVCUyjb+dBoyEsBl--
