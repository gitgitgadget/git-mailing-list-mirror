Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587746D545
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518181; cv=none; b=cDmO+PMkbZQnh9UjNwlK2RRe49i/pE1i0uXgRO/I4YOrbbc1AP46OrH0GFgPmgsuqXbVyLOAOTOvdXFYGmmVCbD73KkxbH3zzDq0LvGEY7rnLnbxI4ZPD+K+hX4TljbXhmBgToBVy9ChIfSO+r/DoRWBdhCEdzksakaKMHDz6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518181; c=relaxed/simple;
	bh=wvirR2m3jd9AJOjIpUHLuC3gGS3on9HGg9SuK/8EQwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McTtYVnPVGGIkp3IvLUwNGcJUNJ4V8rpegLrqM9i+fDxdag/oAa21ZMmgUdJ/NV4fLSW9ELo34yY0Z5VLkyG0BpOuHPNNKqe5ulgLJP6rNIl0S7cvTdeTIPweSAwHEGEi2Afa+nO9O3jvQC+DXGFQ+72ggg0XWe0kdngNpgCj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqxBr9P9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9nlo7Ri; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqxBr9P9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9nlo7Ri"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B7C231D000D4;
	Fri,  4 Sep 2026 06:36:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 06:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518177;
	 x=1788604577; bh=2XOeDn5HXzyjxkrQhwS5dbRRO/ACYWq8j5v9g7Q6oLA=; b=
	lqxBr9P9wCxoyyivSS8tvcyYHYjOFJd9BErfGbKQUkU/5WG/QaC/xKzFu9JtiNbS
	BGJ14NXmI6BJjCKTxQqNG5HnlBPnhmnbabFr69YVBN1J5sxTb3eH3f/3MPua8a5X
	rVdgUa/ZC13SrmY2NNpz6WdVlj9h3Q1d+KklUPV2uauxcZT4LvVathDpZOGT5hu0
	s0EkeXYDOx0eqhN4K7VfK7bQ/EOxNmZLvLeRIREet3eSzp2ZZWZsF5927/c7UIk9
	5Swn3gPwOMrsHv5uauVjUFElTPgW2hq8RWcZ/O16F5L6QT7iNpRg68lR4uP2z5jR
	55LDV7HXf8tCHBLXnYMi5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518177; x=
	1788604577; bh=2XOeDn5HXzyjxkrQhwS5dbRRO/ACYWq8j5v9g7Q6oLA=; b=D
	9nlo7RizSTxXgUL4GtGb9qRn0y+J/P5TLjFGtnh7Zn9ax9NsUOCFaYAcVFATDz2a
	w3bR6qwwn77NkKFOe+/l4d0Er70kb25o4Cf3Kq4aMiloYkraOsYUmsABIBqEzm7d
	LO/4PqCPulYSA5uEKMALNlQFfVWd3OZEeBa037vS6Dynk6q4KghDgRtIomwzgGl5
	NQ0pF0Yp/SrJTaHtrcBZE9rFKMB2SOIVu+xhe8T1RL4gkAJvSiGCds1HwuXqsbrJ
	z7sI8xfK0jEAiqNu4Uq//Ijjh8lcKR14GQzikymuWfWxBBYU7iyEzWUi/LCticX/
	fkv1sB3xecV2kGoHoa0rw==
X-ME-Sender: <xms:IZ-aaiSH0kq_kcU2tXP1Lm73q2dtlncufDrzDE0ISE3khYvk4zLi_w>
    <xme:IZ-aatyB0aaw3HWQKj3cjRO5GYaxnjbAVOvKL-3f6Cg-qU95ATfjpt6B3cyXqb0_J
    cvaKFi2MsLxLbx_4k2P-yqjP39wUfa8pKsdEad5-_vz6eXh_Jao52c>
