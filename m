Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B614882C
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595650; cv=none; b=GlKhJJxk7ShfXDEKiB7peX1fPu/UacxSLlthCbtU7oACCw7svSCDHrWOOMPyUBC6WwG7ZF36EabUwMTrsM102tgRRAJxPFZVSk0+H+79FAL4QiIi0TmkKxSF5O2pM8qy4DXhQs6ud7KHUSVhFIEUJVFKtD+IAyLSVc0TEoITmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595650; c=relaxed/simple;
	bh=kZmeGP5/CamBVQopjOF1hfk5Wf80T+HApm+x14TrcaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfTSMECdYKnpMzRx51P7u3HvvwHa2OurlkqhPdBgYdaYy6Gun1txsMRedSyLPGP2xKcBfxf4PDud++6xvWoJB2aSD1VhczAGvnWGQVDxGoZM96kX3gQqr7Sqjvv8Wbm4aWl8wE0F+LRT64ggQ9mXKhYSZ62gDv6ztKN094Pz9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s2bSWt9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp5AksuK; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s2bSWt9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp5AksuK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id EA55C1C0012F;
	Mon, 13 May 2024 06:20:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 06:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595647; x=1715682047; bh=kZmeGP5/Ca
	mBVQopjOF1hfk5Wf80T+HApm+x14TrcaY=; b=s2bSWt9qhMShvIbJVjv5QhT0RY
	WIlKPIclVn4vLL+h3dnpt5UcxiEHtwJRBjzTKluBPUj9Ib7MSIUxer6HjCIdGNRQ
	VIDs0dqSTPPFfY8E6ZwoO9JqXHc7LlEQFsmiZNfZ1s8lZVu04ibMz1OoMhqp7p97
	w9ZoEzXcRoxQGLVZN+8yksfJ+uOVx0Jo+kkQ15LBxr9ib3sybazBP/BCcH8p+wVp
	+TVhXTxKlbfvWvJC3kUuRN0t2CtjssFXl6jxXNmY3ZD4Ov9mQtAO3l5tcq0fvGw+
	RG7lgtlLGMBAQrVjNkY9E0e843lHSZhNYevRTWl9lGlC2GWvKnX1FBCRG6xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595647; x=1715682047; bh=kZmeGP5/CamBVQopjOF1hfk5Wf80
	T+HApm+x14TrcaY=; b=dp5AksuKoaRyMG438j+T9QGyrFEfbyXNhbLtAtV6vih0
	dE2aN26SFD1KXGGClvGfVUz7/rhdb+Ypa3g3qywaizHIeMw+83udd5z2GIuKsZjN
	qreu72vmZopBDjjONQxyZgT1PvRgstsL0M2tLr58gPrETxTVwGuRfLKWwQ9Eys/I
	BoROulxVjno9d90pkVCUhqlLTmg1ekZ5l6Uh7SPCqt1nOtIwpOrWhHs/zi4VbW8V
	cnNthvaqX4YgqZSh1bWJ1x/iMTDz+qWq4f5nV9ZE2VKMjO4klqJ0UQTXFAiquu9w
	ipRNFTzKDglFy4C96GU0JZQ/DdkSe4GpNXiF68069Q==
X-ME-Sender: <xms:f-lBZhg-tkleO9oipxvCO-3Atz4E7o-UM84BemLrznzK5Luk3o6Wnw>
    <xme:f-lBZmAceHSsliAQweaGB4bNmPLXw1yii-R977AVD7TMk-boBVdZgQywi6tTUcTfB
    RDVBCBqH6xiY3lQ-Q>
