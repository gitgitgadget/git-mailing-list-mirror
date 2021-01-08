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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C4C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6FE233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbhAHJ0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbhAHJ0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:26:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E1C0612FA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:26:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lj6so3340763pjb.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVX6eJ3wxIokxH7wit+ZYj6rChgUicxUxJe7J+MG3Ag=;
        b=CfaUFUg10BQ2aeub8dYQ355hfpOT2vu/XXIsH4vj3483qeZNiMIdcHV09cP8e4Vjx/
         vPrKDICwsfAsHHA0paYGnShRKW+3xq8iOGrJMzU8v5MaqQga79wwB83NX0I6HRuy+PQz
         SR6M4pugRmZy6+arHOdCTx1gCe7uTqYJHcIdMQa/z76/lq+Q4EXcSxULFJ3o1G6GLm68
         i6T+AC+DQCS/Q5FFCMXCUAa35hF39LNmXOEE+T/MGGCvDHl+GztT4D6TzHX4ilcV6Ped
         Q/DglwMEQYri+nd6Y9K9iLzC+iKcuRl/bsCZ7tj6YNIWNENbXvXtssIlU4p4Knm067tH
         6qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVX6eJ3wxIokxH7wit+ZYj6rChgUicxUxJe7J+MG3Ag=;
        b=tMjK7N6UFJbElZPSJh8kTMXRY28wEQWeQVNVFHHeixG8hy9wz4osVvwQYzX/07xVwh
         gi034HVSQb5b9jImcjDoxHkLy+hoXdviJg8NjxlmPkGpAwueV0OFVVJkajrqSou5ykqr
         vMk5U+IEbkoOnYRSuGcg4Nby1DIW2KgbCMP5KhNra1A9RUKeSSOhetQl5zpX8JkTu1HG
         TIv/8DtI4AQLJ/U+RFTQ3QTWNTpUDLnthTfJM5pncL6o3ilBNZIySw7cUIdLLF6SSXCX
         T+zY6tSvR0QAjEWRn/Ao6G2q9a8hD9OLbQA6CQliEZnfc/h7ggr1/mzhgetD7YSnZGv2
         DF3g==
X-Gm-Message-State: AOAM5310AIz5qBp1VwEmbEo/ihW1DMRNQ1q8PT3VKqe7w2l8jnN12pS/
        iBGfbQ3WNJzTAjmOOIR3bAIWMl648GT6ew==
X-Google-Smtp-Source: ABdhPJwmb0Yd12KhPwlkz3i8gjvbeFkrtThqm/anYto0CFvq5DL36kM/kycT/fsQoaB6B1SxFpi+6A==
X-Received: by 2002:a17:90b:228e:: with SMTP id kx14mr2939620pjb.210.1610097963427;
        Fri, 08 Jan 2021 01:26:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:26:02 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 5/9] sequencer: use const variable for commit message comments
Date:   Fri,  8 Jan 2021 14:53:43 +0530
Message-Id: <20210108092345.2178-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use and reuse the comments.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cdafc2e0e8..b9295b5a02 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1736,6 +1736,15 @@ static size_t subject_length(const char *body)
 	return blank_line ? len : i;
 }
 
+static const char first_commit_msg_str[] =
+N_("This is the 1st commit message:");
+static const char nth_commit_msg_fmt[] =
+N_("This is the commit message #%d:");
+static const char skip_nth_commit_msg_fmt[] =
+N_("The commit message #%d will be skipped:");
+static const char combined_commit_msg_str[] =
+N_("This is a combination of %d commits.");
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
@@ -1745,7 +1754,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
 		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
-	strbuf_addf(buf, _("This is the commit message #%d:"),
+	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
@@ -1774,7 +1783,7 @@ static int update_squash_messages(struct repository *r,
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header, _("This is a combination of %d commits."),
+		strbuf_addf(&header, _(combined_commit_msg_str),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
@@ -1801,9 +1810,9 @@ static int update_squash_messages(struct repository *r,
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
+		strbuf_addf(&buf, _(combined_commit_msg_str), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _("This is the 1st commit message:"));
+		strbuf_addstr(&buf, _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
@@ -1819,7 +1828,7 @@ static int update_squash_messages(struct repository *r,
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

