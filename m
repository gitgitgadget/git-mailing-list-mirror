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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232EFC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE70064F6D
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhBDTIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbhBDTG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B9C06178B
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so2373321pjj.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=atoDgMo1NlC5ButhDWWDRfByAcbcXC771zKISW14XpuET+8BiHV3cGmxAy/LqQXVlS
         gcqsjP/E/yUjGltkMSlHhZiPwjW+KLnKg4fPzkRehpca2VP8XGjZmj1MGLbe6aKc8EpN
         z9EbNtPwxCtJPp/gLfUiCos/E1NQvzbPelSxgMgaQQubMWAbH82TfeSTL/3kT+pmSRDr
         ckxT6WJqYNhFiBFiE4a/lBxV3VJ4TGqpmY1wEkok6Gj+6Ps7sOVGWexB5enbitehgeNy
         G7ENWAfDxV3VrMHK3koGNQ1LaHRsTCsetehmC+xCjy05KmFeVV0cEVT7gXN6cffxRdMt
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=XPqFWMoNXYysdGbZpkU1Dhx1PvofOBQsIdjvdZiq+fhakXu96lzlj6F8SJu3e/Fm9E
         AoSZZqJZv2J69qE/O9dG5DRXomRgWB3uNO9C4eJvO0cvRo6/ePHCVaqIoufNNyFgRnvn
         vybsMtfABRQqvVwtuOjfohvYKfWl9xyecLKCMItoHXQcvfEW4qguV2H1U0OC3A9+FD5E
         40XysV6hF3PzGLqUC81M/YAeQdkSno3cZ/5nOc09PGVzKdQ4lqxGD3JtP3ya3BWzuJ24
         xEJWfHx3tbh5YFLezSevWwliYWFLNtyW+38HZktmuKN75kJuj+gY3xvznP+ycqFxswKk
         Llag==
X-Gm-Message-State: AOAM5325LXUmQ/sF1nZ0Gu9R24Dd/mXE9EJ0f+bojZWHnbhiv4Qqq41b
        gw9SQXVHiowZmIhsmMUfMsUYEKQ9dYZ29g==
X-Google-Smtp-Source: ABdhPJxr6Nf60TsliSNY6LxyNF06qydIJ6D7lbowhEO1/UmhlpZkf067GwHcKULDTv6TvH1CGs1GmQ==
X-Received: by 2002:a17:902:ed83:b029:de:84d2:9ce9 with SMTP id e3-20020a170902ed83b02900de84d29ce9mr536251plj.2.1612465575425;
        Thu, 04 Feb 2021 11:06:15 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:06:15 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 5/8] sequencer: use const variable for commit message comments
Date:   Fri,  5 Feb 2021 00:35:04 +0530
Message-Id: <20210204190507.26487-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use and reuse the comments.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 09cbb17f87..6d9a10afcf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1732,6 +1732,11 @@ static size_t subject_length(const char *body)
 	return p - body;
 }
 
+static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
+static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
+static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
@@ -1741,7 +1746,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
 		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
-	strbuf_addf(buf, _("This is the commit message #%d:"),
+	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
@@ -1770,7 +1775,7 @@ static int update_squash_messages(struct repository *r,
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header, _("This is a combination of %d commits."),
+		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
@@ -1794,9 +1799,9 @@ static int update_squash_messages(struct repository *r,
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
+		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _("This is the 1st commit message:"));
+		strbuf_addstr(&buf, _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
@@ -1812,7 +1817,7 @@ static int update_squash_messages(struct repository *r,
 		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
+		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
-- 
2.29.0.rc1

