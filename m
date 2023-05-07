Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C69C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEGDsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEGDrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:47:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5521A115
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so21241165e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431169; x=1686023169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El59bK7JSFEywYHqvBjD2SN+B4bI3RMWhoHGQ1NHguA=;
        b=lJD3eVTSN3VIJG623aO1GzrZqm4LO4iTNXMzmiU+7zl2qkUso2ui3l/tkGCZC/ika9
         PLYxRxBFqnvyzWihECZVbIe/4b0u0YxDYvK761jZKq4wYUkAgOj1j6XM0GRMwmiNp+ZS
         iFAS74vR2Fm29Q0HcwQUqdF+0wMO+PWnDJXNXV2XI//hwH4VuLLjuRczIl+nDSeCac+R
         K2C+tFr6hJmtD2GAQY9m2b5LMj+7HK57MrLo9Z+jUNOnNqeAatbbg2SnCrgpcLdrjkHz
         iGqeeg2JZepjxbCmuE8k6ewzkJLyam2UZ0YKoge20bjakvWwFEfTuZR/RGFDHk8dY3g+
         E1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431169; x=1686023169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El59bK7JSFEywYHqvBjD2SN+B4bI3RMWhoHGQ1NHguA=;
        b=Plt9zVl8eJ03wP3s23F4ESfKh7+JoxDcWmXAdGv/08dh81YNRWzEdq812EqiH/VG1U
         RDaNU+EVUbVawj0j4W5S6czg/liqxIavxBH9kvv5vfiT3rOAPlM+1QNiwAI4uAvsMu2T
         xXBkNbY+iS7hSeXhqk5uX01ELxobogHjkSpE0zDqU6GdI5tQhtZfs9GFGS8X4Snpkn8N
         0sJESRqDe2/2JdVCuP3LkV/N4hKGFaG/gmXb3BFVM1tocfV3DjeEzP2uzHC4JGdBW4em
         hiDqweYNqcMdXwjWGCyLIe8452qumjiaYtK2UYp734cWLVEHDNKZ6NqfMjoDVz355ntz
         u0zw==
X-Gm-Message-State: AC+VfDwSc4g5psGRRhbE3+tmD8lEExsMMRe/w3htTwUvOVy2X1fcWGZC
        bILUVdOnKx7B68HzaxmFszUpmZTGcYQ=
X-Google-Smtp-Source: ACHHUZ4J+/Rwy4n34bCdVeumypS1A9PZ9q/EpDFW+Oa9B9l6V5nQrUC/9oRFRkHLjo6SJxYFqwxduw==
X-Received: by 2002:a1c:6a1a:0:b0:3f4:2365:e5ac with SMTP id f26-20020a1c6a1a000000b003f42365e5acmr173547wmc.13.1683431169484;
        Sat, 06 May 2023 20:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003f423508c6bsm360661wmd.44.2023.05.06.20.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:09 -0700 (PDT)
Message-Id: <7a9deb749e853e475bc87aed4151dfa7a465c069.1683431153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:47 +0000
Subject: [PATCH 22/24] git-compat-util.h: remove unneccessary include of
 wildmatch.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The include of wildmatch.h in git-compat-util.h was added in cebcab189aa
(Makefile: add USE_WILDMATCH to use wildmatch as fnmatch, 2013-01-01) as
a way to be able to compile-time force any calls to fnmatch() to instead
invoke wildmatch().  The defines and inline function were removed in
70a8fc999d9 (stop using fnmatch (either native or compat), 2014-02-15),
and this include in git-compat-util.h has been unnecessary ever since.

Remove the include from git-compat-util.h, but add it to the .c files
that had omitted the direct #include they needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                   | 1 +
 builtin/describe.c        | 1 +
 builtin/ls-remote.c       | 1 +
 builtin/name-rev.c        | 1 +
 builtin/reflog.c          | 1 +
 builtin/replace.c         | 1 +
 builtin/show-branch.c     | 1 +
 config.c                  | 1 +
 diffcore-order.c          | 1 +
 fmt-merge-msg.c           | 1 +
 git-compat-util.h         | 2 --
 log-tree.c                | 1 +
 pathspec.c                | 1 +
 refs.c                    | 1 +
 revision.c                | 1 +
 t/helper/test-wildmatch.c | 1 +
 trace2/tr2_cfg.c          | 1 +
 17 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index be58dc08d22..801f2bcc99c 100644
