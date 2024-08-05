Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B03E479
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876178; cv=none; b=Dj29haZ5/JDqyBZLb8jaotcQQXM1PeeqXiVUmzTVFjQkA5RHn9vhv2DNCUh6G54pjtfpEoNmj51eHHXj5a8OeMUvzinGhWhODRUOSUkD7qFALfJeLRcCFYFICvhvs0HwYaj3DR4ePnHhw+xagofScy5odG/wP4v4fmnXxB/jr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876178; c=relaxed/simple;
	bh=jqKmSzwIpD6qSKZTkXzR51JKCWhCIP2ibHU5LzIY0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbqjj7TXFcAJ5KafXZvNVuUh/fH5ISNc26E4zgffy2mec4RthqtTGIWEncoGF6OrTUbuvT8HnJ0G2q4YezyC76ZwLRpUy6rvrUnB9WMulvL1fFLs6vQZUuSLqOJDNSBASpgcS+1129o9/dYlHcBJrQc35sDNmbvUoq3sbRdhuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/qMBUDD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/qMBUDD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d399da0b5so9171916b3a.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876175; x=1723480975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxmAH2zhbrX5QgUD55kbMJotC6557LWDaokbkEmV//o=;
        b=b/qMBUDDhXwHXwBARaDDr115WW7hY2umSxQ4CmgRXwVNaLRuDZGT+y1NQBO8GHpbsd
         /KgYEK//FYeAxtpVtc49fRxD3H7RnN83s37k3noT5YJlTeWiGXrVmwTdnswRlTvh1wMN
         o5Nf6RtLGbjZOVLePJ5O1XSMphxwDs/hFHZXEgdQekUyJCununmQ5dibLeT10HqlACEF
         R92/3SlnYgplPaQq8nAtG9tWawDR8zOyTZpBlKrkjxYLX00W0jaDf9Sbz5We6MV53bQu
         PljkaEFHWKN6a6MjOviBR7b4l/2k9KVShWG2YxOgCkzuCErNE4e17lKvYyMsCfBXtIs/
         9zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876175; x=1723480975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxmAH2zhbrX5QgUD55kbMJotC6557LWDaokbkEmV//o=;
        b=aPooIRaJ6IZyIeTuka2IZ55cvPURJshPxO4izwHfLh3RCvM3RncXhddebnGoUk190M
         48ubtRMpiWQy2EAEze8Z6FgMtUiK3Wa4LA5ig9TCP1U/XwDd8khGWvASJJ2ivzA31Y6Z
         Rhm34n6xqHoAG1mx9q1skuONkWHLHujcfKEHMA5hoKK3k2cbYRgviC59uezHoKBVYZSQ
         MyWWXLWn40myp94OBpz5DDyKaxC8GVwBdnFzblp1uyLUmSE5xTXAaNSMMrH0WVVdQBzD
         AJvlpROV1z9kkQoHtIkzl4qtVnFQcn5wAHRxXxgb7Mk4PBbY0myvD7qShaNI5+oBMd5r
         oERA==
X-Gm-Message-State: AOJu0YxKEDQIJhlLSjfIgfdWkxdnAOQ15DO9PuRFgm3z9NhQmPrkn5Cs
	frrUa0F1HNvt/XQN/cKUjUNHwOHD7BBr/EGITcCllZWr4k5plSe4htOOBA==
X-Google-Smtp-Source: AGHT+IG42y6zBV4uW4VJFs/HtC4OPbXoSpJ3l3o0vsWxF4jFAZLE8g+P+7eYwVWAz8KBd4pKIfw66A==
X-Received: by 2002:a05:6a00:2301:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-7109d5df755mr3377785b3a.19.1722876175143;
        Mon, 05 Aug 2024 09:42:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec40f5asm5614712b3a.51.2024.08.05.09.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:42:54 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:43:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 0/9] ref consistency check infra setup
Message-ID: <ZrEBKjzbyxtMdCCx@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

Hi All:

This version handles the following problems:

1. Patrick advices that I should not use `va_copy` in the changed
`report` function. Actually this is a mistake, this version avoids
redundant `ap` copy.
2. Patrick advices I should rebase [v14 05/11] into [v14 04/11]. I
follow this advice in this version.
3. Patrick advices that we should put [v14 06/11] before we introduce
ref-related operations. This version reorders the commit sequence. It's
a minor change.
4. Patrick suggests at current we should not add `git refs verify`
command into "git-fsck(1)". This is because we should disable this new
check by default for the users. Many users use "git-fsck(1)" in their daily
workflow. We should not be aggressive. However, if we provide this
mechanism in this series, we will again make more complexity. So this
version drop patch [v14 09/11]. Also because of dropping, change the
test file to use "git refs verify" command instead of "git fsck"
command.
5. Patrick suggests that we should use `ends_with` instead of
`strip_suffix`, fix.

There is another important problem this patch solves:

At v13, Junio has suggested that the `files_fsck_refs_fn` should be
adapted to Patrick's change. Actually, I made a bad design before. I
should always pass the `ref_store` structure. So I change it to

  -typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
  -				  const char *gitdir,
  +typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
  +				  struct fsck_options *o,
            const char *refs_check_dir,
            struct dir_iterator *iter);

`gitdir` could be got by using `ref_store` parameter. By using
`ref_store` parameter, we provide extensibility here. If something else
change, we merely need to change "files_fsck_refs_fn" prototype.

Because I drop one patch and rebase one patch. I provide the `interdiff`
for reviewers to make the life easier.

Due to the deadline of the GSoC, I will speed up the review feedback
process.

Thanks,
Jialuo

