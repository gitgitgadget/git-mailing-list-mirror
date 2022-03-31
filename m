Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DAFC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiCaQXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiCaQXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:23:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4E4EA33
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:21:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a1so473235wrh.10
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g58DNb0bhWTQ57PmiKQSmhSAPFuyP4gtTslaN8gdYZQ=;
        b=Zz5DnyPI4uqdBSH7y+f4HCcS6E/rLitm4uh5WKVkm0vw71ZFQCqL/ca8KTVrViARTs
         3bLlkw1+Du034Fev9A6EgsIxEJBCtG+GYDSSGcGHsicF/5CvaQl/5OZLzJz3FRlsAtom
         QJ8mIbOO+SKM6VAhL79QGuvDvu0GdIV0zQnPCnLez4nHkmSo6nHdxiIQHgam553zL9zp
         SXHey7MWrRBa6PLOyheNsb4lfWPWNI8Z9TztD0n0CjY9o+JQiL0fV1zsWq/wXtcVMFDF
         v7o/rjpgrHmId7HmwArQfoZZhbl3dQzI1gpIhznuj7vbS0mYBzvyu3Mj7B7ocoKITKY7
         sWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g58DNb0bhWTQ57PmiKQSmhSAPFuyP4gtTslaN8gdYZQ=;
        b=Oo+rrFNBG3xYrKd3BmsrSK99z1koDvdi6pCWaVGkefvlRDmcWVvO6BIOzt3aFSEYsk
         2Ej8iHj0958YK4w0vDXHPKxV47IThQv27fHtfkRp8ETeVQgJOVnP1LR29bYR0Xho/JvR
         pmOdrDhos/V8K0G9NVkqHto2TaDAD6ooFEl5FMCH1zn/K5vneW2q6dMHpzHIUomiOs4H
         FeBUAvjdfCqO5hnaW9KPln5h0tSFTqH7OsEXRTo6OPflhQrKOyQj8nJq7mlqj5svX7bf
         XczYFOfuC+5Va+A754jju+9/RkKsFZuH273xStvAXoRxy7/7XOqyCOvzApfbEovn1GwO
         4kNQ==
X-Gm-Message-State: AOAM532ZeDpkubQMCUhJJiKf+4uTCfKRX3AwtyUf/hKzEq1vQGG4NTwl
        5QjSy8PWW34InilWhFv3pg75LOdbqk4=
X-Google-Smtp-Source: ABdhPJytRwI3e3Hy5xok9hn2HnBu+q0nrxDnIATOd0RvwADQ4rBtTO4lrmlsJ5bitEU9mQNFd81Zgg==
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id d2-20020a056000186200b00204e4179cf8mr4712781wri.593.1648743690316;
        Thu, 31 Mar 2022 09:21:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm20934049wri.4.2022.03.31.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:21:29 -0700 (PDT)
Message-Id: <pull.1164.v2.git.1648743688825.gitgitgadget@gmail.com>
In-Reply-To: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 16:21:28 +0000
Subject: [PATCH v2] worktree: add -z option for list subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a -z option to be used in conjunction with --porcelain that gives
NUL-terminated output. As 'worktree list --porcelain' does not quote
worktree paths this enables it to handle worktree paths that contain
newlines.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    worktree: add -z option for list subcommand
    
    Thanks to Eric, Jean-Noël and Junio for their comments on V1. I've
    reworded the docs and option help and tweaked the tests as suggested by
    Eric, fixed the error messages as suggested by Eric/Jean-Noël and
    changed the implementation to use write_name_quoted() as suggested by
    Junio. I've punted doing anything about quoting the output without -z
    for now, I'll fix that with and without --porcelain in another series.
    
    V1 Cover Letter: Add a -z option to be used in conjunction with
    --porcelain that gives NUL-terminated output. This enables 'worktree
    list --porcelain' to handle worktree paths that contain newlines.
    
    For a previous discussion of the merits of adding a -z option vs quoting
    the worktree path see
    https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1164%2Fphillipwood%2Fwip%2Fworktree-list-nul-termination-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1164/phillipwood/wip/worktree-list-nul-termination-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1164

