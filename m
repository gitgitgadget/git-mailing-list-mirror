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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFDC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5372B2312D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbhASHp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbhASHoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:44:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37066C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so10009111plr.7
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=APmVMt1zv5hZVjlOfdJYZGGKCsCyLfjRXD+2GkcH2TmuLYOO55KS+twyKLGj+cIMls
         E4eoRlj97wDWfkN7AuieO2l4R82vtUzGxk/icb2LTfsuIootzMAY5OTZDns+YRZcaLaw
         cMJLVfwzT2AV87yl9BdiRi66EgXgIJXjM6xCSlfvAjH1Jt7xUX3Hx00blGvPrK+L8FcN
         AlNwAKdCjFSGkZ9R1NXgxeCJyLZaq/ASjSsuH/6dGcZ2d1wodv1Hg9ADROTVwp1hwE0H
         itD3ZPPPKpHhUbnEj+Y46gXqhCAkdakD46UxwDAV4F9d/VvZtXjDijWau/7QsHN1jLe7
         7Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=RR245sdNBU+lnOecAatCJQuC00wRia0QPra/E6Iauyit6gN3CMGpL6FQwTjAqNAD3W
         SMmvs9olNLKF+B2oLWx/wX0SMIDOAeCcUpjB4hBwKEqxuOYQvE36bnx9aZV7fUtSv7rB
         4F2Qgul4BEgEqJLisfhzrGo8EHDeEO56JLp8TKRYixl5vD2amTlm+syAuEKQLoKs17TV
         SZbB506VUl8Lva65Amopg/OiX0RIZWEiVkLCMdR65VCBwSKchr2E9ay6cvU8hlo7HAlN
         7tzWB1Jr/4Glz59yyC/8fnCDdSnX4eHMtMnn0nyVdBz96C8Z2w00Hn3Jt48PNCf7hIDn
         qA2w==
X-Gm-Message-State: AOAM531oLtQ3rAve8pz8Mp5ckzZfUOjrnzGhhvQIaJo6ltDvvArFD9po
        05SrVOJjWodPR0TmME77ytyeeYzak3zu1A==
X-Google-Smtp-Source: ABdhPJxhq7C1D8+T4diUXQuEM19FAafphTne/FT9EAwNAifYVpK9tU2tO/kfWXRzQofy7eXqQV616g==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr3857528pjv.7.1611042240669;
        Mon, 18 Jan 2021 23:44:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:00 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 2/9] sequencer: factor out code to append squash message
Date:   Tue, 19 Jan 2021 13:10:57 +0530
Message-Id: <20210119074102.21598-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is going to grow over the next two commits so move it to
its own function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a59e0c84af..08cce40834 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,6 +1718,17 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+static void append_squash_message(struct strbuf *buf, const char *body,
+				  struct replay_opts *opts)
+{
+	unlink(rebase_path_fixup_msg());
+	strbuf_addf(buf, "\n%c ", comment_line_char);
+	strbuf_addf(buf, _("This is the commit message #%d:"),
+		    ++opts->current_fixup_count + 1);
+	strbuf_addstr(buf, "\n\n");
+	strbuf_addstr(buf, body);
+}
+
 static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
@@ -1779,12 +1790,7 @@ static int update_squash_messages(struct repository *r,
 	find_commit_subject(message, &body);
 
 	if (command == TODO_SQUASH) {
-		unlink(rebase_path_fixup_msg());
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is the commit message #%d:"),
-			    ++opts->current_fixup_count + 1);
-		strbuf_addstr(&buf, "\n\n");
-		strbuf_addstr(&buf, body);
+		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-- 
2.29.0.rc1

