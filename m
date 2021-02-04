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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F1C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C64A64F5E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbhBDTH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbhBDTGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C4C061788
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:05:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so2240703plg.13
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=O3TXXPqr/zkrOUNjQARBZo1pkywe83PxUSbUTrZxg2HvRoOpQak2IVRGtEDHsoC17o
         d9JqOl3AG+BRRRUt3AqOywDJzOuZ8EBQlYYHuLcEuhj8aZ9uiNsxizBP2Q8xkxNehsp8
         RGF4ev0P9x5XXWDXw0WxY5IUc5OXQRYzHEZ4HWF0Lwu0ULBe+Nn7zvohhweEld9o1qsC
         uix6dr2DrsHuxVoY+CIwouJo1972pv/lzZqVVprMM8Yyos85Vm7PuioDT/Bbtvc7YThB
         gngNliPQgw1dNBJTLGqwGhaprj/ywTfE6yQffVfnIqsvmonck16WOjybOs91uWLDVhHF
         5JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wq7AT0GeWUiw6/y3jlwDs7feIY/g4Gw8ax680CWXrw4=;
        b=OksUPBDqvJ8Yk2hSNIXQcFCdWtLVLigXXFHIHipJkXtDpM/ZU3ONDRDXLJIdGkiMH8
         ugB9Q8UL8INt7ZqCy26bq61sOKpocYS3QaNYdCfQB8vKBntwSFhXZIi7cU3OmrONMEzD
         gxWzT+Bqri0jBdiUsxNShShwNRxBEY3Qi58KNuNkwtAalfOYyXdbk1b7HtEi/HTZ2vNs
         vfw2UqrCLaQigkgzqR8z+5hIdIaqe8/8MPdOfa0cUfpcx6KXk0fCcltVvlAl0gwcbldE
         x4Pyqh0qBvoen1V5NlJoMmfF3jhgy7/njN8TmxA4rkhI0PND4Hohpt0H28CH/HdrNjgf
         EZvQ==
X-Gm-Message-State: AOAM532jeXf6SfmvNTSL9+dNWsR6jLJYycTE3fcGwKbcLNeUyPzwFdiJ
        LXAKgwT8xdmqVPQGHrTSRuV+0ACh3tsImQ==
X-Google-Smtp-Source: ABdhPJyG5nA8AWV8ENxUuBnc8cVXx5pCwavCuys2oUhu/ZygWI0cde6IvxpxBg8lp8QyN26DgndY0w==
X-Received: by 2002:a17:90a:170f:: with SMTP id z15mr389909pjd.63.1612465552425;
        Thu, 04 Feb 2021 11:05:52 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:05:52 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 2/8] sequencer: factor out code to append squash message
Date:   Fri,  5 Feb 2021 00:35:01 +0530
Message-Id: <20210204190507.26487-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
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

