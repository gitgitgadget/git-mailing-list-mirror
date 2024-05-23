Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB13EFFB
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467210; cv=none; b=Ecbo4CI6StuX0tvej3SeMbBpmv52SefSdZqEQlByKOgsEAhmmZt32j5lN/DhzuDv1AyaNfpwWfck7vj+pV9XK17dTnTynxB3OlawXdhTjqaEGs8oSW0MO4qie8K9KsqgaP1Pdxuwiwj7HtzCo9A2bkEP6EAg4RjO+GAHqHzbPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467210; c=relaxed/simple;
	bh=NPOF7SxqBIow4LbOQwRC7N2Hm2hldT7PwHaTqKMyNXc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3YpqUK2+2EAVeaFcMo1g9meX4rp4IMQeeeHqF9d0cGpI9LyDOL3ki9xQ3rgLCpr3Ub74KcuFIYGsSloM3uIJCC/r51Q0Aoz2IlAz/azYsD9Ot2UiiluQVT1Y5Ii27vC5l1vSom3EWMk2BYN7mJoA+VVptBiWz+IB4AkQaQGe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lvl8/9hR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwwwQP67; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lvl8/9hR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwwwQP67"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B350018000F0
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467207; x=1716553607; bh=zbHDzRqkJV
	jeRiUVyhEHCXATYPFcH8GhLLRP9QKMx5M=; b=Lvl8/9hRbr0QDZbupg/cfN2HEW
	Jtk0q/HyodUQI/YqMosrRW7P+wB12RtppghrMVS8RNz5me4qeflkL3L7mWUC+L3j
	RRNpwn1LpLWM+pA4CyCczsgg/PQBSkI604WE5pwba6kH3eAahU/KaAaWtMjav3Jd
	tKibqFVWs0Dyqgem5ybXmYEwQT3US85Mb0pY8Bcveif37sN0KY/zGsNbJ1sJlhjL
	LqmAfUeEJzkfmRoLX67BwAEj+8IPiawvzZRk2Y92DqRYlJjTTgjfga4dtJk7BFhV
	7qaUI80leJNbdTKGfA0v9A+hnjyEuamYSRrlUS+DgZ7STQ6UUNT5ZcAZC2Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467207; x=1716553607; bh=zbHDzRqkJVjeRiUVyhEHCXATYPFc
	H8GhLLRP9QKMx5M=; b=kwwwQP67j9Zd6jazbFsprFrjJTQL/nRFNN+P+ZSOnhWc
	8YFo1OY8Jx2qb7zR2R7IXG/2gIuRP5bGYCXKIFoRr6Ywx+iJy8CnQyNXHLui1VEw
	kTXNSyHVsC5P0iTKXPIB3ylZ7EHaJU9+c8P+WZK/xS8HTr8tL2WgusPo4HqAp0H8
	Gug/+okcW3pD2tIZderCL7Pmm+huxDWlGUaqFTxPs9CqwPt84+MtscADy0/cUiBj
	UAnEILht3Dx3xCNbHcHDO3BL5qPb+U0msOurNxhFQFLaSx29nr+ZrAsV3SQ7lVbX
	dsOG0ySm0gxufjCXVmMLlNPJytv0LyJysyvvIXN9PA==
X-ME-Sender: <xms:BzZPZspnscXIulwBMTkARK0FveEy-qP1Iz86LDkGBRQXNI9yRCIrxA>
    <xme:BzZPZirJ9rGIKNV6L3vRmjFYLJ4hXp1Y_Ypz_GnrbhaaBwFK14wdpMJ2oGewiKLmR
    xdUCl-fH4N97rSgkA>
X-ME-Received: <xmr:BzZPZhO751R-fwO4Fbk2SUse3EYXeBxThPwibfrY0XeBNLItoL8cRowIfvwfL3Tzo39mDz_ZyFiHFLz-MaABfdX9-lGH-NA2KQlGrGMVw-B0kXij8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BzZPZj4lJY30_6_ScUb-8o3OBivQWXM5zAfTTUc2Bpz_Mr9f9e13zQ>
    <xmx:BzZPZr5Tss1mh-TB0fYzxgeC83ylKXiyV5xfg28n7qRBPjA8x_-H1Q>
    <xmx:BzZPZjj4OERgQZHzgARsYRfzfAJM0H111eYK1ereEM5WoshpL4URNQ>
    <xmx:BzZPZl6RgRGh4Bu2S-8P1w3jKVaTyflvq12NqUubWLFuPexnoFVukg>
    <xmx:BzZPZlRaOEO7InJPZTQkALyz3vIIpAOs01_PG59S55TGCcBeOgwFQh0G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4181b09c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:40 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/20] builtin/mv: refactor to use `struct strvec`
