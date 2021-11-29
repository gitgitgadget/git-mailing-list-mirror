Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4045C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhK2V4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhK2Vxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:53:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95ACC043CE4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so38976195wrb.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MCuiqxLv9bQVl5PA1+97daaKtvuwv7Ii0bPhxb1xHqQ=;
        b=QmGww+duLsweCZy2HKcEeGRJQ2kHqZONqboUd9FCOjJZDe56x5kQ4cK++rIceNwaYt
         mKjOMLuSJNXhYMj8In+URM6QfGrG4zHMjb97mHwmo34xfQNmzGaaoNeh3QNoHh/vrojs
         4eVhTUwnJBgmh6SnsyW13i0f2kFqHmvGbihFhHC4OE5bR/wVx5pwLyQrLT1jXmTX2L41
         LhsYppT00a7/TxFThXwSz3O4q6hfjME3exAk1sClYfn0y6pSDb59v3YnUT0ujD9rk8Pv
         7iPGFz1tsnvo18laX7UDaCGZ5cUOmPhzvCE5iDTQTZgzF65v9E/28r4gF/tcaiqusLad
         Yp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MCuiqxLv9bQVl5PA1+97daaKtvuwv7Ii0bPhxb1xHqQ=;
        b=BN4gT6kslJy9JjE008q2mQsDr/nmHHku++olFLp9KvL4YDTc8FJRACLU+mVbSo+oGp
         b+zBPZ5ooY3OoE+2hgxjdY8a74Ql+2mkJsS46zVwg7Yfcsb0jcBtb+ybtzeN3zRPEDU/
         E63u6Wo/8gmdRx147GACTiOXQ+mkTPzUh8KEGPML7mMvRV9hRwch/Ma3+oGj+B85ZniK
         JEMHbQddNGSMeuo0ZVacVRH6c5nzOZj4OhCCU1jO6iqsGD1tnxLeujUuS+eh+RBdtrRX
         2balS93OC3gFUG681wd34gOBglUVjSThnGVF6aa7Uoh5/442eIrWSLCcJDD4o8+2VwL0
         JZqw==
X-Gm-Message-State: AOAM532Xfnta4duQIJbbvB7FfF8xe7m+ZDF5Wo0aIW08wccGBQSYZtaK
        Z1GysGtKgsD5F8dZ215GC1mfsZOmwbw=
X-Google-Smtp-Source: ABdhPJxjeyukhhWS5K0kD/zUTiY8FfAmheZhX1+mql3SQ3CR/FNodjjEHS0ximwuSAAdLj2PQFki3A==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr37191922wri.305.1638211790355;
        Mon, 29 Nov 2021 10:49:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm14534971wro.35.2021.11.29.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:50 -0800 (PST)
Message-Id: <06c8ff7df15d325c7d66a63d30d94fcfe2ef91c0.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:45 +0000
Subject: [PATCH v2 5/6] t1430: remove refs using test-tool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1430-bad-ref-name.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 56d0726944e..5c600980b5f 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -154,7 +154,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git branch shadow one &&
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
-	test_when_finished "rm -f .git/refs/tags/shadow" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
@@ -165,9 +165,9 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
 	git for-each-ref >output 2>error &&
 	! grep -e "broken\.\.\.ref" output &&
 	! grep -e "badname" output &&
@@ -204,7 +204,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
@@ -216,7 +216,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
@@ -225,7 +225,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
@@ -234,7 +234,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
 
 test_expect_success 'branch -d can delete dangling symref to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
@@ -246,7 +246,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...ref &&
 	test_must_be_empty output &&
@@ -255,7 +255,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 
 test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_must_be_empty output &&
@@ -264,7 +264,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref with broken name
 
 test_expect_success 'branch -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
@@ -273,7 +273,7 @@ test_expect_success 'branch -d can delete symref with broken name' '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_must_be_empty output &&
@@ -282,7 +282,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref with br
 
 test_expect_success 'branch -d can delete dangling symref with broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
-- 
gitgitgadget

