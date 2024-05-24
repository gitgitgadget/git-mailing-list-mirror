Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C684E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545082; cv=none; b=Bt0kqfpVPquAizMgvp3pHlX0YhDttNkD2aItO4rG+lthNebXxl9J6+VvmGCxFlz/Laz04LZvEQapHyQdx41aUXvVUjcAi1Jb9ZWJO0GTUu0+07mlhjEMXky97pnAl6Y77suWX5mYfQ6K+LGe9jfWxB7G4RP0cicls4g9uEN8OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545082; c=relaxed/simple;
	bh=XbmcA9TOUUM90hRD8ONpjFWyNzzwsiHPFXVw+PY1YYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA9YSlYhGqyRt8E3QLWQQoAD/XPXe28kmKdcBIsC7NNKnJUDKOstzurXyGIz9NUrtadIYSGIhRp32wa8DiT16xWuHR28L7eM+MoIlk/UlyNCbX+BpRoSUpx3TysEuRKoQdohJK6AMFqIgPfiiIJbPWQoo80WZ/ypOSci/i5GetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQBkAN1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBu5ZEJ6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQBkAN1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBu5ZEJ6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A073C114009F;
	Fri, 24 May 2024 06:04:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 May 2024 06:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545079; x=1716631479; bh=P6RW0bokoK
	nTuIDmfWrpn7m/LgRPeahWdJSJrck2/fw=; b=HQBkAN1ORfIXsgw4PCt5mUZAjv
	LCQVduNSxMYbodoWq1au/gKBXyJhdb4q2VFHTU/AzQLGs4ZECUvSqd0kzo4+YUx9
	1lYSKdle4agVIEhRe567VexsUy5a1yguHZqtZb9Yok2yX8146VJWIjNwFuCkbxMB
	EC+3wuhr4lUKtyc00v898LRKyAPcPLSB4cWGZ1Q78hn50OjTSyiTSE4mlTFju83R
	G/IJ3FxHCdXhYS95hK/o3FKP8WbHYqIkeBFi7JQXq/aRBXz33AN/HbaOa8JaD31i
	+4XUSY7uCxxtEArnQLIu/qw487gk8dMmm+xUP/jpO0plWyvPlzXXgFiss8dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545079; x=1716631479; bh=P6RW0bokoKnTuIDmfWrpn7m/LgRP
	eahWdJSJrck2/fw=; b=RBu5ZEJ6FbY4Wsh2w4bBGpQ2sbBMOyIks/6rbYSXC9d8
	35ty+vt99vZDviBEPSC/P1jOszVlH9SUNvJ+vsLLYOc10ch0f6oOS9SxO0HWRbOf
	kWCOK4v6AVc29Uzl5XREyVwgloyTw6YIgp8bhevCdwFl5Gw/4wOY4jCG6ZuE+vLD
	EXJW+uOn3qzj/9spV0VHUVfDfmiEuoG1xPlVFPsla0KRcQjWqszBWnEi9U9s2f7k
	njWbRYGxUf0m4nMltulWPdhm6F0siyIsxVw0PRCFW8WHrSahyDg2LfYEgPc6GHd5
	HnivAsDNH6o54nA8hm75x9umUzjj8AittKs4oQCFLQ==
X-ME-Sender: <xms:N2ZQZhngAY_TN6ngonmHW9TqBUvJI80Fb3_-jGUlMLsUjxT7MmWcqg>
    <xme:N2ZQZs38JCAodB-SRzGjwraFxRMRa6l3XPq_lO3nio5OzchLvfJ-ezIFszMfsDZod
    45pOvyxxsVgffQnnQ>
X-ME-Received: <xmr:N2ZQZnopPLVRWQIvvEdyluzZwlxp-d1g_9c1jqzaoamexgsNSV2frxfAMzglE2zPTfb0pdi0JD8K1qJ3_x_5fAsp3XAPvEXTkHg8JgdbpfGId1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:N2ZQZhmxPIUzYri6ATJkmQY6WXCqBe1fQRc4Qg8cYq15WrRj_klzsg>
    <xmx:N2ZQZv2hQ2-B18pNPoUgXZQaUWBWUsWku6L2Cb-IPlVwA0kmbSip4w>
    <xmx:N2ZQZgvjd18MIjK8XzS4NVLl7apdONcBpoecMuZWWVdQlAc_YCvFgg>
    <xmx:N2ZQZjUfyabsOdVyBwq3WJU22e6um-TQ5vquj9thljNjqObchrU1cg>
    <xmx:N2ZQZgx_t09STixwxzmD33czhZ7ricTsYoy5X1TO3aU3D45Xe2UGJhqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f7041c68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:35 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/21] builtin/mv: refactor `add_slash()` to always return
 allocated strings
Message-ID: <1310b24fc2b82d567a8b9dd46c5f93ecdc87accc.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgfANaOxzvtb3SO4"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--xgfANaOxzvtb3SO4
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


--xgfANaOxzvtb3SO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZjMACgkQVbJhu7ck
PpSOwA//TryLp5rOUPkXaAgC2MODeaNNbFJWnXP01QdeYzzaBnOsEJCA1VSL2Wlh
d8ixHv35TLcEpOXzmPAQuZgfds6LGM764RQMflXNbN+nO8BhCvx7nd4K4mtyMLmg
dwB3e9kdtOYfsC/8StgztoTGpEnXXLGBFbiC8PP1X3IvPGWcXHaJ9MV6NsAGAsPF
zX0z2SuAboYjDCvojrC1SBGF9iXiREOgCCFvXzCbvyFD2Tkbi0dh3rnj0zWjV8XZ
G+ojMb1y7kqFZHE/qzc6XYV0h2f3FW7KdUMlxu5KJeO69i17+Yfo1WMQE5hazMEC
ryosyWUusBDORc7Ayg7VWEYzQB/vnIMACN4TI44zDCflC3IGC6jQnaXFHW2vHEVF
SWextf6ek6mNRmjCpGszbQHRX4dvAHbH1crMEGJ5H1hKH84cuS1gZlb7li8Fowai
MJLrrlz0s9R9MTiu6p0fHZUyaYaCJIfqKTR2Hl+zhqt2CB2G1Hyh3Ml4hKqIYnJN
GQMkJ2W7KRbcMWopgMyHdAEGSE0+1y+RztOGUwM8G8ARBGSO9kPAiFQD82bWx4qd
7Lr9rg5uLivPHdWr22HghLIiVq1MKatPLzlkP4F5G3OtaIi5jRmBCeUtq9O/nj8N
1pkd30m11Ea/Q/KwUegaOskfeEPtRsKr7BzfmWlGEMcKxE1BWqs=
=oBu3
-----END PGP SIGNATURE-----

--xgfANaOxzvtb3SO4--
