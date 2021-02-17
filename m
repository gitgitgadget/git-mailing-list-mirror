Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E4EC433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CED864D79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhBQHmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBQHjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:39:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392CC06178A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:39:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l18so1119134pji.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M37ZGhknj/vqCxjk4Hapr61Q2QQ93ZzW9WaLvLjfTcc=;
        b=n1mTgQz1LINhaVktufqA6g+O4WkwHFGFO7q61taEJOPCjWtbY8jDGJxgCj6Y5wH6H2
         nnLWBQlf3OkCbNlo4YieaWK+pePmi9spLxdvd8dXbLCcYCDG7/faXMfnYuJPZcU+qWmi
         lC2MmbhXfDNGZ8svyulLvW23165Bm8znTlyyh5jMWcHZ6HaNe9PU7Z8CY15cChn5ubx9
         ehbpBYfMpp9slvktThx6qxKY3IAACYDRw3n9YQa7TZdvQsMgGAGbMozl+r/QODl0pR5f
         u5QeH/RdKdJ39DwAFplLdTGYhjTOZveArGVsYCel1PgP/9Ioi+KR6UJYfPP/waanD7Z5
         dAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M37ZGhknj/vqCxjk4Hapr61Q2QQ93ZzW9WaLvLjfTcc=;
        b=I4yGWRzRSt0zZ6oe9oucctRqsn65KlVhjUXYWhhDPxpM9KZfCZ0XFHDa/hGc7NF9YU
         5tZnk5T8vPpVW5e2Z96V8+YhTdyFAKGavb8hsNIwXHa6OASymIneYyfNfpeLA4rtNrI9
         ilKKEVi94nkthqhM3uVfdbRFJSPXRA8GYOApEMm2KBnlLdn1mIcinONquiXJ91vRiZIE
         d+Vow3lDGUlLfxlSPTRy+WMQQ2Et0kryq494+i9m0kK6V5Y8inlUQYYfjzep7Qmiu3+1
         iCTEBQr50TAMkyDLO1+MDNEDf3vYtms6BRkKDLZ/2MNviVLPF0OFoYU8Swv3xk3w8iCP
         5Kog==
X-Gm-Message-State: AOAM531P5LQgzaHbq8H2R+rKEkutyt6zsNdOv85CKjZ0p7Kp5LEscFsa
        GHoA/jecGDXj/tu97xE1Dqa3bpinKX8LLw==
X-Google-Smtp-Source: ABdhPJzypIUUB575voIEm/SFHi6hmn3l2/+AoiCSwdOIfXMGc722qN4L882tRGaRPdeFvEQ400agpg==
X-Received: by 2002:a17:90b:17ca:: with SMTP id me10mr7602049pjb.60.1613547543073;
        Tue, 16 Feb 2021 23:39:03 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:39:02 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 6/6] doc/git-commit: add documentation for fixup[amend|reword] options
Date:   Wed, 17 Feb 2021 13:07:25 +0530
Message-Id: <20210217073725.16656-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217073725.16656-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
 <20210217073725.16656-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-commit.txt | 39 ++++++++++++++++++++++++++++++------
 Documentation/git-rebase.txt | 21 ++++++++++---------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7ea..9a60876845 100644
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
@@ -86,11 +86,38 @@ OPTIONS
 	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
---fixup=<commit>::
-	Construct a commit message for use with `rebase --autosquash`.
-	The commit message will be the subject line from the specified
-	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
-	for details.
+--fixup=[(amend|reword):]<commit>::
+	When used without options, lets's say `git commit --fixup=<commit>`,
+	it creates a "fixup!" commit where the commit message will be
+	the subject line from the specified commit with a prefix of
+	"fixup! ". The resulting "fixup!" commit is further used with
+	`git rebase --autosquash` to fixup the content of the specified
+	commit.
+
+	When used with option `amend`, let's say
+	`git commit --fixup=amend:<commit>`, it creates a "amend!" commit
+	to fixup both the content and the commit log message of the
+	specified commit. The resulting "amend!" commit's commit message
+	subject will be the subject line from the specified commit with a
+	prefix of "amend! " and the message body will be commit log message
+	of the specified commit. It also invokes an editor seeded with the
+	"amend!" commit log message to allow to edit further. And it denies
+	to create "amend!" commit if it's commit message body is empty unless
+	used with `allow-empty-message` option. "amend!" commit when rebased
+	with `--autosquash` will fixup the contents and replace the commit
+	message of the specified commit with the "amend!" commit's message
+	body.
+
+	When used with alternative option `reword`, let's say
+	`git commit --fixup=reword:<commit>`, it works similar to `amend`
+	option, but here it creates an empty "amend!" commit, i.e it does
+	not take any staged changes and only allows to fixup the commit
+	message of the specified commit. It will reword the specified
+	commit when it is rebased with `--autosquash`.
+
+	`--fixup`, with or without option, can be used with additional
+	commit message option `-m` but not with `-F`/`-c`/`-C`. See
+	linkgit:git-rebase[1] for details.
 
 --squash=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8bfa5a9272..ffea76e53b 100644
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
+	When the commit log message begins with "squash! ..." (or "fixup! ..."
+	or "amend! ..."), and there is already a commit in the todo list that
+	matches the same `...`, automatically modify the todo list of
+	`rebase -i`, so that the commit marked for squashing comes right after
+	the commit to be modified, and change the action of the moved commit
+	from `pick` to `squash` (or `fixup` or `fixup -C`) respectively. A commit
+	matches the `...` if the commit subject matches, or if the `...` refers
+	to the commit's hash. As a fall-back, partial matches of the commit
+	subject work, too. The recommended way to create fixup/squash/amend
+	commits is by using the `--fixup=[amend|reword]`/`--squash` options of
+	linkgit:git-commit[1].
 +
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
-- 
2.29.0.rc1

