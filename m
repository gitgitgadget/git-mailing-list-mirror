Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA2C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9312222F
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 12:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNI/KaOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394282AbgJTMNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394007AbgJTMNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 08:13:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607CC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 05:13:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so806732pjb.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=hNI/KaOwBQJQjilb/8tdXahqE4BGSIe/X+icPLg+lvIASMpRY9m6VXpKwRZHDt7MJw
         FQPopXnh8ZHWQb8jegRwAO0hdoy0vkX0SpZi4TZ+pMgHEXs0lEyQlhY2p1pFi84oqPdV
         xDf9ETJZRR2ju/CSrkMRINmBvdzw6mQNN+2FhM3SRbZtRMHc4+G4M43pFuSXmKfTY7aO
         mXQBB3VqjJuJYQxzQMlRF/LXdNihpWqZautqI6nX4NLs2bcEZpAbQUbcgofMYI+Xtqkw
         jGbLOis2mHrdnWA+NDMnXioREwMq9pdObNvdSzL38BJhNpb3YYrq+OtdBhkXkM9gcuxM
         7J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=dbm/xAHKbtlHOMM2BOA1BVi7rJbqYj8AIvtNUsJJlhOEluevQeJMApMZwaLxdF8+U6
         ukObICEwgQgWjScetyJKDTglem4e/cYZAG9wDLar4tVYfYUdXAECCXG7XWqSahu8aKv3
         Je2kmFD3jA8+aQtvy6Ru8x1+NdfPDSrZJVfizN8TIgQ3mEhcHJu7+pAl+bmbBrdAiVtx
         fGpN2iQeCCF9Tcu66yktR/cm0xrqtHan+oIReUcLoSAePzzIy7Cs6Y2BivwrMqhEwb+y
         tx0X1LYVEn7tyNRWPtMJxDO8Ysq2nhOWSo/PKt4w60ZPq2+09lXphaFZH8pftgFJduC8
         iAzg==
X-Gm-Message-State: AOAM533heru7gALzdh7bBTAOXJdkTrNunxtvhQkwOCfd5RA4lNqnpAEn
        3guLSQhhAWv4FV8whlPILAyRQ1XDrz2EYA==
X-Google-Smtp-Source: ABdhPJy73kowiGyaADmZQtcpV7TmbXT32EQMGFrsYcZ9eTEL+OJp+gNzNhoIoCvTWadx9nI0Bqg6vA==
X-Received: by 2002:a17:90a:4ece:: with SMTP id v14mr2689750pjl.70.1603196022681;
        Tue, 20 Oct 2020 05:13:42 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.gmail.com with ESMTPSA id w17sm1954162pga.16.2020.10.20.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:13:42 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4] t7201: put each command on a separate line
Date:   Tue, 20 Oct 2020 17:41:52 +0530
Message-Id: <20201020121152.21645-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern practice is to avoid multiple commands per line,
and instead place each command on its own line.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5898182fd2..b36a93056f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -157,7 +157,8 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout -m simple &&
@@ -180,7 +181,9 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
@@ -205,7 +208,9 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 	git rm two &&
 
 	test_must_fail git checkout simple 2>errs &&
@@ -218,7 +223,8 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	git config advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
@@ -237,7 +243,8 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
@@ -254,7 +261,8 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -269,7 +277,8 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -284,7 +293,8 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
-- 
2.29.0.rc1

