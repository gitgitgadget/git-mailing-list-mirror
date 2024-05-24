Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AD84E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545091; cv=none; b=ZJBb8EmpTo/uWcOQLxroUWnRKcE8Vh3dtDVZnaJ6Sm+NOlMD5RD4rfdUK3EN4xmqMp71UqpPR0C6828CxPNnWKlPo1iT5N8GgubGH0hhncIuZy30dPFIS5rXhNaMOLPw7Yelm5mJfZqhKfiBCERYeBPErRPRqMaY4KA8VVLjq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545091; c=relaxed/simple;
	bh=Y2T63wti23z55rVqYgzTsrMQXy6yFe2ui8e2I3Y3vms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbW7iNf+1niPmFNupoynkE5X/LOZSDgrFKOEBmDOpf9VKsFFz1V9DrmGybPhKHogv1N/3SscxA10j9mLhJScKbPPVWQGCvCjl1nemCj6qsmjOyjL0SGYeRJkwanNO3neV6TChLaU5iQRQoS8qj3JxVJxD8C0UYM9c12M+H/qhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UZSONQvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BE4OB1T1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UZSONQvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BE4OB1T1"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA75E138011A;
	Fri, 24 May 2024 06:04:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 May 2024 06:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545088; x=1716631488; bh=ecPCX94G/Y
	ixG8+h94M3eNqgAnByqYgO0BF9EK4HnMA=; b=UZSONQvdNrQDZ95E2R0eIYGnWD
	2qg92rPuokpe3uJLq/swrCsXaF16HISjV0x0dM+1GJ9+DhYiS0/p8eGemFnkSdDG
	5a5A+4nJOi9U7DfJZMw7mE5BaQ7fZoAxz3EgMnqckQuFWFxbyfjR7ohWldHq+afq
	ztP4NIzZdDmiYUDSz5+bm916bUsG2VdXCsix51EOLqn+ZWJ+LFTw/OKUraAORO3M
	s2VtyGoFgqO1g1oOcJVCWssv50BUpwlg/B83zOTZfVn0FdO57GDlBerI54mlQoWT
	EeP3qx74uMMZ86XcvGVoMkJRcuzOG+yPfQ8XzQ4eBnSP7uK4PnRZBxjLrO0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545088; x=1716631488; bh=ecPCX94G/YixG8+h94M3eNqgAnBy
	qYgO0BF9EK4HnMA=; b=BE4OB1T1IDLU21U0DCXQGFJ13Ozn+dWG+/ocv/wXKujD
	8JWIJCl4qu1m+9/xfVJsGG+94ke5J7z/CokhAhBWn8DyJ+qr7xFZFCvbrxxzyDoS
	+mVXx60qlql8XJ+ncgToz6/UQ/aTE58+JoAa2zNFm1H4FkoW8ukpK1nXicMJ/neo
	rVsvCeUpvhaLhvHhzUg3NE3pRZEkKuAfpZ3VVyKu0p23YPk6MbXdtAswGP3iY35C
	6q70Ni1nOQEYQQiAI5J+xijh/ju1bR0tHuT0OPfGwREGfkRTnOuyR6Bk0XLGkVHH
	u7DxBMJXcJs7kjP0msG5drKJgL9RAcivHP1pl26j1Q==
X-ME-Sender: <xms:QGZQZnpiSfeOr-T0DHXFK8NLClBGQ0eyY7Po02V2v6CbCzIeWWra-w>
    <xme:QGZQZhqmJhVUUoSmIxr-gu8r1Vd6Kk0UGAcqNc_ZgSUIr5Ggv35QZfucIluWdT3Fx
    rJ5qBtZzb2uYWH3kQ>
X-ME-Received: <xmr:QGZQZkNtCF552cj62RhABYJ7VMgfS9-zopj4utCv0C1_MKAXMd5Z1qsQTTV4WzxwRToCLD5b4FzaGQgaDV6YqbGU4-mJ7LsLx8lDhjvwI5hIhEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QGZQZq4jaLRTzDkD8tk-eLFbstoNyZAFVAKPMXPB2-QrUSfHpQjmvg>
    <xmx:QGZQZm5JEWXaWA4-TJlcRFTM5PIsF6_Qw6FdW9s1t10yzOtsVIsZFw>
    <xmx:QGZQZii0oyaeaEdYnXJx0lfLL-Re8hWJGGi2gzrSlA4KfJRJgs7XOA>
    <xmx:QGZQZo42Db_UIYzx87V1Z0eiSJU5wS64RgV7bn7Z_QW0sAOzEynQeA>
    <xmx:QGZQZsl2b2-q71xQuzGqynhjRAMl9BS4qnhSfpZPPissjokcZpDaiI3S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 87fda9c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:45 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/21] builtin/mv: refactor to use `struct strvec`
Message-ID: <797cdb286adcb577e21d8da6bf11b3f56795b0ee.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ECxUAP3yQuon9CQP"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--ECxUAP3yQuon9CQP
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


--ECxUAP3yQuon9CQP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZjwACgkQVbJhu7ck
PpSMHRAAlIAjIWHGZbT03sTxxZrKdHGyqDESQQChAuq7EFgU/BMoEUzWc4dUZPHF
xCVTPIS0JRPVrWlEIkmXkvCSVXubwFRXTBwkc9tXaCpwXA9UItH4YxQq+4vvzGOP
bvrAW/0Bq2jo3ZQhrFISMtmOI9+bHahNPmAWWaRpUrRj49RTKTHBm9jwr+IAyFY/
zAXh15kS074jtc1N/74dONB+eTRHy58lw14dlEWnrl2FfafcNcP4ltofZur1Ywhb
TuH9SA9aYcYUmyDuXNb9Hhozb/pgmMn+XaTt0OhmDqhMwP8a/c1uFPwOlU0o2Udu
NCmbTioaeKap/XLV/0g/m9X0Ddcwkeov8bpiL7ZX4v5rERNgi5RP5gDCbGEyuBsK
1vt4tojighmkIQGB56xTIPgAKL5yDChybgt7ZE+tMKnJJlpbpVh2hv/mACFUKuD7
gkZIctzEIzN3M7l2RAOgbwi5DZY6C/s8PcQ+vxs+HRdcSHC63LwMHeGX6sgajPxv
5pkHF/IqIP9XPuMrUWQyozU7gF5w7VhMjKl5B8sUTh7npVsKRRDHR26dOAZnlCR/
vbXd2ilyBDFnOd4YEpa5XhMNUD+d+fiS55uxlxI4r4wZiuVhtRPit9EOf0OtRjMr
bZ6bNcf+X/EsItUb5+uzXfGpKaeJfu0niJO9WOlvmHEypvYLCWI=
=OP6K
-----END PGP SIGNATURE-----

--ECxUAP3yQuon9CQP--
