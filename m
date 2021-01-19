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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77908C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A38523131
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbhASHsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbhASHpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:20 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73101C0613D3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n7so12499571pgg.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6naTkIZpRW98nvH3qAFSueVtXncK2odSznG5IWp1L2g=;
        b=jVqyoTPu4oUvdVDTdTpCfPnDI+qn9KLmuziJTtKh/nsOczpuYvBHE6YR6GYpjKbbGd
         FkFiJocLsf6ZkW6q6gnPQC6FWeLVsFsN5hZORaGO7maAbsIkgXUQJyhiOy3u9DRvuksk
         2mkYRLFovNkK/rT/mmiyWYKlb/sM2O1CTcsvER6EhfOskPPZEpNaX2IT4s6west02nr9
         m8h9hcjJ4KiTogdxTFylnxvyEHR+UzU+FSR6h6pmFupHvfWyuissex0Fo+EhNC6GShc9
         eoBT8RFmzkMB1NCHx+f1bdibTHM+GxSfWb/suVpaoAtPv+YUdSf9Ht3qhDRJ4cwKyT91
         R/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6naTkIZpRW98nvH3qAFSueVtXncK2odSznG5IWp1L2g=;
        b=kaB1hG4pIm4XEvOg8FOqmIrwKkHgn7ABmDOufg78sumyU8ZhsqvtYKHtn41TbMPtzc
         8MReM09N4+53WbHSd7gvCsNXc7sqLr3wWl0NDjC/btLw+dq+7bqNexmo1aGGcK9lBhvR
         HJHvu7DMQkD8GnzSchRcgcOoG24WoUzFrdemBkBw2wc2pvNCgN20W97exLwJIajdrVLs
         8dCD5yEnKFzA6BtYPY2c6qUPzDZ7zqJO6OqjJVmQanfHwp6D+kwvn9B39rb7hGSx1kSC
         6UKWY0gnmrlhuchG0vR5jaNJhZPMW9hPko+HmxI5IOcXbxLvVOIKKoB47ZLs+JEhrd5A
         RvfQ==
X-Gm-Message-State: AOAM5328OajuS/Uy1SJBKVGGXLBdab2cwrj2oOuhRfcy3Ir9gOiLdAPi
        Ccm2Pitvlxa1zrBgkg7AfnJWs8bHk3aA9A==
X-Google-Smtp-Source: ABdhPJwVRe4WgUs72IP5zr1aWwk2YDA4LbRpyudX8RwqHOWHphggfyN/mk4JULy9sifxhOFVh8Napw==
X-Received: by 2002:a05:6a00:acc:b029:198:2ba6:c0f6 with SMTP id c12-20020a056a000accb02901982ba6c0f6mr3035955pfl.53.1611042279764;
        Mon, 18 Jan 2021 23:44:39 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:39 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 8/9] rebase -i: teach --autosquash to work with amend!
Date:   Tue, 19 Jan 2021 13:11:03 +0530
Message-Id: <20210119074102.21598-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
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
index 3c0cd487f9..2a3f8d2fae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5664,6 +5664,12 @@ static int subject2item_cmp(const void *fndata,
 
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
@@ -5722,15 +5728,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
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
 
@@ -5760,9 +5764,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
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
index 9e62d74249..532dc1c11b 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -187,4 +187,16 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 	test_commit_message HEAD expected-message
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

