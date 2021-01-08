Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9706C43381
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870F2233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbhAHJ1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhAHJ1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:27:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A99C0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:26:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u4so4119392pjn.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5d3r4ROZAvqT/9LDJdc0FjThQBb0/svoVRZRspqCHk=;
        b=jv5nFjrOme9sGqJ0uhCbaCZdbJj+2JOMcz1lvzVqLvxMUibdnWUmtekh50GZWzZQll
         6RB2lteD5F4fx0vzFUZReUAp79p3yA43xP10LNajexfha/MQ/k/MWLi7mFeSfcRz2+xC
         huRG1VFXzFk0YAFfA85SarUP78TQo9kz8xlTnbU/k8oGFA6rQ1uKHWm6kjDqTH1r+rPf
         +jPd/XGPM79LEGgDOhR7Be7+I3zFM029es9UHUsgkrJRv4YLphL4uFjGw30PXuIp1sqP
         JvBjE1zqi6VeuGPcBs9dEKUb7dcttchoBpfsk67FrvHZxleX7nJWmai7nMRGSSjduAVS
         UIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5d3r4ROZAvqT/9LDJdc0FjThQBb0/svoVRZRspqCHk=;
        b=gSNNAhjAQfJHlKznYUMKOqURO9RNu+bogiITv3N2aiF1ad9CYiezfmKxyjSXZsp7sy
         aYBSKcMbBgwQYdwZrGSy5ZtyOyEVmTukq461qRKSvpRUOSNpg/JqLj+uV2gFVxI7Qjd0
         QsfH6Kr0PFO7Pjqx3T7aQ6BREIm/KzBuVq2DuntipUn36aWqUbkrkZ4NHvX2sU6xgrX+
         relrckMgglkF86vTovv1c2bRf/Nv2uk+LEqyLit2X0qPAEQ5BnwTzM22icdouKJtoESt
         +KqiV/mncNFXfekpizyubDyR7On+vY+wFYv+BW4tInDJshZRCiHadfbRvYX2EM9TYKLl
         eP/g==
X-Gm-Message-State: AOAM532rMf3ekq9gS/qoMFTBGPhJQhWduKWWf3BvhkvmU/ki96zi9KGp
        8HRYFapvR/DuQ6/HDob9YClMfakZJY47IA==
X-Google-Smtp-Source: ABdhPJxk3zpteVopJnVWgatJ7STNM9pcVBLz4N/zjpt9wlJDE+mD+JUnjFZWyB7mDO9G5eyewln/GQ==
X-Received: by 2002:a17:902:d90c:b029:da:9930:9da7 with SMTP id c12-20020a170902d90cb02900da99309da7mr2988060plz.85.1610097982115;
        Fri, 08 Jan 2021 01:26:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:26:21 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 8/9] rebase -i: teach --autosquash to work with amend!
Date:   Fri,  8 Jan 2021 14:53:46 +0530
Message-Id: <20210108092345.2178-9-charvi077@gmail.com>
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
index db016717d1..4b2e71cbda 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5672,6 +5672,12 @@ static int subject2item_cmp(const void *fndata,
 
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
@@ -5730,15 +5736,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
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
 
@@ -5768,9 +5772,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
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

