Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF3166F1D
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929574; cv=none; b=Lln3T8wZ20at/xjkZcg1sJrIK/wFnLQmV2YWbmpsVBxqir20GaJsb/lvHPkg9jZFzNsuio1fvQkgcCxMBL5kUiZH1pTLuSvwFi0HzcKJQSCi3N5xvXnC8h9Bts0/4Q9ICgvFDA2Z/8mV4/aaGzh8BBbgwiIjnLbw5h+ndw5VRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929574; c=relaxed/simple;
	bh=WBJ+LiGTu091A2mBSih23aVRc5Kk2oUpLsgG0oSGD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewPG6pD6GL8Q0rIA/Bg4R61iyR+oUMXLMRA2V1tsYs3AEFqQsigZKpeg4VXaqxccU3RBg6xB/NUECvYl6vkQeony192+i2AMP0m7pp4WD+QsfxNe8ZR9NbWS3DpIRF6VqwmAkjDRnlvjOesf0s7ZbyThFnSxrvKiZWaCNR25wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wp8eXZy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZX3msXjN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wp8eXZy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZX3msXjN"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0FE6C138FC3A;
	Tue,  6 Aug 2024 03:32:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 06 Aug 2024 03:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722929572; x=1723015972; bh=Uxm0xP3cpC
	NCnMtjznpCfr3nQpY3EwxHkNOfbCa/xE0=; b=Wp8eXZy1kKLidKi4fEthR3oGiF
	R1QktIvs2tQ4v5XNqFgaDcgyVPLzAJ/Jf4iwRoV3Ys2iejb3Uu96kQVNx1f28wS3
	HN6kogdfHMyypQfmz08Ux81e1Yl340S/Ni9UUzFobKmq4zTTxObwPWl2m0bVMjE0
	OAUwIPLULeni8gu/VX/W+njY/Uqlvj1m2JRbFCZM0Z/vfd4PK/2pwagGndg/XSdF
	REnzDDg5mlRo55B5KDa+68N5pRGfOfXvhOh6vPhEIcmHYR9sCGmSTIsMlr7FfkBB
	/3mx9asaSnvErRKrTMmwR0n3Xs+VPxZe7gvwXjSaUshku49+3HCHNv/fv3+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722929572; x=1723015972; bh=Uxm0xP3cpCNCnMtjznpCfr3nQpY3
	EwxHkNOfbCa/xE0=; b=ZX3msXjNRaDRjg1Dgnw1UV/qBUZ3V3jCvyFmy6K493rV
	Nc1/0Gp17liJCE8eKJ89ZJQHuqfItQoGryFN+k24zD0JjzmEqEupkzspepwnPYLJ
	mZm+2jVFVSWygsYFn7zbg7DYlYoGRDnfXCDjigS/ED8rJlIsdksNzq080imqlrSE
	QX8PdRnSuXW2V7SYtXSa7/c6MRcE89ZbGhYS47fciIMf/ZNfRRFCOkI3sZ3JqxdZ
	p356VAypkt0puiQqhKPYittTtdR0XhGyZ/1mT6KFctQDcQj6JGqsxYvC77oun/Sw
	MxjTD8QxWbTpPBVGb13AJaueZTS+d/CE6Y4Uwyq7hw==
X-ME-Sender: <xms:o9GxZmNlldcC7BwSnZ8X8eeCbu5M6oG21qwwB2vkUsvugscFLftuBw>
    <xme:o9GxZk857ZwhLiqOFm91J1_0Nwdtck98NrG8jRJLZTmMVxTeBBo7ZtTjqLvswN7ie
    SsnrjMKkF15WSDRUw>
