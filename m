Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE8C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E2B23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLHAF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1DC061285
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:16 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so6388051otq.6
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cEQOsB+BOx66j/LFEO/fQE8ubCTEUkji902LrnsMttQ=;
        b=qSES9HD9RzK4mzjrkCAUnKWqIS/FIGknKUJ3lYjXS4myejNY8+mgeCfKsLCiSp+73M
         c7Y2gRR0CZSeeyTm4sl+3+yTN7vKV8EKnaKyQebHo+gPOxUm4f/uZBH5vdYFC3uoeepF
         Vaw6c6EcVeSEvZ3Y4k2ES4u7cnFyPUDHQoUoj4mSkb/XkjwflN0XFnWkPqPKzTPyDR0e
         8zFRtY7ec+nMn38U83NfWGAlkzWO/GDEeQoUjLgk18sC3PlA0JefreLgK+i3Wf9iOLMf
         D6w9uG3bBipjBoMPdGiyQErrRoUoqobnwYeZy9ddZNoDUfAoShJbUasyQFQg2FEbhrx3
         GVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cEQOsB+BOx66j/LFEO/fQE8ubCTEUkji902LrnsMttQ=;
        b=hDfMNwbFWnnFhqefcH4haUiYK3Wic1YXlhcd6gdTvc4pBg1dwHt0WYlbVI1F93wugb
         bzl9Yum4BkyqvT/eVhg4dYv1OmZMgDZRplcHOX8or2EsgQ93vYIIKguU5bn3hCQXigeR
         DtJenik1Usio1lhVurUP9qozK+QOWlXK4cdKxb0FVOWOU0lu67hOHRyQqyGn+b7s7dFR
         Bv2FXbQCDrJ7S1iWJi53F6qurNas8wm4cagr9I9rgJtlm6IY9ihYA2zDVbsjGgoz8a7C
         M4WQjf+RETqhwax2b/tQm/5qvn0RaOvZdIJV8LPo565I/19uj2USYBPBqK/ZQYr4S7J+
         eFDw==
X-Gm-Message-State: AOAM5329bj+JUsFr2iIE3ZeuG7nFJtz7HyCJjcaIrYh9mW2dL8L0X73E
        3IxWW5dWbECsyN0HBz6vpx8MbYvf34Ye2GKN
X-Google-Smtp-Source: ABdhPJybsOJreDMrywXl9d/HCPIe0mjnCcT6Ss94HOSWOG7Lgec7Jtek4DkaczB0/nd8DcVU4OShdQ==
X-Received: by 2002:a05:6830:1e0b:: with SMTP id s11mr15274457otr.352.1607385916063;
        Mon, 07 Dec 2020 16:05:16 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k5sm2960731oot.30.2020.12.07.16.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:15 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 14/24] commit: implement commit_list_contains()
Message-ID: <72e745fed8e357e8af6725ab8a0929752c0d2593.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
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
2.29.2.533.g07db1f5344

