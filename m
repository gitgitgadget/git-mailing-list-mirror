Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64FF1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeHIAju (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:39:50 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:48775 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:39:50 -0400
Received: by mail-ua0-f201.google.com with SMTP id k17-v6so2985573uao.15
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pA/h4+tsA1nCRyXyWtsZLW62DnrQDdUPF9IKPkL4CXQ=;
        b=YdAA0PUFqz9tJZcFbr9GTrDtFBR1OGc6owUXcw7QtdVsY0TfkHksiYCY/a/ckiw2o8
         uxPnSkZfSV5gYeBF4bFUgVGhCv8/K1OIl3NVHKBWeQGDeMvwmzMSXGzJNoYyHMNTgdJQ
         tcW8sBLg6ztzWILzyULjLlXHIja9Y+wf8utGJ54Ooes/wzAtcq5rgPc2ohf4IdIqKxux
         YOqYlRmFEeKOU0f9mqV+cbsZe+HPXzzu03Ze/F3m0U421POXN6NTCbEFY4yKmk6hiN3I
         jSyAFrvwQlYWaw+tuZKFyqWgYf5eAQASDaREHlZ5//EMYLscfEgKNkNkTtO/SKJbJMKu
         CIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pA/h4+tsA1nCRyXyWtsZLW62DnrQDdUPF9IKPkL4CXQ=;
        b=fqbx4mRzh9Gkx3kr5QKjeo6D1jVQRdV36wFlt/lJX9/2s+jB+iI7V1l5785N9yMIGQ
         GFAOvMWCJ71VCn23O+z0Ep6E+3IoHyDAuNmnNuAJ6hPrPRbFelcjjR28P4Y2xoYO9omE
         lff3cXPAwJBIWrPaSGgsJJ0UBjtAxzVgwvymppMcSEaSax/hr5rocBgltXTZfI7v+tjU
         74gyqutbzgqoWYTJrG5LeSVVTBGS5z2EKzsnWFuMRydcpRnOnPyu4wq/c3HAzsTIDfIG
         SKKc14KZL+j4I4GCTlhKG4GPBw4LKd/xgFqAWVRqeUFV7bHF6oJtQi+RkugzFhQht4jF
         lgMA==
X-Gm-Message-State: AOUpUlG18LCbjeuGFbiTNob8S/3n9i2/2OGojuplxEPm18eZs41BySFd
        O/4JNKjeYbT3wwq5egTdH+6ms9SfuX8cm+QAE+cxZ62c/YxRyOCLtd5Y11KGEtUmTKxKHwGUKKy
        oLvCqsupIO/g90n6UXoIxrfAerRjWOpDdRzzDLARpDoLOUuBHWi/C1sWQcKEK
X-Google-Smtp-Source: AA+uWPwLNI63l8MZ27c+SkTP2IcCLV8UGAeJ5YBATtheVlkE2G8vUI6OnPcU6ejQpepJYvRxaMkqpcqR29iE
X-Received: by 2002:a1f:2ecc:: with SMTP id u195-v6mr2627372vku.26.1533766689601;
 Wed, 08 Aug 2018 15:18:09 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:44 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 02/10] string-list.h: add string_list_pop function.
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A string list can be used as a stack, but should we? A later patch shows
how useful this will be.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 8 ++++++++
 string-list.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/string-list.c b/string-list.c
index 9f651bb4294..ea80afc8a0c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -80,6 +80,14 @@ void string_list_remove(struct string_list *list, const char *string,
 	}
 }
 
+struct string_list_item *string_list_pop(struct string_list *list)
+{
+	if (list->nr == 0)
+		return 0;
+
+	return &list->items[--list->nr];
+}
+
 int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
diff --git a/string-list.h b/string-list.h
index ff8f6094a33..a1a41bc961a 100644
--- a/string-list.h
+++ b/string-list.h
@@ -191,6 +191,12 @@ extern void string_list_remove(struct string_list *list, const char *string,
  */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+/**
+ * Returns the last item inserted and removes it from the list.
+ * If the list is empty, return NULL.
+ */
+struct string_list_item *string_list_pop(struct string_list *list);
+
 /*
  * Remove all but the first of consecutive entries with the same
  * string value.  If free_util is true, call free() on the util
-- 
2.18.0.597.ga71716f1ad-goog

