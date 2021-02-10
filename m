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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A3C43381
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F96A64E2A
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBJLmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhBJLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8E8C061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so1096457pfk.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=pKFpv625zq6eybCYRXA/0fdDnbM8Be0iZrOoJTSC/e7fENP8f2rzb/LcB7DrZG/5qv
         Nwmx9ac4kPFc9+CfncZn3dR6xj0mF5NB1xdkhOmL8wCLlc3uCrhvs2sUOZrjbOxZH/j5
         vJgCVllJ5ycLqCum2ZtmMtqEAfGgvpO4/+DRCEjDudNQJA5iIma/82cwI0XbQrYm6EAB
         z6BkKclOz50yW0OuAYeqbIYb8Y7OLv/eS4BjnbvHSh8fFi1WnSLR66A5/mQXxYqpu7X9
         /mJJ5W/NUT3PHhUbrDXRiX45pdliI5v7JEMOsaio6Ni/w+KA838XJHTrUW/ofQrNvbdA
         OJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=CL74S0cRoltMHqRI0+esA6k+bQiFYsNBxhBNlYD++vByo0rcEy5+BucxLSlWkD4u+A
         ym3nzK7+djuo/6MEzERVp1WmZzxj6e1wjIQAQlQOWUutuYIR2xQAP/mXR759UCN1MdLB
         m+MRol4W5ySXWC3H85Kox0hCQ92yhvt79ZQJKUZ21J+64z3DqbPRAlPC1u0QIQ2YhcRo
         e8cBuIAs3jag5cjryXNl2qPZrTnX6ePUS06r2kuNHrwykozRsp5aYJLV1WLSg/G0vsC3
         b5Wgsl91BUX+9wc4EVBQVi2aIteH3IWUy2j3ZMBeAj+QLig8RAwAIxqlwakvr7mZmwGB
         vMBw==
X-Gm-Message-State: AOAM531DVtgKridPXcJe/eMifntMxyNpwFd4jqoefJAGfh0yHJjRBWkn
        RAH7/VrHJa2zZYIWPqBLJ7jTyVd5Zjafvg==
X-Google-Smtp-Source: ABdhPJz7HxTDEohQ5a+D7ImrK2oMwiE3HuLjx+YZ97Rn9OwD1HcpnxjemsyeHP8VVmCsINSsX+LZyg==
X-Received: by 2002:aa7:9a4c:0:b029:1db:1c54:d52d with SMTP id x12-20020aa79a4c0000b02901db1c54d52dmr2552363pfj.35.1612957077569;
        Wed, 10 Feb 2021 03:37:57 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:37:57 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 02/11] sequencer: rename a few functions
Date:   Wed, 10 Feb 2021 17:06:42 +0530
Message-Id: <20210210113650.19715-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename functions to make them more descriptive and while at it, remove
unnecessary 'inline' of the skip_fixupish() function.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f3928cf45c..abc6d5cdfd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1744,7 +1744,7 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static int check_fixup_flag(enum todo_command command, unsigned flag)
+static int is_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
 					 (flag & TODO_EDIT_FIXUP_MSG));
@@ -1873,7 +1873,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addstr(buf, body + commented_len);
 
 	/* fixup -C after squash behaves like squash */
-	if (check_fixup_flag(command, flag) && !seen_squash(opts)) {
+	if (is_fixup_flag(command, flag) && !seen_squash(opts)) {
 		/*
 		 * We're replacing the commit message so we need to
 		 * append the Signed-off-by: trailer if the user
@@ -1928,7 +1928,7 @@ static int update_squash_messages(struct repository *r,
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
-		if (check_fixup_flag(command, flag) && !seen_squash(opts))
+		if (is_fixup_flag(command, flag) && !seen_squash(opts))
 			update_squash_message_for_fixup(&buf);
 	} else {
 		struct object_id head;
@@ -1951,11 +1951,11 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, "%c ", comment_line_char);
 		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, check_fixup_flag(command, flag) ?
+		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
 			      _(skip_first_commit_msg_str) :
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
-		if (check_fixup_flag(command, flag))
+		if (is_fixup_flag(command, flag))
 			strbuf_add_commented_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
@@ -1968,7 +1968,7 @@ static int update_squash_messages(struct repository *r,
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
 
-	if (command == TODO_SQUASH || check_fixup_flag(command, flag)) {
+	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
@@ -5661,7 +5661,7 @@ static int subject2item_cmp(const void *fndata,
 
 define_commit_slab(commit_todo_item, struct todo_item *);
 
-static inline int skip_fixup_amend_squash(const char *subject, const char **p) {
+static int skip_fixupish(const char *subject, const char **p) {
 	return skip_prefix(subject, "fixup! ", p) ||
 	       skip_prefix(subject, "amend! ", p) ||
 	       skip_prefix(subject, "squash! ", p);
@@ -5725,13 +5725,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
 		unuse_commit_buffer(item->commit, commit_buffer);
-		if (skip_fixup_amend_squash(subject, &p)) {
+		if (skip_fixupish(subject, &p)) {
 			struct commit *commit2;
 
 			for (;;) {
 				while (isspace(*p))
 					p++;
-				if (!skip_fixup_amend_squash(p, &p))
+				if (!skip_fixupish(p, &p))
 					break;
 			}
 
-- 
2.29.0.rc1

