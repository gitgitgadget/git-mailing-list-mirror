Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C28F4FA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929586; cv=none; b=j6MdJOLM1HaDv9sQJ8txm/ADz+NbTt0MzcL2lF0o+CXpkvkoJTMYgxApPG2EYQuH7lOEjpuHe97c1UxUM2LOZGMeuU9OLcOWa2p1Lpqb2Z6zgTb8UxFLYrOJo/nCe1mqHCdYmL9CNeWajXH+hQTlB+W4WQdK0HYzR9hgyQgIVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929586; c=relaxed/simple;
	bh=ftnET7EQvCg6uyGMGQ+gOZChrDlQYQQF1xvxlvArCm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcCQJriZ6a8+zbdZL22mcwfNGMbbeJ4y5rlityB+wQxGvbgFECgZ+VbZsP1SWBPqh11rzoYvsX38a9ZIVIvhI0GOq/AoC813RpsnmNn3C6RTTg6dV0p/OVc3A/+I80mgDZiLGgMpoNh0ZdTBWJoR9OV1Kin8JSTbGCwXOA3NTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pCLxTcr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjr6ciKK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pCLxTcr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjr6ciKK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3141C138FC38;
	Tue,  6 Aug 2024 03:33:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 03:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722929584; x=1723015984; bh=WyGSQj0ESK
	e99bjdrFb64uizrZ4m047DRJ1biKfdsFY=; b=pCLxTcr6ep9gLODc60uz0T5LNR
	8anv8vpQRao/2qqSbNbxC0FPOBAdWamp/nx2rTzNFxrVhLCPKNQoKuGhdwD3hHMQ
	943rhyeVyUo89fNMRquYm2dtMmGnWM88Iaw3ZOcT6YNEu6d1sLOz5Mnvtw6sGK4Y
	e2ypzFR0ap3AQ3yHrydE1ohKDBVRcc8qXruP7FCsxHzzykbCZiGYB1FDcWDNYdrm
	EAvZsLjyG55rD846dY5ckNdTHoFmlq3blAJwRVJkFlhPqWRdiNvhzmYVPAbA6vrW
	/QTIvnTt/xH8nxzMgAFlWFWnQtbNXoBEdijqK2FoZAT7Uet4Sn19WDr8mYlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722929584; x=1723015984; bh=WyGSQj0ESKe99bjdrFb64uizrZ4m
	047DRJ1biKfdsFY=; b=fjr6ciKKha8A9oyvb/3wQAD85t64y+NVkvd/Lle+RQTh
	VjS7sgH3TUZDvh8XGPmIdZZPF7zK0AutniX3zE2BsQc/wKWJ4IP38G43bPZbfowE
	24IANd8PlmTvblFAX2H/Wdc8SUH+rDvk7EA7XO1lmu29A7ztlAYH7uYQ8OckiUYK
	W4abv+wr/8kuQFmBDZrgoYMroNPxigYRC57F/hh75OEhL+bUZNmWtZnz3XtyHJ8o
	uxknVk7xggkXXctsdS9VvmJ4LxsFxxHo0fR6E1uxl/HMsPzbPuRxv06VXkxGqL92
	fADhx4P9dm8bbCx7h8De/A7ciAavgCF+Qcz/eUOCGA==
X-ME-Sender: <xms:sNGxZkmvBJKUuTkzUVBJcpXvFIGf5oo6zklDz72TG3GWy2vvjPgEXA>
    <xme:sNGxZj1UvI6Cfvtfj5VbcVGsmjxJLKUcrh93JLF6U10ZGeLZp4voPr9si_YTpNs5Z
    nP4RP28GdXHVGJrDw>
X-ME-Received: <xmr:sNGxZioEe3_osR8Zwc2groiGELhRd3eUUxMJkzhBwv1dNjU3NNuDblkPUuVy0ukrKn7PwN-A31-yaqoWl-4fEs21Aljz-34ljiGJ7-48qbqa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:sNGxZgnuuVR4zyorfI3pnPDClvdO2pIQc1cPGPESad-J5CcGenszWw>
    <xmx:sNGxZi00lpnx3yPwcDmZ1pjd4bM3fxeYE8-zqVP0z9JIm-K2b1jFJQ>
    <xmx:sNGxZntBN_iwk9iQmUG1LlI8em0Mn-3AHyaeQSIoBTivzTpHrVU0Zg>
    <xmx:sNGxZuX0XM70iGU3gA1zH0BflubqBPiGmdvDBzssPLeAJfTdd0ORlw>
    <xmx:sNGxZsp4EJV5D2LVyRPy6R4Dr0YRRIsEOYGPO0dagL46HAzrZSH8gU-f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 03:33:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a018877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 07:33:00 +0000 (UTC)
Date: Tue, 6 Aug 2024 09:33:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 8/9] files-backend: add unified interface for
 refs scanning
Message-ID: <ZrHRrEJmCdyL8l1i@tanuki>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrEB4PjNPM6SZspS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2HX1ZFmBBTpj0aYw"
Content-Disposition: inline
In-Reply-To: <ZrEB4PjNPM6SZspS@ArchLinux>


--2HX1ZFmBBTpj0aYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 12:46:24AM +0800, shejialuo wrote:
[snip]
> +static int files_fsck_refs(struct ref_store *ref_store,
> +			   struct fsck_options *o)
> +{
> +	files_fsck_refs_fn fsck_refs_fn[]= {
> +		NULL,
> +	};
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, _("Checking references consistency"));
> +	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
> +

Nit: another empty newline.
> +}
> +

Patrick

--2HX1ZFmBBTpj0aYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax0asACgkQVbJhu7ck
PpQZjQ/+MY40uuULXmEd9mCC5R4yi/iaQ+5onmer8f0vaHEMdkst/kwfODshWcub
XFW8bPeo19qhFhF8Aq9X0yE/8q5kb8/9NzvoXE5F8NlPaKIsrFlaE0qMSv/OoUGu
u4+qWP8hR6RxdhX1H6nkgEiVS5avuijYVXBri/ioxjBnjKojX078D6JOere2pD6Z
cYtc7996eTlTsIa0Ze8xlFjFByKbzStHLSg7aaDkMjpl9I1JE134FcA/01x8S7vB
rMCb+0hczz3Ld6RMVR7xjsni3u0uFZYwgZzWiE4yzHiTIzIrngNm00ZnBShe1mMm
mGhUNw7DENPUCDlAjb5n3tb0Zg1g6R9Xs22BsTLX2bNi0XmMfUtjnN7XfufwaPBV
Ie9OxJwDiXRYjn5ygNy01CERngZc8/BEF4L8DYVA43TUI++cW+1FmGOHoqXiz0VG
N4utgrSLd+ube9W9yUQNj+/cURdQ/DsLbfaJOiHO47kDbSl4uDfLYRuC4eIpFn+v
npLp0Uiz7tV/lpqvMKyLibpiH0Sg3f0nrZscpTx3tyrFHBqPLQaAOd8i2t45ldoj
NcwTuFiDpuitmgZDD/MQruGnkoo2O9NcEx1tx/QYYPSfIqC0pCQrf8LMxf5h6bsJ
26/DeFDNZCKEgg4LejFdBTIg3JJvZlkC8SjEmh0nYgkhuUn0fTY=
=U6w+
-----END PGP SIGNATURE-----

--2HX1ZFmBBTpj0aYw--
