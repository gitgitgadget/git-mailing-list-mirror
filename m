Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8601F461
	for <e@80x24.org>; Fri, 17 May 2019 00:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEQA1y (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:27:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45791 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEQA1x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:27:53 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so4062812iob.12
        for <git@vger.kernel.org>; Thu, 16 May 2019 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hTr4pN44FmnhWMAl8MLEcZk81UwDfgVB+q5rQ/ehRM8=;
        b=IoWXAucxuJij3ISVTLm37gmCOWjC885lvrSTpbI0ZJYS646gifhLfPhvpfFsRBEg43
         JRpUWEX88xrXDzUatKfvWM4DBPkxr355BQOmw5hPhICkrHMOlqKT8dj08xrKLPdYtC5q
         sSC5hIFmmEPgN4BQl0PBTD+r/Qs6vG5egB3onSZLEW83WHJtZYszNS+Ov+ThPHpfT/eZ
         8I0LL1e9YLwLdeBcgFbN5l4LmsFnjGY1rZdX1RkY2YbxS6+D8MwBEToZMr0yjCuqF4xC
         ZTLAnCkjhmJTn2trY7UffWSGiLEmGePNP2rSyZlp2laddAlwmHk7Yzg2p8rAiAsPjZ/x
         B1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hTr4pN44FmnhWMAl8MLEcZk81UwDfgVB+q5rQ/ehRM8=;
        b=EyY5VMfM9Rdy4SXg8EjONJe8dfnUmcokyRMsfEe3LZEPLtBcYcSYd/ickAvmUt8SAo
         HlbN15ifmXnkNBHWihcqS7typDldnhfo7+zhE1lCkdQNxLaChVSGi1fy9BI1eMNXFh87
         YLS8e3+8wRgUfgaXNwwLNCFezjor8fmPvgN12bpoz8ZR/uNTKLxnDTtydI2ms/b97BCR
         XAcFrTP0cr4qQtMRKzhWJ2uumG719rWrdCgkWgTDxtUmMtx0xSf4BnerwfJ9Eeg5vm5r
         rd7VKIAN82ESywBzRLbv1XjznKERx7R4n5rQgIQNvOtZpMv+1xpEGwuGIFvoBUaGsAEl
         i1rQ==
X-Gm-Message-State: APjAAAUnMciXl6sXaVozprA0EFHkvQW8BCybuoSJV8bp6bNUn4bmXxKd
        s2mc2gsCWFzI43HA8zXesxKkQigT
X-Google-Smtp-Source: APXvYqwfJGxWYKzENn6dabCvtpnL9ZzOXR8MAPa8e3GEOmN5c9Qjr9npetqJchXyBmVERxDNr7w2+Q==
X-Received: by 2002:a5e:840c:: with SMTP id h12mr14717005ioj.81.1558052872656;
        Thu, 16 May 2019 17:27:52 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id e22sm2426693ioe.45.2019.05.16.17.27.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 17:27:52 -0700 (PDT)
Date:   Thu, 16 May 2019 20:27:50 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] string-list: create string_list_append_all
Message-ID: <cafb8c0650af0746319061a296dc09cf773866a4.1558052674.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <cover.1558052674.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we'll need to take one string_list and append it to
the end of another. Create the `string_list_append_all` function which
does this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 string-list.c | 9 +++++++++
 string-list.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/string-list.c b/string-list.c
index a917955fbd..e63d58fbd2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -215,6 +215,15 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+void string_list_append_all(struct string_list *list,
+			    const struct string_list *append_list)
+{
+	struct string_list_item *item;
+	ALLOC_GROW(list->items, list->nr + append_list->nr, list->alloc);
+	for_each_string_list_item(item, append_list)
+		string_list_append(list, item->string);
+}
+
 /*
  * Encapsulate the compare function pointer because ISO C99 forbids
  * casting from void * to a function pointer and vice versa.
diff --git a/string-list.h b/string-list.h
index f964399949..8227e00e6a 100644
--- a/string-list.h
+++ b/string-list.h
@@ -208,6 +208,13 @@ struct string_list_item *string_list_append(struct string_list *list, const char
  */
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
+/**
+ * Add all strings in append_list to list.  If list->strdup_string is
+ * set, then each string is copied; otherwise the new string_list_entry
+ * refers to the entry in the append_list.
+ */
+void string_list_append_all(struct string_list *list, const struct string_list *append_list);
+
 /**
  * Sort the list's entries by string value in `strcmp()` order.
  */
-- 
2.21.0.1049.geb646f7864

