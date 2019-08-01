Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1F31F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbfHAWUz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:20:55 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40784 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfHAWUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:20:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so46656599pfb.7
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lGUSbt+34syfPccHw0l4DrGv0PoqDbOxTp+Fh1W7Cnk=;
        b=HkBzfvYO+5zKy/ZDraLT4HPpc47dFFysgGVGl2ED2hXac9UTWJoUQvYP8GyoEVaYzU
         NJCIergcUyDL/R/K6YZl6l3+jLrqeDqO9wlTslA9NtpGQtPRPg5xHacjsUqlKYtIqBOJ
         n36q+KP3vAtmVR4wHr+6nec2zzmNxU1U01NQGsq+lBbumavXaPyJ/4CC9gGE4zcdINM0
         WP682yhdlrVa4rGNJGyf5u4w8Ge8FftTHh6pMqnn+9iImTuKxP632SajE4enyWd70Imh
         SXtMr+PwCtItjTOPJQUbwxC4x0xFhJCbWpKP2N4RnguR61Lr9XWfsqOVYnIm4tYXTsbo
         Kajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lGUSbt+34syfPccHw0l4DrGv0PoqDbOxTp+Fh1W7Cnk=;
        b=OomSpry3LXW5FNjkn/3eUeX5ClMVUm5lxuzMPglXYC5UrwJXl65yFrWsSwwzkuGguK
         4FGuACamzgCL3UT/giIw0mBpMuuuFgFpC98e2S9cqOln3p7IjhIz1HC723fmz1uKgJBF
         GljOfHBu54nr9hNf7AJupUsZuaNb5vYtff8ejRDcU8E96o0Ny3ST+SYWISr/kP1DjRCi
         TxxSixfXAsOdaGCvJROZ30hLqcE3g9ZB7MRQDfNLkIrvlIMa8GPz3qMHrdc9rqUMGDcc
         ZpvoF30LrAZmA1j99y8aX6M66rcx1Z93KC/A7X+XY9HbybXvVNYeFrjzFoXCA2hB5x+b
         69VA==
X-Gm-Message-State: APjAAAXJw9Mk+p9K5wrH8W1rbUyuAFeI/PNOml5u4AXHsCW6J5/pJR1n
        MmcDGWbslGTdfnbO44BcCptPc3wLvugFmQRrFY8vPUZ52V+MpzI65NbaH+3dWcw5WgSL0/ZRBGC
        LrjfSBHnSp/P4ie75gzLnbsSKdx/4/tJwgS/lyEvPyihG0AI6NunuEfgAv0M0QGE=
X-Google-Smtp-Source: APXvYqwsAn/woJg2TmZX2k8/YWs2/q3PLf72iHDNdB5gwg2zy246ASd/+Eyp/6JrKbPo6sBE86JDoucvcF98YQ==
X-Received: by 2002:a63:c84d:: with SMTP id l13mr116395435pgi.154.1564698054229;
 Thu, 01 Aug 2019 15:20:54 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:20:44 -0700
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
Message-Id: <89ddbf410f71bbd0dc556297913561c8492a4084.1564695893.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 2/4] merge: do no-verify like commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f8b863598c ("builtin/merge: honor commit-msg hook for merges", 2017-09-07)
introduced the no-verify flag to merge for bypassing the commit-msg
hook, though in a different way from the implementation in commit.c.

Change the implementation in merge.c to be the same as in commit.c so
that both do the same in the same way. This also changes the output of
"git merge --help" to be more clear that the hook return code is
respected by default.

[js: * reworded commit message
     * squashed documentation changes from original series' patch 3/4
]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 01fd52dc70..092529c619 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
 'git merge' (--continue | --abort | --quit)
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..d6a9f4b96f 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -105,6 +105,10 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
+--no-verify::
+	This option bypasses the pre-merge and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin/merge.c b/builtin/merge.c
index e2ccbc44e2..4425a7a12e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -81,7 +81,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
-static int verify_msg = 1;
+static int no_verify;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -287,7 +287,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
 	OPT_END()
 };
 
@@ -842,7 +842,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
-- 
2.22.0.770.g0f2c4a37fd-goog

