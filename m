Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3829CF4
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730439; cv=none; b=jgM1Ukb0Hs0tZYs1z0gUwuJszdHobpO3AA47+CUQRcvF77f77pCx1YUMjKHfN6RCp1x5aj9uYLuzLe/L2wah3Wma6L0WiO9RVXt906K1Rq+N4f7/V9p0XSD7x/J+8GGNE4+Lkl2peZWVup+ZGsBjLBrl4b2j6OWkbSJjhfsYVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730439; c=relaxed/simple;
	bh=gdMFdvFZz/OcPdtcRO0VXFn+OA7io+a+3+E7M4bh4I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twONXOf0JvcyjH24+Hdj14EidJVstAgXvm5gEXpCBjTnN+YkNErwDKI9MEa17H0bjDelAGlHRG8bqq6MOma+5ZOfJvchz3VhCi7icFhzVJjDcsrbqC4WMFEgQ4Bsu9HvP/1cLNz3UzpsCgT6AxUEl4yHCuWfbU8qUHYrOyMQY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESIyqQTV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsiBT7jd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESIyqQTV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsiBT7jd"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A077114015F;
	Wed, 10 Apr 2024 02:27:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Apr 2024 02:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712730436; x=1712816836; bh=NA/vwUhpIC
	zdRp9ITJwuvZYEgI+edtuPk5n1AkfedbM=; b=ESIyqQTVR7tByTxhwgyQC7U3zU
	KOQX/hkhIL38xrZnvnFKB8SXD5eyGtOOZArPAjRTYWA8vV1jugIX5VXO9aJ/sjya
	2guOkI6pTUPXdLKmUhHgHsnh4NsMgIOXhMHbfAeaOwQlLjnyATo+obrHg4o6aGTi
	n08tmJbq1dTfDOg0zGmAdA+FeETvsGoctqfFnPknOfcb3vqr0s8k3AwemjLcFczT
	TymFgayO7L4fyab39cq3/3ptpPdQO0jL3hRjGqOiGXH+isFmpA2CQfNJ2wibmKBb
	iT4JkNF/yvc/wYeTAV6li9eUKhqvX6O5U31DKVJ47dTFIuYqWegilr5sGNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712730436; x=1712816836; bh=NA/vwUhpICzdRp9ITJwuvZYEgI+e
	dtuPk5n1AkfedbM=; b=UsiBT7jd6X5qLrJloobouO0ElUitC7NIMSOpwtFpXhkw
	wMUjgCFDgczca19g1VK1+vJYO+JzIlKcpIm/o+0IDJ+XBRem1NFmv5yMuZIO/bcz
	Z7pYnELikNnkP5GinPYAHmCzXf2vV4pbvZnbvgeVUMxXYytj7u12An5nQF3wVhkH
	fx6ObaXuPgV/CWjesWl2f+2VEO8xJty8Mq209a+WeZxX9uLiO71QR8xvAoKvOTZx
	keOvPrV8GCDNhodaDsWVzoAJbzW+GRCBW3dwfSgfPdg3gHj8BbZRAk7I/XQLvuQY
	UzJ2cQC0bWZCKSnuCd6XM/zY74uN3veLS+ElpYjZsQ==
X-ME-Sender: <xms:RDEWZtnfm-imtA8apZAmA-otjMhd623Kh5vVlcTHpaU6Y_w1fRvl7A>
    <xme:RDEWZo1hfedRgHqrgDZCqaFlyySH32be66qTssGtDSdCju0QZieORtNGd4Dl5uts6
    BTIE79Y_VKXNufg6g>
X-ME-Received: <xmr:RDEWZjqPY2E8spZsecuLydZYmmQZQTvvcnOgAoCgtqEi5gm4tvffJkQ6pBAdFSff-NJOPoYyPO2Veu3_iLW06H7Xx6A6t3LOfn7gJRpxixhRhAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RDEWZtmDbYSH6m7BdQQvWg6w_7WLBrH_ToWsSpsxfTWeDXmuFfIZzA>
    <xmx:RDEWZr3dZb1FkxX6ZMU4R_8cwKkzpGmA7h5pU13QXsQzclPLeUZFIg>
    <xmx:RDEWZsvTufrdtwivI8vY14Vmp6zqEk3SmOtSqNIzZcTiKzAaOH7rrQ>
    <xmx:RDEWZvUgKXFoY8-isDkc-yjPZUP8sLFTIOaXLO1U5_jNQ-VVRnaYZA>
    <xmx:RDEWZszHflNvbW3mFIpeH3gJ8-N53cS4lxOJcq8LuRxTiAapOsS_Fa_Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:27:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fc014cf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:27:04 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:27:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/8] fast-import: directly use strbufs for paths
