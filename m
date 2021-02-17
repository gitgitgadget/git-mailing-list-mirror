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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDBC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DB464E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBQHjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhBQHiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:38:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84EC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o7so7972456pgl.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=oSoWkTSb3B7WED5sEJ4VCgIP1G0BIdsO/owH3ll5dVoNBYzss1ehg94+gKgPY8WTw+
         W3Gzu9L4dyaCRDxx2fqeW/Ds5AtXsDWHbOD26MujTmtPXTC3Xw1lUbgXQ6iqqMrp6iHU
         vV7dIo8sqWUP1VGR6inZUXzdIPnlCXsw8uuEEcy3zDp0vkqR+TwYTC0ZNQYN0rX4Cj5w
         8mZSsO/GK7aXpzxbpgP/AJsJ9N5gRO27oU+hFtzCOdRThS1uKvn+Ozx90tq3uBoyWEO3
         4x7VsjnopkzdMVw6WLHBH7ESeki4kNU8CUH3rTUk9f5L7WAQWpC4DDuSLXJ8KeuYi0bd
         qktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=CdEehBNHQKMftXtTlMEfvcS8VhRl5uau9Vn22vpqA8+bFqMeVWWSbQRAB09MBsk9vF
         npnWby3FzTbgQ6Q9ZKHdDLv4CLz8kWlXZTOE7kCDe04bpPvABBLk94c109JOUgVtidpg
         DQBypxGJZyOq3cibvUGpAT0kM6OXRAN110DbWLXI48O9CRw0R7uVbzYdBPPQWmQnLXV5
         aAaA4jYrbz+9AwjKFS7TWJKFYzsYt5wLaPi8hOEk7fPF/T5zbfX8oF/hFweylVCUf+Xv
         g8olj4ASgsN0oJfEvQlc1NhvhQS06Uw7Sz+Qe1fxLmxfljdVZWoeQQmpnp8fNFRvjfLg
         9hQA==
X-Gm-Message-State: AOAM532d3Cyc3SGWX+KzKtiZS2gptt1N8gRK56008ytWReYM3z49imre
        vF8s3u9dzRZ06eKJ97djZJkY33N66zJETA==
X-Google-Smtp-Source: ABdhPJzmyxL4dLn986Bgi6FSU2HsChbmvW47YGhSTXJ7SIDyaPfTLbB0thT64cFXjmxUodQG95W+hg==
X-Received: by 2002:a63:4662:: with SMTP id v34mr14696042pgk.197.1613547493237;
        Tue, 16 Feb 2021 23:38:13 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:38:12 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/6] sequencer: export subject_length()
Date:   Wed, 17 Feb 2021 13:07:20 +0530
Message-Id: <20210217073725.16656-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
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