X-ME-Received: <xmr:IZ-aatfo-PSlHLZulGemf9kLr2B3sGVN4QG6NPue27IpuEfSgawm490dnH550Dkb-7WA6g>
X-ME-Proxy-Cause: dmFkZTFxvR4riYu4L7GQ6jfYeXFfxvpkMR3ZVU6X1/VWa119qXXoKE7y5zS6uIyMSVUaDc
    qkyj0UlHBprOBfgWUkAaWuNJcVpHD1PSWWFIfFoUM8XPgB7TZa0yadB8r95xaqTDBvXwUJ
    eYQRBh/tMu1r3/q2W7dgritYzkdzPpcYcp8Nywgg2ikCLyoXyfNbqzE8EcmCNRunxSRgIU
    4IXYwwkpuZe+taafLv4FIoCmF11woOh0QdUYqk65mo2+BlAIZn1XlLDAt26G+KC4vb8lih
    80PrzCb4S8fOCtH0OeKNiVMFpIqE9mtteA5qEMByRtLmxCL9lCc4TFRszMYtZ1YaSJrIFi
    /WfuT2FB3OrtRv6IB1dnBFIqwdIyb+X+JO5kG7a2kg1bxP8u7sBZJJ3DdNkdQZ5mp1PlZ9
    8nIGNTpfxwb3P6S2r5hsJs39mHrKZRrKzk1+T0x4hRDlIQBlD9GahNNWEJEb8cp5RxIywz
    R8xNgFeRdPXE3ZffqDKRSr22hWImKiGMoDzEJ4FOzt3Ly7BiY8q3R91izvVULYy0RPs8EP
    39u+oWJMV/IJKeaYOXnv0A3XLm3oyQ9Ba8bARAFBScu6dVTKFd64rerL0TaUtR78UbYuZm
    hhxQtUBxqKjB9Gkf31Qso/v/U+dKKUG/brZHWCzhbh7L9TVGRQYTm6cmnEAg
X-ME-Proxy: <xmx:IZ-aapKWOi8BqH2xcjFvfY6bKyV3KGqrGcU3H8m5ABJF66T3kwIUtQ>
    <xmx:IZ-aauHFlxOGlMvgxNMgEA_Vt721XnXctc7SDK4VSisPJX1gjDegFg>
    <xmx:IZ-aajpSa9q9xRSVFBhIaxwAjoSQM5uTTmsIoLON9exrt6ceIpzaNQ>
    <xmx:IZ-aanTRnmBPu59M9xrEcJvjRAFXmW0axzjvj8s39XIrLVDVc5cXAQ>
    <xmx:IZ-aamBUpiys6yKHSgEctZ5HvgIrr01YA9Vu09yXuhMclchKwK_Pa16K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4e2c078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:02 +0200
