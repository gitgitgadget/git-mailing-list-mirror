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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0702FC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1CC22D57
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbhAXRHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbhAXRHf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B2C0613ED
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t6so6158103plq.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMhPi4eCfuYg0ONamdCX/xyYmKMLmLyJyx2MePXNztQ=;
        b=Gp+p4FnCPImVr7kzYSc1QlgDi5+nf348HIVFGBEk0miRqPDFab+R9atRUACWAQ+Unp
         RzaPMYYBDl5VBLNlqB6KJLVoLRdUUGKbdrzLaISK/vYtnmxu4TWoVsWEGv/XhoME9YZK
         9Kaqd7rSwR3GaY5WNC5/k7/XmQ4QubQ13VaIFJReoxvi9NlJ0xGh1+D8GfPZ8+FcAHOv
         FQboErzHU01JgvGKPeQytJqEILOPocIDo4iTGjldEaJJIECZYbvaUz7YTIPAFksRlMhj
         3tZnNCWwL6hjaW7UIsKSlhrJ/SQ/LA+Exj/fDzlm3qC+2jSqjt3W3R/KgyZy84KquqHN
         5TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMhPi4eCfuYg0ONamdCX/xyYmKMLmLyJyx2MePXNztQ=;
        b=dEoSINbMTspgRAlNZLstscnJdCYWTa0eyM2vrmua3ROd9Raiibn1OFbRz1u7fLySqi
         7hYexv9DLkwDYFd5GbFFxYYwjMkbQ28OEpbg/GMXTQDy4YCzEeBzKBHJY9gvBwRDI3Rl
         /4bJFwvA35pdy+aqnBqOOBDSWc4PZXTyDdnteaPtlfwMa7GJmA9c7nC5JYgRLw1UaRMq
         XAjxprimIBrAlVX00+8PCXq2btXGCLOwhjBbbA6e/ENH5DK/oa/+y2YEaAIWWaHY4Kh3
         pYPC+dDiC7/QJAwqW3MVSCYdxSaF3JwkSYOB80z8tMRcVS9gwURPGAT0BCbXL6toyOvO
         5ciQ==
X-Gm-Message-State: AOAM533oNFjflkkIh+l7axHcKLztXGdl1DWLRVowOSXw52u1aAhpQKKA
        a2WRMXyepJb1SL7WHV1Q8bK0Dl+InvUPaw==
X-Google-Smtp-Source: ABdhPJxtWvmDnsNU0bx72+wRLAcdIfNlkt38jLOgW66nhn+9OUAmW8PaXDGKZqNckyV9RyFGhbmYXQ==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr17629220pjd.84.1611508014226;
        Sun, 24 Jan 2021 09:06:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:06:53 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 7/9] t3437: test script for fixup [-C|-c] options in interactive rebase
