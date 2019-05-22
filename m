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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9151F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfEVCoi (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50612 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfEVCoi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:38 -0400
Received: by mail-it1-f195.google.com with SMTP id i10so1158416ite.0
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zfIyUCdV+7cGlBhZehrDRdzHVlwMZpaPNiY0S+QleeY=;
        b=b+2xM+0m7X0zEKGyW8W9vISQkhkI1kOmV5jsHODiIQjocPFIiNGKdjTM0T6pBA9gwv
         bVURNUNW7wFCdaZxaoinVxGpae5ad/HtDp7/G6F5wSvCfR6ENqX1neIX/1kyzZ2xVeZy
         bD06Kk+TCyfQqPpprnwbcufiebDNrAx39zGIbMUSTLWOVkeYjgiEca6Sk9HT/eiNiaJK
         MqMqXPUsjtsAs45+l7y5si3yc8Pe/m9hkuflbtnvrDdKKfG6vuZi6ycfMGK2sV9yI6/p
         /o9hdK4RNCRBFBeXn7DIhpozuQFG9CZpyYNjbhqex4fHXL1a5kBvE/RNZnqc0BT0iPyX
         17iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfIyUCdV+7cGlBhZehrDRdzHVlwMZpaPNiY0S+QleeY=;
        b=F+dOz2fIWNHFhvG4Beisqh4sZYJWIky4GaEdN5Hkj1p76KkUCv3Eu+KEs0r2Mxw+iS
         smDnPF70i6aV9Mjk5i9AOLnmhP8ThWHgsXwuEHr+72DmvfX6TYXoF6tkp/g1DieAiv/c
         YDKQ9Q51VTS9jTxVlD+XReKjp7arkd4IGxobEEq1Em/P2tQkaAgSdEQNZmtAsVLWE16Y
         9LGSkEEvdeDtzfBsSE90T9nICW6K6xAvGbr2beq5neF62ATzPtNVCqYuEsY68W8oDrFg
         pYHNexvJS66rXXvGpFK3FV7+nLTH4f4YJi3tdbvC4v1Ek4dTntEs0A/1nFQeKQ/gOVpf
         Lj8g==
X-Gm-Message-State: APjAAAVXvFnEaebfiifRp9Q1cbitpWoYB8lz/AMKlgBhPALKqtXPDBeL
        tNIJvCsBxDCWvwcsE4PXS8W4oO7W
X-Google-Smtp-Source: APXvYqxVA8YzcPDHxiHhtezf2vnv8adyRaXV2s4qogRhGtDTbgXgYK7TbrfQ8p/KYMNmqiM/8S1fqA==
X-Received: by 2002:a24:5ec2:: with SMTP id h185mr6495874itb.19.1558493077006;
        Tue, 21 May 2019 19:44:37 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id z16sm6907769ioj.64.2019.05.21.19.44.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:36 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:35 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] string-list: create string_list_append_all
Message-ID: <27c60c715c6e01197153583c6a55c865e0115be1.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
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
2.22.0.rc1.169.g49223abbf8