Subject: [PATCH 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-1-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Back when we gained support for reftables we of course introduced the
ability to control the reference storage format that is used by newly
created repositories. This infrastructure has grown over time, and
unfortunately without consistency:

  - The command line parameter to specify the ref storage format is
    called "--ref-format=", while the corresponding repository extension
    is called "refStorage".

  - In most cases we refer to the "ref storage format" in our docs, so
    calling it "--ref-format=" is being inconsistent with them.

  - It is possible to override the ref storage format via an environment
    variable that is called "GIT_REFERENCE_BACKEND", which is not even
    remotely consistent with anything else.

  - There is also an "object format", but that format does not control
    how we store objects but rather whether we use SHA1 or SHA256.

So in summary, it's a huge mess.

This problem is about to become even worse though, as we're soon going
to introduce an object storage extension. This extension is the
equivalent to the ref storage extension, and of course we also want
users to be able to control which object storage format new repositories
are using. But we cannot properly name that parameter without creating
even more inconsistencies:

  - "--object-format=" would match "--ref-format=", but that parameter
    name is already taken to specify the hash function.

  - "--object-storage=" would be a good fit, but be inconsistent with
    "--ref-format=". Asking the user to execute `git init --ref-format=
    --object-storage=` just feels extremely awkward.

Instead, this and subsequent patches will fix the mess by consistently
referring to the ref storage format as "ref storage" throughout all
options, environment variables and config settings. This new name much
more closely indicates that it is about how we store data and finally
brings consistency into this area. We will keep the old names working of
course for the sake of backwards compatibility.

Start with git-init(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc         |  2 +-
 Documentation/git-init.adoc            |  4 ++--
 Documentation/git.adoc                 |  2 +-
 builtin/init-db.c                      | 16 ++++++++-------
 t/perf/p1401-ref-store-tombstones.sh   |  4 ++--
 t/perf/perf-lib.sh                     |  2 +-
 t/t0001-init.sh                        | 24 +++++++++++------------
 t/t0610-reftable-basics.sh             | 14 ++++++-------
 t/t0611-reftable-httpd.sh              |  2 +-
 t/t1400-update-ref.sh                  |  2 +-
 t/t1423-ref-backend.sh                 |  6 +++---
 t/t1460-refs-migrate.sh                | 36 +++++++++++++++++-----------------
 t/t1900-repo-info.sh                   |  6 +++---
 t/t5510-fetch.sh                       |  8 ++++----
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 15 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index 7b4abdaf8b..9c78440192 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -15,7 +15,7 @@ endif::[]
 	this config.
 `init.defaultRefFormat`::
 	Allows overriding the default ref storage format for new repositories.
-	See `--ref-format=` in linkgit:git-init[1]. Both the command line
+	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
 	precedence over this config.
 
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index bab99b9b47..54cff89dfe 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git init [-q | --quiet] [--bare] [--template=<template-directory>]
 	 [--separate-git-dir <git-dir>] [--object-format=<format>]
-	 [--ref-format=<format>]
+	 [--ref-storage=<format>]
 	 [-b <branch-name> | --initial-branch=<branch-name>]
 	 [--shared[=<permissions>]] [<directory>]
 
@@ -57,7 +57,7 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.adoc[]
 
-`--ref-format=<format>`::
+`--ref-storage=<format>`::
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..e3260fde68 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -593,7 +593,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_DEFAULT_REF_FORMAT`::
 	If this variable is set, the default reference backend format for new
 	repositories will be set to this value. The default is "files".
-	See `--ref-format` in linkgit:git-init[1].
+	See `--ref-storage` in linkgit:git-init[1].
 
 `GIT_REFERENCE_BACKEND`::
     Specify which reference backend to be used along with its URI.
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e96b1283b7..763ee47d21 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 static const char *const init_db_usage[] = {
 	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
 	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
-	   "         [--ref-format=<format>]\n"
+	   "         [--ref-storage=<format>]\n"
 	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
 	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
@@ -83,7 +83,7 @@ int cmd_init_db(int argc,
 	unsigned int flags = 0;
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
-	const char *ref_format = NULL;
+	const char *ref_storage = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
@@ -109,8 +109,10 @@ int cmd_init_db(int argc,
 			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
-		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage, N_("format"),
+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_END()
 	};
 	int ret;
@@ -173,10 +175,10 @@ int cmd_init_db(int argc,
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
 
-	if (ref_format) {
-		ref_storage_format = ref_storage_format_by_name(ref_format);
+	if (ref_storage) {
+		ref_storage_format = ref_storage_format_by_name(ref_storage);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_format);
+			die(_("unknown ref storage format '%s'"), ref_storage);
 	}
 
 	if (init_shared_repository != -1)
diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
index 9e3d8031aa..72db3c80fc 100755
--- a/t/perf/p1401-ref-store-tombstones.sh
+++ b/t/perf/p1401-ref-store-tombstones.sh
@@ -5,7 +5,7 @@ test_description="Tests performance of ref operations with many tombstones"
 . ./perf-lib.sh
 
 test_expect_success "setup" '
-	git init --ref-format=reftable repo &&
+	git init --ref-storage=reftable repo &&
 	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
 	for i in $(test_seq 8000)
 	do
@@ -24,7 +24,7 @@ test_perf "recreate refs after mass delete" '
 '
 
 test_expect_success "setup asymmetric" '
-	git init --ref-format=reftable repo2 &&
+	git init --ref-storage=reftable repo2 &&
 	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
 	for i in $(test_seq 8000)
 	do
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 2ac007888e..50a35545a1 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -153,7 +153,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
+		"$MODERN_GIT" init -q --ref-storage="$refformat" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5cf2e5a35a..bb3ec31097 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -696,9 +696,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "init with --ref-format=$format" '
+	test_expect_success "init with --ref-storage=$format" '
 		test_when_finished "rm -rf refformat" &&
-		git init --ref-format=$format refformat &&
+		git init --ref-storage=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -717,9 +717,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "--ref-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
+	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_FORMAT" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-format=$format refformat &&
+		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -735,9 +735,9 @@ do
 	'
 done
 
-test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
+test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
+	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
@@ -791,8 +791,8 @@ for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
 		test_when_finished "rm -rf refformat" &&
-		git init --ref-format=$from_format refformat &&
-		git init --ref-format=$from_format refformat &&
+		git init --ref-storage=$from_format refformat &&
+		git init --ref-storage=$from_format refformat &&
 		echo $from_format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -807,11 +807,11 @@ do
 
 		test_expect_success "re-init with different format fails ($from_format -> $to_format)" '
 			test_when_finished "rm -rf refformat" &&
-			git init --ref-format=$from_format refformat &&
+			git init --ref-storage=$from_format refformat &&
 			cat >expect <<-EOF &&
 			fatal: attempt to reinitialize repository with different reference storage format
 			EOF
-			test_must_fail git init --ref-format=$to_format refformat 2>err &&
+			test_must_fail git init --ref-storage=$to_format refformat 2>err &&
 			test_cmp expect err &&
 			echo $from_format >expect &&
 			git -C refformat rev-parse --show-ref-format >actual &&
@@ -820,12 +820,12 @@ do
 	done
 done
 
-test_expect_success 'init with --ref-format=garbage' '
+test_expect_success 'init with --ref-storage=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
 	fatal: unknown ref storage format ${SQ}garbage${SQ}
 	EOF
-	test_must_fail git init --ref-format=garbage refformat 2>err &&
+	test_must_fail git init --ref-storage=garbage refformat 2>err &&
 	test_cmp expect err
 '
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 35e98b43db..4a83e1ce56 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -59,28 +59,28 @@ test_expect_success 'init: reinitializing reftable backend succeeds' '
 	test_commit -C repo A &&
 
 	git -C repo for-each-ref >expect &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage=reftable repo &&
 	git -C repo for-each-ref >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'init: reinitializing files with reftable backend fails' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage=files repo &&
 	test_commit -C repo file &&
 
 	cp repo/.git/HEAD expect &&
-	test_must_fail git init --ref-format=reftable repo &&
+	test_must_fail git init --ref-storage=reftable repo &&
 	test_cmp expect repo/.git/HEAD
 '
 
 test_expect_success 'init: reinitializing reftable with files backend fails' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage=reftable repo &&
 	test_commit -C repo file &&
 
 	cp repo/.git/HEAD expect &&
-	test_must_fail git init --ref-format=files repo &&
+	test_must_fail git init --ref-storage=files repo &&
 	test_cmp expect repo/.git/HEAD
 '
 
@@ -163,7 +163,7 @@ test_expect_success 'clone: can clone reftable repository' '
 
 test_expect_success 'clone: can clone reffiles into reftable repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
-	git init --ref-format=files reffiles &&
+	git init --ref-storage=files reffiles &&
 	test_commit -C reffiles A &&
 	git clone --ref-format=reftable ./reffiles reftable &&
 
@@ -182,7 +182,7 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 
 test_expect_success 'clone: can clone reftable into reffiles repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
-	git init --ref-format=reftable reftable &&
+	git init --ref-storage=reftable reftable &&
 	test_commit -C reftable A &&
 	git clone --ref-format=files ./reftable reffiles &&
 
diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
index 5e05b9c1f2..3f0c4acf56 100755
--- a/t/t0611-reftable-httpd.sh
+++ b/t/t0611-reftable-httpd.sh
@@ -10,7 +10,7 @@ start_httpd
 REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
 
 test_expect_success 'serving ls-remote' '
-	git init --ref-format=reftable -b main "$REPO" &&
+	git init --ref-storage=reftable -b main "$REPO" &&
 	cd "$REPO" &&
 	test_commit m1 &&
 	>.git/git-daemon-export-ok &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 269fdaa3ed..7cc6f2e3e8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2361,7 +2361,7 @@ do
 	'
 
 	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
-		git init --ref-format=reftable repo &&
+		git init --ref-storage=reftable repo &&
 		test_when_finished "rm -fr repo" &&
 		(
 			cd repo &&
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index fd47d77e8e..26a3655058 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -137,7 +137,7 @@ do
 
 		test_expect_success "$method: read from $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
@@ -152,7 +152,7 @@ do
 
 		test_expect_success "$method: write to $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
@@ -179,7 +179,7 @@ do
 
 		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo wt" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 8f42697143..fc04bb7c70 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -105,7 +105,7 @@ do
 
 		test_expect_success "$from_format: migration to same format fails" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_must_fail git -C repo refs migrate \
 				--ref-format=$from_format 2>err &&
 			cat >expect <<-EOF &&
@@ -116,7 +116,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			git -C repo worktree add wt &&
 			test_must_fail git -C repo refs migrate \
 				--ref-format=$to_format 2>err &&
@@ -128,20 +128,20 @@ do
 
 		test_expect_success "$from_format -> $to_format: unborn HEAD" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_migration repo "$to_format"
 		'
 
 		test_expect_success "$from_format -> $to_format: single ref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			test_migration repo "$to_format"
 		'
 
 		test_expect_success "$from_format -> $to_format: bare repository" '
 			test_when_finished "rm -rf repo repo.git" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git clone --ref-format=$from_format --mirror repo repo.git &&
 			test_migration repo.git "$to_format"
@@ -149,7 +149,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: dangling symref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo symbolic-ref BROKEN_HEAD refs/heads/nonexistent &&
 			test_migration repo "$to_format" &&
@@ -160,7 +160,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: broken ref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
 				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERIFICATION &&
@@ -172,7 +172,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: pseudo-refs" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo update-ref FOO_HEAD HEAD &&
 			test_migration repo "$to_format"
@@ -180,7 +180,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: special refs are left alone" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo rev-parse HEAD >repo/.git/MERGE_HEAD &&
 			git -C repo rev-parse MERGE_HEAD &&
@@ -190,7 +190,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: a bunch of refs" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 
 			test_commit -C repo initial &&
 			cat >input <<-EOF &&
@@ -208,7 +208,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: dry-run migration does not modify repository" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo refs migrate --dry-run \
 				--ref-format=$to_format >output &&
@@ -221,7 +221,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: reflogs of symrefs with target deleted" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo branch branch-1 HEAD &&
 			git -C repo symbolic-ref refs/heads/symref refs/heads/branch-1 &&
@@ -234,7 +234,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: reflogs order is retained" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit --date "100005000 +0700" --no-tag -C repo initial &&
 			test_commit --date "100003000 +0700" --no-tag -C repo second &&
 			test_migration repo "$to_format"
@@ -242,7 +242,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: stash is retained" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			(
 				cd repo &&
 				test_commit initial A &&
@@ -259,7 +259,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			# we see that the repository contains reflogs.
 			git -C repo reflog --all >reflogs &&
@@ -274,7 +274,7 @@ done
 
 test_expect_success 'multiple reftable blocks with multiple entries' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage=files repo &&
 	test_commit -C repo first &&
 	test_seq -f "create refs/heads/ref-%d HEAD" 5000 |
 	git -C repo update-ref --stdin &&
@@ -286,7 +286,7 @@ test_expect_success 'multiple reftable blocks with multiple entries' '
 
 test_expect_success 'migrating from files format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage=files repo &&
 	test_commit -C repo first &&
 	git -C repo pack-refs --all &&
 	test_commit -C repo second &&
@@ -313,7 +313,7 @@ test_expect_success 'migrating from files format deletes backend files' '
 
 test_expect_success 'migrating from reftable format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage=reftable repo &&
 	test_commit -C repo first &&
 
 	test_path_is_dir repo/.git/reftable &&
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..db5ed71818 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -39,10 +39,10 @@ test_repo_info () {
 }
 
 test_repo_info 'ref format files is retrieved correctly' \
-	'git init --ref-format=files' 'format-files' 'references.format' 'files'
+	'git init --ref-storage=files' 'format-files' 'references.format' 'files'
 
 test_repo_info 'ref format reftable is retrieved correctly' \
-	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
+	'git init --ref-storage=reftable' 'format-reftable' 'references.format' 'reftable'
 
 test_repo_info 'bare repository = false is retrieved correctly' \
 	'git init' 'nonbare' 'layout.bare' 'false'
@@ -75,7 +75,7 @@ test_expect_success 'values returned in order requested' '
 	references.format=files
 	layout.bare=false
 	EOF
-	git init --ref-format=files ordered &&
+	git init --ref-storage=files ordered &&
 	git -C ordered repo info layout.bare references.format layout.bare >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..1b239f4f22 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1803,7 +1803,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 test_expect_success REFFILES 'existing reference lock in repo' '
 	test_when_finished rm -rf base repo &&
 	(
-		git init --ref-format=reftable base &&
+		git init --ref-storage=reftable base &&
 		cd base &&
 		echo >file update &&
 		git add . &&
@@ -1814,7 +1814,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git update-ref refs/heads/branch @ &&
 		cd .. &&
 
-		git init --ref-format=files --bare repo &&
+		git init --ref-storage=files --bare repo &&
 		cd repo &&
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
@@ -1857,7 +1857,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
 	test_when_finished rm -rf base repo &&
 	(
-		git init --ref-format=reftable base &&
+		git init --ref-storage=reftable base &&
 		cd base &&
 		echo >file update &&
 		git add . &&
@@ -1868,7 +1868,7 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 		git update-ref refs/heads/branch @ &&
 		cd .. &&
 
-		git init --ref-format=files --bare repo &&
+		git init --ref-storage=files --bare repo &&
 		cd repo &&
 		git remote add origin ../base &&
 		mkdir refs/heads/foo &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 559713b607..d6ea84bb90 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -31,7 +31,7 @@ test_expect_success 'add existing repository with different ref storage format'
 	(
 		cd parent &&
 		test_commit parent &&
-		git init --ref-format=$OTHER_FORMAT submodule &&
+		git init --ref-storage=$OTHER_FORMAT submodule &&
 		test_commit -C submodule submodule &&
 		git submodule add ./submodule
 	)

-- 
2.55.0.1007.g17ff1f9808.dirty