Message-ID: <b546ca4d62c6828df0080028bbf18020dface3fc.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EbMnNkAgtGobizh5"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--EbMnNkAgtGobizh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Memory allocation patterns in git-mv(1) are extremely hard to follow:
We copy around string pointers into manually-managed arrays, some of
which alias each other, but only sometimes, while we also drop some of
those strings at other times without ever daring to free them.

While this may be my own subjective feeling, it seems like others have
given up as the code has multiple calls to `UNLEAK()`. These are not
sufficient though, and git-mv(1) is still leaking all over the place
even with them.

Refactor the code to instead track strings in `struct strvec`. While
this has the effect of effectively duplicating some of the strings
without an actual need, it is way easier to reason about and fixes all
of the aliasing of memory that has been going on. It allows us to get
rid of the `UNLEAK()` calls and also fixes leaks that those calls did
not paper over.

Mark tests which are now leak-free accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c                             | 125 +++++++++++------------
 t/t4001-diff-rename.sh                   |   4 +-
 t/t4043-diff-rename-binary.sh            |   1 +
 t/t4120-apply-popt.sh                    |   1 +
 t/t6400-merge-df.sh                      |   1 +
 t/t6412-merge-large-rename.sh            |   1 +
 t/t6426-merge-skip-unneeded-updates.sh   |   1 +
 t/t6429-merge-sequence-rename-caching.sh |   1 +
 8 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 12dcc0b13c..e461d29ca1 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -20,6 +20,7 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "entry.h"
