Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA654143752
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254573; cv=none; b=Cfl81CDawpPNH6+WfZ0zVhvSidyFf+oSRMfoOKSrdGhZUctjXZzpGkT5W5FXJSrIrLhLL0gOF6PTe0aXbNxm/Z7KFaYNKz3d22rCwZZkWsUtJVDmf8rixayzzZOWQ27eWo8tAEihWA8yCk28zgzV0ggthQH2CtxdZDZcNrlbyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254573; c=relaxed/simple;
	bh=p4BmC8t6L4uaP8D/PvDCQtLmnmr7qWjbUPkAb+aBkNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPIFAzQVO9U8bNj9POtZ5FTVzDlWk5oRtuOul+Bkjq6A3RAm064G3xJbNqwRTXAbr13z/BC/As8iJl8ABcW5y437Zr8WQH7rsokqVwhgD7sh/NHy3bvk0t44oM32ez/EFJq+E096i9wDv7BM7ZBsH7dq5TM2ehfkKMKab/7G2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=St/0RxD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSQZvaQn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="St/0RxD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSQZvaQn"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D3C9A11400BD;
	Mon, 29 Jul 2024 08:02:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Jul 2024 08:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722254569; x=1722340969; bh=STQenwWMQC
	Z3ICLBATOh4WmI8frckfsU0P4dVqXNizM=; b=St/0RxD75vYwMyVlIRTSJ1SGKl
	5DWymCc4uBk4uSMUPwG8tfdDRJjeUqhhj2DZULB1UxvATJv6JgbvRapmo0n1dtel
	xaKCac5Ae6HdrMwemi1+vyZ7tFryVj6xEHcDNZ76JBZigB1r431oWXZG0S4MaxXq
	XnL7RyWeO+N4NbvHXoGClI3y5hR68sWAWJaIzfSkAJDJs1q+ZcoIYL6rk7f09+BI
	a0P5dTsqxVNZXiYkhGnAxOwEdSAwOdxxbmg6UfegG/ZfNNUjd32NFiRmgdN2DzOz
	vzohNvaiOb2tVzg8vtk6gpT2MD800FT9zQ3QKj0adwIw3ojrSHa0F4Et4LiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722254569; x=1722340969; bh=STQenwWMQCZ3ICLBATOh4WmI8frc
	kfsU0P4dVqXNizM=; b=RSQZvaQnIMq7/euypqyCNgUHbSaltnzVqGMbpY9EbiyO
	dNKTpuD6fGOrK4WD7yFoVIKkMVzs7hM1yR7n4+89p5ewIhb84d+k+g+1TZaChd3Y
	iXO13Ie8yJralapzmojEVJHSrXU12SGWU2wDapWXmTYsXW8maHsmqpxXvf2Eze0d
	Uk0/gdR/93u4FmdHgCzuDCvt00EiVGStt6hEZ6MqwQcNY1c3eYcJ43ccrY+AEpEp
	KZ5Ei8gQtgx+1ouEzIt006AFjE/+QfzNQWcUzUWoiYheMFEH6YsKSpRnbJS8wnxu
	mThHUDFneOw1NWrNwwhzUiqwrMDNiGJWlqK+h2jKQw==
X-ME-Sender: <xms:6YSnZgWwVUcKcSEs8uYYF7Xx9sHozuUSpqPl2C4d-cYCWclZgvBnGw>
    <xme:6YSnZkmMMj6ucfiQ6NktH-znL5hGAhx9oj260lTWODIwDvJEN4qMONxQgXKcRAWdi
    d5Q20fpnN7-DBXpKQ>
X-ME-Received: <xmr:6YSnZkapO34J0GTKYiD9zcfThOScwaZUddmEjcrgbgFBjq5AI4Dya8VLkuwc_XMV3MDagsikWGezxZIDquLLAXGXM5dPzMUMcaQLHYXp3cXfwdwCTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6YSnZvVi517x8jfO1I-MrMultm49y2GucwJ_lMK0hoFnt3Igr5tDIw>
    <xmx:6YSnZqkEjTeWPqDO2EXopktW4c01Y_vmKFokmBywVr0RrJ4vXqD2fw>
    <xmx:6YSnZkdu7bMiioGmKxt_jDfD_pJCnHvetsagqZG7nwTNO85fAMOJfg>
    <xmx:6YSnZsFPPZuv9CYtnbHn28J-HXm6fjzd4KXsMRuEmhP__fSBuPesSw>
    <xmx:6YSnZvydSh8Ea6hHQ1bMVlX2nmaYg4FDUoZ8gP9sp86or2sKhSYUKriH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 08:02:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 263ca5f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 12:01:18 +0000 (UTC)
