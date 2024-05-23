Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1E13C693
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467199; cv=none; b=i0QGm68Q5sYmuzDkq8SolwrRTCfS9lq0Idqufm77SKdANymuqliLl/afPONBzfv/Q0rsuRc/vDIk9fGYBqI4O1biNbt4xYnK1Y93gH7AaEo9Rjr/YssBAXbIYIhmL1o6Ws+d0pm3NeGpEZ/2ER+f0X1dlavQxKuoCckH6s4TYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467199; c=relaxed/simple;
	bh=e+Vv/VpZSuLk96UoC0bsZ8dTDUsFe/S9qDhp1jJ4FoY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyEbTF83g6u3zfULsM5DHkpRLomNnRAJi8aUv26XvRf5HomZ8srEqICqTI5m5Gb9u/0os6Eg6LvYv9Z9Gb4KnBwd2Nn+nKMAGEs9TgV24d8xyULUFZlfvmLsISvOXzHOb7sLvv8kNbodcmLUsmHobl8g+gMU7oWxbABIazVYYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pHJMXDUc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1ge12bR; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pHJMXDUc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1ge12bR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E138A18000F0
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467196; x=1716553596; bh=wavjjhVUVG
	+JOOEXyAzqv/Y3AfBBKWZZvSsRA2pIiQo=; b=pHJMXDUc582UUDA/RkZWFoJb6d
	adBx+S3fjQ+45a5fxvON3iM6BDlgvO1WfzHFnKbjATbMmmYN1TwYnY0Ej9Cow67E
	Fu+T8VmBi2ny/wsi1uF/hWBgU92/awfDjbuG/MLcEeiSdHIYXaijq4LnbpRiybjt
	M7du9g+Diu574ZhMNpo89+w579QGabBqTa3PjHoLMiLJ5YOxldgqSrJsfghtmdZv
	ZyZs6lzJHQUh83qQYrGdqZtAc4aAWyrjQh57XQcbn9LkKwu3ZlX5JWIn3RqvHjCN
	8Si2rsLVpWtH5IL+S3FsqosxfxA9lXtMe7/Gr5L0iwL+9yX7SRKDOwWIqcXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467196; x=1716553596; bh=wavjjhVUVG+JOOEXyAzqv/Y3AfBB
	KWZZvSsRA2pIiQo=; b=Y1ge12bRxi4Y7BIu+NkqTmhPwv0QeaORex4i8jN7/lIs
	P9F3aXQ9AssG3LIEfibW6kKoxTJ9+OLJujm90a4d6O5ph4M7MZ5Rj2Bigh7VCcjo
	ko8uCcUwHrV5RFiMccLljNfFf5F689sY+zdw4cWD2PS+JKDiN//zaDdhUGL/pHZl
	LrusS/bvfRFoxmWgDwIOqfVld+I/w2KqfJmamISgilh9UlH6rKkKfWRcLwOIrKkd
	BH8qusZmWF57xbeDnD1ZPvzZ9bfA6no5mgDNCIuHq23ZMJ4TiUnYcLdoDusATqG2
	f+FeXM7P07Jdp09vIs2W6OH0rS1VW8gNDcQHFsielw==
X-ME-Sender: <xms:_DVPZjiiIXChd2-pglhhm9RKex1IgOhMmHHdRLyzw_6NFRhwQ9HIIg>
    <xme:_DVPZgB-pllA14TDLprrmqzwoTl88_u-HXPkJhwQi7X9n0aeXPtcCP1VFubpZ9Kph
    dEctus9FNfn9h8-_g>