Date:   Sun, 24 Jan 2021 22:34:05 +0530
Message-Id: <20210124170405.30583-8-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/lib-rebase.sh                   |   4 +
 t/t3437-rebase-fixup-options.sh   | 213 ++++++++++++++++++++++++++++++
 t/t3437/expected-combined-message |  21 +++
 t/t3437/expected-squash-message   |  51 +++++++
 4 files changed, 289 insertions(+)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-combined-message
 create mode 100644 t/t3437/expected-squash-message

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index b72c051f47..e10e38060b 100644
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
+		merge_*|fixup_*)
+			action=$(echo "$line" | sed 's/_/ /g');;
 		"#")
 			echo '# comment' >> "$1";;
 		">")
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
new file mode 100755
index 0000000000..832971ffdb
--- /dev/null
+++ b/t/t3437-rebase-fixup-options.sh
@@ -0,0 +1,213 @@
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
+test_commit_message () {
+	rev="$1" && # commit or tag we want to test
+	file="$2" && # test against the content of a file
+	git show --no-patch --pretty=format:%B "$rev" >actual-message &&
+	if test "$2" = -m
+	then
+		str="$3" && # test against a string
+		printf "%s\n" "$str" >tmp-expected-message &&
+		file="tmp-expected-message"
+	fi
+	test_cmp "$file" actual-message
+}
+
+get_author () {
+	rev="$1" &&
+	git log -1 --pretty=format:"%an %ae" "$rev"
+}
+
+test_expect_success 'setup' '
+	cat >message <<-EOF &&
+		amend! B
+		${EMPTY}
+		new subject
+		${EMPTY}
+		new
+		body
+		EOF
+
+	sed "1,2d" message >expected-message &&
+
+	test_commit A A &&
+	test_commit B B &&
+	get_author HEAD >expected-author &&
+	ORIG_AUTHOR_NAME="$GIT_AUTHOR_NAME" &&
+	ORIG_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" &&
+	GIT_AUTHOR_NAME="Amend Author" &&
+	GIT_AUTHOR_EMAIL="amend@example.com" &&
+	test_commit "$(cat message)" A A1 A1 &&
+	test_commit A2 A &&
+	test_commit A3 A &&
+	GIT_AUTHOR_NAME="$ORIG_AUTHOR_NAME" &&
+	GIT_AUTHOR_EMAIL="$ORIG_AUTHOR_EMAIL" &&
+	git checkout -b conflicts-branch A &&
+	test_commit conflicts A &&
+
+	set_fake_editor &&
+	git checkout -b branch B &&
+	echo B1 >B &&
+	test_tick &&
+	git commit --fixup=HEAD -a &&
+	test_tick &&
+	git commit --allow-empty -F - <<-EOF &&
+		amend! B
+		${EMPTY}
+		B
+		${EMPTY}
+		edited 1
+		EOF
+	test_tick &&
+	git commit --allow-empty -F - <<-EOF &&
+		amend! amend! B
+		${EMPTY}
+		B
+		${EMPTY}
+		edited 1
+		${EMPTY}
+		edited 2
+		EOF
+	echo B2 >B &&
+	test_tick &&
+	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
+	echo B3 >B &&
+	test_tick &&
+	git commit -a -F - <<-EOF &&
+		amend! amend! amend! B
+		${EMPTY}
+		B
+		${EMPTY}
+		edited 1
+		${EMPTY}
+		edited 2
+		${EMPTY}
+		edited 3
+		EOF
+
+	GIT_AUTHOR_NAME="Rebase Author" &&
+	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
+	GIT_COMMITTER_NAME="Rebase Committer" &&
+	GIT_COMMITTER_EMAIL="rebase.committer@example.com"
+'
+
+test_expect_success 'simple fixup -C works' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A2 &&
+	FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
+	test_cmp_rev HEAD^ B &&
+	test_cmp_rev HEAD^{tree} A2^{tree} &&
+	test_commit_message HEAD -m "A2"
+'
+
+test_expect_success 'simple fixup -c works' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A2 &&
+	git log -1 --pretty=format:%B >expected-fixup-message &&
+	test_write_lines "" "Modified A2" >>expected-fixup-message &&
+	FAKE_LINES="1 fixup_-c 2" \
+		FAKE_COMMIT_AMEND="Modified A2" \
+		git rebase -i B &&
+	test_cmp_rev HEAD^ B &&
+	test_cmp_rev HEAD^{tree} A2^{tree} &&
+	test_commit_message HEAD expected-fixup-message
+'
+
+test_expect_success 'fixup -C removes amend! from message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A1 &&
+	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
+	test_cmp_rev HEAD^{tree} A1^{tree} &&
+	test_commit_message HEAD expected-message &&
+	get_author HEAD >actual-author &&
+	test_cmp expected-author actual-author
+'
+
+test_expect_success 'fixup -C with conflicts gives correct message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A1 &&
+	test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
+	git checkout --theirs -- A &&
+	git add A &&
+	FAKE_COMMIT_AMEND=edited git rebase --continue &&
+	test_cmp_rev HEAD^ conflicts &&
+	test_cmp_rev HEAD^{tree} A1^{tree} &&
+	test_write_lines "" edited >>expected-message &&
+	test_commit_message HEAD expected-message &&
+	get_author HEAD >actual-author &&
+	test_cmp expected-author actual-author
+'
+
+test_expect_success 'skipping fixup -C after fixup gives correct message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
+	git reset --hard &&
+	FAKE_COMMIT_AMEND=edited git rebase --continue &&
+	test_commit_message HEAD -m "B"
+'
+
+test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
+	git checkout --detach branch &&
+	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4 squash 5 fixup_-C 6" \
+		FAKE_COMMIT_AMEND=squashed \
+		FAKE_MESSAGE_COPY=actual-squash-message \
+		git -c commit.status=false rebase -ik --signoff A &&
+	git diff-tree --exit-code --patch HEAD branch -- &&
+	test_cmp_rev HEAD^ A &&
+	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
+		actual-squash-message
+'
+
+test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fixup -C' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout branch && git checkout --detach branch~2 &&
+	git log -1 --pretty=format:%b >expected-message &&
+	FAKE_LINES="1 fixup 2 fixup_-C 3 fixup_-C 4" git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
+	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'multiple fixup -c opens editor once' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_MESSAGE="Modified-A3" \
+		FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
+		EXPECT_HEADER_COUNT=4 \
+		git rebase -i $base &&
+	test_cmp_rev $base HEAD^ &&
+	test 1 = $(git show | grep Modified-A3 | wc -l)
+'
+
+test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	FAKE_LINES="1 squash 2 fixup 3 fixup_-c 4" \
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
index 0000000000..a26cfb2fa9
--- /dev/null
+++ b/t/t3437/expected-combined-message
@@ -0,0 +1,21 @@
+# This is a combination of 4 commits.
+# This is the 1st commit message:
+
+B
+
+# This is the commit message #2:
+
+# amend! B
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
diff --git a/t/t3437/expected-squash-message b/t/t3437/expected-squash-message
new file mode 100644
index 0000000000..ab2434f90e
--- /dev/null
+++ b/t/t3437/expected-squash-message
@@ -0,0 +1,51 @@
+# This is a combination of 6 commits.
+# The 1st commit message will be skipped:
+
+# B
+#
+# Signed-off-by: Rebase Committer <rebase.committer@example.com>
+
+# The commit message #2 will be skipped:
+
+# fixup! B
+
+# The commit message #3 will be skipped:
+
+# amend! B
+#
+# B
+#
+# edited 1
+#
+# Signed-off-by: Rebase Committer <rebase.committer@example.com>
+
+# This is the commit message #4:
+
+# amend! amend! B
+
+B
+
+edited 1
+
+edited 2
+
+Signed-off-by: Rebase Committer <rebase.committer@example.com>
+
+# This is the commit message #5:
+
+# squash! amend! amend! B
+
+edited squash
+
+# This is the commit message #6:
+
+# amend! amend! amend! B
+
+B
+
+edited 1
+
+edited 2
+
+edited 3
+squashed
-- 
2.29.0.rc1

