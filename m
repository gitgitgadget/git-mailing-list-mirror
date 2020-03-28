Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A7C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 21:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E569720716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 21:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwfLmAL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1VLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:11:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43463 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1VLj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 17:11:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id m11so10280689wrx.10
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ngy6MUBQ1iGnsQSLvldqx5ooCSJtBGE/Ql8EWue0BUg=;
        b=EwfLmAL0B9Cn0vvT272LcbPgvz1dwQZZhFOo9vTEFqVrLh5iQOEUKJEV8BETOw1+Kc
         Ecx/HnYr0+OtFOrcUmRJF6LkPP1EDmUkq4jBDycp04iRkiUTvvP7fBOvG+7Zum/aed1i
         uU4tCCEykWNs/kzLt/7QU5BGUzTNuCHei14oqo8NJaPDDmLFEVjnleoc86t4Lhx552By
         EXisoC47sk4TQ2HZuvYkmSI1Rf860yxowQ863SNU0kk929dG10Cv6hvwp6JFlId6E83I
         jQRU6ERIRQT7HJ9ccwrPyPFTMFX+gng6sWXhkzyAyWQV4qipNEMRAHo6VsuX4q+KcIul
         ntvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ngy6MUBQ1iGnsQSLvldqx5ooCSJtBGE/Ql8EWue0BUg=;
        b=rYEQ47T+aHcznoeM5lgO+6iLmrcHD8I3x4DKcv5d0QpPt7/hYVsZ2uABlEQQvtqnr5
         2jEf7sfQu5PoUb8M9ALazVgUBszeWvzEp6sEE/hwce7rY5WmWHNKdKxmoQEBGZuraQpv
         Qdc3/A6nm6nyBgjXNQqWMz6TmHhSyXmQzXVv+KE8bA9Rt2R+K3GdVqtQ2CghjPxnzGwC
         o4WoRdEyAIof76FljXLsO8PbpU8r8RYzdawEQ/1goxTSNlGLDnmm5a8iojfvD7osPKvw
         aDtUfkRmRdX+a9MyJ0E6HJouPzveQxmi5bDhRB0C52LKtR4Wcyrsvxb3GnpsbeHycPXD
         EY9g==
X-Gm-Message-State: ANhLgQ0I8lKIwQTFw7oNRis7ecZlUWReU5Q1QjCYHCMiEkrXEf/hX4hZ
        rSrFs0A0Cs/m3/Kds7NDsKRTf+f5
X-Google-Smtp-Source: ADFU+vvdAh4rVkeUx3gf9AawNdaHzHtvV15g0AxDFS6630a6bYc8hpcb0k7YIbm9pFjWo4hkfq4cFg==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr6228990wrp.287.1585429895364;
        Sat, 28 Mar 2020 14:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u204sm13568204wmg.40.2020.03.28.14.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:11:34 -0700 (PDT)
Message-Id: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Mar 2020 21:11:34 +0000
Subject: [PATCH] doc: log takes multiple revision ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

`git log` accepts multiple revision ranges, but makes no mention of that
in its documentation. Currently readers have to go to the `git
rev-list` documentation to discover this useful feature.

Mention it and adjust the synopsys in the doc and in the short
help for `git log`.

Also add links to the documentation for `git rev-list` and `git diff`
instead of simply mentioning them, to make it easier for readers to reach
these documentation pages. Let's link to `git diff` as this is the
porcelain command, and the rest of the family (`diff-index`, `diff-tree` and
`diff-files`) are mentioned in the "Raw output format" section of the
`git diff` documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    doc: log takes multiple revision ranges
    
    I hesitated to send this in two patches but decided not to, if it would
    be preferred I'll split it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-590%2Fphil-blain%2Fdoc-log-multiple-ranges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-590/phil-blain/doc-log-multiple-ranges-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/590

 Documentation/git-log.txt | 12 ++++++------
 builtin/log.c             |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index bed09bb09e5..fa8affd436a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,15 +9,15 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[--] <path>...]
+'git log' [<options>] [<revision range>...] [[--] <path>...]
 
 DESCRIPTION
 -----------
 Shows the commit logs.
 
-The command takes options applicable to the `git rev-list`
+The command takes options applicable to the linkgit:git-rev-list[1]
 command to control what is shown and how, and options applicable to
-the `git diff-*` commands to control how the changes
+the linkgit:git-diff[1] family of commands to control how the changes
 each commit introduces are shown.
 
 
@@ -90,9 +90,9 @@ include::line-range-format.txt[]
 	<revision range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
-	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision range>, see the 'Specifying Ranges'
-	section of linkgit:gitrevisions[7].
+	(i.e. `HEAD`), but not from `origin`. You can give more than 
+	one revision range. For a complete list of ways to spell <revision range>,
+	see the 'Specifying Ranges' section of linkgit:gitrevisions[7]. 
 
 [--] <path>...::
 	Show only commits that are enough to explain how the files
diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e2..51c2ef54823 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -53,7 +53,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
+	N_("git log [<options>] [<revision-range>...] [[--] <path>...]"),
 	N_("git show [<options>] <object>..."),
 	NULL
 };

base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
-- 
gitgitgadget
