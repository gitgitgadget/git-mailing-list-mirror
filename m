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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B711C433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B575264E9C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhBHTcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhBHT3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:29:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D63C061797
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:29:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l18so155812pji.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSZtLnp+dc0mEwU+RBlPqG6GNYXOMNgtCVJ4xWdhqSw=;
        b=GUAy1JTtDezJeFkP60Hr201bYBSRZ85T/RrWjS3joOd17wp900LiOzZA2G5YQ9krzQ
         QTeDik3gVw3qWcyvCCocVOni2WDKF2OaRYGeX89H7ByPG1Y1GvKtSiyLMcfuO3pGk+ZX
         dtIGmg9q3sxFE5J7c/VoMgZ4ED92zpMQvf7HcHWVrLSP8Dzpm/bhTUpCwZb878OPJuNx
         vlCDod/oihx2CDbdecwEcEqxGOptMbfSDbc3TAqqrfcjyTP+AIQQ2dXZ+T1IiGX0UH5d
         2u3R6G404a+v6xneM1wHUVN2XGih29MEI08wWpatv0E3sLbT+5o3MQ12EWqG5wLTiW4h
         aD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSZtLnp+dc0mEwU+RBlPqG6GNYXOMNgtCVJ4xWdhqSw=;
        b=lI/F8NxIEmXN/6hay6H5GHgE0CAIB55pT/tpFtUBzKqI7DW+qoeXhg7/dIaa+HkZyw
         iB10qoyqaIwnM6h3Ffb+x5Kvx86NLLw1cxzotDq0P3l3Erj/ODVF4jI1xV5OnQKB/6IG
         Oqy1ew7PJ2CKqwS4lkkAjtp2m6o2Fe/h+yxNDxXKVpKQxn6N5kz/mHf+dpFCLX+WY+t7
         eOJJcKyC8vyZsiKuigkTgWd7Sssix3h1Yw8KoHHEJfHfsRiwID51esej9tYvGk7hekMX
         +3SlrRsw+PNcOF/l2ifV7HeyDGI+X4LC/nOTxcVqZkNZa3+Gi3lMgkzY1TqI8R7mXzsU
         9r6A==
X-Gm-Message-State: AOAM5315Q6kWhiBhjZUw4FQpYaL9vRZWNA+wQjqGcc0p9ImCTiOGqakX
        XKfIpcSYB9d3JGpwDhhCCCPyWm3Zf+CYpQ==
X-Google-Smtp-Source: ABdhPJw1P3d2qOHvWzCjUFR+0RQOUfC5JwXsyt2AHfLBPGnvejY6ebW3d5h1nLQAOvNGZCrYSnV/MA==
X-Received: by 2002:a17:902:7083:b029:e2:e330:7eaf with SMTP id z3-20020a1709027083b02900e2e3307eafmr4885695plk.18.1612812548899;
        Mon, 08 Feb 2021 11:29:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:29:08 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 09/11] t/t3437: cleanup the 'setup' test and use named commits in the tests
Date:   Tue,  9 Feb 2021 00:55:29 +0530
Message-Id: <20210208192528.21399-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove unnecessary curly braces and use the named commits in the
tests so that they will still refer to the same commit if the setup
gets changed in the future whereas 'branch~2' will change which commit
it points to.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 40 +++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index cc0ae9411a..d651fb8901 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -43,9 +43,9 @@ get_author () {
 test_expect_success 'setup' '
 	cat >message <<-EOF &&
 	amend! B
-	${EMPTY}
+	$EMPTY
 	new subject
-	${EMPTY}
+	$EMPTY
 	new
 	body
 	EOF
@@ -70,40 +70,43 @@ test_expect_success 'setup' '
 	echo B1 >B &&
 	test_tick &&
 	git commit --fixup=HEAD -a &&
+	git tag B1 &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
 	amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
 	EOF
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
 	amend! amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
-	${EMPTY}
+	$EMPTY
 	edited 2
 	EOF
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
+	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
 	amend! amend! amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
-	${EMPTY}
+	$EMPTY
 	edited 2
-	${EMPTY}
+	$EMPTY
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
 	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4 squash 5 fixup-C 6" \
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
 	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
@@ -194,12 +197,11 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 test_expect_success 'multiple fixup -c opens editor once' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	base=$(git rev-parse HEAD~4) &&
 	FAKE_COMMIT_MESSAGE="Modified-A3" \
 		FAKE_LINES="1 fixup-C 2 fixup-c 3 fixup-c 4" \
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

