Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD894C153
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675614; cv=none; b=iU2L8IL4qLBt4O1C4B534m+5QU7RvHRXJpbBM/d1WfjD724/s58tOJrNfU1Bher/Pfyshb0e6GXGn2DW3vjvZaTSnBl5x7sUSzXQr6ajxjX3DxSNm8aKhe4MX2zOLNdqkZbNmEtEaLqVZOcg8p4xCZAfDfR9FD+SZEKntDOnBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675614; c=relaxed/simple;
	bh=irbM16YkxcR452TMvPU0V3MNOIXBL1k/9OHmQunBJb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlWN7YHTQJ1Awp8FlvQAIlP58EncnK1LqyU7g9OCVAhvzlxvkykCyIbzbrlQzHIvsLIdqOQREqX7X5lpHpg1cfxnravre1v4o/McSuXOpNR918BaTuF2HCYRWBHZc7iIeHGg5niMQfL9FuOJXgHxm+OCxmaCFV1WYF/dlCq+0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UxAhitx3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJjt9RoR; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UxAhitx3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJjt9RoR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id D0354180016D;
	Thu,  6 Jun 2024 08:06:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 08:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717675611; x=1717762011; bh=rhpdHkbFxo
	s0C1Ee3JFsxM6I78gcbuC5tMo+HN56/oA=; b=UxAhitx3eSTQ09IZ6q4YYH9rI+
	yrLK5h6U+Eqir14XWekI8DXTkJxn15QkgQpqa2FvK+vcfOvjkFDiwnAswhBFgNmR
	lnPPXUubKC5LvQz9speUo+749GlPtTpS0akZBRge/Y7RCTrd21+9U2UgpaP7gzdc
	/mE+SopDAetBoCsEPhkvr5lo3yR1vnbb8DWrsj7XadIVuBpcyv7r8pvva0bz3uHM
	GCEvWVzwHVBNWm8G/Q2GFUH2nrqcdIsCAqnA0Kj9ZWiVtxK96DVxHPajwJSAiJVs
	xtlegDeykf608J+duZjBne5brbGUxjVk7XqTmz+VmbYyTjvs3setifbJUNVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717675611; x=1717762011; bh=rhpdHkbFxos0C1Ee3JFsxM6I78gc
	buC5tMo+HN56/oA=; b=TJjt9RoRQFek0AMPO6y+9fjJ8RrxNGXJhWyosAOgs84e
	ZYEKXqFsTlcQvNJ0U55bUXIUwvcmhD3xvjFBbHAAgCg1oDL7+DyZw3R7+Ecb0UUv
	R+HjjwLkZV3Id4juyMWZX1/4vtyKWuoqK/YWDxqdJyjQvKWEb38QUnx5AXela0V5
	J7Kh5MrEoOJOR/g2J+y/N5vm29qxjbVrSgSllpaJ6rYr7jO0wjSwzJ5Vc1zs7uil
	Shy+f5J+EEPmGzh2N1vvb6smWxy5Eew/GZLYgLPfx8NqdcpRPSav+AvilOe/n0dg
	UkqCoePDCn2DVH0KkBQVI5CVfncQ/UlVO2ZlOgMIbw==
X-ME-Sender: <xms:W6ZhZkx1DZdxgHxMt-VuWONUGMXPHzgxcfS57nKJAidamKaonv8x5w>
    <xme:W6ZhZoRVI7qwpuO58V-Uo3cCtW7nkL09lVOF4gaJ7evRJ94QCjK-EyDB58IIAPn4t
    QiTwL7FY5wcZBOWdQ>