Message-ID: <ZhYxP42Br2h1mq5r@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <82a6f53c1326a420348eb70461f5929340a930d3.1711960552.git.thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OgIFsyR1lGb9PWCT"
Content-Disposition: inline
In-Reply-To: <82a6f53c1326a420348eb70461f5929340a930d3.1711960552.git.thalia@archibald.dev>


--OgIFsyR1lGb9PWCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 09:03:06AM +0000, Thalia Archibald wrote:
> Previously, one case would not write the path to the strbuf: when the
> path is unquoted and at the end of the string. It was essentially
> copy-on-write. However, with the logic simplification of the previous
> commit, this case was eliminated and the strbuf is always populated.
>=20
> Directly use the strbufs now instead of an alias.
>=20
> Since this already changes all the lines that use the strbufs, rename
> them from `uq` to be more descriptive. That they are unquoted is not
> their most important property, so name them after what they carry.
>=20
> Additionally, `file_change_m` no longer needs to copy the path before
> reading inline data.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c | 64 ++++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 37 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 6f9048a037..fad9324e59 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2305,7 +2305,
> 7 @@ static void parse_path_space(struct strbuf *sb, const char *p, const=
 char **endp
> =20
>  static void file_change_m(const char *p, struct branch *b)
>  {
> -	static struct strbuf uq =3D STRBUF_INIT;
> +	static struct strbuf path =3D STRBUF_INIT;
>  	struct object_entry *oe;
>  	struct object_id oid;
>  	uint16_t mode, inline_data =3D 0;
> @@ -2342,13 +2342,12 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  			die("Missing space after SHA1: %s", command_buf.buf);
>  	}
> =20
> -	strbuf_reset(&uq);
> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
> +	strbuf_reset(&path);
> +	parse_path_eol(&path, p, "path");
> =20
>  	/* Git does not track empty, non-toplevel directories. */
> -	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
> -		tree_content_remove(&b->branch_tree, p, NULL, 0);
> +	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *path.buf) {
> +		tree_content_remove(&b->branch_tree, path.buf, NULL, 0);
>  		return;
>  	}
> =20
> @@ -2369,10 +2368,6 @@ static void file_change_m(const char *p, str
> uct branch *b)
>  		if (S_ISDIR(mode))
>  			die("Directories cannot be specified 'inline': %s",
>  				command_buf.buf);
> -		if (p !=3D uq.buf) {
> -			strbuf_addstr(&uq, p);
> -			p =3D uq.buf;
> -		}
>  		while (read_next_command() !=3D EOF) {
>  			const char *v;
>  			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
> @@ -2398,55 +2393,51 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  				command_buf.buf);
>  	}
> =20
> -	if (!*p) {
> +	if (!*path.buf) {
>  		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
>  		return;
>  	}
> -	tree_content_set(&b->branch_tree, p, &oid, mode, NULL);
> +	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
>  }
> =20
>  static void file_change_d(const char *p, struct branch *b)
>  {
> -	static struct strbuf uq =3D STRBUF_INIT;
> +	static struct strbuf path =3D STRBUF_INIT;
> =20
> -	strbuf_reset(&uq);
> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
> -	tree_content_remove(&b->branch_tree, p, NULL, 1);
> +	strbuf_reset(&path);
> +	parse_path_eol(&path, p
> , "path");

This looks weird. Did you manually edit the patch or is there some weird
character in here that breaks diff generation?

> +	tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
>  }
> =20
>  static void file_change_cr(const char *p, struct branch *b, int rename)
>  {
> -	const char *s, *d;
> -	static struct strbuf s_uq =3D STRBUF_INIT;
> -	static struct strbuf d_uq =3D STRBUF_INIT;
> +	static struct strbuf source =3D STRBUF_INIT;
> +	static struct strbuf dest =3D STRBUF_INIT;
>  	struct tree_entry leaf;
> =20
> -	strbuf_reset(&s_uq);
> -	parse_path_space(&s_uq, p, &p, "source");
> -	s =3D s_uq.buf;
> +	strbuf_reset(&source);
> +	parse_path_space(&source, p, &p, "source");
> =20
>  	if (!p)
>  		die("Missing dest: %s", command_buf.buf);
> -	strbuf_reset(&d_uq);
> -	parse_path_eol(&d_uq, p, "dest");
> -	d =3D d_uq.buf;
> +	strbuf_reset(&dest);
> +	parse_path_eol(&dest, p, "dest");
> =20
>  	memset(&leaf, 0, sizeof(leaf));
>  	if (rename)
> -		tree_content_remove(&b->branch_tree, s, &leaf, 1);
> +		tree_content_remove(&b->branch_tree, source.buf, &leaf, 1);
>  	else
> -		tree_content_get(&b->branch_tree, s, &leaf, 1);
> +		tree_content_get(&b-
> >branch_tree, source.buf, &leaf, 1);

Same here. Is your mail agent maybe wrapping lines?

>  	if (!leaf.versions[1].mode)
> -		die("Path %s not in branch", s);
> -	if (!*d) {	/* C "path/to/subdir" "" */
> +		die("Path %s not in branch", source.buf);
> +	if (!*dest.buf) {	/* C "path/to/subdir" "" */
>  		tree_content_replace(&b->branch_tree,
>  			&leaf.versions[1].oid,
>  			leaf.versions[1].mode,
>  			leaf.tree);
>  		return;
>  	}
> -	tree_content_set(&b->branch_tree, d,
> +	tree_content_set(&b->branch_tree, dest.buf,
>  		&leaf.versions[1].oid,
>  		leaf.versions[1].mode,
>  		leaf.tree);
> @@ -3174,7 +3165,7 @@ static void print_ls(int mode, const unsigned char =
*hash, const char *path)
> =20
>  static void parse_ls(const char *p, struct branch *b)
>  {
> -	static struct strbuf uq =3D STRBUF_INIT;
> +	static struct strbuf path =3D STRBUF_INIT;
>  	struct tree_entry *root =3D NULL;
>  	struct tree_entry leaf =3D {NULL};
> =20
> @@ -3191,10 +3182,9 @@ static void parse_ls(const char *p, struct branch =
*b)
>  			root->versions[1].mode =3D S_IFDIR;
>  		load_tree(root);
>  	}
> -	s
> trbuf_reset(&uq);

And here.

Other than those formatting issues this patch looks fine to me.

Patrick

> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
> -	tree_content_get(root, p, &leaf, 1);
> +	strbuf_reset(&path);
> +	parse_path_eol(&path, p, "path");
> +	tree_content_get(root, path.buf, &leaf, 1);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
>  	 * until it is saved.  Save, for simplicity.
> @@ -3202,7 +3192,7 @@ static void parse_ls(const char *p, struct branch *=
b)
>  	if (S_ISDIR(leaf.versions[1].mode))
>  		store_tree(&leaf);
> =20
> -	print_ls(leaf.versions[1].mode, leaf.versions[1].oid.hash, p);
> +	print_ls(leaf.versions[1].mode, leaf.versions[1].oid.hash, path.buf);
>  	if (leaf.tree)
>  		release_tree_content_recursive(leaf.tree);
>  	if (!b || root !=3D &b->branch_tree)
> --=20
> 2.44.0
>=20

--OgIFsyR1lGb9PWCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWMT4ACgkQVbJhu7ck
PpTUtg/+MFgznepBxW3w72PV7Eg9Bna0p9k3hbfO1yAzWe73ArfWzXdHpWcJSlAL
GcCZRFbvohry3hFkJ13lTNUplrZLoK+jN9Ekx5MpDO4SLULcr8zx61BTGIVT30wY
NVcVsxlpYX16ix49+U1wdFAyNUzT+VUoUE/eJH0MxMT8xi+R2AztLGw08iVuUJ5B
gfS/I89vvlpQ+QnvkKA0Ap0+t+pJlrUhVKO17WBfF4qEuoSnQLORygIA6dRCNRb0
i6G2uKammJxbu1TD81JgRDboV8+yo4QGRxMRdJDTwJK6UGvJ8AAAkxLKYo5dFcXN
wBWzgRkhQuP3vgy7wm5/DtOE/C79ACL8fEFHchXc7VvBNhLZZhDFDkvU/S5B2E+X
cCKBJ8f+BMBqiM0Yj23YZmpKDSJQhyj81xuYRhwiveL1Bj/k5I9P2W6Ble9wYzTu
Ztbh3IQSV8rDMzOZhGL3/wuQq/rygSpyhbkbxVl8gs3TPn+kqCZfnyp2HIsch9EY
HB5WLcOH4Hz1nwYpGDLZea7dkeBbPs84conUDhpFEr9gc7dI/g50I3f+hViRgEIp
IL+8wj0CTXyci5Xa451h2EpFI7z/Bi0EL57T9ErKa9G6xAMiq4asnrFiSwGxpeu2
wzSRArFtOOA2BrOqwL5yWbUI8L1O+p52+aXsTkE7oWl7S2b2LC0=
=JZnm
-----END PGP SIGNATURE-----

--OgIFsyR1lGb9PWCT--