Date: Mon, 29 Jul 2024 14:02:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] patch-id: make get_one_patchid() more extensible
Message-ID: <ZqeE2IaIhiWmpVM4@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240621231826.3280338-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2M2SVbAyxgUPpwms"
Content-Disposition: inline
In-Reply-To: <20240621231826.3280338-4-gitster@pobox.com>


--2M2SVbAyxgUPpwms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 04:18:24PM -0700, Junio C Hamano wrote:
> We pass two independent Boolean flags (i.e. do we want the stable
> variant of patch-id?  do we want to hash the stuff verbatim?) into
> the function as two separate parameters.  Before adding the third
> one and make the interface even wider, let's consolidate them into
> a single flag word.
>=20
> No changes in behaviour.  Just a trivial interface change.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/patch-id.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 0f262e7a03..128e0997d8 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -58,9 +58,14 @@ static int scan_hunk_header(const char *p, int *p_befo=
re, int *p_after)
>  	return 1;
>  }
> =20
> +#define GOPID_STABLE   01
> +#define GOPID_VERBATIM 02
> +

This certainly is a worthwhile change. I have to wonder about code style
though:

  - Using 01 and 02 as constants feels somewhat weird to me. Don't we
    typically use `(1 << 0)` and `(1 << 1)` for such binary flags?

  - What is our preferred style nowadays? Do we prefer defines over
    enums? I rather had the feeling that enums are the go-to style for
    things like this nowadays.

It would also be nice to have documentation for the flags.

In any case, all of these are really just smallish nits and I think that
this is a strict improvement regardless of whether we massage the style
or not.

> @@ -237,7 +243,11 @@ int cmd_patch_id(int argc, const char **argv, const =
char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, builtin_patch_id_options,
>  			     patch_id_usage, 0);
> =20
> -	generate_id_list(opts ? opts > 1 : config.stable,
> -			 opts ? opts =3D=3D 3 : config.verbatim);
> +	if (opts ? opts > 1 : config.stable)
> +		flags |=3D GOPID_STABLE;
> +	if (opts ? opts =3D=3D 3 : config.verbatim)
> +		flags |=3D GOPID_VERBATIM;

I was wondering whether we could use `OPT_BIT()` here to set those as
flags directly. I guess that would require a bit more refactoring, but
if we also converted `struct patch_id_opts` to have a `flags` field then
this might overall be easier to read than the weird massaging of opts
that we did before and after your change.

Patrick

--2M2SVbAyxgUPpwms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmanhNgACgkQVbJhu7ck
PpSyfxAAi90wfapj3xVCs4oWPD7K7dTCypCJcvvp82jyujyc+SgLw1QXucSh6TnO
RV8YrMTChxTCYTgMgunhjjSEWSo4J5CRDaxzjwFdl6fMI/8q/mARVl4Zrz3mBYOs
t5MchKf4A6AYVChw1g/WX7BdhXeH118UpihglvXJzHoSTE1upQiFObsStbz7X0KU
WtvEDCJSG8KrfZRMPiKzyqWzCztZXEz4Ie3suRbfoh8+O/suVKxuBWtEJCSrCtsD
LvPSMW7uI+ZboNcE5uqdhABwc4snZF9LEdKUeO26FYed9FM1ABMdMoz4Piu4iSy2
e89GmjL3mJLcONik+DRQwY6dbyWUR11DH6TWzysm+qiLWKcniyuQW9xU8G3aYmmd
3I0NE4EO1aIr+Wtr58B8XXRfMMUfyUKB2xjzdTD/xy7ayIkahDi9gV8f5Mqto+rZ
UhHf9YMgFUvtEUSNAQtKAt/hoz5vOYxOZclrMhSpBzXdjiz56QwpOqR5z2gHNt6l
67Y/LZdCE6Y6EDYvmlO75FcUBpcZ2129f48esX/w/ELRxQhGH3cvac0K9dgdQtnA
82WAKiRwInSblUhiza5/NG650UNwbD8YffQCg8fnWuCE7QMkfHLV6fFLl/3w1l9i
MtVP1blaJ/rRSTVDN8xuzcyztyTMhjk/QOUX98KQDWT0E9R2ZEw=
=hDia
-----END PGP SIGNATURE-----

--2M2SVbAyxgUPpwms--