X-ME-Received: <xmr:f-lBZhGtguDqF_R7ohYJhjJjX2J4gyFJAGDjmekl49kToAT-G254Pxy2Hhww1XWM0XF6KAnxpNGB8gYL4qjhJxF7nEspPyNvL7Ksh1ELfiXkcMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:f-lBZmRisI2bcnJ2UhGc-sSM5KCn5-egdEIvZkn1z0uLTbVKnNbcQA>
    <xmx:f-lBZuyA83SL09BR5_TgQ0kgbL-Mbvn-LNkogYFJuS0Zm17WRzAPXg>
    <xmx:f-lBZs6I-JPOPh9h7f_zVqUr6737YA0hexRlFPEjyHCxWvd-EyQG7w>
    <xmx:f-lBZjzlQIAAgKo7pjzddKy3Dtq5u1Oe89BhzAIdwIyXyUYnUvBzcA>
    <xmx:f-lBZp8_XUP5ZbgT0ImkXajNkOr_N90BzVnGsaSZKDfyV1BOg_MxZeg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:20:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc9795aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:20:26 +0000 (UTC)
Date: Mon, 13 May 2024 12:20:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/21] builtin/config: move actions into
 `cmd_config_actions()`
Message-ID: <ZkHpe12KCaBv3AO6@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <2e308393edb0c34593e78603b43bee8d3a45dd8a.1715339393.git.ps@pks.im>
 <CAO_smVjXjW6pM-bWbQmCWxVi8LLZ2iB2p6RYhJhtc529cgDxHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vt6R9Tt1p1b78zEp"
Content-Disposition: inline
In-Reply-To: <CAO_smVjXjW6pM-bWbQmCWxVi8LLZ2iB2p6RYhJhtc529cgDxHA@mail.gmail.com>


--vt6R9Tt1p1b78zEp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 01:42:49PM -0700, Kyle Lippincott wrote:
> On Fri, May 10, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
[snip]
> > -/*
> > - * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
> > - * one line of output and which should therefore be paged.
> > - */
>=20
> We lost this comment when inlining this. Not sure if that was
> intentional (comment deemed to be of low value) or accidental. I think
> as someone unfamiliar with this logic that the comment would be
> helpful to keep - it describes _why_ those items are checked for (vs.
> needing to infer it from the action that's taken when there's a
> match).

It was intentional because I found the comment to be somewhat redundant.
But I can also see that it does provide a bit more context than the code
itself does, so I'll add it back in.

Patrick

--vt6R9Tt1p1b78zEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6XoACgkQVbJhu7ck
PpRM7Q/9F77kEL9PmG/TCq5Iab0HPVnibQ/QTRhNW5BkSnwvADP3Cx0hyAcOMh9/
rFxhCa+ATPMmKhTdrQysXBCiPbgLoWiOD2rXb9B/Pydidi4m7g3TGcfNZGFeT1Q+
+bpaI8Voc/16ij1CrTBIeeNBpjU+ZfR04ICifwdMeJXHdPX8gyKOY+lnq4RRXaoh
DtgKjYtD6K7z+tv+PtgjUKirwjSNnvb/WSkK2q6/RKV5UP4sHuMJSbB9kuxPM1CO
8EHiUB18eESm0LOGHsy7QLBDTBbeZR1LaqUaEvuvsSIl4rP/ngjAYKN9fYj9GbCO
AWq+fUrhWH4Opididqi45WdFSK8KrZFjN93N5EDb7HTcvNL0oiVpclnP5lxM3Phs
qzPIIRN3YZPss8o0BXMsFls5ZWRBAGWJTcVTPc4Vm++Maqq5SXUYWbTh9ZhvLS81
vXpRZSjczf6aAi1M+Nz9R03TsguYCeB/5NIZXINDx7kfWzxxqDK6Cvz16WKXwiAo
JSIjVy6XyZzhbvFL/eBDAgknMpszGFwZ+zd+jWqM3NhElndVAyNM8xSOpvpk7r7l
OOtpqbSCV18x1T4oxVHeZ/5o9nJHT0ws7LAAQj6szrx/qKbu0fJH/e26GdSMUYP1
qWyWnYgdapELed3/+aKwxhBMP3hAB7K0OLwmN4tyt0XxFJITWsA=
=2mDj
-----END PGP SIGNATURE-----

--vt6R9Tt1p1b78zEp--
