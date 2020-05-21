Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C4C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB09A20826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ndPRVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgEUKPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgEUKPW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:15:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654CC061A0F
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so6069726wrx.10
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=FR/KXs6GHuueuE9OqnXNxN0z6G4h26TVXb4O4s0QHxw=;
        b=e6ndPRVWiFuUg1l98qrY3dUk5TGneho2e97ZxS3Cma5m9y0DvEQO6SsVT5T8Colw8n
         VEAzTy+rfsxS9G5gyuem9NTadmGRxMmIZkcwabmF6J2AqC792btPv38L6BOpRsLMzz5B
         l4A5cEOML4rg4wU0NzbH0Llr17K031MyIbOSdTG+zDmeLfkJB5PPClxKJGCvTS15vyTX
         cRlG0aNjHauBdsZTGIMv/mW35uslWz4uQKa4Yd65a+FAEub7vHRsclpqEx8ROsl9nbNE
         HWY1rmp0jC/fZ9/Qrj9i1RpJ7Id655Rh4kyQiVVXNkrFW3IoXaU0VhQgZuwnEUx0h/Dv
         +JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=FR/KXs6GHuueuE9OqnXNxN0z6G4h26TVXb4O4s0QHxw=;
        b=huST+9e6M3qAtzDr4TjZVlFLcSs6CzLw1jNfvE5tK+1KD3baO737aIYPd2nS5zvUQC
         UtZkO4G0KXsFzAQFrI9j167kSZivQpnrLPdBEwWLJibA8ZnBWWzUN26iHziGGVKwvTcH
         kXYOGN7dlP/6ENGfNJl5qdHtbA8UgpDVc8RmdtobN45XW12GnT2XFfSuPc3rFJGgefAX
         P6LxiLVNyQfFDwJ5tGYJV34nMtDYN8NXRdnuFuIjMmAvQQt2+Jd1i52wlGTl3/puFLgb
         Y/bg9cZhxFZ/abrnPohy3oFJnvSNP0csL/s1061FL1Zv9EtW4mprIUl7NXfDor9pwhQd
         FQpw==
X-Gm-Message-State: AOAM5322/919wyUgBjjsI/5Pzg6JiAbjg4f+XUPj/vItvrTJ3i4TXKi9
        Oz5++7tDcLweC6lsDzDtLRSg0Cum
X-Google-Smtp-Source: ABdhPJxRNYsDbeYS/BUdjeU8lWiSp8J8iC88OrxjKv2znVWqDOEvb8S/G3Sbxaysfz427M92tDgyGw==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr7754050wrs.11.1590056120779;
        Thu, 21 May 2020 03:15:20 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id y5sm656219wrs.63.2020.05.21.03.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:15:20 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v3 5/5] rebase: add --reset-author-date
Date:   Thu, 21 May 2020 11:14:55 +0100
Message-Id: <20200521101455.63484-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521101455.63484-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The previous commit introduced --ignore-date flag to rebase -i, but the
name is rather vague as it does not say whether the author date or the
committer date is ignored. Add an alias to convey the precise purpose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt   |  1 +
 builtin/rebase.c               |  6 ++++--
 t/t3436-rebase-more-options.sh | 34 ++++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e2717e20e6..a5f82913fb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -450,6 +450,7 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index cf86240bc8..911587690b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1519,8 +1519,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_BOOL(0, "ignore-date", &options.ignore_date,
-			 "ignore author date and use current date"),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-author-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 6cd3848689..2ee7346562 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -137,22 +137,22 @@ test_expect_success '--committer-date-is-author-date works when committing confl
 # Checking for +0000 in author time is enough since default
 # timezone is UTC, but the timezone used while committing
 # sets to +0530.
-test_expect_success '--ignore-date works with apply backend' '
+test_expect_success '--reset-author-date works with apply backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --apply --ignore-date HEAD^ &&
+	git rebase --apply --reset-author-date HEAD^ &&
 	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works with merge backend' '
+test_expect_success '--reset-author-date works with merge backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date -m HEAD^ &&
+	git rebase --reset-author-date -m HEAD^ &&
 	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works after conflict resolution' '
-	test_must_fail git rebase --ignore-date -m \
+test_expect_success '--reset-author-date works after conflict resolution' '
+	test_must_fail git rebase --reset-author-date -m \
 		--onto commit2^^ commit2^ commit2 &&
 	echo resolved >foo &&
 	git add foo &&
@@ -161,17 +161,17 @@ test_expect_success '--ignore-date works after conflict resolution' '
 	grep +0000 authortime
 '
 
-test_expect_success '--ignore-date works with rebase -r' '
+test_expect_success '--reset-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
-	git rebase -r --root --ignore-date &&
+	git rebase -r --root --reset-author-date &&
 	git log --pretty=%ai >authortime &&
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
-		--ignore-date --onto commit2^^ commit2^ commit3 &&
+		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -181,16 +181,26 @@ test_expect_success '--ignore-date with --committer-date-is-author-date works' '
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
-		git rebase -i --strategy=resolve --ignore-date \
+		git rebase -i --strategy=resolve --reset-author-date \
 		--committer-date-is-author-date side side &&
 	git log -1 --pretty=%ai >authortime &&
 	git log -1 --pretty=%ci >committertime &&
 	test_cmp authortime committertime &&
 	grep "+0000" authortime
  '
 
+test_expect_success '--ignore-date is an alias for --reset-author-date' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
+	git rebase -m --ignore-date HEAD^ &&
+	git log -2 --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime >output &&
+	test_line_count = 2 output
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.26.2

