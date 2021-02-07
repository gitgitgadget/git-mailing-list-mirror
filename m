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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E747C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0816D64E31
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBGSTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:19:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F8C061786
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:19:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gb24so509145pjb.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=AXUW+A8UpZcVTiDWi3uyJCKK4R0xckU3O2lIOtkrbovAf6IFahP73xdX6AQ86UKqIz
         DtskiabNbci7dHB0JpUbYQu0p3ezNdaFwJqOMZ6mn8funvKEn65f5KSQh1GCZRSy6WTs
         +SMCw9PcLrIL7JgIqe9fn8d3gSLTCyBrLv6k7+2F+RW3icklRw4rwJMn/XgVjKM7grGe
         Mic+OUUjcUoD+8IBQWHKNIrhu1juBLRZJzDwTA9e0P3RG5/gksXn7JeO1hj0bunH3kAU
         bvsGxY+X9wu1bFs2/lW4+DOu8I1m2QzQYgXvGjHioIQ+FZ8BvxBommIjoHx4AoQweri7
         F4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lC4QR429u0+7ZPSy8kdmBfdRM5ddttlVJKfi+xAtjSA=;
        b=OSJNQPYGj6RGXGPbE5ZQFTNaCD8tSfywsCFYOv0FuXpbLDIRqEvCECgmYMtRSHO9vx
         t/HQJKLel43Zk16nHG6iXUN0Dx4zpQWnqfTp59vQlJ+Rxb5J92mK5eUp38vR5scpaM23
         GbyrWI5Dnp5N8jOpmYl69OSS12Kbd5sWhXkJsA7vK8U/n3FZLElpTde+lf47AcGpU6bs
         5uYISCzqR2OtRpuQCwKbPgtOAUN7Op9XykLN5rmSSa0KyrLti6phMIzo3d6mJWMNRyl0
         OWOTU27su1opt9THO75POPcKCPrJeOckuGOAP5vkWJ/TCzdryJxE5py9koFVKXofmkIG
         if+g==
X-Gm-Message-State: AOAM532mKg/MiuSJeHoXkNeZQj5LWWZe1KgAc9BeRviBVL3dvn4a4sWS
        G9ADDHD3dPiK0e5KOl9UDoMDAvKkVw7dBg==
X-Google-Smtp-Source: ABdhPJzDeyIYXhrIHW8ATqApokLjAZWVd1ZtzjE/xYPByDPoXq0oDZSLvgoG3t6CrfvjnqShVUxB4g==
X-Received: by 2002:a17:902:a60b:b029:df:ec2e:6a1d with SMTP id u11-20020a170902a60bb02900dfec2e6a1dmr13187752plq.27.1612721940942;
        Sun, 07 Feb 2021 10:19:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:19:00 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/7] sequencer: rename a few functions
Date:   Sun,  7 Feb 2021 23:44:35 +0530
Message-Id: <20210207181439.1178-3-charvi077@gmail.com>
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

