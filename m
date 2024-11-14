Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1B186284
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603260; cv=none; b=ElGx4rQJWiZznVJiNQwC7+I1BtnWyMcxpM37M50yEvJgHrdtn+iCZHMCQgzOQIRMouDS7ltIDtvxeBnEcwl92CnxHjtpDSSealGnUH0luQ0H3bBuxLUz+yHRXPlJrOWe7EnKE+FbjYxIZxPbH1ZJtOR16mX4sH46W2kdbzn/k68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603260; c=relaxed/simple;
	bh=UMmNFe+UimwvkhTx+Oxb3XjhyVe27DK+GxSHcDqvSRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0eE0Q5yMc0a+qfzuRcGJMOI/meSg2krdsklQtdZrnmyG0M7HOuwMkT10jIKItJlO0kmJYAtq/W35FbHIoJILB/MYiYjspPsHYrlqzG5NPz3b4nsuvDr7GXVfYUBs4HiaoU3ZIWm7yDlAnil83bmXNzShC2vFM49gcYdf8lusXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkH+7RQa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkH+7RQa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2110a622d76so7812195ad.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603258; x=1732208058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCrwS1CZXCGmjcEuTdAojT1OFTke1dmbq+oiF708lmM=;
        b=TkH+7RQaYEX9xw7Yjw3RwyZ1IqlG7RwTIwJEJkiHcjtlg6dtl7wHHbR2Zv5t9wIS0s
         i55JIOaLUIHKYibVeBvHZd9HJf3DG7hGF8YKR4EXG8MPUkMao0lnIiv68jfIsS9/19dF
         Dpj5OeFH2go9XqGRsj4vc/u3YmVu/CkJh0eYa7/OIaxNRezqH4VSigBUyX1VcLzBaTUa
         4emWaycCmLX7Q6EF4F6Ox/mrqMRSjukN317teoua2LS8vNfOG43fVfdAE5hr3YDsUBj5
         v85EnJHPXNyXVpIpHVqeqsoigSlzKgVjAbKqGVdW3UrB5VeLZSSeSTlYCNN8MILMCzgf
         5teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603258; x=1732208058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCrwS1CZXCGmjcEuTdAojT1OFTke1dmbq+oiF708lmM=;
        b=r7Mq15xHDW7fWOzi44zQ4GUV/NZA3wAl9REge/ikTscWCez1pWDVKpjkjw+W0a1SmG
         34q/eiKCDLTcuSGd92IrlLPEqwRA8SS8NU5yygZAeqI0gWC7Us3QyZ3vBvzGIgvmCBup
         dtCENUD2OdM51bXSrAQxP6nyuB9cr9JaRIQWEF7AP49iq+DSaRgeToV3+83RPnwhsyUD
         PqNqlX078OJ1Dhs9QhRgG8uH5qLTlFOYyRj6X6scD8Q84l2/aq/GJT291LOmw778oU6n
         zYwJZAhkJfRKBRZKFIFHQVcGt+oWVHe183sAFBMDRiQae3L9dI27ZGC/N51s21OxGOQe
         YhzA==
X-Gm-Message-State: AOJu0YwAFS/JDnTyldBjTuor8yD5zEw/osp7QH6CzanO5WmxnqVG88W5
	vMmPDwuKJ0J+z3cn7bWK/bSCIgPYs1eOElBKidqEBgG2pFQCxiTrrXaC4w==
X-Google-Smtp-Source: AGHT+IFdskRxKXwtwf2TFD9A8SaWHkQi7yeXutZTonS76UnzqO+YpyK2MnZ6hfS47v7qczQYKnVpKQ==
X-Received: by 2002:a17:902:e549:b0:20f:c225:f28c with SMTP id d9443c01a7336-21183da3eeemr353772235ad.52.1731603257684;
        Thu, 14 Nov 2024 08:54:17 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7ce9461sm12888635ad.117.2024.11.14.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:54:17 -0800 (PST)
Date: Fri, 15 Nov 2024 00:54:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZzYrOyvgyS8NWSzO@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

We have already set up the infrastructure to check the consistency for
refs, but we do not support multiple worktrees. However, "git-fsck(1)"
will check the refs of worktrees. As we decide to get feature parity
with "git-fsck(1)", we need to set up support for multiple worktrees.

Because each worktree has its own specific refs, instead of just showing
the users "refs/worktree/foo", we need to display the full name such as
"worktrees/<id>/refs/worktree/foo". So we should know the id of the
worktree to get the full name. Add a new parameter "struct worktree *"
for "refs-internal.h::fsck_fn". Then change the related functions to
follow this new interface.

The "packed-refs" only exists in the main worktree, so we should only
check "packed-refs" in the main worktree. Use "is_main_worktree" method
to skip checking "packed-refs" in "packed_fsck" function.

Then, enhance the "files-backend.c::files_fsck_refs_dir" function to add
"worktree/<id>/" prefix when we are not in the main worktree.

