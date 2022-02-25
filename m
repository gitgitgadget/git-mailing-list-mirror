Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723CC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbiBYPJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiBYPJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:09:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C57EA25
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:08:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so4947435wrg.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ezEmxTVZNu2aIIx7bPf7QJuz+rcA0Vealqv5nlKhkXo=;
        b=O5BUpwF8H0RU91RAGfk0Cf5+yLyHILpMonASW+q6TNw6x5vA3JpsOSJHjH50YD5Zx0
         eKmIMdXBypBTlno8IS0i2aoYFuEHkaGbaMGD0JKhmkem+w60FaKfHQJZ4DK/2WLUEB8v
         PGdSTN9I4i/CX0W+PoPdaanSNDSJntxH1W1fnPqZEP3M3xMeqZX9F6Gja2BLqqzKfyvz
         2LgNagpsBmXGxJkF0YfdSgdH7brBZSjnfI9/Vl8l3fkCm8Zh5ZPnsYx+CNN+MNvO2PJH
         e9017krleKawtksLO6JDJR4a65ityZHJpE4ccUnm7H7MhQSURZDuBxqqbxVs9CJae2eR
         hCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ezEmxTVZNu2aIIx7bPf7QJuz+rcA0Vealqv5nlKhkXo=;
        b=N084aUwPOEHJW+VAVxB7WX4p/usj6AanJT44NMVEnXKSP+uO74GRGXeV69mSqiOXx+
         tbiWWFSSvuhQaFTlZlXgraMZTHjh5pZCRS83ueWpVtHGNGHbguVP7L+sF7EQvyOoUcrA
         KhzOIGI9AOlusWubMQDbrLRdfVqIlHAV0OeidbegMt8PqnLTMJvGWTzv3JcTuYXy17Wy
         Gz+62flwXZI+4WBsHRcKH2noXv3GQqxE8u3G+AsAtZDbS4YWzfoxbW4M6jT0BpmArPH0
         DRIKHf8WImpvkU/GAAM4urPRZ/bPj5czMhp5/PNUfvCEpDysKFiBOGuez+UEL4iFKq3U
         U6hQ==
X-Gm-Message-State: AOAM533xuf+12eBpqUDEhqCflhfwR5L721gFsBwxKhlYMN4/0VmfpbtR
        41ohH5oY7ahcxlR1zJhEOSfvcfQzrxs=
X-Google-Smtp-Source: ABdhPJzZcP5M01MUOnCcqSLp2knnre6b9yIyCCfP0TXzeKo0zL4sRvDIsWn7UibgiXUKWSkzrk73pg==
X-Received: by 2002:a05:6000:8d:b0:1ed:9ed7:c915 with SMTP id m13-20020a056000008d00b001ed9ed7c915mr6458469wrx.543.1645801728756;
        Fri, 25 Feb 2022 07:08:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c15c500b003810188b6basm5684206wmf.28.2022.02.25.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:08:48 -0800 (PST)
Message-Id: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 15:08:47 +0000
Subject: [PATCH] worktree: add -z option for list subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a -z option to be used in conjunction with --porcelain that gives
NUL-terminated output. This enables 'worktree list --porcelain' to
handle worktree paths that contain newlines.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    worktree: add -z option for list subcommand
    
    Add a -z option to be used in conjunction with --porcelain that gives
    NUL-terminated output. This enables 'worktree list --porcelain' to
    handle worktree paths that contain newlines.
    
    For a previous discussion of the merits of adding a -z option vs quoting
    the worktree path see
    https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1164%2Fphillipwood%2Fwip%2Fworktree-list-nul-termination-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1164/phillipwood/wip/worktree-list-nul-termination-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1164

 Documentation/git-worktree.txt | 15 +++++++++++----
 builtin/worktree.c             | 33 +++++++++++++++++++++------------
 t/t2402-worktree-list.sh       | 21 +++++++++++++++++++++
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9e862fbcf79..a3fcd498df7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
-'git worktree list' [-v | --porcelain]
+'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -223,7 +223,13 @@ This can also be set up as the default behaviour by using the
 --porcelain::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
-	configuration.  See below for details.
+	configuration.  It is recommended to combine this with `-z`.
+	See below for details.
+
+-z::
+	When `--porcelain` is specified with `list` terminate each line with a
+	NUL rather than a newline. This makes it possible to parse the output
+	when a worktree path contains a newline character.
 
 -q::
 --quiet::
