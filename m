Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C854F82
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019099; cv=none; b=conlVNCcUVr1Nemf2pOa7WOEvswMcVj2pz1mCzfYm6jBkAip2Nrz+I9DTehfdawk5g+13k/k7eZosmP1zmR7d0wnOJ4Lsu1jI1OwI3vKgpG1hyr8PlM+6dJtpD1GZ+TiGSA0H4Q/hXoQiT2SI3ZWUf4s3Sb3BOA1Vmh1bcTLgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019099; c=relaxed/simple;
	bh=LPz4FKA16H5N5fLKhwmclvXLz7zycToodx+hg0jrOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIB3ho9V53w2YqjouSUExNyOeCAfqOfd/LO/4uCdfsb9RMdpOlHInQFZRzfs8VxfOswRzs67A0GzDMpPzN2dEw5TaXiUptS1y5RbAJji1tkxBTmpIe+ygrIWkCE2pqZNG4qtJL5uhqA4DcC1IEsRWKlBkPy9zwz7B/T0l0oZi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T0wNP0yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Injzg8dW; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T0wNP0yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Injzg8dW"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 972B55C005B;
	Tue, 27 Feb 2024 02:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 02:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709019095; x=1709105495; bh=8ibrrTC1cw
	H8NT3Xa82+b1ThL20KGtCJ/oqZVzDI9hs=; b=T0wNP0yrSf5XcTPcQRkjf9qDiN
	hYss1bmNo903saDvnuAM5fvnPiXfkjsFwckA+LKxpMybDXMJr0IeHAVV9fXiHVuN
	cAxoQIwTVpgTgb6JgUgAA8Krvxi9bOZOFqErI0axHHf9MGW+GD7p4m4G4QfDKLxt
	j6w5DAZV05WIvSe3IE5tfFAhEOXwE+KMLlWrhrriHwfwd46RDHHnLeSAImHLxEph
	Y9Rpa7ZCEl94nDlooGxXTs5m3gp6XYZZyk1loBkZYRyICBSt8KFYXW+bVPTveu3U
	5A68h2bqOkbHsbx3jX2olKURtXdACxDM1q6u8/PJuu1o4PAOZEbA8fX56ZyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709019095; x=1709105495; bh=8ibrrTC1cwH8NT3Xa82+b1ThL20K
	GtCJ/oqZVzDI9hs=; b=Injzg8dWfdXsTchrOlE3je19aPpyQUHaXd/L8GwNhYjt
	bI6IMuZKIqTncFBYBughj3NGSqegpUwhYp98H16zz2RCfDmcLZ8mewT2yfOZXBL2
	Sf/hQ6b+B9DocJSkNjkHuG4M0RJW5T/cd3RTAVSA3dNvi1M9wBM3pD4R5KF4IS8x
	DVFue7vi9rypvmvGVqnFKhS30iCGpQ2qnbwkfBm9fnZkgdmYMApAkOcK0V5rHMjn
	boTOjoBkivjoH/AEb8pAJDna/zHm1ivP5ONbD59lB7vukgPfMsy2HuaU160Ggf41
	DKqWw7OdY3A9xhP1ToyqGvk0gcSuff8+fZSOgV70KQ==
X-ME-Sender: <xms:14_dZTzASi36KPfpHWbXs0UZ_NouwBAQGQrs2uexxel3KKID5VxfQw>
    <xme:14_dZbTdz_g5Fl9Nb6_s3BcD1a4crOzGp8bP9Fn2SWoODFTe__jTfyjnyk-Eb5EK1
    XKgEOMymrBBbkgmtw>
X-ME-Received: <xmr:14_dZdV1ASNbxA5-bJYggqnPxFmPWIm2fkxK2KmHJD01Lz8-93UJVRDTASpc6Ox19Ur-mR2l_aiE0FXkToxV5_wNLr6WjC2Nyvjm8lE_EKZLmfE6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:14_dZdj1u9L12F51LwtiIdLRobaiH0DtmrBOzBSDTODHOnfDKdc4MA>
    <xmx:14_dZVCBS8iTuoZMbZrytHSLYzI_Zoun4n85MRrTToXnQPidiIqtEw>
    <xmx:14_dZWKL-jQYVIFfkopmFPCgcRnXjVP1VtQfWSl2JKx4BueZnomviA>
    <xmx:14_dZS7kerNkaxS0ujh8NaBwNTzz4XEMksg9RVxmTOyPRLC4bNqozQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 02:31:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f04f39b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 07:27:16 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:31:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] submodule: use strvec_pushf() for --submodule-prefix
Message-ID: <Zd2P0irjsaeiSapJ@tanuki>
References: <8cd983fb-32b9-41c6-a9e7-a485b190488c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YbsGuGctCxGkEiF+"
Content-Disposition: inline
In-Reply-To: <8cd983fb-32b9-41c6-a9e7-a485b190488c@web.de>


--YbsGuGctCxGkEiF+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 07:24:39PM +0100, Ren=E9 Scharfe wrote:
> Add the option --submodule-prefix and its argument directly using
> strvec_pushf() instead of via a detour through a strbuf.  This is
> shorter, easier to read and doesn't require any explicit cleanup
> afterwards.