X-ME-Received: <xmr:W6ZhZmVZ8EQK9XYjURLtYcsHiuKbSV8UcLKXYXnSc_moPhD5ZtgZjzbfwL_rU2Ra63do7zYLtschOWXsEyvYgLkcoRMQhyVRAFVSNIYxb1867hQj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:W6ZhZig6po4xsoNdv66RXBQPZIZriWssK8xU1Y-OLZdBmGVHmlt4nA>
    <xmx:W6ZhZmB3Kp7zcFdUC11WuEfpNdL8M-0R7lNcbIMiWOWeQlE2B_Pt2w>
    <xmx:W6ZhZjKwu0yy-7KUVEdF58LlpQ6nV2zaCRrKu7kJ68MayYLVGK5CYA>
    <xmx:W6ZhZtCC7Ijgo7VUWstGnpzpF_o5ZFpm1onucgvxHQgMjrh6VkyMig>
    <xmx:W6ZhZt4Sac-BZAH8DWFL4_bWruB5yRqrFULe_jo33V8oq-PPLxrGK_wT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 08:06:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 54475472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 12:06:18 +0000 (UTC)
Date: Thu, 6 Jun 2024 14:06:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v4 4/4] unbundle: introduce option
 VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
Message-ID: <ZmGmV8-QNMN643ou@tanuki>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <68b9bca9f8b19897997c2adc9a278ac5052e75cd.1717057290.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ej8kn9TDfKcxKwGq"
Content-Disposition: inline
In-Reply-To: <68b9bca9f8b19897997c2adc9a278ac5052e75cd.1717057290.git.gitgitgadget@gmail.com>


--ej8kn9TDfKcxKwGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 08:21:30AM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>

Same here, the important part is not that we introduce the flag, but
that we start using it in `unbundle_from_file()`.

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 066ff788104..e7ebac6ce57 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, c=
onst char *file)
>  	 * the prerequisite commits.
>  	 */
>  	if ((result =3D unbundle(r, &header, bundle_fd, NULL,
> -			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
> +			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
>  		return 1;
> =20
>  	/*

One thing that is a bit weird is that we first change `unbundle()` to
use `FSCK_ALWAYS` in a preceding patch, and then convert it to use
`FSCK_FOLLOW_FETCH` in the same series. It could be restructured a bit
to first introduce the flags, only, while not modifying any of the
callsites yet. Passing the respective flags would then be done in a
separate commit.

Patrick

--ej8kn9TDfKcxKwGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhplYACgkQVbJhu7ck
PpTk5g/9EWJiwAEHX0nuukhbF8U7c63IBtPDMr5vuZazT3fjZBpbDKUPcmtLZnAP
CUCQF+4VbApamjbY6Zq8bY24D6E3vfFFcSldtsM1I21teeGf3ONHnZtoJIrzJza1
xfOfxDu+VfAtAXRUMUTaaCEihhI3r2Pi2uHUcYr16IBoQT4fTKtyWNyZlvV8AyW6
IxID+UqXmH6wzVzTATC+XnZvhRMPEA6doJa5F76LIuRzttk5SqwbTadIDzGfqFNX
qSN1dbevPxfBoN7YdA0e111DJXisz2BgFtQwRUhP4mdM13aIBmVEUHWtrBNX5R1d
RYhiRJrUnUy5XyMBjEnSKU6OwFPe7hL9EDYhPDRvyynwkj25Cjs32Mzlt6/kHw1l
PdyUDyPFu26ndVQwLl9Lfi1teb7wAdOj1cAkezyC1CWjbOsb8509UfHoVhUWFAYt
5MnTWYPQR0LxOC1mj2KMHa33dWAQliv3XEY1sbGiQ7G0yPUvkOoUPHgUGBOj4Vc6
KkABS95aW91Jp5VIU222TkSVSZKwnrWlAfGVJXf/iYZhyU61XxxlvwjCocSM19DZ
LaYi8SZNRCMcOAuExCG/ARlc/7dN2GmVs8ooSZljyZvMBc70hQY46azefogGWVtE
TvyP/GfqgxCAURZhFgHjVx7jnj4LYuHOuCX+qR9nMIHKGpoafcs=
=iDeH
-----END PGP SIGNATURE-----

--ej8kn9TDfKcxKwGq--
