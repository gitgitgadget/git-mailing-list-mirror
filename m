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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE3C433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CCB64E9D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhBHT2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhBHT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:28:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD2C06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:27:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g3so8383723plp.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quLqiydcx0JzvD1hH2HfpO0CYyX0VEALuDUggMY3YcY=;
        b=gWAEwBkso+3n6T9jbNub9azUrLsy7i4zkSvz4AajZQoBqgVhV7jrRbUrpy96h0Tqwl
         7KwUZxoI4l1NZbYaplf7rMkPplRv0lFHaxogzG0NZrG9gGifMGQfs7bCBZOdcEkOoDo5
         YhlkY6txrgY/bJYcw/g5R2J6XgCK/5w1M0jqhfYDa8fksX1MXiMnWB03V/nBN9QBEhQe
         i4C02KfOs5fhP31Qa7KeaJbs0tZMCZBbGRDSBxHGNPTcRTQxPLldsEVKBW4/TKxuuRgG
         RbjUdT8ii7EhJGMQAV8nvUSPWbqzmvQKgmfL2OsmrNJ0SwW5vWyvh4qTxq6jwOsa7vqs
         cfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quLqiydcx0JzvD1hH2HfpO0CYyX0VEALuDUggMY3YcY=;
        b=U05vKOs7R8h8p2u2SFJR0Br9CoEnShC/yDuVbehRY+/nb6ZAkJr6N3Ex2KytIXmtHh
         xIe7Ryer7Ca5pqV0k5+KDaRDud9mYYkwbYDhYCd3IiVsxvZFpMCcFl+7/gR9hLi/UBPx
         B+B9cZMRNL4+bZsqr6Y+twlhMMR2WBETxuaw6Itacye+o2mvI+XmdxGK9hKDFskFsYnT
         +7K1vKuObicpgvF3jlx+fkF3cdqznbJEm2CzBVzM5KY+dGrkYvcbtx5Bcv3USFl3fA8P
         e5s0XyfzTLQgK1ZVjOcvcoUTZCV7YiLGYnKROl6Wpi+it+liStw3cOL4WI+wRkEnhW+w
         xGiw==
X-Gm-Message-State: AOAM531H0VvPRUtkRua1ZHOsYboObJLfaKTunIA7HpFKEkCxZ/D11NMT
        odoTTs+ixVzFqIlEEMMPA1FlV0PC2Rty0g==
X-Google-Smtp-Source: ABdhPJyrN6DCHz7qjMe90Nz0oxKd11f6MkfvXGP4Zw/LEdj50flyN7vXZTauJXWoL/WyHOIL2pm78Q==
X-Received: by 2002:a17:90a:5317:: with SMTP id x23mr332998pjh.154.1612812454900;
        Mon, 08 Feb 2021 11:27:34 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:27:34 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 04/11] t/lib-rebase: change the implementation of commands with options
Date:   Tue,  9 Feb 2021 00:55:22 +0530
Message-Id: <20210208192528.21399-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"fixup" and "merge" mirrors the implementation of FAKE_LINES handling of
"exec", but the cases are quite different. The argument to "exec" is
arbitrary and can have any number of spaces embedded in it, which
conflicts with the meaning of spaces in FAKE_LINES, which separate the
individual commands in FAKE_LINES. Consequently, "_" was chosen as a
placeholder in "exec" to mean "space".

However, "fixup" is very different from "exec". Its arguments are not
arbitrary at all, so there isn't a good reason to mirror the choice of
"_" to represent a space, which leads to rather unsightly tokens such
as "fixup_-C". Let's replace it with simpler tokens such as "fixup-C"
and "fixup-c".

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/lib-rebase.sh                 |  8 ++++----
 t/t3437-rebase-fixup-options.sh | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index e10e38060b..e6bd295c05 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -15,8 +15,8 @@
 #       specified line.
 #
 #   "<cmd> <lineno>" -- add a line with the specified command