X-ME-Received: <xmr:_DVPZjH-d-A-jJzKUenSdeyK9G0PXArs1TUs0K44a1Nf-lchHkGh-OM-Vk_FJL-jC-lgjaeM46A7LX0rSqmJUc6Ern-ch9q2w2pEubnU7NQiJz7eTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_DVPZgSthnmzHUvudKhj0cm6sADZiMIV3BVIMyd86G20e87DYu9S2w>
    <xmx:_DVPZgwHvfEs6uIlL0AcDkWpwMa98q_LfU97DfoP9OZV7Q5SG9ZQKA>
    <xmx:_DVPZm5kxymb6HOn9qfCjSemHPkViHGTFZJ1_FClxEYvlEJdNbcTJw>
    <xmx:_DVPZlwoJlpHzuJ3yfzjN2yn_73WN7m12KRMrYGEgMjEUSLWSmih_Q>
    <xmx:_DVPZtrUvOg9W1Aa_3LL0KKFw3wKYG2SZJFM5dY4Z-CWDvrWdWQAyHLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0432fe6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:29 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/20] builtin/mv: refactor `add_slash()` to always return
 allocated strings
Message-ID: <97470398ad943776577f18ad2e19bb8707e6dc46.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WzaLnT7ZLdsAkRHa"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--WzaLnT7ZLdsAkRHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `add_slash()` function will only conditionally return an allocated
string when the passed-in string did not yet have a trailing slash. This
makes the memory ownership harder to track than really necessary.

It's dubious whether this optimization really buys us all that much. The
number of times we execute this function is bounded by the number of
arguments to git-mv(1), so in the typical case we may end up saving an
allocation or two.

Simplify the code to unconditionally return allocated strings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 74aa9746aa..9f4c75df04 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -76,7 +76,7 @@ static const char **internal_prefix_pathspec(const char *=
prefix,
 	return result;
 }
=20
-static const char *add_slash(const char *path)
+static char *add_slash(const char *path)
 {
 	size_t len =3D strlen(path);
 	if (len && path[len - 1] !=3D '/') {
@@ -86,7 +86,7 @@ static const char *add_slash(const char *path)
 		with_slash[len] =3D 0;
 		return with_slash;
 	}
-	return path;
+	return xstrdup(path);
 }
=20
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
@@ -111,7 +111,7 @@ static void prepare_move_submodule(const char *src, int=
 first,
 static int index_range_of_same_dir(const char *src, int length,
 				   int *first_p, int *last_p)
 {
-	const char *src_w_slash =3D add_slash(src);
+	char *src_w_slash =3D add_slash(src);
 	int first, last, len_w_slash =3D length + 1;
=20
 	first =3D index_name_pos(the_repository->index, src_w_slash, len_w_slash);
@@ -124,8 +124,8 @@ static int index_range_of_same_dir(const char *src, int=
 length,
 		if (strncmp(path, src_w_slash, len_w_slash))
 			break;
 	}
-	if (src_w_slash !=3D src)
-		free((char *)src_w_slash);
+
+	free(src_w_slash);
 	*first_p =3D first;
 	*last_p =3D last;
 	return last - first;
@@ -141,7 +141,7 @@ static int index_range_of_same_dir(const char *src, int=
 length,
 static int empty_dir_has_sparse_contents(const char *name)
 {
 	int ret =3D 0;
-	const char *with_slash =3D add_slash(name);
+	char *with_slash =3D add_slash(name);
 	int length =3D strlen(with_slash);
=20
 	int pos =3D index_name_pos(the_repository->index, with_slash, length);
@@ -159,8 +159,7 @@ static int empty_dir_has_sparse_contents(const char *na=
me)
 	}
=20
 free_return:
-	if (with_slash !=3D name)
-		free((char *)with_slash);
+	free(with_slash);
 	return ret;
 }
=20
@@ -178,7 +177,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	const char *dst_w_slash;
+	char *dst_w_slash =3D NULL;
 	const char **src_dir =3D NULL;
 	int src_dir_nr =3D 0, src_dir_alloc =3D 0;
 	struct strbuf a_src_dir =3D STRBUF_INIT;
@@ -243,10 +242,6 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 				dst_mode =3D SPARSE;
 		}
 	}
