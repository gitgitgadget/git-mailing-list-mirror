Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1CC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8972463D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="f0PqAHvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgKQVrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKQVrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE7C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 11so22360991qkd.5
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=20LuDZ0/tqk6rFM5lLPtdr8IqDUAgw2aiaqSEtSZ7UU=;
        b=f0PqAHvFclJlaJvdFXmVXwhZxWUNCyYehhFcMrPxdJitoeC+9y4JMiedPDKfiq4uLc
         a2Sn7iqJolN6zqY0jT5ZIOWkxmUI31MOmVDJ1yMVZeQajvWZ95RzD3B7Q3gkokq+niK1
         PksuMeHot6QBgYQ9SpJJ1RPsJvlpO/R1KdqNxkXN8A/+DiY4H9NHFOwb6rC7ANmVW6DA
         ydiEQMjGUQ/NcTf+VQSc3OFH+ozh5rwPPUcdDCSYf2XeUSU7TWkIcrzSxkRFxQZjuvT4
         tCSqTQSpPwponXmC4nFjm9oQ+lF+Sc23nEEp58/uDOYPx9Mym/b1qwwZ4QyMm9i9Ghsa
         hiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=20LuDZ0/tqk6rFM5lLPtdr8IqDUAgw2aiaqSEtSZ7UU=;
        b=fS54NS6weIMX/EnCQHUD0wKSbKItQ9HcCVud+KCEwF6E0r0itFLvSmDEMqEVAtXjHK
         XN4cNs2N1tk3qgdVsxfbUL/hqJk2uqmmHfn2yIc5dD2TGFUOaSj9Qfy7/bvdL6n/zp3P
         Me1KnDETsVkTP0ENVNO4fuAlpQei9ZPwLqpyRYkieLgP8Eujn+OMRqEbU6CnvTS3roop
         TN9fCtZuyWD3ouUsLmCeliGFH9hHinMHhimf8NAy3s75rfXV7FFgJ0E9Ws+vxpiIa44N
         bSDN271rhCwl0J/gZKC4m9nMwzdue9i80m5LthljNbhFYkTnn5GhZ8ePXSb38kE7U+Dh
         0uxQ==
X-Gm-Message-State: AOAM532i51JFcvvPVulQj9LqhLidl1v0VemVH2fPO2fbUm6twP1vB8bA
        Hd3Jp96UQfqOkmdCKMZfa3Db8rWt7ZwsIpYl
X-Google-Smtp-Source: ABdhPJxziwp1PFRfGJYRicyTqGwN3ir8uqgJ3PAks8Tw9kZmVyAzrXck7JTufDslznGUYqmElPBqsA==
X-Received: by 2002:ae9:e007:: with SMTP id m7mr1745542qkk.416.1605649657210;
        Tue, 17 Nov 2020 13:47:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id k8sm10647363qki.55.2020.11.17.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:36 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 14/24] commit: implement commit_list_contains()
Message-ID: <63e846f4e8841edeecccb46efa1645293f7452a8.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It can be helpful to check if a commit_list contains a commit. Use
pointer equality, assuming lookup_commit() was used.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 11 +++++++++++
 commit.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index fe1fa3dc41..9a785bf906 100644
--- a/commit.c
+++ b/commit.c
@@ -544,6 +544,17 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+int commit_list_contains(struct commit *item, struct commit_list *list)
+{
+	while (list) {
+		if (list->item == item)
+			return 1;
+		list = list->next;
+	}
+
+	return 0;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 5467786c7b..742a6de460 100644
--- a/commit.h
+++ b/commit.h
@@ -167,6 +167,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+int commit_list_contains(struct commit *item,
+			 struct commit_list *list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
-- 
2.29.2.312.gabc4d358d8

