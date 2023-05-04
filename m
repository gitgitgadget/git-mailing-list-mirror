Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA510C77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjEDPtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEDPs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 11:48:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7831BF7
        for <git@vger.kernel.org>; Thu,  4 May 2023 08:48:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so5209915e9.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215333; x=1685807333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bh+kqb5Hx725gysAKpHAhm4E2jcRpHCCM1qwhjbSj8=;
        b=qFoPwgwjNnIELfRasKD3XDXwoWO+OJNNdNZ8kL4HC4jBzXtEWwHXTt6VheYaZgvpEA
         5VoPN6/8HEhdqK8wAeNi6BiSo75l5TXMcbnUtXZFpOPdYlgjx9tgd0W/gvyqyI+yNRm7
         k9kPN9YkrN7u3KfpVJOrMvgllHlitFabO/AM0Zs/sYFXf8QxCPaI9kuMraBnACycPerJ
         uiCkB4pzbhAvxTrjBQ5cEwKtLrdREk1bS3KUxX8mdgcZHVJCRUajNMJvYw+1uT/4SQT8
         euMkWpqF6euuqRSKZaXDU5l54gOsX1f9qrvcGOu+AqyH5kxTS1gELZODyP4c1/S/udZR
         uvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215333; x=1685807333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Bh+kqb5Hx725gysAKpHAhm4E2jcRpHCCM1qwhjbSj8=;
        b=WJRyKWX4gnumIK1RN+8miIUamUdqJHdIV0DqikSu2PTnUMHR2012X/6AcIZiGGZZjG
         xoTyqNDXe4fWP+VPuAoV2eFZg6/d+NHRyGTjd+hT66D9oiAkFW4pjzaf5PjEVGhs3dr4
         ZH3e05BfoRiGJj3cPrwC8wsCx06fzx9b+FnWo3IVKkulUQyBsdKsFTH59HIaWmh7Wv+Z
         y5zn2o2DZR4c9EHreQZ8/o85iW1hhFsApClnLK68LWzQLTAyvthbI1Jalxl30Q+R+kE7
         CoYQSAPzUZdtzQRWtlGGz91OBv+6AYJILLaKV9BpNn5d/2pmORyPFNmCNYwbMmHgKXeu
         gsCg==
X-Gm-Message-State: AC+VfDxchCrw+T0pePrFsdF3JB5rs2gzOYyQzq8nxCjePEV9a6G89uv5
        yDMKu+LsfcMwpMFInMYLIAEAwX11cUg=
X-Google-Smtp-Source: ACHHUZ4J/1FGDRYCcqjR6zzJrgd51cWP4cLnRHQSiHOw6Ug3g5+L3JWBidLpPHE8f0hjv3JdyQHPkQ==
X-Received: by 2002:a05:600c:2257:b0:3f1:78a7:6bd2 with SMTP id a23-20020a05600c225700b003f178a76bd2mr75997wmm.27.1683215333243;
        Thu, 04 May 2023 08:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003f193d7c6b7sm5187247wme.41.2023.05.04.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:48:52 -0700 (PDT)
Message-Id: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 May 2023 15:48:51 +0000
Subject: [PATCH] pack-refs: teach --exclude option to exclude refs from being
 packed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <jcai@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <jcai@gitlab.com>

Currently once refs are packed into a pack-refs file, deleting them can be
slow since it involves a full file scan of the entire pack-refs file. At
GitLab, we have a system that creates ephemeral internal refs that don't
live long before getting deleted. Having an option to not include certain
refs from a pack-refs file allows these internal references to be deleted
much more efficiently.

Add an --exclude option to the pack-refs builtin, and use the ref
exclusions API to exclude certain refs from being packed into the final
pack-refs file

Signed-off-by: John Cai <johncai86@gmail.com>
---
    pack-refs: Teach --exclude option to exclude refs from being packed
    
    Add an --exclude option to the pack-refs builtin, to prevent certain
    refs from being packed into the final packrefs file. At GitLab we keep
    ephemeral internal references that quickly get deleted. Being able to
    exclude them from the packrefs file will avoid incurring the performance
    hit from ref deletions--especially since it scales with packrefs size.
    
    It's worth noting that [1] discussed a proposal for a pack refs v2
    format that would improve deletion speeds. The ref-table backend would
    also improve performance of deletions. However, both of those proposals
    are still being discussed.
    
     1. https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1501%2Fjohn-cai%2Fjc%2Fexclude-refs-from-pack-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1501/john-cai/jc/exclude-refs-from-pack-refs-v1
Pull-Request: https://github.com/git/git/pull/1501

 Documentation/git-pack-refs.txt |  8 +++++++-
 builtin/pack-refs.c             | 17 +++++++++++++++--
 refs.c                          |  4 ++--
 refs.h                          |  6 +++++-
 refs/debug.c                    |  4 ++--
 refs/files-backend.c            | 13 ++++++++++---
 refs/packed-backend.c           |  3 ++-
 refs/refs-internal.h            |  4 +++-
 t/helper/test-ref-store.c       |  3 ++-
 t/t3210-pack-refs.sh            | 18 ++++++++++++++++++
 10 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f2de2..d80e0a1562d 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 SYNOPSIS
 --------
 [verse]
