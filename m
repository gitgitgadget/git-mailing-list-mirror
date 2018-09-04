Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025E81F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeIED3T (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33814 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id y130-v6so3726809qka.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zur8ToAfT35JpKVdxQqWX0SFFnSuKEiYHnhjBifZzXA=;
        b=VGwj638k63WtRIjf8mrUX1ZjU29DwYHdwPNWn/JgD9o8GrmziT/+9YrerN1qh1f/ES
         DiMAE2Mh/Eqnc0xEZqbDEvzB4PlK/b+o3MOggnfMPsMaegiNQf7I4DBsYWw4dSil3dFT
         oW31JFe046bwPy0WTNKOXtnkzd1OxJrmrfbxHIfoMl448g7CDgqQ7M2x7CSTYWqGrNrg
         ZGsaZP87lfovEhblqabTKuKZCd9aVgW3vjAxnDdh+kKgcI06XiuX7BGxz+oqaNcnM5hN
         LMgqBmVUxr/1DsRjh47ju9fQ2WDntpEjjrNyY3Ura0BeBu85xv6THWKTglMEbY8Ajt7W
         ry8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zur8ToAfT35JpKVdxQqWX0SFFnSuKEiYHnhjBifZzXA=;
        b=GYiINzL86ebePHA/d0x5Yga98pVN1bQysbV3szmZMcVGEqTFna58efVQcRzJ4PSk9D
         HKwdyQgGkRbyot0PC7rqQ1+k8I0n+j93SGXmPYkKjTXJWRXdKCDa8zEaLAaCepnD2oGy
         XX7OohHu0n1Q+pnCJ6Wgt+Fw97hiadfhl+tmnVzH1Nw8tvzZxPWMYoIqPXZVm8oZREC+
         Fzz4g4K8VBHKYBIC/8dhEI1uOPqvvFZm54rHwE1SDKUZKPYZaxr1dOn7CrO2HIp5VCCs
         HIC3WjmorrkB9njzkH+QBhxJuGm/qkIke3AAboQVGadNCG6keTmm90GopFoB76UR+lmY
         GmKg==
X-Gm-Message-State: APzg51BldrmbAL1UiwaA8xsa+XY37TxJMsL359BKByzMeRdamUQ+5lKj
        Nra8Yomco8zDjo5IQLzRqxesrkwnpkTBmseAC1UVpjuuBp8dIVSym6oOv+DEhK+NRGqGwhJXJ9v
        vVuJgAvKZueBMnbeEJ99Y2aPC0h/id2tQ2DBaVFN/+D8RzcpxD2rcEphcgg7i
X-Google-Smtp-Source: ANB0VdZ+GArognAxeb5iIUeLt+wVUNl5RiKiz33c8/yEfExi3TzbJGmTch4x20T8KT9W833eXDZ3oAE9qlMS
X-Received: by 2002:ac8:2925:: with SMTP id y34-v6mr19260115qty.56.1536102121751;
 Tue, 04 Sep 2018 16:02:01 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:40 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 02/11] string-list.h: add string_list_{pop, last} functions
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A string list can be used as a stack, but should we? A later patch shows
how useful this will be.

In an earlier iteration of this patch it was suggested to return the last
element or NULL (if empty), to enable a pattern of

  while ((item = string_list_pop(&list))
	work_on(item);

But it turns out that this pattern is error-prone as the memory model
of the returned item is unclear. The caller would need to free the
item->string if the string list is a duplicating list; and more importantly
if there are further calls to insert items into the list, a memory
reallocation might occur, invalidating the returned item at some time in
the future.

That is why the implementation doesn't return any item and the caller
needs to be worded as

  while (list.nr) {
    work_on(last(&list]));
    string_list_pop(&list, free_util);
  }

Also provide the function to access the last item in the list.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 14 ++++++++++++++
 string-list.h | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/string-list.c b/string-list.c
index 1ebbe1f56ea..21559f222a7 100644
--- a/string-list.c
+++ b/string-list.c
@@ -80,6 +80,20 @@ void string_list_remove(struct string_list *list, const char *string,
 	}
 }
 
+void string_list_pop(struct string_list *list, int free_util)
+{
+	if (list->nr == 0)
+		BUG("tried to remove an item from empty string list");
+
+	if (list->strdup_strings)
+		free(list->items[list->nr - 1].string);
+
+	if (free_util)
+		free(list->items[list->nr - 1].util);
+
+	list->nr--;
+}
+
 int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
diff --git a/string-list.h b/string-list.h
index 5b22560cf19..d7cdf38e57a 100644
--- a/string-list.h
+++ b/string-list.h
@@ -191,6 +191,17 @@ extern void string_list_remove(struct string_list *list, const char *string,
  */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+/**
+ * Removes the last item from the list.
+ * The caller must ensure that the list is not empty.
+ */
+void string_list_pop(struct string_list *list, int free_util);
+
+inline struct string_list_item *string_list_last(struct string_list *list)
+{
+	return &list->items[list->nr - 1];
+}
+
 /*
  * Remove all but the first of consecutive entries with the same
  * string value.  If free_util is true, call free() on the util
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