shejialuo (9):
  fsck: rename "skiplist" to "skip_oids"
  fsck: rename objects-related fsck error functions
  fsck: make "fsck_error" callback generic
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend

 Documentation/fsck-msgids.txt |   6 ++
 Documentation/git-refs.txt    |  13 ++++
 builtin/fsck.c                |  17 +++--
 builtin/mktag.c               |   3 +-
 builtin/refs.c                |  34 +++++++++
 fsck.c                        | 127 +++++++++++++++++++++++++++-------
 fsck.h                        |  76 +++++++++++++++-----
 object-file.c                 |   9 ++-
 refs.c                        |   5 ++
 refs.h                        |   8 +++
 refs/debug.c                  |  11 +++
 refs/files-backend.c          | 116 ++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 +++
 refs/refs-internal.h          |   6 ++
 refs/reftable-backend.c       |   8 +++
 t/t0602-reffiles-fsck.sh      |  92 ++++++++++++++++++++++++
 16 files changed, 480 insertions(+), 59 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Interdiff against v14:
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b6ac878270..766bbd014d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -899,21 +899,6 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
-static void fsck_refs(void)
-{
-	struct child_process refs_verify = CHILD_PROCESS_INIT;
-	child_process_init(&refs_verify);
-	refs_verify.git_cmd = 1;
-	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
-	if (verbose)
-		strvec_push(&refs_verify.args, "--verbose");
-	if (check_strict)
-		strvec_push(&refs_verify.args, "--strict");
-
-	if (run_command(&refs_verify))
-		errors_found |= ERROR_REFS;
-}
-
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1083,8 +1068,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
-	fsck_refs();
-
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
diff --git a/fsck.c b/fsck.c
index d5e7c88eab..7eb5cdefdd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -235,7 +235,6 @@ static int fsck_vreport(struct fsck_options *options,
 			void *fsck_report,
 			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -251,12 +250,10 @@ static int fsck_vreport(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_copy(ap_copy, ap);
-	strbuf_vaddf(&sb, fmt, ap_copy);
+	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(options, fsck_report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
-	va_end(ap);
 
 	return result;
 }
@@ -1391,5 +1388,6 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 		puts(oid_to_hex(report->oid));
 		return 0;
 	}
-	return fsck_objects_error_function(o, fsck_report, msg_type,msg_id, message);
+	return fsck_objects_error_function(o, fsck_report,
+					   msg_type, msg_id, message);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1186b6cbb1..6e6b47251d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3414,26 +3414,25 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
  * the whole directory. This function is used as the callback for each
  * regular file or symlink in the directory.
  */
-typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
-				  const char *gitdir,
+typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
+				  struct fsck_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
-static int files_fsck_refs_name(struct fsck_options *o,
-				const char *gitdir UNUSED,
+static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
+				struct fsck_options *o,
 				const char *refs_check_dir,
 				struct dir_iterator *iter)
 {
 	struct strbuf sb = STRBUF_INIT;
-	size_t len = 0;
 	int ret = 0;
 
 	/*
 	 * Ignore the files ending with ".lock" as they may be lock files
 	 * However, do not allow bare ".lock" files.
 	 */
-	if (strip_suffix(iter->basename, ".lock", &len) && (len != 0))
-		goto clean;
+	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
+		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
 		struct fsck_ref_report report = { .path = NULL };
@@ -3445,7 +3444,7 @@ static int files_fsck_refs_name(struct fsck_options *o,
 				      "invalid refname format");
 	}
 
-clean:
+cleanup:
 	strbuf_release(&sb);
 	return ret;
 }
@@ -3455,13 +3454,12 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       const char *refs_check_dir,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
-	const char *gitdir = ref_store->gitdir;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
 	int iter_status;
 	int ret = 0;
 
-	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
+	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
@@ -3478,7 +3476,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 				fprintf_ln(stderr, "Checking %s/%s",
 					   refs_check_dir, iter->relative_path);
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](o, gitdir, refs_check_dir, iter))
+				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
 					ret = -1;
 			}
 		} else {
@@ -3507,7 +3505,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 	};
 
 	if (o->verbose)
-		fprintf_ln(stderr, "Checking references consistency");
+		fprintf_ln(stderr, _("Checking references consistency"));
 	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
 
 }
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 2be28427ab..71a4d1a5ae 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -26,7 +26,7 @@ test_expect_success 'ref name should be checked' '
 	git tag multi_hierarchy/tag-2 &&
 
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	test_must_fail git fsck 2>err &&
+	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/.branch-1: badRefName: invalid refname format
 	EOF
@@ -34,7 +34,7 @@ test_expect_success 'ref name should be checked' '
 	test_cmp expect err &&
 
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
-	test_must_fail git fsck 2>err &&
+	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/@: badRefName: invalid refname format
 	EOF
@@ -42,7 +42,7 @@ test_expect_success 'ref name should be checked' '
 	test_cmp expect err &&
 
 	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
-	test_must_fail git fsck 2>err &&
+	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
 	EOF
@@ -50,12 +50,12 @@ test_expect_success 'ref name should be checked' '
 	test_cmp expect err &&
 
 	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
-	git fsck 2>err &&
+	git refs verify 2>err &&
 	rm $tag_dir_prefix/tag-1.lock &&
 	test_must_be_empty err &&
 
 	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
-	test_must_fail git fsck 2>err &&
+	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/tags/.lock: badRefName: invalid refname format
 	EOF
@@ -76,18 +76,16 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	git checkout -b branch-2 &&
 	git tag tag-2 &&
 
-
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	git -c fsck.badRefName=warn fsck 2>err &&
+	git -c fsck.badRefName=warn refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/heads/.branch-1: badRefName: invalid refname format
 	EOF
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
-	git -c fsck.badRefName=ignore fsck 2>err &&
+	git -c fsck.badRefName=ignore refs verify 2>err &&
 	test_must_be_empty err
 '
 
-- 
2.46.0