X-ME-Received: <xmr:o9GxZtS4skBy7eQ4ZRziFFpMQd3_M0---yHPoDWKVxWdAZQUf7caWslSHKZtGfR3hCIJN-LR_tiPdIhZDZPEbkZIrVfy9lZHMLPB-WMjN0sv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:o9GxZmuWep4OpKdlUQhPK44WNXStjaAvPQDYlqf2mketeOqoqT295Q>
    <xmx:o9GxZufxPU5R9odpzGA1WGKp7k8tcikKsg4bj2TjDH_9CAhpDfxX6Q>
    <xmx:o9GxZq0lkMvqWr5IassVtOWTxKy-j34QmWzlHS3LNViJ9amia5bzDw>
    <xmx:o9GxZi8KU2KAXAbnn8RnxgKA6JZ4JWRC7HC_p0BgV0bGWX4jwFjxcg>
    <xmx:pNGxZmTpAqQn15JZJ5bysQ-frTc5sqWidHWx-kqwufv9v_ggtk5JAXY6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 03:32:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 859b9e48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 07:32:48 +0000 (UTC)
Date: Tue, 6 Aug 2024 09:32:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 5/9] fsck: add refs report function
Message-ID: <ZrHRoCka8yCAwxzz@tanuki>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrEBxYagfzAfZKVJ@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="03B1zUrIaJbeGFPF"
Content-Disposition: inline
In-Reply-To: <ZrEBxYagfzAfZKVJ@ArchLinux>


--03B1zUrIaJbeGFPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 12:45:57AM +0800, shejialuo wrote:
> @@ -1237,6 +1250,34 @@ int fsck_objects_error_function(struct fsck_option=
s *o,
>  	return 1;
>  }
> =20
> +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> +			     void *fsck_report,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id UNUSED,
> +			     const char *message)
> +{
> +	struct fsck_ref_report *report =3D fsck_report;
> +

Nit: there's an unneeded empty newline here.

> +	struct strbuf sb =3D STRBUF_INIT;
> +	int ret =3D 0;
> +
> +	strbuf_addstr(&sb, report->path);
> +
> +	if (report->oid)
> +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(report->oid));
> +	else if (report->referent)
> +		strbuf_addf(&sb, " -> (%s)", report->referent);
> +
> +	if (msg_type =3D=3D FSCK_WARN)
> +		warning("%s: %s", sb.buf, message);
> +	else
> +		ret =3D error("%s: %s", sb.buf, message);
> +
> +	strbuf_release(&sb);
> +	return ret;
> +

Here, as well.

Patrick

--03B1zUrIaJbeGFPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax0Z8ACgkQVbJhu7ck
PpQiVA/9GNPN+RhHLQuSuA7aLwTSGCqtSLVYtONjf/mQZyfCX6xTXDf8eaZC2caM
UrsVUvNFOvyVtsVT28a5dMvMrNDvgBw602upVlqqE2SRl5USvY3GoP10egjlHQ0L
0MI4ZcuFNDkGe5QhCv9E61K0tCyUl1x5qK6N5zabMeZVXBU9wpsUja8SXpJXYz+Q
fCGtz9gEGUGPsqiIT2RPqFBljf62B+OL+f2HpEoKlXYstWRr07b32zyrFwVbVb0K
aJPbzLSMi4WGvrgn64di5rOToyNBg01KIzUD3HB89XFZADI55ovowLl/FQQ/GRsb
j0nJY05MVz3tzLSIoPwz0Ysxw/OzZZxeg7XQ9QUhK+Au9sv65/zy/2mkQO73ofYi
4q4kP4nuZtinnDQWIXiNjLqk4oWTKHfbg/D80e/p6WqdHUOpYx856vEZ/d+Zd2mZ
DlR2sPI4a4ZS573B2GHmFYkSFEtjP7/Q1dAL3lytFLIgoXnNO16rwHlk12h8+Vi/
D3YPhuZb+YAkJiplx7L/A2bJY4/4J6nQSO589RT4LiiLytTrNhOPbicuctZjem09
ZgSxSup10KDgIg5hsAxh8MH0uHKBKjEmd17pibko6RL0cHob2Gq2vCVKR/EL41SA
lGiKnSNBXLPJYfG6sVfgtG+M/66ptxkPXhmEB6yz1eTgA6FKjF4=
=airC
-----END PGP SIGNATURE-----

--03B1zUrIaJbeGFPF--