Last, add a new test to check the refname when there are multiple
worktrees to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c           | 10 ++++++--
 refs.c                   |  5 ++--
 refs.h                   |  3 ++-
 refs/debug.c             |  5 ++--
 refs/files-backend.c     | 17 ++++++++++----
 refs/packed-backend.c    |  8 ++++++-
 refs/refs-internal.h     |  3 ++-
 refs/reftable-backend.c  |  3 ++-
 t/t0602-reffiles-fsck.sh | 51 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b7b..394b4101c6 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "worktree.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
@@ -66,6 +67,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 {
 	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct worktree **worktrees;
 	const char * const verify_usage[] = {
 		REFS_VERIFY_USAGE,
 		NULL,
@@ -75,7 +77,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
 		OPT_END(),
 	};
-	int ret;
+	int ret = 0;
 
 	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
 	if (argc)
@@ -84,9 +86,13 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+	worktrees = get_worktrees();
+	for (size_t i = 0; worktrees[i]; i++)
+		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
+				 &fsck_refs_options, worktrees[i]);
 
 	fsck_options_clear(&fsck_refs_options);
+	free_worktrees(worktrees);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 5f729ed412..395a17273c 100644
--- a/refs.c
+++ b/refs.c
@@ -318,9 +318,10 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
-int refs_fsck(struct ref_store *refs, struct fsck_options *o)
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt)
 {
-	return refs->be->fsck(refs, o);
+	return refs->be->fsck(refs, o, wt);
 }
 
 void sanitize_refname_component(const char *refname, struct strbuf *out)
diff --git a/refs.h b/refs.h
index 108dfc93b3..341d43239c 100644
--- a/refs.h
+++ b/refs.h
@@ -549,7 +549,8 @@ int check_refname_format(const char *refname, int flags);
  * reflogs are consistent, and non-zero otherwise. The errors will be
  * written to stderr.
  */
-int refs_fsck(struct ref_store *refs, struct fsck_options *o);
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
diff --git a/refs/debug.c b/refs/debug.c
index 45e2e784a0..72e80ddd6d 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -420,10 +420,11 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 }
 
 static int debug_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->fsck(drefs->refs, o);
+	int res = drefs->refs->be->fsck(drefs->refs, o, wt);
 	trace_printf_key(&trace_refs, "fsck: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8edb700568..8bfdce64bc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -23,6 +23,7 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../revision.h"
@@ -3539,6 +3540,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
+			       struct worktree *wt,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
 	struct strbuf refname = STRBUF_INIT;
@@ -3561,6 +3563,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
 			strbuf_reset(&refname);
+
+			if (!is_main_worktree(wt))
+				strbuf_addf(&refname, "worktrees/%s/", wt->id);
 			strbuf_addf(&refname, "%s/%s", refs_check_dir,
 				    iter->relative_path);
 
@@ -3590,7 +3595,8 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 }
 
 static int files_fsck_refs(struct ref_store *ref_store,
-			   struct fsck_options *o)
+			   struct fsck_options *o,
+			   struct worktree *wt)
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
@@ -3599,17 +3605,18 @@ static int files_fsck_refs(struct ref_store *ref_store,
 
 	if (o->verbose)
 		fprintf_ln(stderr, _("Checking references consistency"));
-	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
+	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 
 static int files_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return files_fsck_refs(ref_store, o) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return files_fsck_refs(ref_store, o, wt) |
+	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
 }
 
 struct ref_storage_be refs_be_files = {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07c57fd541..46dcaec654 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,6 +13,7 @@
 #include "../lockfile.h"
 #include "../chdir-notify.h"
 #include "../statinfo.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../trace2.h"
@@ -1754,8 +1755,13 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 }
 
 static int packed_fsck(struct ref_store *ref_store UNUSED,
-		       struct fsck_options *o UNUSED)
+		       struct fsck_options *o UNUSED,
+		       struct worktree *wt)
 {
+
+	if (!is_main_worktree(wt))
+		return 0;
+
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..037d7991cd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,8 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refnam
 				 struct strbuf *referent);
 
 typedef int fsck_fn(struct ref_store *ref_store,
-		    struct fsck_options *o);
+		    struct fsck_options *o,
+		    struct worktree *wt);
 
 struct ref_storage_be {
 	const char *name;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f5f957e6de..b6a63c1015 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2443,7 +2443,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 }
 
 static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
-			    struct fsck_options *o UNUSED)
+			    struct fsck_options *o UNUSED,
+			    struct worktree *wt UNUSED)
 {
 	return 0;
 }
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 2a172c913d..1e17393a3d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -107,4 +107,55 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
 '
 
+test_expect_success 'ref name check should work for multiple worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	cd repo &&
+	test_commit initial &&
+	git checkout -b branch-1 &&
+	test_commit second &&
+	git checkout -b branch-2 &&
+	test_commit third &&
+	git checkout -b branch-3 &&
+	git worktree add ./worktree-1 branch-1 &&
+	git worktree add ./worktree-2 branch-2 &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+
+	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
+	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err &&
+
+	for worktree in "worktree-1" "worktree-2"
+	do
+		(
+			cd $worktree &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+			error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+			EOF
+			sort err >sorted_err &&
+			test_cmp expect sorted_err || return 1
+		)
+	done
+'
+
 test_done
-- 
2.47.0

