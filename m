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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E9C433E9
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D17064E45
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBJLnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhBJLk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12385C0617AA
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lw17so2834682pjb.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOudtJpzjqDa7IDFjBBsAIh1GqloMpAatv6gZAZXnKE=;
        b=ownvvm0z3ECGDfIZL/jk73ll6Tv49HGsupC/V7A1oOA9LEBlH93GIz02X8r4OaewKP
         4Q5YG67OUYKNtiMnyHOsIZMThsvOL58ZJkLfXKEIfWEDGW2UNJ2OyFUgEFvRMIrjNxkk
         PP1TQi/b0GMLYYRUfGrv2R4WkS44RndUMq50ib9dT0Euj3tksE73CPa4XNGUAPo076ci
         7dGIZbSZRXEHLLjucQsGNSNi6x2cGN6nSzwimc/fAHmnnR4KjSmPPy3MdKQAtU5hqEYR
         1/S/wm0nDaQThCLwJ0Lfu2Qvl2jdFpqQMNV6Txgb+zAOSxwNw1UGfG8c/iwFuyoXZikh
         1VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOudtJpzjqDa7IDFjBBsAIh1GqloMpAatv6gZAZXnKE=;
        b=Db6RgCGm+97h51d7Y7eWB9oasrCcHeg3wCZGyLEJphQQSIN+PUV9BeXkRIbcj7XILq
         cB60xjk1KPsCJATgwnnAoEdKW7AHbEZ+bmDn7iZUlYaa/NnCkErxhnOyNyTit7WsOhgx
         lfnTfuCY9puwc2tK47lyl2Pqum6jeETCTQqnTmGHLdmzLc0T7J7lND5xurtgEm3NnU33
         JRHehK/j7P4aqxp0NcATLq6TU3gaRApH88mb97bEYKbjTaPjawu5o7bLtZyXn4FVDNh5
         MsNIC7lvbIMf5ukSe1x192qJ2W9PGAiH6rNTWDdShjqb+vD/yJFoYoQgWPoF+jxDuYHe
         AIJw==
X-Gm-Message-State: AOAM533C6Os3HmbOIYQZBair0naqojLPGqiIwdGItwthsUhJnBCJMxCK
        075fOWR7NLoDmGGEMt8OoYJDiizCwt6KZQ==
X-Google-Smtp-Source: ABdhPJyyUeA4031EXbvG83WApA1pQQA+AHM2aNNhKEDaJBD3PysDNlFyhrL9X+dqSJAnwg/i4wPuAA==
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr2882953pjd.142.1612957129389;
        Wed, 10 Feb 2021 03:38:49 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:48 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 09/11] t/t3437: use named commits in the tests
Date:   Wed, 10 Feb 2021 17:06:49 +0530
Message-Id: <20210210113650.19715-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the named commits in the tests so that they will still refer to the
same commit if the setup gets changed in the future whereas 'branch~2'
will change which commit it points to.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 6b464989e9..6e981fa487 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -70,6 +70,7 @@ test_expect_success 'setup' '
 	echo B1 >B &&
 	test_tick &&
 	git commit --fixup=HEAD -a &&
+	git tag B1 &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
 	amend! B
@@ -91,6 +92,7 @@ test_expect_success 'setup' '
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
+	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
@@ -104,6 +106,7 @@ test_expect_success 'setup' '
 	$EMPTY
 	edited 3
 	EOF
+	git tag B3 &&
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
 	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
@@ -171,12 +174,12 @@ test_expect_success 'skipping fixup -C after fixup gives correct message' '
 '
 
 test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
-	git checkout --detach branch &&
+	git checkout --detach B3 &&
 	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4 squash 5 fixup_-C 6" \
 		FAKE_COMMIT_AMEND=squashed \
 		FAKE_MESSAGE_COPY=actual-squash-message \
 		git -c commit.status=false rebase -ik --signoff A &&
-	git diff-tree --exit-code --patch HEAD branch -- &&
+	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
 	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
@@ -184,7 +187,7 @@ test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
 
 test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fixup -C' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout branch && git checkout --detach branch~2 &&
+	git checkout --detach B2~ &&
 	git log -1 --pretty=format:%b >expected-message &&
 	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
@@ -194,12 +197,11 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 test_expect_success 'multiple fixup -c opens editor once' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	base=$(git rev-parse HEAD~4) &&
 	FAKE_COMMIT_MESSAGE="Modified-A3" \
 		FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
 		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
-	test_cmp_rev $base HEAD^ &&
+		git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author &&
 	test 1 = $(git show | grep Modified-A3 | wc -l)
@@ -217,12 +219,12 @@ test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
 '
 
 test_expect_success 'fixup -C works upon --autosquash with amend!' '
-	git checkout --detach branch &&
+	git checkout --detach B3 &&
 	FAKE_COMMIT_AMEND=squashed \
 		FAKE_MESSAGE_COPY=actual-squash-message \
 		git -c commit.status=false rebase -ik --autosquash \
 						--signoff A &&
-	git diff-tree --exit-code --patch HEAD branch -- &&
+	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
 	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
-- 
2.29.0.rc1