-'git pack-refs' [--all] [--no-prune]
+'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -59,6 +59,12 @@ a repository with many branches of historical interests.
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
+--exclude <pattern>::
+
+Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
+accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
+patterns.
+
 
 BUGS
 ----
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 9833815fb30..bc2db41c2cb 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -4,22 +4,35 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
+#include "revision.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune]"),
+	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
 	NULL
 };
 
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
+	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct pack_refs_opts pack_opts = {.exclusions = &excludes};
+	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
+			N_("references to exclude")),
 		OPT_END(),
 	};
+
 	git_config(git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return refs_pack_refs(get_main_ref_store(the_repository), flags);
+
+	for_each_string_list_item(item, &option_excluded_refs)
+		add_ref_exclusion(pack_opts.exclusions, item->string);
+
+	return refs_pack_refs(get_main_ref_store(the_repository), flags, &pack_opts);
 }
diff --git a/refs.c b/refs.c
index d2a98e1c21f..637810347a0 100644
--- a/refs.c
+++ b/refs.c
@@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 }
 
 /* backend functions */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags)
+int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *pack_opts)
 {
-	return refs->be->pack_refs(refs, flags);
+	return refs->be->pack_refs(refs, flags, pack_opts);
 }
 
 int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
diff --git a/refs.h b/refs.h
index 123cfa44244..a76dbb2d3f0 100644
--- a/refs.h
+++ b/refs.h
@@ -63,6 +63,10 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
+struct pack_refs_opts {
+	struct ref_exclusions *exclusions;
+};
+
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
@@ -405,7 +409,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
  */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags);
+int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *opts);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/debug.c b/refs/debug.c
index adc34c836fc..93f6168052a 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -122,10 +122,10 @@ static int debug_initial_transaction_commit(struct ref_store *refs,
 	return res;
 }
 
-static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
+	int res = drefs->refs->be->pack_refs(drefs->refs, flags, opts);
 	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d0581ee41ac..b77c474919f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -19,6 +19,7 @@
 #include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
+#include "../revision.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
@@ -1173,7 +1174,8 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  */
 static int should_pack_ref(const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
-			   unsigned int pack_flags)
+			   unsigned int pack_flags,
+			   struct pack_refs_opts *opts)
 {
 	/* Do not pack per-worktree refs: */
 	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
@@ -1192,10 +1194,15 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
+	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
+		return 0;
+
 	return 1;
 }
 
-static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int files_pack_refs(struct ref_store *ref_store,
+			   unsigned int flags,
+			   struct pack_refs_opts *pack_opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1221,7 +1228,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * pruned, also add it to refs_to_prune.
 		 */
 		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
-				     flags))
+				     flags, pack_opts))
 			continue;
 
 		/*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2333ed5a1f7..8a611dd92b4 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1576,7 +1576,8 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 }
 
 static int packed_pack_refs(struct ref_store *ref_store UNUSED,
-			    unsigned int flags UNUSED)
+			    unsigned int flags UNUSED,
+			    struct pack_refs_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a85d113123c..7b4852104f0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -547,7 +547,9 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
-typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int pack_refs_fn(struct ref_store *ref_store,
+			 unsigned int flags,
+			 struct pack_refs_opts *opts);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 6d8f844e9c7..0405cacc99b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -116,8 +116,9 @@ static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
+	struct pack_refs_opts pack_opts = { 0 };
 
-	return refs_pack_refs(refs, flags);
+	return refs_pack_refs(refs, flags, &pack_opts);
 }
 
 static int cmd_create_symref(struct ref_store *refs, const char **argv)
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 07a0ff93def..31b9f72e84a 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -108,6 +108,24 @@ test_expect_success \
      git branch -d n/o/p &&
      git branch n'
 
+test_expect_success \
+    'test excluded refs are not packed' '
+     git branch dont_pack1 &&
+     git branch dont_pack2 &&
+     git branch pack_this &&
+     git pack-refs --all --exclude refs/heads/dont_pack* &&
+     test -f .git/refs/heads/dont_pack1 &&
+     test -f .git/refs/heads/dont_pack2 &&
+     ! test -f ./git/refs/heads/pack_this'
+
+test_expect_success \
+    'test --no-exclude refs clears excluded refs' '
+     git branch dont_pack3 &&
+     git branch dont_pack4 &&
+     git pack-refs --all --exclude refs/heads/dont_pack* --no-exclude &&
+     ! test -f .git/refs/heads/dont_pack3 &&
+     ! test -f .git/refs/heads/dont_pack4'
+
 test_expect_success \
 	'see if up-to-date packed refs are preserved' \
 	'git branch q &&

base-commit: f85cd430b12b0d3e4f1a30ef3239a1b73d5f6331
-- 
gitgitgadget