=20
@@ -38,42 +39,32 @@ enum update_mode {
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
=20
-static const char **internal_prefix_pathspec(const char *prefix,
-					     const char **pathspec,
-					     int count, unsigned flags)
+static void internal_prefix_pathspec(struct strvec *out,
+				     const char *prefix,
+				     const char **pathspec,
+				     int count, unsigned flags)
 {
-	int i;
-	const char **result;
 	int prefixlen =3D prefix ? strlen(prefix) : 0;
-	ALLOC_ARRAY(result, count + 1);
=20
 	/* Create an intermediate copy of the pathspec based on the flags */
-	for (i =3D 0; i < count; i++) {
-		int length =3D strlen(pathspec[i]);
-		int to_copy =3D length;
-		char *it;
+	for (int i =3D 0; i < count; i++) {
+		size_t length =3D strlen(pathspec[i]);
+		size_t to_copy =3D length;
+		const char *maybe_basename;
+		char *trimmed, *prefixed_path;
+
 		while (!(flags & KEEP_TRAILING_SLASH) &&
 		       to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
 			to_copy--;
=20
-		it =3D xmemdupz(pathspec[i], to_copy);
-		if (flags & DUP_BASENAME) {
-			result[i] =3D xstrdup(basename(it));
-			free(it);
-		} else {
-			result[i] =3D it;
-		}
-	}
-	result[count] =3D NULL;
+		trimmed =3D xmemdupz(pathspec[i], to_copy);
+		maybe_basename =3D (flags & DUP_BASENAME) ? basename(trimmed) : trimmed;
+		prefixed_path =3D prefix_path(prefix, prefixlen, maybe_basename);
+		strvec_push(out, prefixed_path);
=20
-	/* Prefix the pathspec and free the old intermediate strings */
-	for (i =3D 0; i < count; i++) {
-		const char *match =3D prefix_path(prefix, prefixlen, result[i]);
-		free((char *) result[i]);
-		result[i] =3D match;
+		free(prefixed_path);
+		free(trimmed);
 	}
-
-	return result;
 }
=20
 static char *add_slash(const char *path)
@@ -176,7 +167,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 		OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside=
 of the sparse-checkout cone")),
 		OPT_END(),
 	};
-	const char **source, **destination, **dest_path, **submodule_gitfile;
+	struct strvec sources =3D STRVEC_INIT;
+	struct strvec dest_paths =3D STRVEC_INIT;
+	struct strvec destinations =3D STRVEC_INIT;
+	const char **submodule_gitfile;
 	char *dst_w_slash =3D NULL;
 	const char **src_dir =3D NULL;
 	int src_dir_nr =3D 0, src_dir_alloc =3D 0;
@@ -201,7 +195,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
=20
-	source =3D internal_prefix_pathspec(prefix, argv, argc, 0);
+	internal_prefix_pathspec(&sources, prefix, argv, argc, 0);
 	CALLOC_ARRAY(modes, argc);
=20
 	/*
@@ -212,41 +206,39 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	flags =3D KEEP_TRAILING_SLASH;
 	if (argc =3D=3D 1 && is_directory(argv[0]) && !is_directory(argv[1]))
 		flags =3D 0;
-	dest_path =3D internal_prefix_pathspec(prefix, argv + argc, 1, flags);
-	dst_w_slash =3D add_slash(dest_path[0]);
+	internal_prefix_pathspec(&dest_paths, prefix, argv + argc, 1, flags);
+	dst_w_slash =3D add_slash(dest_paths.v[0]);
 	submodule_gitfile =3D xcalloc(argc, sizeof(char *));
=20
-	if (dest_path[0][0] =3D=3D '\0')
+	if (dest_paths.v[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
-		destination =3D internal_prefix_pathspec(dest_path[0], argv, argc, DUP_B=
ASENAME);
-	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
-		destination =3D internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BA=
SENAME);
+		internal_prefix_pathspec(&destinations, dest_paths.v[0], argv, argc, DUP=
_BASENAME);
+	else if (!lstat(dest_paths.v[0], &st) && S_ISDIR(st.st_mode)) {
+		internal_prefix_pathspec(&destinations, dst_w_slash, argv, argc, DUP_BAS=
ENAME);
+	} else if (!path_in_sparse_checkout(dst_w_slash, the_repository->index) &&
+		   empty_dir_has_sparse_contents(dst_w_slash)) {
+		internal_prefix_pathspec(&destinations, dst_w_slash, argv, argc, DUP_BAS=
ENAME);
+		dst_mode =3D SKIP_WORKTREE_DIR;
+	} else if (argc !=3D 1) {
+		die(_("destination '%s' is not a directory"), dest_paths.v[0]);
 	} else {
-		if (!path_in_sparse_checkout(dst_w_slash, the_repository->index) &&
-		    empty_dir_has_sparse_contents(dst_w_slash)) {
-			destination =3D internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_B=
ASENAME);
-			dst_mode =3D SKIP_WORKTREE_DIR;
-		} else if (argc !=3D 1) {
-			die(_("destination '%s' is not a directory"), dest_path[0]);
-		} else {
-			destination =3D dest_path;
-			/*
-			 * <destination> is a file outside of sparse-checkout
-			 * cone. Insist on cone mode here for backward
-			 * compatibility. We don't want dst_mode to be assigned
-			 * for a file when the repo is using no-cone mode (which
-			 * is deprecated at this point) sparse-checkout. As
-			 * SPARSE here is only considering cone-mode situation.
-			 */
-			if (!path_in_cone_mode_sparse_checkout(destination[0], the_repository->=
index))
-				dst_mode =3D SPARSE;
-		}
+		strvec_pushv(&destinations, dest_paths.v);
+
+		/*
+		 * <destination> is a file outside of sparse-checkout
+		 * cone. Insist on cone mode here for backward
+		 * compatibility. We don't want dst_mode to be assigned
+		 * for a file when the repo is using no-cone mode (which
+		 * is deprecated at this point) sparse-checkout. As
+		 * SPARSE here is only considering cone-mode situation.
+		 */
+		if (!path_in_cone_mode_sparse_checkout(destinations.v[0], the_repository=
->index))
+			dst_mode =3D SPARSE;
 	}
