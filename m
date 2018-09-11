Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5F41F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeILEvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:39 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48843 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeILEvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:39 -0400
Received: by mail-ua1-f73.google.com with SMTP id i4-v6so41136ual.15
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lMk6V2S9Ij9c1Tflda+kLjZxJTK7ji21TJ3lMoyYnE8=;
        b=QyDQgmt7c0kKoFJgeB/YqjEpB1sDrdO5DIWlbx1mEztY7U4E3W+QPP7as/ekouWOaT
         HQ/JUoMBFvjSVwKIII9Ao03Rloo8pG1G/TixhQ5xk8fpJ2u5acYLM2SZPL+kGfbhocSV
         136gPbN5XrO4+OFqnEz8lO6i+eWXCzKIg9Jjbrmavw4H/b04MGNSAukln5hiF2MioGol
         xe9K0iGl44y5Ce9a93qZhwwWTKB8w9LSHKUBMe595bg2cAdPAN+P8Vjc9AacwqLAtv0F
         t/zx0aXSoi66mV3CjMGiJbDv7DwVrJhL3YibqqYrBsCIMewzm7JtGzCaQ8I80yec0E4A
         /sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lMk6V2S9Ij9c1Tflda+kLjZxJTK7ji21TJ3lMoyYnE8=;
        b=es9+anwYpRkKr6aMe7FZBNy0QAPD+Hj50/ngIifAtmELscW9lwweG3y5Iz1Xi/4W3d
         mj/FesJsLfWnE8BMoE3CMtQ+S22yDVzsOWzZ/5t11DfqPLmtUmJGicfs0FnznDxNzo4R
         nBkJQ8OKysrV8nw76+nOTFhIDgC1HF8r4phwaXTgvBxAUBV23KyoPtYYKLSIZVYU6uEq
         W6eGHYe7tGT7NSwWVjmw5I4HzZUcvaqUMkoLSFfX5JYHBZcqcmicZgo1V0pk9N24TeYT
         DhmAWTQKnjRACb7l819fM7zt7TN71MZ+UfNwSMraKqNYAlXmW1WFGm4GFKhpTbruI45o
         nrvQ==
X-Gm-Message-State: APzg51A3bocRHENqz+J0IGhaFERKWUhfLr7cCfxKrhxF2OhnFIaDWgsN
        lwRBN54n8cIOjpCFXiL7Ip7JMLgkfApbZhnwYXz04gOYRmQpE/Anh5k0jJx8QTYZk9J+N872U79
        AzLOWIbgrBZON2YM9mMsFSf4Yd7OznQcnTX/lkP6YRjUQ4RMe8G3a2UCco43M
X-Google-Smtp-Source: ANB0VdbufBtFm1RkBC744eg/vjE6CjNjP7Dg1Yau0frs0BVyIfzZAEdsD4HHr19CUlpI4Dn5mAmqZ/p2rPZG
X-Received: by 2002:ab0:59c1:: with SMTP id k1-v6mr5295869uad.70.1536709799906;
 Tue, 11 Sep 2018 16:49:59 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:43 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 1/9] string-list: add string_list_{pop, last} functions
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a few functions to allow a string-list to be used as a stack:

 - string_list_last() lets a caller peek the string_list_item at the
   end of the string list.  The caller needs to be aware that it is
   borrowing a pointer, which can become invalid if/when the
   string_list is resized.

 - string_list_pop() removes the string_list_item at the end of
   the string list.

 - _pop usually has a friend _push. This role is taken by
    string_list_append already, as they are not symmetrical
    in our code base: _append returns the pointer, such that
    adding a util is easy, but _pop doesn't return such a pointer.

You can use them in this pattern:

    while (list.nr) {
        struct string_list_item *item = string_list_last(&list);

        work_on(item);
        string_list_pop(&list);
    }

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 14 ++++++++++++++
 string-list.h | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/string-list.c b/string-list.c
index 771c4550980..04db2b537c0 100644
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
index ff8f6094a33..ce2528bbe15 100644
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
+static inline struct string_list_item *string_list_last(struct string_list *list)
+{
+	return &list->items[list->nr - 1];
+}
+
 /*
  * Remove all but the first of consecutive entries with the same
  * string value.  If free_util is true, call free() on the util
-- 
2.19.0.397.gdd90340f6a-goog

