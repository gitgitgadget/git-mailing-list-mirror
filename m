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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E2C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBB964F65
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbhBDTHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbhBDTHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:07:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6361AC061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o20so2723523pfu.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wft5ezGvz2rkaVUQX0urthMTPZWEqxmeMp3WTgpz8Rg=;
        b=jkDMV2nJLQm9QAaTFtsNfjGInq3NsYvesmbafYcqh10/mYXJo7M0kBny+vMoYrRnai
         xT07wvGDHJVQcNpaW+tPH6WRxcpE547WZHvCj6wlXJKcEtuchqATZnYwVRtH92ugM6Fe
         X747w8Y2xBF/Q8ZTPrl4RhTTFjIu4FXpywcRZEKJL0kelI0FBkNh7XU1fc7ptwIp8SmA
         Qs2KSeOhCwbmyL2m93XVrJvVrGtQ/SImcoCtCw2LIss9vZ0tHlsVt9jnkPuaVweOpfp0
         B2j/n/UUdICKskn2UbszT+4vRUP1n5C5/Ao1cz6jt4LhvhGpQ20fMhqsKdlXbfUj2Pjy
         xoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wft5ezGvz2rkaVUQX0urthMTPZWEqxmeMp3WTgpz8Rg=;
        b=Z1dF0glUn+CENRAAgzlcaMStQafRDkJNRTCGLJrYS/jOhw7gD0NYrnA8EcBYr0/YYm
         WchRp2msZ4vU5jJYaNO7VbjEdlGfB4FgF88jS0qFNMINjff/RjLC/OJINAv21I1pGacE
         J3ksRA+YqX2owmKhfnipTP3Xw447y5j7/371Q6dzC0IrWinAgFkOh3EJUcWtxU1oqZmW
         vPdveM/XlHDAe5GkgRzdS1g72eXpU0NG+vhzo2berSO2n5Egeq1jDrhAV2kD/sX4CBMO
         7OFB3vYjaTQ2j8OlD89wlvP2gczEwx87CjHXjEAdbvfLNs7m0SsloOjqt7OeuwjgHQyc
         kUrg==
X-Gm-Message-State: AOAM532lPgzpEBcow8mXxwI5rsgou8vP0J+4GKmt5jp89EjfKRlayeNy
        GAqqhXFFIZDdxQmfqHaUFV5sH3RQdsFaRw==
X-Google-Smtp-Source: ABdhPJzoN4nfL+NDCR68kduHJ14LVDcaNVn4+gtKTACiBnVQJN2LYRm3OWKRpdQ8S8zeM/DORrHycg==
X-Received: by 2002:a63:575e:: with SMTP id h30mr428094pgm.7.1612465590613;
        Thu, 04 Feb 2021 11:06:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:06:30 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 7/8] t3437: test script for fixup [-C|-c] options in interactive rebase
Date:   Fri,  5 Feb 2021 00:35:06 +0530
Message-Id: <20210204190507.26487-8-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/lib-rebase.sh                   |   8 +-
 t/t3437-rebase-fixup-options.sh   | 133 ++++++++++++++++++++++++++++++
 t/t3437/expected-combined-message |  19 +++++
 3 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-combined-message

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index b72c051f47..d9afed7b47 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -4,6 +4,7 @@
 #
 # - override the commit message with $FAKE_COMMIT_MESSAGE
 # - amend the commit message with $FAKE_COMMIT_AMEND
+# - copy the original commit message to a file with $FAKE_MESSAGE_COPY
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
 # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
 # - rewrite a rebase -i script as directed by $FAKE_LINES.
@@ -14,8 +15,8 @@
 #       specified line.
 #
 #   "<cmd> <lineno>" -- add a line with the specified command
-#       ("pick", "squash", "fixup", "edit", "reword" or "drop") and the
-#       SHA1 taken from the specified line.
+#       ("pick", "squash", "fixup"|"fixup-C"|"fixup-c", "edit", "reword" or "drop")
+#       and the SHA1 taken from the specified line.
 #
 #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
 #
