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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C64DC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159B664ECE
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhBYKWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhBYKTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:19:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C7C061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:18:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a24so2923010plm.11
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g52YFRg1TwM1D4L//bJ2ZX9t9v3zr5UTsVofFE04rLU=;
        b=qcJgV+MtldUoxCT2nEuDrCjfg48lwhJLberwBtHxxo1aL1WBNDXExnkmvbF7mVHIoo
         RlTdNvLWfoQ0OxQ6jUu0r5KxBm3xTxw80yTtLhJZnLmSaol7J+jqd5LRlxYaAlvL7ZH/
         8Q+EiO7H0Ru7w/xavteRyItBw/24gZRvyezJnKjAvF2rI6MfH1CA4ottXCQIphe97i96
         YyuTaVIlGAedan0uMZdrUoc9JTi5hH7uHTOlC9lEl4lBXifVy462JzXjg8ywoIkV0+b+
         qoYPp/CMlw1P7gfodbuPGNG83hyYsGeny7hNjdUKYim06Ss/ez/o3v+IeX+8p5q2J6CM
         Zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g52YFRg1TwM1D4L//bJ2ZX9t9v3zr5UTsVofFE04rLU=;
        b=jdqtDO7Y/NLr6FlixwLcsOw/3yOX9iX1I4XBohPayyR7stKMABXnOOeqFn7fUt4VTa
         UyAu2EuR6vLiOr5IZNqBfWwnkZ0+7bS1CUTJaABvFGguk1K1xZRrtQbI3O+K0ZHqjp4g
         UzMyysv9NLJC0XpjC/baPQyEP8p4qMylmV3UEXqqkc+dGP9fSGYLHeZmE75Z30JBJKhK
         wuVEJam6J3XUmDHA1Jgd1DBQ644oGH1cPuVk3hv8KdcvoDKB1xzHa/uQPNNqSAW/JMIP
         KBANDEv9NRkwxUH8zXvXOQ2SNEB+okY+EIgF5lBRfNRRuA5xGPVrfUkf6KcqVFJDfqhV
         VOxg==
X-Gm-Message-State: AOAM5329XwgehMinrRpXtFbN01KCyB6cjMEYlttJPlzhXUXSCMICIf2T
        qqEVWQhocVf/iYDf9qAPfBHR6XoJmAM24Q==
X-Google-Smtp-Source: ABdhPJyLVx48WBJj/epXHbkUJnr7Uuj3lMKXU73LXtcgVrePgiZyt8qSnkmob9tD+x/CP+Bl5/kk+Q==
X-Received: by 2002:a17:902:f781:b029:e4:419b:e891 with SMTP id q1-20020a170902f781b02900e4419be891mr2461932pln.10.1614248309015;
        Thu, 25 Feb 2021 02:18:29 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:18:28 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 6/6] doc/git-commit: add documentation for fixup=[amend|reword] options
Date:   Thu, 25 Feb 2021 15:39:04 +0530
Message-Id: <20210225100855.25530-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-commit.txt | 39 ++++++++++++++++++++++++++++++------
 Documentation/git-rebase.txt | 21 ++++++++++---------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7ea..bc50301b1c 100644
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
++
+When used with option `amend`, let's say `git commit --fixup=amend:<commit>`,
+it creates a "amend!" commit to fixup both the content and the commit log
+message of the specified commit. The resulting "amend!" commit's commit
+message subject will be the subject line from the specified commit with a
+prefix of "amend! " and the message body will be commit log message of the
+specified commit. It also invokes an editor seeded with the "amend!" commit
+log message to allow to edit further. And it denies to create "amend!" commit
+if it's commit message body is empty unless used with `allow-empty-message`
+option. "amend!" commit when rebased with `--autosquash` will fixup the
+contents and replace the commit message of the specified commit with the
+"amend!" commit's message body.
++
+When used with alternative option `reword`, let's say
+`git commit --fixup=reword:<commit>`, it works similar to `amend` option, but
+here it creates an empty "amend!" commit, i.e it does not take any staged
+changes and only allows to fixup the commit message of the specified commit.
+It will reword the specified commit when it is rebased with `--autosquash`.
++
+Unlike `--fixup` without options, `--fixup=[amend/reword]:` is incompatible with
+`-m` commit message option.
++
+Also, after fixing the commit using `--fixup`, with or without option and rebased
+with `--autosquash`, the authorship of the original commit remains unchanged. See
+linkgit:git-rebase[1] for details.
 
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