-	if (dst_w_slash !=3D dest_path[0]) {
-		free((char *)dst_w_slash);
-		dst_w_slash =3D NULL;
-	}
=20
 	/* Checking */
 	for (i =3D 0; i < argc; i++) {
@@ -265,12 +260,14 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
=20
 			pos =3D index_name_pos(the_repository->index, src, length);
 			if (pos < 0) {
-				const char *src_w_slash =3D add_slash(src);
+				char *src_w_slash =3D add_slash(src);
 				if (!path_in_sparse_checkout(src_w_slash, the_repository->index) &&
 				    empty_dir_has_sparse_contents(src)) {
+					free(src_w_slash);
 					modes[i] |=3D SKIP_WORKTREE_DIR;
 					goto dir_check;
 				}
+				free(src_w_slash);
 				/* only error if existence is expected. */
 				if (!(modes[i] & SPARSE))
 					bad =3D _("bad source");
@@ -310,7 +307,9 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 dir_check:
 		if (S_ISDIR(st.st_mode)) {
-			int j, dst_len, n;
+			char *dst_with_slash;
+			size_t dst_with_slash_len;
+			int j, n;
 			int first =3D index_name_pos(the_repository->index, src, length), last;
=20
 			if (first >=3D 0) {
@@ -335,19 +334,21 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			REALLOC_ARRAY(modes, n);
 			REALLOC_ARRAY(submodule_gitfile, n);
=20
-			dst =3D add_slash(dst);
-			dst_len =3D strlen(dst);
+			dst_with_slash =3D add_slash(dst);
+			dst_with_slash_len =3D strlen(dst_with_slash);
=20
 			for (j =3D 0; j < last - first; j++) {
 				const struct cache_entry *ce =3D the_repository->index->cache[first + =
j];
 				const char *path =3D ce->name;
 				source[argc + j] =3D path;
 				destination[argc + j] =3D
-					prefix_path(dst, dst_len, path + length + 1);
+					prefix_path(dst_with_slash, dst_with_slash_len, path + length + 1);
 				memset(modes + argc + j, 0, sizeof(enum update_mode));
 				modes[argc + j] |=3D ce_skip_worktree(ce) ? SPARSE : INDEX;
 				submodule_gitfile[argc + j] =3D NULL;
 			}
+
+			free(dst_with_slash);
 			argc +=3D last - first;
 			goto act_on_entry;
 		}
@@ -565,6 +566,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
+	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
 	UNLEAK(source);
--=20
2.45.1.216.g4365c6fcf9.dirty


--WzaLnT7ZLdsAkRHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNfgACgkQVbJhu7ck
PpTCuQ/9EnYq55sLM0twMFbuolRsY4wCZZM9rRfTomCBRMA2H5qUdnHAY9UBk9g9
mWmPihIBihUaF3fBsHRKlPZgb6ukID4wdTZo8WBx3xtECRqcuadG59jZBTTkNeuD
oD7IaxeGQIqvl+6QkgxgbMEEkqqR9cGLVVYth+Tv1N1EI38A+D0VbqvzmwoF/XPP
MhEeTAHNG8RxKANL0ypmgb839fadDG+4YQXG5kfWZrKrzwnBjyM5iDY05dgvPpmT
uCnkW8r8NKfOml1NGet17dv87ESqLrfYYV0tSUE3AQWhR+iMGkN3IkF20rpaAc+C
dFHVMgpAUzAYC2/DyRtKVJTSd+ygBbvbq4Iwo5YXgzD1a6HJh0F/d3NXR4AvSIHe
0GiCWHYZk3RW+02v4zk2jC7wOWfERulm6YkTag7QiTNnS28vtDHTslsXvaLctYcm
CdiHpO1y/3b0Y8SXa8VaSaOhAPtlcM9X5IvnYrTDS/SkRWZNR10EJlnzM9uHMY1h
V2EOwiVsfnFOSypTlyFeEOl7zXmabmderqWVVdyv86z2pzVNdeL9UhRWMVHLIrXQ
m8cRJLKHMIYimLsaewnH+1LlSKoSfCW68Acd0Pdc9UFJddBjnq4fJduUK9i/zzSG
B7eKFFQ3BR7OYfH6wtU5vApEmecrPTAKfYYCVWCfn9maFFr2Uy4=
=KBMr
-----END PGP SIGNATURE-----

--WzaLnT7ZLdsAkRHa--
