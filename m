Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE72CCA0
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614073; cv=none; b=Zg561vpjjAFnBVB5+L5awIHCZx/iX17kjPWZwuWQu8V1nNjKyCiIm4XKMyDC1u1iA3+4KSFhpUOFns0FbK6aiM4ky02MBiJPS3NsdRQLEmWcvIhpIRDZQpngKkd1wpW4ARaMEK8Ky/6Fa2nQOz3ptno5TzVRZRCgD3eULziy+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614073; c=relaxed/simple;
	bh=V97SEIrHMrOnm2UroOebI4qM2D1qouHwj+5DvGYpRcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhVD16a7ZUIBX+LZ+JCHJ+gXU8GJ/DA8hrA1KAPD1iEFdAsH38ZW8bHEc/4i/DDWTrIrwQpwwnJiUcUGw2E83XWUldbYDfOvPokw3ZgIbpVOBbrYJuuUdYmRXRwXcLCr93pNJpmDULt9qPxboR7J82qApaC0nKv/PKPNtVwVjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GgYE0eFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOT2uk8L; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GgYE0eFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOT2uk8L"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 34F0D3200A1D;
	Thu, 28 Mar 2024 04:21:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Mar 2024 04:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711614069; x=1711700469; bh=lgZzCl0Eg/
	pNmKesHOIj8QiZtuswbj7J3Hw1VtV49OU=; b=GgYE0eFLxlwmItdnFZsP5HkhOZ
	DnSAxvG52oSZEtOkLx3ok3nfYysn+/dL2T4G5CYWRxv2GhhCjA8Ui40CiMEQ5ib3
	wj7J7TSCp0qvcwcbADSiM6V7va+aeS/iNPr/B0RzidozR5LsUM7YVAMHg0hpvhsZ
	cUzCmBOym0Y140+eqmSC8VKNxjhvT0vCN5dVTSqdLhTHT3BRdZNmEAdZM/vHgopx
	D8BIQEEecxY20QyerJa0whLEieuognAlmuEYwXruO54RA/r5utmmnwQyrE15DqhP
	Fnbs0YOkyaIvmgot1ZyQ4xx0zrkG018M0AfsuAKfiSFEe4it+rNn9eVb8Zag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711614069; x=1711700469; bh=lgZzCl0Eg/pNmKesHOIj8QiZtusw
	bj7J3Hw1VtV49OU=; b=xOT2uk8LVIMXk9DeNBkDDq1CcjVO4IwQzDYfF8LNl8um
	R2iWDcTimcZDSsSsOm1OVysBmcLBKyrzpgqHRVanp9pSUElDl9AqqMpX4U67N31/
	2a255vdCL5kz3h/2J4LwXl1oSZG1gBd1u9H31nt+KartRFTKbvws4PZq34HqVDZl
	gOgL50TldjQEcfA5YIPVWDm6Qisjjx+D8sr3JJFOB3XRKNwEirN6ehLTjuWWK3DF
	rgHXkgAsbJIfjQJO9wBO03qPMBiWY5/AsO0uKfUV2czKned4bBrJTO4CkZQ/bFHw
	xSnjpfwyNxuKsBglB0BEnOvIPq4GFkqzUMxwK6zewA==
X-ME-Sender: <xms:dSgFZpf1VODcqGiDHWN1ynORzDO9NUN1wncmPu5oK6n1Ol0KF3Xzag>
    <xme:dSgFZnNX_HnRBEqKsX5rYyu0q45rkcRL_88D4XihpHoJIU1RdY-jN2nZwlENG7PAB
    wvtuPoPQbiq40SYvg>
X-ME-Received: <xmr:dSgFZijmZvZepPesahBrNHFXVrlOWPGiBjaUL9l07r0ibZwwLdrYBjczzvRQeb3OGpANPYD4WhRXzJKavDoZxLui9Yc1iC6VNt-QF5r_yMlGn8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dSgFZi9bW37yvitHTRTGZQKsoqS70hYGcHepUpVfWCnOJ1LB0lDQtg>
    <xmx:dSgFZlvRae5Ve3-SsDh5qVpwJh1L350xqOXqBD-33iYoqiQ1LVFlFw>
    <xmx:dSgFZhGC8P95HPLqh9YaTFdHVPdWFIg0E6vSb_93iYGhWil7GTkaGw>
    <xmx:dSgFZsM4jCYsyCURotkIqmqDAoOQJtSiJioVTnCfUgGsFZF1nW99mA>
    <xmx:dSgFZtK45p8VwKQGCvFAbHkqtjvWDz8rkI-FcMa6cWINN0fqMCPqCA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 04:21:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 406fdedf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 08:21:06 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:21:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/6] fast-import: directly use strbufs for paths
Message-ID: <ZgUocuwnNQ0fsRhI@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <20240322000304.76810-3-thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gRtdTGwH8GbEcxvR"
Content-Disposition: inline
In-Reply-To: <20240322000304.76810-3-thalia@archibald.dev>