@@ -411,7 +417,8 @@ working tree itself.
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
-The porcelain format has a line per attribute.  Attributes are listed with a
+The porcelain format has a line per attribute.  If `-z` is given then the lines
+are terminated with NUL rather than a newline.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
@@ -449,7 +456,7 @@ prunable gitdir file points to non-existent location
 
 ------------
 
-If the lock reason contains "unusual" characters such as newline, they
+Unless `-z` is used any "unusual" characters in the lock reason such as newlines
 are escaped and the entire reason is quoted as explained for the
 configuration variable `core.quotePath` (see linkgit:git-config[1]).
 For Example:
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0d0809276fe..b4cc586f5c5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -575,35 +575,38 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
-static void show_worktree_porcelain(struct worktree *wt)
+static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 {
 	const char *reason;
 
-	printf("worktree %s\n", wt->path);
+	printf("worktree %s%c", wt->path, line_terminator);
 	if (wt->is_bare)
-		printf("bare\n");
+		printf("bare%c", line_terminator);
 	else {
-		printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
+		printf("HEAD %s%c", oid_to_hex(&wt->head_oid), line_terminator);
 		if (wt->is_detached)
-			printf("detached\n");
+			printf("detached%c", line_terminator);
 		else if (wt->head_ref)
-			printf("branch %s\n", wt->head_ref);
+			printf("branch %s%c", wt->head_ref, line_terminator);
 	}
 
 	reason = worktree_lock_reason(wt);
 	if (reason && *reason) {
 		struct strbuf sb = STRBUF_INIT;
-		quote_c_style(reason, &sb, NULL, 0);
-		printf("locked %s\n", sb.buf);
+		if (line_terminator) {
+			quote_c_style(reason, &sb, NULL, 0);
+			reason = sb.buf;
+		}
+		printf("locked %s%c", reason, line_terminator);
 		strbuf_release(&sb);
 	} else if (reason)
-		printf("locked\n");
+		printf("locked%c", line_terminator);
 
 	reason = worktree_prune_reason(wt, expire);
 	if (reason)
-		printf("prunable %s\n", reason);
+		printf("prunable %s%c", reason, line_terminator);
 
-	printf("\n");
+	fputc(line_terminator, stdout);
 }
 
 static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
@@ -681,12 +684,15 @@ static void pathsort(struct worktree **wt)
 static int list(int ac, const char **av, const char *prefix)
 {
 	int porcelain = 0;
+	int line_terminator = '\n';
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
 		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("add 'prunable' annotation to worktrees older than <time>")),
+		OPT_SET_INT('z', NULL, &line_terminator,
+			    N_("fields are separated with NUL character"), '\0'),
 		OPT_END()
 	};
 
@@ -696,6 +702,8 @@ static int list(int ac, const char **av, const char *prefix)
 		usage_with_options(worktree_usage, options);
 	else if (verbose && porcelain)
 		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
+	else if (!line_terminator && !porcelain)
+		die(_("'-z' requires '--porcelain'"));
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
@@ -708,7 +716,8 @@ static int list(int ac, const char **av, const char *prefix)
 
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
-				show_worktree_porcelain(worktrees[i]);
+				show_worktree_porcelain(worktrees[i],
+							line_terminator);
 			else
 				show_worktree(worktrees[i], path_maxlen, abbrev);
 		}
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index c8a5a0aac6d..48d5d30d709 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -64,6 +64,27 @@ test_expect_success '"list" all worktrees --porcelain' '
 	test_cmp expect actual
 '
 
+test_expect_success '"list" all worktrees --porcelain -z' '
+	test_when_finished "rm -rf here _actual actual expect &&
+				git worktree prune" &&
+	printf "worktree %sQHEAD %sQbranch %sQQ" \
+		"$(git rev-parse --show-toplevel)" \
+		$(git rev-parse HEAD --symbolic-full-name HEAD) >expect &&
+	git worktree add --detach here main &&
+	printf "worktree %sQHEAD %sQdetachedQQ" \
+		"$(git -C here rev-parse --show-toplevel)" \
+		"$(git rev-parse HEAD)" >>expect &&
+	git worktree list --porcelain -z >_actual &&
+	cat _actual | tr "\0" Q >actual	&&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" -z fails without --porcelain' '
+	test_when_finished "rm -rf here && git worktree prune" &&
+	git worktree add --detach here main &&
+	test_must_fail git worktree list -z
+'
+
 test_expect_success '"list" all worktrees with locked annotation' '
 	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
 	git worktree add --detach locked main &&

base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
-- 
gitgitgadget
