Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBBC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E7422249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp3Mo8JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442651AbgJUMvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440530AbgJUMvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 08:51:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90054C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h4so1100937pjk.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=pp3Mo8JAnxOdsn6PXs/xjxWAr9dex71Rwr9Uv4Shiz6L3HpAWShpthexF/Y9MFWcQT
         vlhZpCWz2rCiKH0kJHIO3kIp5/No4qIx9xgI5LkjFohl0i8AoSCOi3qghgbuNYlx+JRs
         wPDGFBoN1gHdq6/WON7MJij/0KB1OwGctPORRT6YN4ZsM0wdNkgeA90SoxuYIw5Zf2M1
         YXok1ENoHpjibu2NzaEXo2qKwJHLtVDixaINruw6Zw6Mwo/tW1dqNgXcg4V+o6eFFhqK
         poFyCXev7NJBARqZHE3I9k3cY33f4FMl1/RRrfe1Y40DKam20LbpUba2zaDQWFg4yRdY
         vsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=uZlMXKt+i9Mi6fTYZMOjHaz89J8rVk6tL2CGUMHCiw92usU1eOm3hXW1N7ooVipJil
         WZg48iSlPUp1JqoGhXq9JaKkAS8yDGzik/XfiIAJ42RgwWIKtH6DD7gWHTXZfFoEydD/
         +XAvoapNmewSH1HkiYGBcbnRQGTJEHTWKiA5KSQlfi6SV4U+Uzbj3rA6OX3t1VbOKZQI
         eM/FprmE58o+b50LtvQN3lWqbvWzPiLW300w+amweveJJ6XbFKpMr1bh83K9eJ6A7pW1
         yPlidn0JgKOPh+Q/Xqe5eu0B+o6zMMN0wwvMBvO/2kUA5vaJQLFqvRhKKeHo833XyQIK
         fSTQ==
X-Gm-Message-State: AOAM532gEagec0ZLNOgk3EQi0nYIz3PE/L5LvlSFvOXYsdrdn0D4TuPq
        /8oPauemwQSmr/I7jGN26G5pxAuJ8ubm9g==
X-Google-Smtp-Source: ABdhPJzlhL6B8JdgSGeZ24Ap5ccgr2+ZDbgneZhD5kUhehwPTmRAxIolTqAHYKK7YVIhhTpyBs0Jnw==
X-Received: by 2002:a17:90a:39c5:: with SMTP id k5mr3318047pjf.34.1603284681919;
        Wed, 21 Oct 2020 05:51:21 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.googlemail.com with ESMTPSA id j24sm2054857pjn.9.2020.10.21.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:51:21 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 5/5][Outreachy] t7201: put each command on a separate line
Date:   Wed, 21 Oct 2020 18:18:23 +0530
Message-Id: <20201021124823.2217-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201020121152.21645-1-charvi077@gmail.com>
 <20201021124823.2217-1-charvi077@gmail.com>
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

