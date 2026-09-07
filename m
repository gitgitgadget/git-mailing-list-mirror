Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0928640B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780046; cv=none; b=fMyisNpKOesMyCuPiAwEBoT5xhaBl5JWUo+SoVNpA9X5Lm+w5biv0uepJaalYYyhOJbJoXZQwbBdECpUe7cK/Riq57UFiUqC69QZwuRMMJjTKM9FCdhYQdfOnGT+fMEssGP1rC3+MJ60sISrejTzNxXqVC0fJBxS/cV8sYywiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780046; c=relaxed/simple;
	bh=Bjq0YZAqQFqrm1YRow8ySWYIlt8d4VW3q1IsLInohYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7V/CCMkWj6cDgOtxZdjl7xVo6E3EBp+jCWnWMgidWtkd56Y15j+sgPvfc+PWfjg2xQFkx9px1ECyZJu94SAkPZq5cyb/ZAb9B+aRsCmdgzfdIjx3XqDbOAEzRyqNP/zNRnj6a82dDb/ocrASiu9op5QkrfG7YGOnSlLXKRpUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hdrwn7NI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUydBFZS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hdrwn7NI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUydBFZS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C66F14001CA;
	Mon,  7 Sep 2026 07:20:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 07:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780039;
	 x=1788866439; bh=zFnXdm29ETRuAEVFR6fOvg5DDof9WSmV55NQdWmwsMQ=; b=
	Hdrwn7NI0hAl+SRzTPrnKrkqM0OHWF7jKeMpW99HbV8KWZ/g+Fkud/L4E6sQYPVd
	vgqyfEi2U3SrSMVFtmt0TvrhUqs4i4pBvg2cooqBzgRwCWY9DnE+EmbolzLgb9q3
	nZ0bOCEn6eGkxJK/nI+Mk3V0vz+es0ZXAfiF9JGkaboGcYbqdfcBMbcJk4bhJ8/H
	7sBJEIft7vf1uKUVGcifQwSjCm/g8KWhWPRHBkcIpDuK0tX/smxDk9ocoCWH9p6p
	4ASRGaGK/1DlGlbmW3JogKHTHMEe/JHHAD9FfIH6YobYnIIoa0hfhgAnZBs6C7vm
	cEdxe/S/xL+7psM7RmduJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780039; x=
	1788866439; bh=zFnXdm29ETRuAEVFR6fOvg5DDof9WSmV55NQdWmwsMQ=; b=b
	UydBFZSVpAan3MyhWf7b1X4Ik1NPi2CZzeyR0GiQMZrDG9J/lzO987D0qzIqbbex
	VMl9+kUPalt5bppPeCNS1w8k/YXcQm98E28mIqLSIN2uv+V5QfD9U6zbReoOxEdN
	hx8rYB60bXsRSrdvRqaQT+nJw2lTyATTkydyHa/nz64efGTG1aVuOUM8A5JIOwFJ
	+sB+a5sgaf8MBx+PebJVZ/5pfgJUurRj3eQyoj0meYFDhlCRqEZrnaHN4kjkKyAz
	F9QtpVyJKlY0Oo2ihbhitEZnSgzmsxEqlruWKGWy2s/nfI05Ijm9kveM8T814YTN
	WmARGaZxkaJqwu3K/dPvQ==
X-ME-Sender: <xms:B56ealle3tNZi_o98A-r4-djIEfnqoGI1TMq6M_-KRiAAHSu4JKuFg>
    <xme:B56eaoQZUNjucFgmMZq_hFwrxCsuvlxSSKcVcsNVsvdwIgk9Wo3xYUa1quDWHHiJv
    3eEjo2-V8NphtPoyiB3PnqWszrldwv_TRq8KQQD2gGHUcSPpUFrmxs>
