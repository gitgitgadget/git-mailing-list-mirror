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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8401C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B868B235FC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbhAHJ0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbhAHJ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:26:22 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21667C0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:25:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c13so3179675pfi.12
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+iuw58bpRNV/4LmdjqxdI+1xwKuxJqIpLxTjv0CSVa0=;
        b=VxwsW35LCKGFYC6C2aVR9Pa3mwgJ5FydZAloIOyWCtHeIWH25yKnU8HTSi3BY8iNqp
         8Y6RVLeoN2gGoOCtnInA6FeDq3aWFV5IvXhVIsG/R9plHqpThciiC2Nqt2tgNeZKpoWe
         8ss9GiTypWw11QnRuDai9VLDSUQSuk+GbwWEvqgoUKxMICMj/vmPXMApVPAhf78RVLmz
         LWEyrG5LxKCR/WQP3+3UtOOUGb0lWCqwvuwcsyChfj99rqEvPc/BO6X0RecwUyC8cu4d
         Y6+FQpj0BrRgwnzbiFivU5KkOsCcCOX/R8EKG4RDb7kU+75DrcioEY1J9Cb4V04Je0w5
         SKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+iuw58bpRNV/4LmdjqxdI+1xwKuxJqIpLxTjv0CSVa0=;
        b=XA5BgU74Qkg02qomqsFQSjuDg0GusxjQys24gZ+B7k8GCAcEROjCWOI+8nHQ9QiYlv
         xBZIrqPnZY/Qe5apOsHwzP5K+Aas6y6mR9SEzuswPQnTds1dvAxSQTo0YPjjNCHbZRZE
         iC7EotDpWhXfOD3yu/hr/agbI7TkNr+Cwyo+ygQt3YDSqtaTVZ6+luXtPuOoiMjSKp6z
         pGy2yLlwgxZ6wRGaGaLhJ1a5u1r2qwUc/wChW2mCfT3Lfo6bbQLj+to6zL5gpWM+BgjW
         dH0JgeLBPzNxbgBfcA6CDavt1peKEFVHOVa9rmoi4/sxrD7IOInZahk1XEXwJftcB77v
         aUyw==
X-Gm-Message-State: AOAM531AoNNIIpRT7IvxyqxOtcp8P4dkLHLopOOOH851eLVDTXGvzKyD
        jLX5PpPHp3w2Yzewvlr0BT6CSVAl7BAhQw==
X-Google-Smtp-Source: ABdhPJyZIM1ozs7uEeVYYRkoR9kq7UgryWLoAwijAjBvhqkfwSvuIvTQ+/iJQNAM+wWZILgBvQJO/Q==
X-Received: by 2002:a63:f44f:: with SMTP id p15mr6250997pgk.141.1610097941583;
        Fri, 08 Jan 2021 01:25:41 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:25:41 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de, Charvi Mendiratta <charvi077@gmail.com>
Subject: [RFC PATCH 2/9] sequencer: factor out code to append squash message
Date:   Fri,  8 Jan 2021 14:53:40 +0530
Message-Id: <20210108092345.2178-3-charvi077@gmail.com>
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
index f888a7ed3b..5062976d10 100644
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
@@ -1782,12 +1793,7 @@ static int update_squash_messages(struct repository *r,
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

