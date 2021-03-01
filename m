Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EBC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415BF64E04
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhCAItA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbhCAIrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:47:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DEAC0617AA
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so9417664plh.3
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=K/tEHUAC0MQhidsRpAv9ihCjpRXGg18TNCLQG7yeMcLX+G5W+0s38HmX/qlHGICiI4
         OglpLldNM1jSOiIlAU5Dff4gv4aEHNaCWBwB2TaRdzEw1avUDXXCGiYWCYAz5glOqOzk
         ntEkSSz6xFW0tl7rkoRccicGujN/hb6imYdOwXbxb/Am4ozB1+xYMrSjDPL9w21hGLUC
         CxCrs09E/eFwf1bF5+O4BzpWGR5y9onfvde2v0AEXKSN+PT5Xz8vl0VfYum5T1ol6K2P
         Wed0FFbi9c8u11BFPUdqLrePYl4HIdxU7ln6AqPSea2yxu8nLL/5WotHtqPOZ5vhvnl0
         HvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=XBEqabcMiDuKacGgCFRzUGdcx+5fzb7w7WpTNM2htRp3EgOeG6hOyTQm8rjM+P0nFV
         tNAbLgnllumFDuXsPAZ50bAS0uHU3oLPvEZKVFJzCpd+bSHxVQ7RWtmPJ0AzGNNIKhML
         S0z7xfkvbLjZdaYG1fYqYQP3yY4wm5bq/UhU6VMFGxb1+m2B9dI/iyc2dOim7AGq2skF
         DfBsa/qqNNzM568cwsMax96l6mxw84GN3Ne8wNpsNAs+LrIVvA7DhnOY6+0oyc5+ZoB4
         PHR8iFddAl++1gFvIgymq7Hma9nWGpBGtxJfIqITQ7F3LDGQH7KdUaxhWT0LR2UEaJXz
         cCLg==
X-Gm-Message-State: AOAM532M1pCIq+x0xdnRBzR6m+N9uDVANjlLEFJs1I3IQ/Qk00Vxa3Ai
        KpiPkd1+sM79jB47W2IigedC01g9UBQDug==
X-Google-Smtp-Source: ABdhPJx7K1mav7ol7OdZg+mwzeh4nXu89VWa5mNcyWcytIRUIbcahyLhpIvTyEuWfTnYsLCeMR8RbQ==
X-Received: by 2002:a17:90a:8b02:: with SMTP id y2mr16412203pjn.111.1614588391647;
        Mon, 01 Mar 2021 00:46:31 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:31 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/6] sequencer: export subject_length()
Date:   Mon,  1 Mar 2021 14:15:09 +0530
Message-Id: <20210301084512.27170-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can be used in other parts of git. Let's move the
function to commit.c.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 commit.c    | 14 ++++++++++++++
 commit.h    |  3 +++
 sequencer.c | 14 --------------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index bab8d5ab07..41cc72c4de 100644
--- a/commit.c
+++ b/commit.c
@@ -535,6 +535,20 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 	return eol - p;
 }
 
+size_t subject_length(const char *body)
+{
+	const char *p = body;
+	while (*p) {
+		const char *next = skip_blank_lines(p);
+		if (next != p)
+			break;
+		p = strchrnul(p, '\n');
+		if (*p)
+			p++;
+	}
+	return p - body;
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index f4e7b0158e..12ff6bc641 100644
--- a/commit.h
+++ b/commit.h
@@ -165,6 +165,9 @@ const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
 
+/* Return length of the commit subject from commit log message. */
+size_t subject_length(const char *body);
+
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
 int commit_list_contains(struct commit *item,
diff --git a/sequencer.c b/sequencer.c
index abc6d5cdfd..3fac4ba62f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1724,20 +1724,6 @@ enum todo_item_flags {
 	TODO_EDIT_FIXUP_MSG    = (1 << 2),
 };
 
-static size_t subject_length(const char *body)
-{
-	const char *p = body;
-	while (*p) {
-		const char *next = skip_blank_lines(p);
-		if (next != p)
-			break;
-		p = strchrnul(p, '\n');
-		if (*p)
-			p++;
-	}
-	return p - body;
-}
-
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
 static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
-- 
2.29.0.rc1

