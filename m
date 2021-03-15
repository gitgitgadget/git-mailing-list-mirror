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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D70C433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB4064E67
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCOH43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCOH4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:56:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A94C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e26so6042914pfd.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bcNUf/pJC3ONHo2UWh9jb3H1szQD3VEl0/K4ug0RWQ=;
        b=Zs+heHoXAlHs8ZCU6A4zR2MQBEkP2peQv6a53Sj4XBmWpPJZxdI0Dk1sPaYV2StmfY
         JDiZ3wUHZD6dwueVf1nNVk1JNnotfuIkM0ltZJS6rF1DmwnYJjimwiRsWlT90qqgd7qQ
         sLNk2LQwXu4R4F1JoO2l9zdpd+K/TDstlGn/wOWBX/uCuAnPgCuLjb+drZvl3gbmjtn/
         5MFLbSV9FItr3BoHMOvpuqKowh0VpQW4b6oHGtha3IQ0aa0Er/K51iprHqzER+rFFmVg
         kIEYd0r+ROX799QSjBcQYofRvfdzLaMFvmGT3f75DGwn95G7G59U3NKxQM5eWbUPdAmG
         AN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bcNUf/pJC3ONHo2UWh9jb3H1szQD3VEl0/K4ug0RWQ=;
        b=gnTRCngCsFe55IMJnIt8FanwFRkCI350G+E/r4g1b+bTJayPHEBXPR+TC620zMdP/h
         bU2cj1L5qE8B6Sj1MtnU/0GSjoPRQPqrryWLRhvIyCqpI+dKlpKLqqeFA2KcSG/Z4V9U
         vDsjmAEzmjKUOWM6Z7Nhz5vuJ+ui0K1XsFWpQyK9GiISwyzeogA5ldq5oqYbdk2zyrYJ
         mLhZBRwzkpkMu6rx7K4BphT7TNaz0iWjDmhWPlOKP/mUXRxksL0SzJdNxZFA9QlUBXk/
         +3dWRNC/mjnM+RwSaQnAE4fdFqcxYCKhTDY8i+ySL9liUruT5Q00NwbSEf5B+tufsyuo
         V74Q==
X-Gm-Message-State: AOAM531wwg9I4U5RILRA0D10/SJwXcVRDZKPcNkI7IMK+DXLZRTsPjbX
        8obFrSNpkSxrTBZDK0Xmu2JRPmkPRtEXIw==
X-Google-Smtp-Source: ABdhPJzdHhCc3S2F6/lXX3RJRwmcc3sQ5B8SY0VZxxgjQtiThk+Wej5xv9VVHy6UPuowhI9QSvVo2Q==
X-Received: by 2002:a63:d618:: with SMTP id q24mr21771615pgg.283.1615794969682;
        Mon, 15 Mar 2021 00:56:09 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:56:09 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 6/6] doc/git-commit: add documentation for fixup=[amend|reword] options
Date:   Mon, 15 Mar 2021 13:24:36 +0530
Message-Id: <20210315075435.18229-7-charvi077@gmail.com>
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
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
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