X-ME-Received: <xmr:B56eapB9NUNMs3TBHSDMYTUpWA93MqvKD2mWBc55UNbMEz0OlMNA1g>
X-ME-Proxy-Cause: dmFkZTEU+csHYvBo9fMYwV3wknAtUSE4SJO0BUQi53xPlseR/gNYI/1nqdGQqVSAlOZjQd
    4l4U+XllsvZqrni2Eec7ZpTaSCKzhBvzOVpCUnAc6LTxJe0zNbgTYyDSzDv3ROAKV1EFYH
    Bx7i+VjTkrj7+yADyLZfC+VgUeQR2ODyNHcvnBvS08LcP9yK0Ar5jOwFYHKPS7P+ZyrIU9
    43fHMkwpKPdLr84bgJ9NgnRDJ1cBOAz/SRYPOGgsns1KFSsbOTQ/K8oZhdQmsg4XqNJkVb
    xyo317as6nauYcrux5Qoi8NFl3mE7HjkjrBL9oDRSzbFL9MtMr+KveMXO0+iOMUks7hooV
    SneSAx5NpJ5MEbryyIJlmLpU+PTdZIZbbPCx7w4Lq4CXdjVIlh4noIus+r9uf8fBI5twtA
    cQrFOEEyFaAkdLtdVSFVPmaLG11OPtPbO5j9DvSsYKT/59eb6r9aiOX2qkUauNt5uACYmb
    0iGMO4Ur19ihdlwG8CngB8+LaVGpu0+Lz1aGvPDixI/2COU4x7BQKiwjIt1yXgHNUGEcnJ
    ZRoMpHIvVCN2EK/cnSI1nAlp9M3s+NhX1bdKooFDD9uBZ+mCIkc1CXMOJQEjjnLey+3eKc
    7O8qi3O+fn8QsXbgZ2kavGpVfFs/qbckCP5AXrcn3KrI+EX4eUI1U4fGzoYw
X-ME-Proxy: <xmx:B56eavRZIDabMi7SHkNLKLaaznaB46SupXOvBpf2N1rLw4wsWkGlzA>
    <xmx:B56eanoA6QtHZM9A0zbGqGedzE3gVZXd0llnGUIY6u5GrfYTnZbDEQ>
    <xmx:B56eahxRrK-kOHTKgbzNhQA9xxAhw1JgKoas4-sxWXqvJ-rhsgRXdw>
    <xmx:B56easK64BgA8yvpF5rJX0Pza47JmRFCBw0Sp4Kjz2k6MnVtZcRheg>
    <xmx:B56easRQB5K-P1Q2VsE_h9MmZqkzLWm0vdRsRo8fVhZEMQfvVwhSl2GJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c67d8466 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:45 +0200
Subject: [PATCH v2 11/11] setup: allow "git init --ref-storage-format=" to
 specify a payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-11-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Reference storage backends can be configured with a payload via the
"extensions.refStorage" config key and the "GIT_REF_STORAGE_FORMAT"
environment variable, both of which accept a URI in the format
"<format>://<payload>". The payload may contain backend-specific
information, for example an alternate refs directory or which database
references should be stored in.

The `--ref-storage-format=` option of git-init(1) and git-clone(1) does
not know about payloads though: its value is parsed as a plain format
name, so backends that require a payload cannot be conveniently set up
at initialization time via the command line.

Teach the option to accept the same URI syntax. Also, document the
optional payloads for both the "files" and "reftable" backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-init.adoc           |  5 ++++-
 Documentation/ref-storage-format.adoc |  8 ++++++--
 builtin/clone.c                       | 14 +++++++-------
 builtin/init-db.c                     | 17 +++++------------
 setup.c                               | 16 +++++++++++-----
 setup.h                               |  2 +-
 t/t0001-init.sh                       |  2 +-
 t/t1423-ref-backend.sh                | 30 ++++++++++++++++++++++++++++++
 8 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index 7e407d3ef1..e078369ed7 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -58,7 +58,10 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 include::object-format-disclaimer.adoc[]
 
 `--ref-storage-format=<format>`::
-Specify the given ref storage _<format>_ for the repository. The valid values are:
+Specify the given ref storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a connection string identifying the
+database that shall store the references. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
index c5e29ec831..21d62557b7 100644
--- a/Documentation/ref-storage-format.adoc
+++ b/Documentation/ref-storage-format.adoc
@@ -1,8 +1,12 @@
-`files`;; for loose files with packed-refs.
+`files[://<path>]`;; for loose files with packed-refs. The optional payload can
+be specified to change the root directory where references are created. A
+relative path will be resolved relative to the repository's common directory.
 ifndef::with-breaking-changes[]
 	This is the default.
 endif::with-breaking-changes[]
-`reftable`;; for the reftable format.
+`reftable[://<path>]`;; for the reftable format. The optional payload can
+be specified to change the root directory where references are created. A
+relative path will be resolved relative to the repository's common directory.
 ifdef::with-breaking-changes[]
 	This is the default.
 endif::with-breaking-changes[]