Range-diff vs v1:

 1:  b954579189b ! 1:  5f0e0213583 worktree: add -z option for list subcommand
     @@ Commit message
          worktree: add -z option for list subcommand
      
          Add a -z option to be used in conjunction with --porcelain that gives
     -    NUL-terminated output. This enables 'worktree list --porcelain' to
     -    handle worktree paths that contain newlines.
     +    NUL-terminated output. As 'worktree list --porcelain' does not quote
     +    worktree paths this enables it to handle worktree paths that contain
     +    newlines.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ Documentation/git-worktree.txt: This can also be set up as the default behaviour
      +	See below for details.
      +
      +-z::
     -+	When `--porcelain` is specified with `list` terminate each line with a
     -+	NUL rather than a newline. This makes it possible to parse the output
     -+	when a worktree path contains a newline character.
     ++	Terminate each line with a NUL rather than a newline when
     ++	`--porcelain` is specified with `list`. This makes it possible
     ++	to parse the output when a worktree path contains a newline
     ++	character.
       
       -q::
       --quiet::
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	}
       
       	reason = worktree_lock_reason(wt);
     - 	if (reason && *reason) {
     - 		struct strbuf sb = STRBUF_INIT;
     +-	if (reason && *reason) {
     +-		struct strbuf sb = STRBUF_INIT;
      -		quote_c_style(reason, &sb, NULL, 0);
      -		printf("locked %s\n", sb.buf);
     -+		if (line_terminator) {
     -+			quote_c_style(reason, &sb, NULL, 0);
     -+			reason = sb.buf;
     -+		}
     -+		printf("locked %s%c", reason, line_terminator);
     - 		strbuf_release(&sb);
     - 	} else if (reason)
     +-		strbuf_release(&sb);
     +-	} else if (reason)
      -		printf("locked\n");
     -+		printf("locked%c", line_terminator);
     ++	if (reason) {
     ++		fputs("locked", stdout);
     ++		if (*reason) {
     ++			fputc(' ', stdout);
     ++			write_name_quoted(reason, stdout, line_terminator);
     ++		} else {
     ++			fputc(line_terminator, stdout);
     ++		}
     ++	}
       
       	reason = worktree_prune_reason(wt, expire);
       	if (reason)
     @@ builtin/worktree.c: static void pathsort(struct worktree **wt)
       		OPT_EXPIRY_DATE(0, "expire", &expire,
       				N_("add 'prunable' annotation to worktrees older than <time>")),
      +		OPT_SET_INT('z', NULL, &line_terminator,
     -+			    N_("fields are separated with NUL character"), '\0'),
     ++			    N_("terminate records with a NUL character"), '\0'),
       		OPT_END()
       	};
       
     @@ builtin/worktree.c: static int list(int ac, const char **av, const char *prefix)
       	else if (verbose && porcelain)
       		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
      +	else if (!line_terminator && !porcelain)
     -+		die(_("'-z' requires '--porcelain'"));
     ++		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
       	else {
       		struct worktree **worktrees = get_worktrees();
       		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
     @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees --porcelain'
      +		"$(git -C here rev-parse --show-toplevel)" \
      +		"$(git rev-parse HEAD)" >>expect &&
      +	git worktree list --porcelain -z >_actual &&
     -+	cat _actual | tr "\0" Q >actual	&&
     ++	nul_to_q <_actual >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '"list" -z fails without --porcelain' '
     -+	test_when_finished "rm -rf here && git worktree prune" &&
     -+	git worktree add --detach here main &&
      +	test_must_fail git worktree list -z
      +'
      +


 Documentation/git-worktree.txt | 16 ++++++++++----
 builtin/worktree.c             | 40 ++++++++++++++++++++--------------
 t/t2402-worktree-list.sh       | 19 ++++++++++++++++
 3 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9e862fbcf79..638e188c409 100644
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
@@ -223,7 +223,14 @@ This can also be set up as the default behaviour by using the
 --porcelain::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
-	configuration.  See below for details.
+	configuration.  It is recommended to combine this with `-z`.
+	See below for details.
+
+-z::
+	Terminate each line with a NUL rather than a newline when
+	`--porcelain` is specified with `list`. This makes it possible
+	to parse the output when a worktree path contains a newline
+	character.
 
 -q::
 --quiet::
@@ -411,7 +418,8 @@ working tree itself.
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
-The porcelain format has a line per attribute.  Attributes are listed with a
+The porcelain format has a line per attribute.  If `-z` is given then the lines
+are terminated with NUL rather than a newline.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
@@ -449,7 +457,7 @@ prunable gitdir file points to non-existent location
 
 ------------
 
-If the lock reason contains "unusual" characters such as newline, they
+Unless `-z` is used any "unusual" characters in the lock reason such as newlines
 are escaped and the entire reason is quoted as explained for the
 configuration variable `core.quotePath` (see linkgit:git-config[1]).
 For Example:
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0d0809276fe..6fef936d5ac 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -575,35 +575,37 @@ static int add(int ac, const char **av, const char *prefix)
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
-	if (reason && *reason) {
-		struct strbuf sb = STRBUF_INIT;
-		quote_c_style(reason, &sb, NULL, 0);
-		printf("locked %s\n", sb.buf);
-		strbuf_release(&sb);
-	} else if (reason)
-		printf("locked\n");
+	if (reason) {
+		fputs("locked", stdout);
+		if (*reason) {
+			fputc(' ', stdout);
+			write_name_quoted(reason, stdout, line_terminator);
+		} else {
+			fputc(line_terminator, stdout);
+		}
+	}
 
 	reason = worktree_prune_reason(wt, expire);
 	if (reason)
-		printf("prunable %s\n", reason);
+		printf("prunable %s%c", reason, line_terminator);
 
-	printf("\n");
+	fputc(line_terminator, stdout);
 }
 
 static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
@@ -681,12 +683,15 @@ static void pathsort(struct worktree **wt)
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
+			    N_("terminate records with a NUL character"), '\0'),
 		OPT_END()
 	};
 
@@ -696,6 +701,8 @@ static int list(int ac, const char **av, const char *prefix)
 		usage_with_options(worktree_usage, options);
 	else if (verbose && porcelain)
 		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
+	else if (!line_terminator && !porcelain)
+		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
@@ -708,7 +715,8 @@ static int list(int ac, const char **av, const char *prefix)
 
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
-				show_worktree_porcelain(worktrees[i]);
+				show_worktree_porcelain(worktrees[i],
+							line_terminator);
 			else
 				show_worktree(worktrees[i], path_maxlen, abbrev);
 		}
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index c8a5a0aac6d..79e0fce2d90 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -64,6 +64,25 @@ test_expect_success '"list" all worktrees --porcelain' '
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
+	nul_to_q <_actual >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" -z fails without --porcelain' '
+	test_must_fail git worktree list -z
+'
+
 test_expect_success '"list" all worktrees with locked annotation' '
 	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
 	git worktree add --detach locked main &&

base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
-- 
gitgitgadget
