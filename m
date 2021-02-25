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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8712C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2A64F0C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhBYKQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhBYKO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:14:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF1C061797
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:13:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b8so114410plh.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=hKbmDRqwFe+tzdjkVUVr5g5KYj+gEmtPg6a8cNewzhLk8ccRgQLB9cbuIEmSibZIDF
         gItzMy8sPY/akPJ3quhv5p3h2mIQ+5FHHJ9etsL0mQgX6Sf5JqJIvSZmFzKiIz3cIfeY
         KAMbt6bNLPHHM8rhH7iIG+kOAUTVzqPeE5Uvf111bvO5sVU4xN3iKkyCnLwJSWeLiU/I
         1mu1MpEOvG42ZA6q2k1QNYWRHJSRABHtCpR63mIid4rBvvr0tgBpB0izpRjoTxvd5Tb3
         su9X5arifpAoelye4eSw/eMYrpsk5G0Uja4/0CU14HxcMHPbo51AypmQJSbmx/Mi49oq
         rvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj8J54VPnUWrGYLdXGgLgaNBhpU1h+x2dO0LH2yGcuM=;
        b=J5FFFAIhlG+uby4HBRzP2f931kwlQN5BzWdmsRqRWmPnvDPweci0+yOGYNy//MLSx8
         lnxcjZXlsWhouW0g9RRS4RDKZ6QeHnvHZxSmdHPIqqxvCLmzuqkh6kFAoSC8+4sDRTGv
         dzzoTqpbmBlTcAvqxNOlFQ+072POYPSXbDHI8JnRaMlv5h6vfaMKhTiyBr3lfH3PPGeQ
         BIik/h87+pvrw1WXQyYrY/CvEYRrtqhhTaDLkaQUt1+PjJQIdyIFZ+y0Nj4GSTwX9g2+
         VuWFB/vPbTI4ckn1Fyw2fzPGn2WXc22/GhHGeB2mZol0Ozn/2MLhwJwcwtC8MZPo0YsN
         8ybQ==
X-Gm-Message-State: AOAM530EE22jGUUvGUFjI/1NsGpZuzwJYGsUVzgUjou4pupdKozGoFTi
        B2LhuGLd9zTcEANBzGq5QuV/RRrGoHY3Jg==
X-Google-Smtp-Source: ABdhPJxpbyqKiLKR3YQysF4G0SAwPFtZvl5gyIdWvYJUg2L6NdFIW/lwb43tPkewDV++m79THLmoGQ==
X-Received: by 2002:a17:90a:3f10:: with SMTP id l16mr2507024pjc.131.1614247988915;
        Thu, 25 Feb 2021 02:13:08 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:13:08 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/6] sequencer: export subject_length()
Date:   Thu, 25 Feb 2021 15:38:54 +0530
Message-Id: <20210225100855.25530-2-charvi077@gmail.com>
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