diff --git a/builtin/clone.c b/builtin/clone.c
index 93be65efcd..808a40c4fb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -901,7 +901,7 @@ int cmd_clone(int argc,
 	char *option_origin = NULL;
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
-	const char *ref_storage_format_str = NULL;
+	const char *ref_storage_format_uri = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -981,9 +981,9 @@ int cmd_clone(int argc,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
-		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
@@ -1029,10 +1029,10 @@ int cmd_clone(int argc,
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
 
-	if (ref_storage_format_str) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
+	if (ref_storage_format_uri) {
+		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri, NULL);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
+			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
 	if (option_mirror) {
@@ -1188,7 +1188,7 @@ int cmd_clone(int argc,
 	 * their on-disk data structures.
 	 */
 	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
-		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
+		GIT_HASH_UNKNOWN, ref_storage_format_uri, NULL,
 		do_not_override_repo_unix_permissions,
 		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 63f33154c0..48074cb235 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -83,10 +83,9 @@ int cmd_init_db(int argc,
 	unsigned int flags = 0;
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
-	const char *ref_storage_format_str = NULL;
+	const char *ref_storage_format_uri = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
-	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	int init_shared_repository = -1;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -109,9 +108,9 @@ int cmd_init_db(int argc,
 			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
-		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_END()
 	};
@@ -175,12 +174,6 @@ int cmd_init_db(int argc,
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
 
-	if (ref_storage_format_str) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
-		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
-	}
-
 	if (init_shared_repository != -1)
 		repo_settings_set_shared_repository(the_repository, init_shared_repository);
 
@@ -251,8 +244,8 @@ int cmd_init_db(int argc,
 
 	flags |= INIT_DB_EXIST_OK;
 	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
-		      template_dir, hash_algo, ref_storage_format, initial_branch,
-		      init_shared_repository, flags);
+		      template_dir, hash_algo, ref_storage_format_uri,
+		      initial_branch, init_shared_repository, flags);
 
 	free(template_dir_to_free);
 	free(real_git_dir_to_free);
diff --git a/setup.c b/setup.c
index 52ad0f417d..4ece4725a5 100644
--- a/setup.c
+++ b/setup.c
@@ -2727,7 +2727,8 @@ static int read_default_format_config(const char *key, const char *value,
 }
 
 static void repository_format_configure(struct repository_format *repo_fmt,
-					int hash, enum ref_storage_format ref_storage_format)
+					int hash,
+					const char *ref_storage_format_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2738,6 +2739,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
+	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload = NULL;
 	const char *env;
 
@@ -2788,8 +2790,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *   6. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
 	 */
-	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
-		/* nothing to do */
+	if (ref_storage_format_uri) {
+		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri,
+							       &ref_storage_payload);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format specified via command line: '%s'"),
+			    ref_storage_format_uri);
 	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
 		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
 		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
@@ -2834,7 +2840,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_format_uri,
 	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
@@ -2871,7 +2877,7 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index 763fd384e8..f04d2984b4 100644
--- a/setup.h
+++ b/setup.h
@@ -265,7 +265,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash_algo,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_format_uri,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(struct repository *repo,
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index fe5bc3d3e1..f1d227f271 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -833,7 +833,7 @@ done
 test_expect_success 'init with --ref-storage-format=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	fatal: unknown ref storage format specified via command line: ${SQ}garbage${SQ}
 	EOF
 	test_must_fail git init --ref-storage-format=garbage refformat 2>err &&
 	test_cmp expect err
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 525b2a19b4..ee2bb66b99 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -254,6 +254,36 @@ test_expect_success 'initializing repository with alt ref directory' '
 	)
 '
 
+test_expect_success 'initializing repository with --ref-storage-format and payload' '
+	test_when_finished "rm -rf repo refdir" &&
+	mkdir refdir &&
+	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
+	git init --ref-storage-format="$BACKEND" repo &&
+	verify_files_exist repo/.git refdir &&
+
+	git -C repo config get extensions.refstorage >actual &&
+	echo $BACKEND >expect &&
+	test_cmp expect actual &&
+
+	test_commit -C repo 1 &&
+	git -C repo refs list >out &&
+	test_grep "refs/tags/1" out &&
+
+	# Reinitializing the repository is fine when not specifying any format.
+	git -C repo init &&
+	# Reinitializing with the same backend is fine, too.
+	git -C repo init --ref-storage-format="$BACKEND" &&
+	# Reinitializing without a payload should fail.
+	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)" 2>err &&
+	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
+	# Reinitializing with a different payload should fail, too.
+	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)://$(pwd)/other" 2>err &&
+	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
+
+	git -C repo config get extensions.refstorage >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cloning repository with alt ref directory' '
 	test_when_finished "rm -rf source repo refdir" &&
 	mkdir refdir &&

-- 
2.55.0.1007.g17ff1f9808.dirty

