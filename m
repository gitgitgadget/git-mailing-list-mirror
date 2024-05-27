Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A76152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810435; cv=none; b=MHmG752BxK7ZkJjf46daWxtDoFXvhZ2AARsj1Dto7L40Ite4QGnCo8H/ZPwm3o6+cg72u4CbYV3JuaHz3AqT5X/qpfev3qJ7/7rfB3p2fUH15a44CXRskalpJvNkOlpE5GXpAS8hUf0YIEkAWvfXeuW3BhSGprvJI76Kdrq5Tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810435; c=relaxed/simple;
	bh=m15Q2qGLXo7dgU0rTr4Wp2tcW5g4g1+7PrlA5in7rgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmWpPA4gMCX6jVX9LXeq9eJj3UlLHvtu+mzboLnKk0BGTAGhuvDaOuZoOB/hdI7Z7GIo55OB2yvWY/7zXFbeIyA98LtUfhNYfpc596quolJv3s+dAZlO6wQvRZf2P9zW6W2it8Qojp7MvQUCZNRK3kvgQSIlucsiOIshjO13QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1tM/KCj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1KKxxHP; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1tM/KCj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1KKxxHP"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 7B9AD1C000AF;
	Mon, 27 May 2024 07:47:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 May 2024 07:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810433; x=1716896833; bh=JOu1SOFZv4
	CL3KiBbCGI1sukxDE+xURPP5bBYO3jYak=; b=D1tM/KCj9zh80BamWIas81Bncx
	AN2fuuwBiFlUpLFHRxwf+6eWl0Pmnh6fyDYoiTL6UhFibArWx2RljkOWYauIOxZ3
	pXusamiVEKEk30siQqTOdYIVABFAlPSzqhZi0ew8XprdbJ19v3lkRSAchLR4xzpS
	jtQROBM8CetS4QVAaKnvDGzgFjBZaFGqd23mmmNx2yhbMsYLY89LJ42WngZ3p5Tl
	FCEQKI/ZDR59rsXFJou8QPU0zmcFZUR/xHS8Lq8KWyZVF3tOLyrStlo5aXDXTxii
	ZuBKz2KdNuC/6nMaZt+DeFNn0by+Xli5jknTxKVGGC+optuWslQPBT0J+Aow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810433; x=1716896833; bh=JOu1SOFZv4CL3KiBbCGI1sukxDE+
	xURPP5bBYO3jYak=; b=M1KKxxHPDDv3yjghXRbV4sI7WLK58yAxrk3mZMMdqnQn
	MBe/aZZzWYP3tYBf9NqgtLdUewv1a4CPNK9MF4Udbx+8yw2NfhSOLMdehYRGxyCb
	SYZpn+BaEzcEoVXXJ6PCu5KzWZ0bV4E+x6dp6+Hac5a9+0ttjJXlhEhz3XOW9G1F
	bbjfaiv3/RWwhxiO0RWbqJr/+WW+XkcV1d538qJqCuoRC41wyLBlogj8FR/8PPns
	sUof0GZhWPAbdAAiJ3FKAj1jKzyQqQabzcYEIO5XmFsWZK61TH0tLnR82rqII+Em
	0UuG8jin8OCQ4qJbo/DNrf7kx1NJvLIOBUAtAttKbQ==
X-ME-Sender: <xms:wHJUZsL-kXgjCSlyv1Fxueb_VqsSm5eA8HpTSdIgvHvMAkySY_aAwQ>
    <xme:wHJUZsLg2d-NTzWiwmH0FNrDlxR4WpCQhQUlDF0KNB2G6ZuFWAaOOoDI4odUi_oMx
    zWKbksfsJNYMy7pSQ>
X-ME-Received: <xmr:wHJUZstW63UKppR8sE5Xo2m3eyrksCtTtlMnfpH6_Hm27fRm22JnloQKVP1fJK4ZtT-YZPjaWzwHBa7rjOvVn4l4I2M_wJORrcazwzOjFYiWX4354E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wHJUZpbCNfebGpqgfU8ERrAa3LYoLPg4Ga2PlCxq7BCiG1U2c_BVng>
    <xmx:wHJUZjZiQkGVHjDscaU0vn9-jYTySrXPnVqphCa8xnB-7cPl8LP6NA>
    <xmx:wHJUZlDxLkxt_y-ePwkCa57EOzCq_8Sm-oHLuZb5GT-yVpKVdkvpdA>
    <xmx:wHJUZpYwKOUxpxa6BPwZGJzBEoKnHYlTcd8uG_ctrsEeFJ-PSAJVyA>
    <xmx:wXJUZuyPy1kCwaAFyo9uA4mf3S8qwMuyl0ewoukDELvkm9pb6cXp-5xi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:47:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b787345e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:47:01 +0000 (UTC)
Date: Mon, 27 May 2024 13:47:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 18/21] builtin/mv: refactor `add_slash()` to always return
 allocated strings
Message-ID: <1830e2a568d4a97c914b8fc6eafdfbb62527296d.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HAknIRn1AEXe3c/O"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--HAknIRn1AEXe3c/O
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
2.45.1.246.gb9cfe4845c.dirty


--HAknIRn1AEXe3c/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcrwACgkQVbJhu7ck
PpQRIg//eSYABXvxIjHZu8l6vNM3Qk4/p14cgUvN+TIW/SsCSMpYxYrrHOWAmfoY
h21HvfyxkbXqqnqaXHs6OQ3MG5mdhvwh+ppYFJ9OoyG19BC/t962MZqqHALhkyaP
tODD7s4y7pRRW/YlO0YrnmTk2QK9+8kt0qbkzlCdpHU1QIfoesHcGsuv0xzUWHt1
d61MDyQ9d8m5gJR3hi1OGzG8IpyDdT40UV/zxh/5O0zfzpqTKsqEQ16px4FRaFLu
freQE/ZJT2ysglNQMp6gwVuiJEu669fHIKcI7jPByJkQtySGsU9wRfwFmiAHv7YW
a35nQw1Je9OcyzBgJeRMyt0SQSAciGLWm08uPCxUheGceZCYOoChcY3L9FloeJoX
rob6GZpkddxyHK5NlZ6nF2wfIKskshgMndmnHNK8BPB9pe74bPjnzv+76ahhcXGo
Ps9m7RfvyVfg0R2O+TD8BQT19RfMOvOjs4gAbSwRcjlAHi4DYkTA2Yz26cDe2Hsj
N/QYEU7m1s1uS+mfT9OIYqxYlmA+z2QWBZUof4kuQN4Y4VyWkppYOhbegzytEF19
goXHgnxNnzOYlvhvJc6S1Glv4beUKpTt7RFn3ztia87usGtJKuUh71rInQGyqW8q
qutuwcRdt2s58dB4QCAugdLnWDrd9gUotpaTvRZxodHD3U23TW8=
=5TDa
-----END PGP SIGNATURE-----

--HAknIRn1AEXe3c/O--