--gRtdTGwH8GbEcxvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:03:25AM +0000, Thalia Archibald wrote:
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
>  builtin/fast-import.c | 54 ++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index b2adec8d9a..1b3d6784c1 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2322,7 +2322,7 @@ static void parse_path_space(struct strbuf *sb, con=
st char *p, const char **endp
> =20
>  static void file_change_m(const char *p, struct branch *b)
>  {
> -	static struct strbuf uq =3D STRBUF_INIT;
> +	static struct strbuf path =3D STRBUF_INIT;

I was about to propose that we should likely also change all of these
static variables to be local instead. I don't think that we use the
variables after the function calls. But now that I see that we do it
like this in all of these helpers I think what's going on is that this
is a memory optimization to avoid reallocating buffers all the time.

Ugly, but so be it. We could refactor the code to pass in scratch
buffers from the outside to remove those static variables. But that
certainly would be a bigger change and thus likely outside of the scope
of this patch series.

Patrick

>  	struct object_entry *oe;
>  	struct object_id oid;
>  	uint16_t mode, inline_data =3D 0;
> @@ -2359,12 +2359,11 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  			die("Missing space after SHA1: %s", command_buf.buf);
>  	}
> =20
> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
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
> @@ -2385,10 +2384,6 @@ static void file_change_m(const char *p, struct br=
anch *b)
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
> @@ -2414,49 +2409,45 @@ static void file_change_m(const char *p, struct b=
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
> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
> -	tree_content_remove(&b->branch_tree, p, NULL, 1);
> +	parse_path_eol(&path, p, "path");
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
> -	parse_path_space(&s_uq, p, &p, "source");
> -	parse_path_eol(&d_uq, p, "dest");
> -	s =3D s_uq.buf;
> -	d =3D d_uq.buf;
> +	parse_path_space(&source, p, &p, "source");
> +	parse_path_eol(&dest, p, "dest");
> =20
>  	memset(&leaf, 0, sizeof(leaf));
>  	if (rename)
> -		tree_content_remove(&b->branch_tree, s, &leaf, 1);
> +		tree_content_remove(&b->branch_tree, source.buf, &leaf, 1);
>  	else
> -		tree_content_get(&b->branch_tree, s, &leaf, 1);
> +		tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
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
> @@ -3186,7 +3177,7 @@ static void parse_ls(const char *p, struct branch *=
b)
>  {
>  	struct tree_entry *root =3D NULL;
>  	struct tree_entry leaf =3D {NULL};
> -	static struct strbuf uq =3D STRBUF_INIT;
> +	static struct strbuf path =3D STRBUF_INIT;
> =20
>  	/* ls SP (<tree-ish> SP)? <path> */
>  	if (*p =3D=3D '"') {
> @@ -3201,9 +3192,8 @@ static void parse_ls(const char *p, struct branch *=
b)
>  			root->versions[1].mode =3D S_IFDIR;
>  		load_tree(root);
>  	}
> -	parse_path_eol(&uq, p, "path");
> -	p =3D uq.buf;
> -	tree_content_get(root, p, &leaf, 1);
> +	parse_path_eol(&path, p, "path");
> +	tree_content_get(root, path.buf, &leaf, 1);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
>  	 * until it is saved.  Save, for simplicity.
> @@ -3211,7 +3201,7 @@ static void parse_ls(const char *p, struct branch *=
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
>=20
>=20

--gRtdTGwH8GbEcxvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFKHEACgkQVbJhu7ck
PpQSew/5AVGC1c/mAwznkdVhePMhuY87ngr84AiVbIUlV17Fkgq57xR9GcE6v2a6
4a/kw4OfF/gpyDv4zFcSw2giek5MEfIfneRHU4e6uy+vofOOOeA+GZMdvFn5fSjQ
11ftF3cEPo0f1fb6Zz8owAcYTRwpy/Lv6pyA+iEkl6uXeuJSQlACcGZjvGiEapx+
emFBXkHt4Q8bbdotIisrYuYHl+OV0psswWwGq6hx4G9Qv5xzjDh44zh8oC8v2TsS
YWjLXrHVmCNw2jxRi3m7j/vEGoevflFYxTE3JmPbwkmVsJEAqSg0VeCcs/YM651x
omNQB4aPxMKLVhC02r3XkibkSFWEOGyTJGb0G1otx3OWYKYL/D+LcSETgPlrRs6Y
VEQriTuYXKQr1iDte4mxxSQYTXx9j3wSZfBS3h8MfSGAV9Ia4xOmsrj7lmwAuSab
XF4Z+yaYaym0pKCr5lAoaNUxQnSE1wopgyS47aWzJxZMfD6/w/CiU1B2T8AD5Obw
uTA7h0PZD08mydU6HQsLjwTTDWADXoawx7QmkDEFRt6aSaO/W92Gw+pF43rPaR3t
kCZMhhUxEIplQY4NZUVFylMDISlbro/0a8mLzzSjJQu/5aGCkYdWr0QryKr3XLgR
oG7c1/oAh4JFsWj9SmVQqMY1SxmfvmdK+Pk4igXfm+6MDk4En+o=
=pdKv
-----END PGP SIGNATURE-----

--gRtdTGwH8GbEcxvR--