-#       ("pick", "squash", "fixup", "edit", "reword" or "drop") and the
-#       SHA1 taken from the specified line.
+#      ("pick", "squash", "fixup"|"fixup-C"|"fixup-c", "edit", "reword" or "drop")
+#      and the SHA1 taken from the specified line.
 #
 #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
 #
@@ -53,8 +53,8 @@ set_fake_editor () {
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
-		merge_*|fixup_*)
-			action=$(echo "$line" | sed 's/_/ /g');;
+		merge-*|fixup-*)
+			action=$(echo "$line" | sed 's/-/ -/');;
 		"#")
 			echo '# comment' >> "$1";;
 		">")
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 945df2555b..36dee15c4b 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -112,7 +112,7 @@ test_expect_success 'setup' '
 test_expect_success 'simple fixup -C works' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A2 &&
-	FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
+	FAKE_LINES="1 fixup-C 2" git rebase -i B &&
 	test_cmp_rev HEAD^ B &&
 	test_cmp_rev HEAD^{tree} A2^{tree} &&
 	test_commit_message HEAD -m "A2"
@@ -123,7 +123,7 @@ test_expect_success 'simple fixup -c works' '
 	git checkout --detach A2 &&
 	git log -1 --pretty=format:%B >expected-fixup-message &&
 	test_write_lines "" "Modified A2" >>expected-fixup-message &&
-	FAKE_LINES="1 fixup_-c 2" \
+	FAKE_LINES="1 fixup-c 2" \
 		FAKE_COMMIT_AMEND="Modified A2" \
 		git rebase -i B &&
 	test_cmp_rev HEAD^ B &&
@@ -134,7 +134,7 @@ test_expect_success 'simple fixup -c works' '
 test_expect_success 'fixup -C removes amend! from message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
-	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
+	FAKE_LINES="1 fixup-C 2" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
 	test_commit_message HEAD expected-message &&
@@ -145,7 +145,7 @@ test_expect_success 'fixup -C removes amend! from message' '
 test_expect_success 'fixup -C with conflicts gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
-	test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
+	test_must_fail env FAKE_LINES="1 fixup-C 2" git rebase -i conflicts &&
 	git checkout --theirs -- A &&
 	git add A &&
 	FAKE_COMMIT_AMEND=edited git rebase --continue &&
@@ -160,7 +160,7 @@ test_expect_success 'fixup -C with conflicts gives correct message' '
 test_expect_success 'skipping fixup -C after fixup gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup-C 4" git rebase -i A &&
 	git reset --hard &&
 	FAKE_COMMIT_AMEND=edited git rebase --continue &&
 	test_commit_message HEAD -m "B"
@@ -168,7 +168,7 @@ test_expect_success 'skipping fixup -C after fixup gives correct message' '
 
 test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
 	git checkout --detach branch &&
-	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4 squash 5 fixup_-C 6" \
+	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4 squash 5 fixup-C 6" \
 		FAKE_COMMIT_AMEND=squashed \
 		FAKE_MESSAGE_COPY=actual-squash-message \
 		git -c commit.status=false rebase -ik --signoff A &&
@@ -182,7 +182,7 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout branch && git checkout --detach branch~2 &&
 	git log -1 --pretty=format:%b >expected-message &&
-	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4" git rebase -i A &&
+	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_commit_message HEAD expected-message
 '
@@ -192,7 +192,7 @@ test_expect_success 'multiple fixup -c opens editor once' '
 	git checkout --detach A3 &&
 	base=$(git rev-parse HEAD~4) &&
 	FAKE_COMMIT_MESSAGE="Modified-A3" \
-		FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
+		FAKE_LINES="1 fixup-C 2 fixup-c 3 fixup-c 4" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
 	test_cmp_rev $base HEAD^ &&
@@ -202,7 +202,7 @@ test_expect_success 'multiple fixup -c opens editor once' '
 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	FAKE_LINES="1 squash 2 fixup 3 fixup_-c 4" \
+	FAKE_LINES="1 squash 2 fixup 3 fixup-c 4" \
 		FAKE_MESSAGE_COPY=actual-combined-message \
 		git -c commit.status=false rebase -i A &&
 	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-combined-message" \
-- 
2.29.0.rc1

