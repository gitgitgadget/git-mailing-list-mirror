Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7DECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiIEI1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbiIEI1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9DEBD
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n17so10293920wrm.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jUTCFsvIFflIGD7PWpnRjAF7iSgCUKIRK+wRKe5apZk=;
        b=CkdEtJ2LezyQgVS+q9tQJwq7xJD36VsB8f4pGJ9RTkq1JtzE7EyGf9PhFX7YPkKb2H
         PWm4vYj+SCg2xpXcs+5svftkCGfb7yTpTi7KUVOAbg5fszT522IlzvnXoivZAav64tCs
         3ZfA+OPqRcl+AtIZGsuSvFN3W0AqLU+5rfnlKq7SZOBHCw6+rLX6xSOJ7DtzQkgNGLnt
         cfTzb2GL/AK78FDsNJW114oxE05hgalWs7jLoVJxwK+OEr9+50PcSL7gJTHsElMRkmMf
         cxvnzY+6Lkk0E5IwZIg5rlF3L6VN1W9JcUKtTgC//xEi9nhGOK6E6Hmh0GMq7X6d8b+w
         a/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jUTCFsvIFflIGD7PWpnRjAF7iSgCUKIRK+wRKe5apZk=;
        b=tt8KQSvGX7nOptJQ9POKOvsihKlDxCQfjST7u39w0EJKRQ33GJ0OJ3VIAKxXFIyCCd
         cjisODpMG2TvxIdc1os2TZhytYD9Z28wWDZ5IVdH4yBIEuw+eVIiBKvVTpMIKWvlm/g1
         gJmKgsTr1JilxjLft4jE4V47f+MIDfUHN/wXvzGenE5flOh77Gvoba5wnwHLWsyWF/KJ
         ds+3iPmTApvw9RHFIP92YwrkifrV5MVCtIY7c98aMujLaRp8HU1lFAEWJV8sAxwNlvSi
         4l4IMvBtMVXYfK7Rx1rYsDc479peMSA0mIqcpedlM2alWNjY96zUHcb+yS0UO9Yx6wUS
         3XHQ==
X-Gm-Message-State: ACgBeo2R95SOi+p3nRt3dNUbYk06FdQ9nxBw+Eod5Tu7EFQ5fJixr5ts
        QqZrV4tfLkkubUuFuLRze9zngy4SO0E9Xg==
X-Google-Smtp-Source: AA6agR6Zr0Npm8AI0+0MjxM3eqB6RsYXBrejjj+JRktUEJJGXVvZpfGTtpPEg8gwb+dBYohzGStK3g==
X-Received: by 2002:a05:6000:1a86:b0:226:fd9b:7357 with SMTP id f6-20020a0560001a8600b00226fd9b7357mr9707819wry.458.1662366420228;
        Mon, 05 Sep 2022 01:27:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/34] doc txt & -h consistency: word-wrap
Date:   Mon,  5 Sep 2022 10:26:20 +0200
Message-Id: <patch-09.34-f79a6ead8b0-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation and -h output for those built-in commands
where the *.txt and -h output didn't match as far as word-wrapping was
concerned.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 3 ++-
 Documentation/git-worktree.txt    | 3 ++-
 builtin/bugreport.c               | 3 ++-
 builtin/commit-graph.c            | 8 ++++----
 builtin/commit-tree.c             | 4 ++--
 builtin/diagnose.c                | 3 ++-
 builtin/init-db.c                 | 3 ++-
 builtin/interpret-trailers.c      | 4 +++-
 builtin/read-tree.c               | 4 +++-
 builtin/show-branch.c             | 3 ++-
 builtin/show-ref.c                | 4 +++-
 11 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bdb..58670ef12f7 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,8 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
+		[--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
 
 DESCRIPTION
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index ada30c86a7c..063d6eeb99d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,8 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+		   [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 530895be55f..faa268f3cfb 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	   "              [--diagnose[=<mode>]"),
 	NULL
 };
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index dc3cc353947..50b1a171566 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -13,10 +13,10 @@
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
 
 #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
-	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
-	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
-	   "<split options>")
+	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
+	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
+	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
+	   "                       <split options>")
 
 static const char * builtin_commit_graph_verify_usage[] = {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 63ea3229333..e4b85d29d56 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -15,8 +15,8 @@
 #include "parse-options.h"
 
 static const char * const commit_tree_usage[] = {
-	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
-		"[(-F <file>)...] <tree>"),
+	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]\n"
+	   "                [(-F <file>)...] <tree>"),
 	NULL
 };
 
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index cd260c20155..c7672fa99e2 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,8 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>] [--mode=<mode>]"),
+	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	   "             [--mode=<mode>]"),
 	NULL
 };
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 546f9c595e7..08ba006d55e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,7 +515,8 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]"),
+	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
+	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
 };
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 84748eafc01..4cf0cf265dc 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -13,7 +13,9 @@
 #include "config.h"
 
 static const char * const git_interpret_trailers_usage[] = {
-	N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
+	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
+	   "                       [(--trailer <token>[(=|:)<value>])...]\n"
+	   "                       [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9f1f33e9546..b3a389e1b1f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -38,7 +38,9 @@ static int list_tree(struct object_id *oid)
 }
 
 static const char * const read_tree_usage[] = {
-	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
+	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 64c649c6a23..6db13de8910 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -14,7 +14,8 @@ static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
        "                [--current] [--color[=<when>] | --no-color] [--sparse]\n"
        "                [--more=<n> | --list | --independent | --merge-base]\n"
-       "                [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+       "                [--no-name | --sha1-name] [--topics]\n"
+       "                [(<rev> | <glob>)...]"),
     N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5fa207a044e..d807ef5c28b 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -9,7 +9,9 @@
 #include "parse-options.h"
 
 static const char * const show_ref_usage[] = {
-	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
+	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]\n"
+	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]\n"
+	   "             [--heads] [--] [<pattern>...]"),
 	N_("git show-ref --exclude-existing[=<pattern>]"),
 	NULL
 };
-- 
2.37.3.1425.g73df845bcb2

