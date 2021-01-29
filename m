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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEBC43381
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCA64DE9
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhA2SZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhA2SXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:23:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48303C06174A
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 11so6746942pfu.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mjnb7s4+wrUzyipXwVf1NX3axMeXC6d+hbWBTYQo6MQ=;
        b=NPIHE+hla4gJvvXor+3KaTgt7Yo23th3wAi+5AdjxUb0jXJ5kyhvOL1hfpvgloDFY4
         cbwYsfEKj6WGkJnBomNHnfRYflVxqoX6XgRLAttVF656SpLCOwhLRfmBSW4Lic2NEfe+
         lCyxstDFlvwuupj2AO4nSQkOG0z7GkjyuQQVPfSrZ2yUtmZv5nhsdsdPlFGp9q6/MFhL
         eLQxBxZVFXOCNCYJWQZfIdEjeO00qo+6N9bEUSMp5JhGNpWcFHZNA6wsszThsOBeky2K
         AWupqnjFxBHh2qb0lDS74+Ta6wTpjkPxGZ6Ud5QPG0hatiU5rrV79S56FbBglsZlpwsa
         UN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mjnb7s4+wrUzyipXwVf1NX3axMeXC6d+hbWBTYQo6MQ=;
        b=AICvrOs7WJ0f2OT4K8Izdv04+0LVqZgbTXIYBlh7mRNuwY+jyTffYW3n0LQxRXK+Q8
         GnrrwCN20L7tMu/UBbbFi0ip4K5bDC5KO+ojYlkPoTBqMqlhdab3Bl7i+fRRxDxWadk/
         2IYkkpm0FxAtVzrsfTBAjWmxJgBubENKF4nlKkq9x/hJq4wN5HC83cnZ5LIpPIQ+bUy7
         lQzegH2dwh57JjVICP6ZbVxN8q8M1kSZ4EE3J1Hg9M6hmNIRj7CyLm8HoF+8LInc50Jd
         mLh/rDBmlFjW4DuHJCp+LedUxYF1p+C5qGOnCVsNV4MxSlqIAMzMvx5p8VqVuwvfdzhv
         qpIQ==
X-Gm-Message-State: AOAM532NfQEnIlN9ThGJr1tV7NX5Hfs7vgcKAPSa4NjNEZ1bq6ZLsLE0
        dkropAoFDq9eY3ImXfjiK3axHwuhxVY=
X-Google-Smtp-Source: ABdhPJxf/lvna5ESmtXeJpeVd18ByyxnSU+Sbv47WW22FV5/ysfQylGzugKk5Pe1EfsP1xCEdxCyQQ==
X-Received: by 2002:a63:705c:: with SMTP id a28mr6049752pgn.402.1611944563523;
        Fri, 29 Jan 2021 10:22:43 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:43 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 8/9] rebase -i: teach --autosquash to work with amend!
Date:   Fri, 29 Jan 2021 23:50:49 +0530
Message-Id: <20210129182050.26143-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
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