=20
 	/* Checking */
 	for (i =3D 0; i < argc; i++) {
-		const char *src =3D source[i], *dst =3D destination[i];
+		const char *src =3D sources.v[i], *dst =3D destinations.v[i];
 		int length;
 		const char *bad =3D NULL;
 		int skip_sparse =3D 0;
@@ -330,8 +322,6 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			src_dir[src_dir_nr++] =3D src;
=20
 			n =3D argc + last - first;
-			REALLOC_ARRAY(source, n);
-			REALLOC_ARRAY(destination, n);
 			REALLOC_ARRAY(modes, n);
 			REALLOC_ARRAY(submodule_gitfile, n);
=20
@@ -341,12 +331,16 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			for (j =3D 0; j < last - first; j++) {
 				const struct cache_entry *ce =3D the_repository->index->cache[first + =
j];
 				const char *path =3D ce->name;
-				source[argc + j] =3D path;
-				destination[argc + j] =3D
-					prefix_path(dst_with_slash, dst_with_slash_len, path + length + 1);
+				char *prefixed_path =3D prefix_path(dst_with_slash, dst_with_slash_len=
, path + length + 1);
+
+				strvec_push(&sources, path);
+				strvec_push(&destinations, prefixed_path);
+
 				memset(modes + argc + j, 0, sizeof(enum update_mode));
 				modes[argc + j] |=3D ce_skip_worktree(ce) ? SPARSE : INDEX;
 				submodule_gitfile[argc + j] =3D NULL;
+
+				free(prefixed_path);
 			}
=20
 			free(dst_with_slash);
@@ -430,8 +424,8 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 remove_entry:
 		if (--argc > 0) {
 			int n =3D argc - i;
-			MOVE_ARRAY(source + i, source + i + 1, n);
-			MOVE_ARRAY(destination + i, destination + i + 1, n);
+			strvec_remove(&sources, i);
+			strvec_remove(&destinations, i);
 			MOVE_ARRAY(modes + i, modes + i + 1, n);
 			MOVE_ARRAY(submodule_gitfile + i,
 				   submodule_gitfile + i + 1, n);
@@ -448,7 +442,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	}
=20
 	for (i =3D 0; i < argc; i++) {
-		const char *src =3D source[i], *dst =3D destination[i];
+		const char *src =3D sources.v[i], *dst =3D destinations.v[i];
 		enum update_mode mode =3D modes[i];
 		int pos;
 		int sparse_and_dirty =3D 0;
@@ -576,8 +570,9 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
 	string_list_clear(&only_match_skip_worktree, 0);
-	UNLEAK(source);
-	UNLEAK(dest_path);
+	strvec_clear(&sources);
+	strvec_clear(&dest_paths);
+	strvec_clear(&destinations);
 	free(submodule_gitfile);
 	free(modes);
 	return ret;
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 49c042a38a..cd1931dd55 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -3,9 +3,9 @@
 # Copyright (c) 2005 Junio C Hamano
 #
=20
-test_description=3D'Test rename detection in diff engine.
+test_description=3D'Test rename detection in diff engine.'
=20
-'
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary.sh
index 2a2cf91352..e486493908 100755
--- a/t/t4043-diff-rename-binary.sh
+++ b/t/t4043-diff-rename-binary.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Move a binary file'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
=20
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 697e86c0ff..f788428540 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'git apply -p handling.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 3de4ef6bd9..27d6efdc9a 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -7,6 +7,7 @@ test_description=3D'Test merge with directory/file conflict=
s'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'prepare repository' '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index ca018d11f5..d0863a8fb5 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -4,6 +4,7 @@ test_description=3D'merging with large rename matrix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 count() {
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-un=
needed-updates.sh
index b059475ed0..62f0180325 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -22,6 +22,7 @@ test_description=3D"merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-seque=
nce-rename-caching.sh
index 0f39ed0d08..cb1c4ceef7 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D"remember regular & dir renames in sequence of merges"
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 #
--=20
2.45.1.216.g4365c6fcf9.dirty


--EbMnNkAgtGobizh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNgMACgkQVbJhu7ck
PpTevQ//cFxw2oIpe7GU4q9WwGfAQhac2WAJE9ooYeFE1QKo+CAFl/iUBs/VsKrD
EQooLydS2M6JjIDSy+k78GlsaI3EW1Sb2w93Y3X/GhnsZ7vnFzh2dn8cQ5dKDtB+
Prs57JMhQNvjlZZoH2Ib1uCVcpjbpu636zTk8KMWU03Lfo4tbLsglcQyRLawQ3/C
nF6OHjz0eo9QrHHYHQAq7Yl996oWGsJaH0sY+D9NbzU+fNVzeqTtv2k7gm+dNf8O
jsj2pcDbhfhYFdik3hyMnvSqu9x4wCNmpwCpJj5HD+p9opC05FssBj5zNpazWC8O
3OyCI3aALZqvLVh7nYhggJM1ipCQm+WTy+pbMsrhVxZkhg8d3+fmJuZpUahUjwrX
H8oY1XQPSIzFuOjua9mvFcv9yf+pq62qeYQ/lBbrzESHSAwrXesJHPbRFkM9m2ev
UqH/PvbzrJRN5VWoBafjdU5heAKiltuXS8PGt+Ph8tiuIZNMtvdyIEoQMvwJj+nM
5IJBfA6WOq0WriQnGRCeSvXj8yjTWxYr2xBNeqMbLLVoXcHppvMC9g6/ldIZjB9P
sCb4x0CHbcXcKhy/jiBJdDrZv5YStGnquB+OIC0s4oTSDtS5Fleh3ZWgLuEIR/Ic
koh13xFeRIBP+U0G1kiUmxFmbnz6/lEJKToEgVL+YwpX5F6So5Q=
=MaTO
-----END PGP SIGNATURE-----

--EbMnNkAgtGobizh5--
