Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B40EB64D9
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFTADl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 20:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTADk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 20:03:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF351AD
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 17:03:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9b258f3a2so14443975e9.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687219417; x=1689811417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYuuPYeHpsDwrxVbSEuev0Ic1f/Eo+SC6+1CzC5Bqwc=;
        b=Zq7sQzbK9eDYDNsUXVONCGfN8fSUUpgUBcNHeK7pt5qXd4HXQggxHF1zHYWQqZZQD/
         mLm6j6l9UGm+/eFLlzHwgdPwNL7s41T+hgT2YNUax4tFtvKn6K4kvJgn9IGez+8zeVLo
         kT73BPosucSXYV6VJqmfdZ9uRTscQSdixV5yfD8nYm0ivLt5yBj53ET+PC8/NCV+2vpo
         qVxMQfLCLxOUHED4jHv+d6Q5H6hg+CQL5GHkpkMajXolQmLmCUAMpXuX5tP7XWu1xJ8Z
         GSisIVwP31I15qWYGT3h221GtWd67Oj9pzje/R5Ozo2BdZI+M1t29M6Aov4RLPcTu/S3
         QhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687219417; x=1689811417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYuuPYeHpsDwrxVbSEuev0Ic1f/Eo+SC6+1CzC5Bqwc=;
        b=lExoForYeoDE7fkvCNlbK4ax+KFL2l8n3htjT54W9p92KSVJOyejzzV65menB/f5sb
         soTxk4aPJ9Hzxq1DRqzOaBN3dHwPU41sWDGSmgA0rRKUz1hU8BMnJoeq0V4660jW0qYz
         5MO82wn+sAA5yLqsbDrD3krQm66nqO9XsfWOGhi9d2EX/7o7SVuMGid44P9LnoB+qt3u
         WCv8zENCxdbJ580hjPfrzOqoPpdz0cfk1fplWia2M+D7BZ1IwXpIXnX0G3o/jjbGnWEm
         2JoGr9Gazl40KVmYgd9mzdCyGC3mPltimFG5S/3VIVfBLmHNS1z7n0tR3kvljEeu1kN1
         ltUg==
X-Gm-Message-State: AC+VfDwirje/opMP//7rTNj0CPfijhpQIfSczqZixiP62Ir3Qigk9VjS
        byoj9F2texQDZOzjvCbMcFzqCQaw74Y=
X-Google-Smtp-Source: ACHHUZ6Gxs9+RksJdyOyjykNEGJtN5VOpycn/j5WpNb/bCfWChtEA8dPnIwW0IQ8FnjhzmkoU1/3hw==
X-Received: by 2002:a1c:721a:0:b0:3f9:c19:dfbb with SMTP id n26-20020a1c721a000000b003f90c19dfbbmr4903778wmc.0.1687219416605;
        Mon, 19 Jun 2023 17:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003f72468833esm918142wmc.26.2023.06.19.17.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:03:36 -0700 (PDT)
Message-Id: <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com>
In-Reply-To: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 00:03:34 +0000
Subject: [PATCH v3] Introduced force flag to the git stash clear subcommand.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein96@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nadav Goldstein <nadav.goldstein96@gmail.com>

stash clean subcommand now support the force flag, along
with the configuration var stash.requireforce, that if
set to true, will make git stash clear fail unless supplied
with force flag.

Signed-off-by: Nadav Goldstein <nadav.goldstein96@gmail.com>
---
    stash clear: added safety flag for stash clear subcommand
    
    This patch started to solve the issue of easy trigger of git stash
    clear. I first went with using an interactive (-i) flag to stash clear,
    but following the conversations I had here I understood that it was a
    misleading flag and not a good direction for implementation.
    
    So in this version of the patch (v3), I went with Junio proposal to
    introduce force flag to the clean subcommand.
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1232%2Fnadav96%2Fclear-stash-prompt-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1232/nadav96/clear-stash-prompt-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1232

Range-diff vs v2:

 1:  13bc75a2b05 < -:  ----------- add-menu: added add-menu to lib objects
 2:  7271a285d18 < -:  ----------- clean: refector to the interactive part of clean
 -:  ----------- > 1:  6150ec27b5a Introduced force flag to the git stash clear subcommand.


 Documentation/git-stash.txt | 12 ++++++++++--
 builtin/stash.c             | 12 +++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f4bb6114d91..e95410d507e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 	     [--] [<pathspec>...]]
 'git stash' save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [<message>]
-'git stash' clear
+'git stash' clear [-f | --force]
 'git stash' create [<message>]
 'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
 
@@ -130,7 +130,7 @@ the stash entry is applied on top of the commit that was HEAD at the
 time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
-clear::
+clear [-f|--force]::
 	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
@@ -208,6 +208,14 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+-f::
+--force::
+	This option is only valid for `clear` command
++
+If the Git configuration variable stash.requireForce is set
+to true, 'git stash clear' will refuse to remove all the stash 
+entries unless given -f.
+
 -S::
 --staged::
 	This option is only valid for `push` and `save` commands.
diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe384..d037bc4f69c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -53,7 +53,7 @@
 #define BUILTIN_STASH_CREATE_USAGE \
 	N_("git stash create [<message>]")
 #define BUILTIN_STASH_CLEAR_USAGE \
-	"git stash clear"
+	"git stash clear [-f | --force]"
 
 static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_LIST_USAGE,
@@ -122,6 +122,7 @@ static const char * const git_stash_save_usage[] = {
 
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
+static int clear_require_force = 0;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -246,7 +247,9 @@ static int do_clear_stash(void)
 
 static int clear_stash(int argc, const char **argv, const char *prefix)
 {
+	int force = 0;
 	struct option options[] = {
+		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
@@ -258,6 +261,9 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 		return error(_("git stash clear with arguments is "
 			       "unimplemented"));
 
+	if (!force && clear_require_force)
+		return error(_("fatal: stash.requireForce set to true and -f was not given; refusing to clear stash"));
+
 	return do_clear_stash();
 }
 
@@ -851,6 +857,10 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.requireforce")) {
+		clear_require_force = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_basic_config(var, value, cb);
 }
 

base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
-- 
gitgitgadget
