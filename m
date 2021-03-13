Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24607C433E6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCE264F0F
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCMNnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhCMNnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:43:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D338AC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:43:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso12456675pjb.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPsSPLrsISOGjuTB25LBsYyxJmavxx71z29VQM3qVn4=;
        b=qyr75PqdVpjrvO/rCdTPkGLtlWqnGCTy8NfOF8guMOmVsQXxcR1HCf+Y0XhRgZDkA2
         fHHiwEhl/MQpE2bVc8OuxZNOE9yHzObdJCY2QfuWrcgmdrdHYFxXVP1H9DTXfB13JUkE
         J0ugtAZl0x9OoeFl7FVEJX2Xn2WiKD7XRDIIITvgAa4/k+52KuNdy0Gj9MTHt1gDsN2D
         t09mRdKLCLVpISWbg2BkoPUZ6uHZigzGTw8BLeqR8hUdIsc8vAG/rr5E500yT0tSZbck
         Or5d2714TyuqkF9Gh19BB8ByhroRtdBtiewf4m9n3xR6gGpZK5LpZpioq2ReymRVchH5
         bpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPsSPLrsISOGjuTB25LBsYyxJmavxx71z29VQM3qVn4=;
        b=QX8TNiwRfXxqK36L9QQFqcL9USFtIhnb1mFvlHenyga7FjbEtXr8qyQA3g0egj1Vq9
         RWQkcTHDLiC6Amt9RjGumaxRKTM7xCGywStsLvQaR8arIpSZARu8uOj6PIVNQae2xwJT
         GvOO4z69ysFKQyK1lbZ5wU+uGqwpEs41OHvpopTNgpmmbqHVALlwCAIOmSvDSq7yliBa
         RjsHPivxj8GgusKnUBOz1CzP4KwZOt9kp3ftoDHzqT2fwTxN7ueguUG9OTIvNnscFrnx
         lfw1sU2K7AVfXh8VOyueb1KcPNCG3GAgYDG3Lxm+38pMtvG2K5ChBUNw4Se7guB6lXPE
         3bSQ==
X-Gm-Message-State: AOAM5306eultbKGmvdA8z6fQvA6yExGDY4FryMoolGEOXiS3nyWWuH1L
        G0mlCNQ6HaDN0p0EuEiKd6qr1y7HJ6yXxg==
X-Google-Smtp-Source: ABdhPJy+N7ekJpa/QeF1STDcGb2Cvqqm98LahRTdFUQn3nV83We/f+nVnNtrnRGDMFew9YA04TPGUQ==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr3578279pjf.41.1615642987091;
        Sat, 13 Mar 2021 05:43:07 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:43:05 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 6/6] doc/git-commit: add documentation for fixup=[amend|reword] options
Date:   Sat, 13 Mar 2021 19:10:13 +0530
Message-Id: <20210313134012.20658-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-commit.txt | 45 +++++++++++++++++++++++++++++++-----
 Documentation/git-rebase.txt | 21 +++++++++--------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7ea..3c69f461c9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
+	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
@@ -86,11 +86,44 @@ OPTIONS
 	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
---fixup=<commit>::
-	Construct a commit message for use with `rebase --autosquash`.
-	The commit message will be the subject line from the specified
-	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
-	for details.
+--fixup=[(amend|reword):]<commit>::
+	Create a new commit which "fixes up" `<commit>` when applied with
+	`git rebase --autosquash`. Plain `--fixup=<commit>` creates a
+	"fixup!" commit which changes the content of `<commit>` but leaves
+	its log message untouched. `--fixup=amend:<commit>` is similar but
+	creates an "amend!" commit which also replaces the log message of
+	`<commit>` with the log message of the "amend!" commit.
+	`--fixup=reword:<commit>` creates an "amend!" commit which
+	replaces the log message of `<commit>` with its own log message
+	but makes no changes to the content of `<commit>`.
++
+The commit created by plain `--fixup=<commit>` has a subject
+composed of "fixup!" followed by the subject line from <commit>,
+and is recognized specially by `git rebase --autosquash`. The `-m`
+option may be used to supplement the log message of the created
+commit, but the additional commentary will be thrown away once the
+"fixup!" commit is squashed into `<commit>` by
+`git rebase --autosquash`.
++
+The commit created by `--fixup=amend:<commit>` is similar but its
+subject is instead prefixed with "amend!". The log message of
+<commit> is copied into the log message of the "amend!" commit and
+opened in an editor so it can be refined. When `git rebase
+--autosquash` squashes the "amend!" commit into `<commit>`, the
+log message of `<commit>` is replaced by the refined log message
+from the "amend!" commit. It is an error for the "amend!" commit's
+log message to be empty unless `--allow-empty-message` is
+specified.
++
+`--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
+--only`. It creates an "amend!" commit with only a log message
+(ignoring any changes staged in the index). When squashed by `git
+rebase --autosquash`, it replaces the log message of `<commit>`
+without making any other changes.
++
+Neither "fixup!" nor "amend!" commits change authorship of
+`<commit>` when applied by `git rebase --autosquash`.
+See linkgit:git-rebase[1] for details.
 
 --squash=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8bfa5a9272..f08ae27e2a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -593,16 +593,17 @@ See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is already a commit in the todo list that
-	matches the same `...`, automatically modify the todo list of rebase
-	-i so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved commit
-	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
-	the commit subject matches, or if the `...` refers to the commit's
-	hash. As a fall-back, partial matches of the commit subject work,
-	too.  The recommended way to create fixup/squash commits is by using
-	the `--fixup`/`--squash` options of linkgit:git-commit[1].
+	When the commit log message begins with "squash! ..." or "fixup! ..."
+	or "amend! ...", and there is already a commit in the todo list that
+	matches the same `...`, automatically modify the todo list of
+	`rebase -i`, so that the commit marked for squashing comes right after
+	the commit to be modified, and change the action of the moved commit
+	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
+	matches the `...` if the commit subject matches, or if the `...` refers
+	to the commit's hash. As a fall-back, partial matches of the commit
+	subject work, too. The recommended way to create fixup/amend/squash
+	commits is by using the `--fixup`, `--fixup=amend:` or `--fixup=reword:`
+	and `--squash` options respectively of linkgit:git-commit[1].
 +
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
-- 
2.29.0.rc1