This looks obviously good to me. Thanks for this nice simplification!

Patrick

> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  submodule.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>=20
> diff --git a/submodule.c b/submodule.c
> index 213da79f66..40f13a3685 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1687,8 +1687,6 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
>  		task =3D get_fetch_task_from_changed(spf, err);
>=20
>  	if (task) {
> -		struct strbuf submodule_prefix =3D STRBUF_INIT;
> -
>  		child_process_init(cp);
>  		cp->dir =3D task->repo->gitdir;
>  		prepare_submodule_repo_env_in_gitdir(&cp->env);
> @@ -1698,15 +1696,11 @@ static int get_next_submodule(struct child_proces=
s *cp, struct strbuf *err,
>  			strvec_pushv(&cp->args, task->git_args.v);
>  		strvec_pushv(&cp->args, spf->args.v);
>  		strvec_push(&cp->args, task->default_argv);
> -		strvec_push(&cp->args, "--submodule-prefix");
> +		strvec_pushf(&cp->args, "--submodule-prefix=3D%s%s/",
> +			     spf->prefix, task->sub->path);
>=20
> -		strbuf_addf(&submodule_prefix, "%s%s/",
> -						spf->prefix,
> -						task->sub->path);
> -		strvec_push(&cp->args, submodule_prefix.buf);
>  		*task_cb =3D task;
>=20
> -		strbuf_release(&submodule_prefix);
>  		string_list_insert(&spf->seen_submodule_names, task->sub->name);
>  		return 1;
>  	}
> @@ -1714,12 +1708,8 @@ static int get_next_submodule(struct child_process=
 *cp, struct strbuf *err,
>  	if (spf->oid_fetch_tasks_nr) {
>  		struct fetch_task *task =3D
>  			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
> -		struct strbuf submodule_prefix =3D STRBUF_INIT;
>  		spf->oid_fetch_tasks_nr--;
>=20
> -		strbuf_addf(&submodule_prefix, "%s%s/",
> -			    spf->prefix, task->sub->path);
> -
>  		child_process_init(cp);
>  		prepare_submodule_repo_env_in_gitdir(&cp->env);
>  		cp->git_cmd =3D 1;
> @@ -1728,8 +1718,8 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
>  		strvec_init(&cp->args);
>  		strvec_pushv(&cp->args, spf->args.v);
>  		strvec_push(&cp->args, "on-demand");
> -		strvec_push(&cp->args, "--submodule-prefix");
> -		strvec_push(&cp->args, submodule_prefix.buf);
> +		strvec_pushf(&cp->args, "--submodule-prefix=3D%s%s/",
> +			     spf->prefix, task->sub->path);
>=20
>  		/* NEEDSWORK: have get_default_remote from submodule--helper */
>  		strvec_push(&cp->args, "origin");
> @@ -1737,7 +1727,6 @@ static int get_next_submodule(struct child_process =
*cp, struct strbuf *err,
>  					  append_oid_to_argv, &cp->args);
>=20
>  		*task_cb =3D task;
> -		strbuf_release(&submodule_prefix);
>  		return 1;
>  	}
>=20
> --
> 2.44.0
>=20

--YbsGuGctCxGkEiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdj9EACgkQVbJhu7ck
PpSFKA/9HixQytqjCrokmTVKuzGZJb9h7dmvCVC+4D+uCpfVzRADbPU99y6UDZj9
1JyCQh/CmqNl23R+VwrrrYjxaJCqOtHKAYSj9PeKaKpiI3QLQcpfXAWs0PkNW3EY
SVZv563g9D0b5Py8DD8HELae4RYwQ4EoqFvnObvDiuwE+FPzsWdsgFCOqyVSiwXi
1zCX0n4GcKTrNjR3l6VVsgExqAFwy0ME+N3xTyuRxtK3qAOat5CIo2FHuTKj43c9
7AWrLFV88gQD6kepTWrOQRMS/TyMjUj2ZaoDf9Od/tZkXFASWINMgscyJTYUC9DQ
lcpLOSQ1DhUUD6Nanl3IWripsiXx7/K5HcQLjwpzQc+kgdonMZrNy9PvmTIudJgN
GjaM9d9RJPlsY2ntUVpJrIRVYWqc4oF/HhJYRQBIdt65hoYxsg8NH6NIRSj+bOBC
ucmcumqQoag8sQf57xSJJ4hnZe8wScXw4wxgChrhJc9ce02pKitJoQ4LeidUhL1J
FPTMk37ViwCWRa+m7SVvJEmds5ns3M205kFzrX56+hL8pnNB/3DZ0UAlzcQtrCGf
/+IbYXTTnT4o/7/BB86+I0DKc1OCN6TW0cXqTuUOYMK3PyCZ15YPAG5XVdIQYlab
16Zmj3zTWBXH3BS91yC3h/Vg+9DOE0BJ9mVPR4IW2luNai6PWi8=
=1WVR
-----END PGP SIGNATURE-----

--YbsGuGctCxGkEiF+--