--- a/apply.c
+++ b/apply.c
@@ -35,6 +35,7 @@
 #include "entry.h"
 #include "setup.h"
 #include "symlinks.h"
+#include "wildmatch.h"
 #include "ws.h"
 #include "wrapper.h"
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 508e8df00ef..eb19ab0bbbe 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -22,6 +22,7 @@
 #include "object-store.h"
 #include "list-objects.h"
 #include "commit-slab.h"
+#include "wildmatch.h"
 
 #define MAX_TAGS	(FLAG_BITS - 1)
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index a0aadc9b8ff..fc765754305 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -7,6 +7,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "wildmatch.h"
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 593f0506a10..de9808e21c8 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -15,6 +15,7 @@
 #include "hash-lookup.h"
 #include "commit-slab.h"
 #include "commit-graph.h"
+#include "wildmatch.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
diff --git a/builtin/reflog.c b/builtin/reflog.c
index fc217748808..79b4ff04aae 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "revision.h"
 #include "reachable.h"
+#include "wildmatch.h"
 #include "worktree.h"
 #include "reflog.h"
 #include "parse-options.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 6b266a66d30..a2f57a56b3e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -24,6 +24,7 @@
 #include "replace-object.h"
 #include "repository.h"
 #include "tag.h"
+#include "wildmatch.h"
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index cd215f89af8..a203f13cb0d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "commit-slab.h"
 #include "date.h"
+#include "wildmatch.h"
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
diff --git a/config.c b/config.c
index 666ec73bab1..0b2a9f1bd89 100644
--- a/config.c
+++ b/config.c
@@ -36,6 +36,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "trace2.h"
+#include "wildmatch.h"
 #include "worktree.h"
 #include "ws.h"
 #include "wrapper.h"
diff --git a/diffcore-order.c b/diffcore-order.c
index 57ccab28464..e7d20ebd2d1 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "wildmatch.h"
 
 static char **order;
 static int order_cnt;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5af0d4715ba..f096b1ef549 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -15,6 +15,7 @@
 #include "fmt-merge-msg.h"
 #include "commit-reach.h"
 #include "gpg-interface.h"
+#include "wildmatch.h"
 
 static int use_branch_desc;
 static int suppress_dest_pattern_seen;
diff --git a/git-compat-util.h b/git-compat-util.h
index 5b2b99c17c5..1889da7986e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -625,8 +625,6 @@ static inline int git_has_dir_sep(const char *path)
 
 #include "compat/bswap.h"
 
-#include "wildmatch.h"
-
 struct strbuf;
 
 /* General helper functions */
diff --git a/log-tree.c b/log-tree.c
index 07d0b47b168..60b61597c42 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -26,6 +26,7 @@
 #include "range-diff.h"
 #include "strmap.h"
 #include "tree.h"
+#include "wildmatch.h"
 #include "write-or-die.h"
 
 static struct decoration name_decoration = { "object names" };
diff --git a/pathspec.c b/pathspec.c
index 0baa85384f8..ad9b9e7dc74 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -12,6 +12,7 @@
 #include "strvec.h"
 #include "symlinks.h"
 #include "quote.h"
+#include "wildmatch.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
diff --git a/refs.c b/refs.c
index 3c0c95ac442..5f76da35673 100644
--- a/refs.c
+++ b/refs.c
@@ -29,6 +29,7 @@
 #include "sigchain.h"
 #include "date.h"
 #include "commit.h"
+#include "wildmatch.h"
 #include "wrapper.h"
 
 /*
diff --git a/revision.c b/revision.c
index 66a1fece0df..d4b4b34fd80 100644
--- a/revision.c
+++ b/revision.c
@@ -46,6 +46,7 @@
 #include "list-objects-filter-options.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
+#include "wildmatch.h"
 
 volatile show_early_output_fn_t show_early_output;
 
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index a95bb4da9b1..b4ff5f986ae 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "wildmatch.h"
 
 int cmd__wildmatch(int argc, const char **argv)
 {
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 78cfc15d52d..db817a80c53 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -4,6 +4,7 @@
 #include "trace2.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_sysenv.h"
+#include "wildmatch.h"
 
 static struct strbuf **tr2_cfg_patterns;
 static int tr2_cfg_count_patterns;
-- 
gitgitgadget

