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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F6C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F402D22D50
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAXRG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbhAXRG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:06:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC9C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cq1so6855193pjb.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=cmFZwvsGWKeLU3WEsrm+YyeT6TSkRvK462oJztaL5hyUGUfJ/KuNOEofYkf+VZgtcC
         vK6yBQ+zLnhu7EBMNlBGgohlkxe63LyfDiUy+ubWJMS3d9M2xNj2oFo+3H10mjuX5cxI
         om9Jw0FJSO3RfQ8S7kTb1eYfv0VPEVDUrUKzwD/dFCR5ZuwLnzerGvygqYATvZiXy8TT
         xJZM1upsVK1iC/RYec7KufVP1KeqxKT0lvQvTAIwh5tWkxyxdAX6D/Loy0mke7ufkBOo
         ENA0S3IVoM+7xtRoUQ97toloAAvIAao4pxIh05QsMOtsnOFMZkugLDIFr74PRVFCOpVT
         peUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=ZZ/4Yo6UWoRViWE2mZRmfrxJuX5028jjDxTghLGISQqfGOykFrvwWFj8uLvAUlkTPy
         KXIuvL/H5svRYXOjgVdUrnPvbYPIqjv3pYqAyvbHuooLmpow5LPrCVH6MtrhpQcOEOax
         ipIKS97MuZWvF3WrDxBJZCc+y2L5NTTgwc0ahOUJfjoTF6nd+bEgpJgM73khOMsjO9u2
         GmgTcSH2mxwtCWyS6p+zAtXg5ertKz1NNxjGpbIJ+XcTa061OOn3psJjkOQ+GsVzombT
         M9VIQ4VQy5LcbXrTEHeZFUiY87uE45ykNGxywJj8Y+y4iVzavE20MG2ps5rqH1vTC9yq
         sp8w==
X-Gm-Message-State: AOAM533WojUkXpGhr4vDV1T5w4KDVE5cbgbS9TwN4C8O/cFiB/+/bOSh
        Tyt+S06v+OBdsGshZH8XOSf5SFmUBT5vnA==
X-Google-Smtp-Source: ABdhPJyO3fQTjtG8R3pzaVnriRr+uxhNOx6Gvkjx8rwkWDhQVLXC+olu/WvNVSwbc1FtIP8SlJ+rqQ==
X-Received: by 2002:a17:902:ecca:b029:de:b5bc:c852 with SMTP id a10-20020a170902eccab02900deb5bcc852mr15232806plh.59.1611507973801;
        Sun, 24 Jan 2021 09:06:13 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:06:13 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 2/9] sequencer: factor out code to append squash message
Date:   Sun, 24 Jan 2021 22:34:00 +0530
Message-Id: <20210124170405.30583-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
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