@@ -33,6 +34,7 @@ set_fake_editor () {
 			exit
 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
+		test -z "$FAKE_MESSAGE_COPY" || cat "$1" >"$FAKE_MESSAGE_COPY"
 		exit
 		;;
 	esac
@@ -51,6 +53,8 @@ set_fake_editor () {
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
+		fixup-*)
+			action=$(echo "$line" | sed 's/-/ -/');;
 		"#")
 			echo '# comment' >> "$1";;
 		">")
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
new file mode 100755
index 0000000000..c2875803af
--- /dev/null
+++ b/t/t3437-rebase-fixup-options.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Phillip Wood
+#
+
+test_description='git rebase interactive fixup options
+
+This test checks the "fixup [-C|-c]" command of rebase interactive.
+In addition to amending the contents of the commit, "fixup -C"
+replaces the original commit message with the message of the fixup
+commit. "fixup -c" also replaces the original message, but opens the
+editor to allow the user to edit the message before committing.
+'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+EMPTY=""
+
+# test_commit_message <rev> -m <msg>
+# test_commit_message <rev> <path>
+# Verify that the commit message of <rev> matches
+# <msg> or the content of <path>.
+test_commit_message () {
+	git show --no-patch --pretty=format:%B "$1" >actual &&
+	case "$2" in
+	-m) echo "$3" >expect &&
+	    test_cmp expect actual ;;
+	*) test_cmp "$2" actual ;;
+	esac
+}
+
+test_expect_success 'setup' '
+	cat >message <<-EOF &&
+	new subject
+	$EMPTY
+	new
+	body
+	EOF
+	test_commit A A &&
+	test_commit B B &&
+
+	set_fake_editor &&
+	git checkout -b test-branch &&
+	test_commit "$(cat message)" A A1 A1 &&
+	test_commit A2 A &&
+	test_commit A3 A &&
+	git checkout -b conflicts-branch A &&
+	test_commit conflicts A
+'
+
+test_expect_success 'simple fixup -C works' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A1 &&
+	git log -1 --pretty=format:%B >expected-message &&
+	FAKE_LINES="1 fixup-C 2 " git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
+	test_cmp_rev HEAD^{tree} A1^{tree} &&
+	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'simple fixup -c works' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A2 &&
+	git log -1 --pretty=format:%B HEAD~ >expected-message &&
+	test_write_lines "" "Modified A1" >>expected-message &&
+	FAKE_LINES="1 fixup-c 2 3" \
+		FAKE_COMMIT_AMEND="Modified A1" \
+		git rebase -i A &&
+	test_cmp_rev HEAD^{tree} A2^{tree} &&
+	test_commit_message HEAD~ expected-message
+'
+
+test_expect_success 'fixup -C with conflicts gives correct message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A1 &&
+	git log -1 --pretty=format:%B HEAD >expected-message &&
+	test_write_lines "" "edited" >>expected-message &&
+	test_must_fail env FAKE_LINES="1 fixup-C 2" git rebase -i conflicts &&
+	git checkout --theirs -- A &&
+	git add A &&
+	FAKE_COMMIT_AMEND=edited git rebase --continue &&
+	test_cmp_rev HEAD^ conflicts &&
+	test_cmp_rev HEAD^{tree} A1^{tree} &&
+	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'skipping fixup -C after fixup gives correct message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup-C 4" git rebase -i A &&
+	git reset --hard &&
+	FAKE_COMMIT_AMEND=edited git rebase --continue &&
+	test_commit_message HEAD -m "B"
+'
+
+test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fixup -C' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	git log -1 --pretty=format:%B >expected-message &&
+	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4" git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
+	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'multiple fixup -c opens editor once' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_MESSAGE="Modified-A3" \
+		FAKE_LINES="1 fixup-C 2 fixup-c 3 fixup-c 4" \
+		EXPECT_HEADER_COUNT=4 \
+		git rebase -i $base &&
+	test_commit_message HEAD -m "Modified-A3" &&
+	test_cmp_rev $base HEAD^ &&
+	git show > raw &&
+	grep Modified-A3 raw >out &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	FAKE_LINES="1 squash 2 fixup 3 fixup-c 4" \
+		FAKE_MESSAGE_COPY=actual-combined-message \
+		git -c commit.status=false rebase -i A &&
+	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-combined-message" \
+		actual-combined-message &&
+	test_cmp_rev HEAD^ A
+'
+
+test_done
diff --git a/t/t3437/expected-combined-message b/t/t3437/expected-combined-message
new file mode 100644
index 0000000000..d21bd1b6bb
--- /dev/null
+++ b/t/t3437/expected-combined-message
@@ -0,0 +1,19 @@
+# This is a combination of 4 commits.
+# This is the 1st commit message:
+
+B
+
+# This is the commit message #2:
+
+new subject
+
+new
+body
+
+# The commit message #3 will be skipped:
+
+# A2
+
+# This is the commit message #4:
+
+A3
-- 
2.29.0.rc1

