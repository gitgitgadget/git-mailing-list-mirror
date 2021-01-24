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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFBC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D258322D57
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAXRHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbhAXRHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDEC061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:07:02 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n7so7338608pgg.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mjnb7s4+wrUzyipXwVf1NX3axMeXC6d+hbWBTYQo6MQ=;
        b=MvifX3ToPSxdxge1qSrKu3T/MaWEYMocoZWZJ7GpbTBw1HKt0cTq9NtFUCmtLi0Glm
         jsStQ3JJDU0xSWfrbuTY1bF4NhYE4vnKrtOfPrUyzhtHb0utH0A82zuGUoBAPQxNaQRR
         kiOVl381SpwG7xChQvqD4LtvsqSD0/i8bbILmDpy+4Svv7vTNYVg1oxtAKDD/GJE2d6N
         JjqWvo4IhJjqA0z0sKtPDklYNhg/JUkSkoB21e9A74ltGEvgXUMZc6m5tFEHZjYm6BFu
         qJcP6o9BufsXUs7vJNLZSaOZV8RGc7R5KT8iaz7pJUttqAAzrLOY3mW2hv34ou7ti9Ih
         8fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mjnb7s4+wrUzyipXwVf1NX3axMeXC6d+hbWBTYQo6MQ=;
        b=cxgHQd1SzGMtNUQH6hcghPaznYTVyvwe7h3HchPvNnGMm4xRIGnmELamyPhRwW7+nA
         Y1zebwp5363Qwb40E2tXiXz/A2b5LCbXA4QuHDJY7G4yIKjSi/+LOBD/MimCrAEd72Im
         ysAupGcUODDplB/ZzIRvtqW4VrQCHdCLqVhl2cJLC1cve+bcVZTRCFBsMbMeolvDh4Pc
         XsXjWLR7Vg3AHn3jNk0pvqyBLpMo4NYiCUQlcS+iJWBIl0/vQqFRqoof6AuQUAKL6Jb4
         ds5AV8XvkMgXG9guZDsv0Gf7K9EW8/k5W8sXt/uAbmhFBkS0MBxs6FXGoDxV0pMDLctK
         1N0A==
X-Gm-Message-State: AOAM533079A2IV1Q6hzNs88bF/l8N9epOPDXS76NgQRDzU970V/vUORm
        yeU/x9dFK94Z5mVdLHQq1e0qoV2Xiqifcw==
X-Google-Smtp-Source: ABdhPJws3GtwjqSHHpg18hVdO/Wwz3iWkGj7Vq2ECGHSjnxLgYfmnfIff7HZ26CcdjndE5+5VpMwPw==
X-Received: by 2002:a65:534c:: with SMTP id w12mr9063046pgr.179.1611508021565;
        Sun, 24 Jan 2021 09:07:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:07:01 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/9] rebase -i: teach --autosquash to work with amend!
Date:   Sun, 24 Jan 2021 22:34:06 +0530
Message-Id: <20210124170405.30583-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the commit subject starts with "amend!" then rearrange it like a
"fixup!" commit and replace `pick` command with `fixup -C` command,
which is used to fixup up the content if any and replaces the original
commit message with amend! commit's message.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c                     | 23 ++++++++++++++++-------
 t/t3437-rebase-fixup-options.sh | 12 ++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 46e11d20e8..d09ce446b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5662,6 +5662,12 @@ static int subject2item_cmp(const void *fndata,
 
 define_commit_slab(commit_todo_item, struct todo_item *);
 
+static inline int skip_fixup_amend_squash(const char *subject, const char **p) {
+	return skip_prefix(subject, "fixup! ", p) ||
+	       skip_prefix(subject, "amend! ", p) ||
+	       skip_prefix(subject, "squash! ", p);
+}
+
 /*
  * Rearrange the todo list that has both "pick commit-id msg" and "pick
  * commit-id fixup!/squash! msg" in it so that the latter is put immediately
@@ -5720,15 +5726,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
 		unuse_commit_buffer(item->commit, commit_buffer);
-		if ((skip_prefix(subject, "fixup! ", &p) ||
-		     skip_prefix(subject, "squash! ", &p))) {
+		if (skip_fixup_amend_squash(subject, &p)) {
 			struct commit *commit2;
 
 			for (;;) {
 				while (isspace(*p))
 					p++;
-				if (!skip_prefix(p, "fixup! ", &p) &&
-				    !skip_prefix(p, "squash! ", &p))
+				if (!skip_fixup_amend_squash(p, &p))
 					break;
 			}
 
@@ -5758,9 +5762,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list->items[i].command =
-				starts_with(subject, "fixup!") ?
-				TODO_FIXUP : TODO_SQUASH;
+			if (starts_with(subject, "fixup!")) {
+				todo_list->items[i].command = TODO_FIXUP;
+			} else if (starts_with(subject, "amend!")) {
+				todo_list->items[i].command = TODO_FIXUP;
+				todo_list->items[i].flags = TODO_REPLACE_FIXUP_MSG;
+			} else {
+				todo_list->items[i].command = TODO_SQUASH;
+			}
 			if (tail[i2] < 0) {
 				next[i] = next[i2];
 				next[i2] = i;
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 832971ffdb..945df2555b 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -210,4 +210,16 @@ test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
 	test_cmp_rev HEAD^ A
 '
 
+test_expect_success 'fixup -C works upon --autosquash with amend!' '
+	git checkout --detach branch &&
+	FAKE_COMMIT_AMEND=squashed \
+		FAKE_MESSAGE_COPY=actual-squash-message \
+		git -c commit.status=false rebase -ik --autosquash \
+						--signoff A &&
+	git diff-tree --exit-code --patch HEAD branch -- &&
+	test_cmp_rev HEAD^ A &&
+	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
+		actual-squash-message
+'
+
 test_done
-- 
2.29.0.rc1

