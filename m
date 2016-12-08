Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858901FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbcLHS7t (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:49 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32978 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbcLHS7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:48 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so176788695pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+y+Ca0iY7YPnm6dP0zc8DysJCxVLsv6LPGVPlTiwHo=;
        b=cTWHj7KnQpo0UerLtl6OZxt/xxsSnhEgrIGlHakgDXjKfoIL22+pRdBPDFP2VAAMq9
         0hdhvMBt3WAIDRuaE7YZL0KfhgxWWDJdbhJMOmDteQ1y9mvfDVQ3FlqF9jHH6swlddkq
         BP002hYUA17gGMK/S5/MuCLad9ccusgAvNXhuejRTPRzOGlXWhaOTAlp9aOiugWxVP8o
         rDWTV3L3q7iZ/kO54QgP6+GzBmBBkX1zEqf9Z8iR04KVXtjVemSPXW9XonvUC3kNs0VF
         WLQy0Cup+ZCawbfGbwKxWUGTG1BcgJWAY2zipE0SV4HkBtDwAzfGBsIjuFQkK9H31sfM
         pz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+y+Ca0iY7YPnm6dP0zc8DysJCxVLsv6LPGVPlTiwHo=;
        b=hp3b0nHMcd2la7Gs3LI83HJv2sCwutDYM35HB8/+MVAzN4pn9uiAqv1U7UUfJ1FPXi
         9Y+hlvuPsQ8YPnlQAwh0p1zbp64zkOb7PkAM0YP29msr2D1if6Cw9rYhUq1fp1tYLIdQ
         sz76LfihfWzg8k0GciV6oiXo0TojKD+a5pQNiPZvSBy/9HwFuEt+qs/lQjv6hG5bxYjP
         PII1wY7s08ep2fxKpQmYtkYyFYE2Moy/jTkSyN0R/PAjb08irjxx6mqVm0vPGffjTkwD
         pCrSGUt1/znl1JM9K+Gpgb9LN5dHxq71MqK0mknhCpvnJDcqwPWguGi8RSxl52gTLgU/
         +1ig==
X-Gm-Message-State: AKaTC01qON/Wj2UDh62gOsygRXAE7NoH96VoNNv9QywsSx2GA3tmYsuOfUQhR0fORMq8OU12
X-Received: by 10.98.252.75 with SMTP id e72mr14471092pfh.6.1481223587908;
        Thu, 08 Dec 2016 10:59:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 16/16] pathspec: rename prefix_pathspec to init_pathspec_item
Date:   Thu,  8 Dec 2016 10:59:10 -0800
Message-Id: <1481223550-65277-17-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Give a more relevant name to the prefix_pathspec function as it does
more than just prefix a pathspec element.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 4686298..08abdd3 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -297,21 +297,11 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 }
 
 /*
- * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix. Return the magic bitmap.
- *
- * For now, we only parse the syntax and throw out anything other than
- * "top" magic.
- *
- * NEEDSWORK: This needs to be rewritten when we start migrating
- * get_pathspec() users to use the "struct pathspec" interface.  For
- * example, a pathspec element may be marked as case-insensitive, but
- * the prefix part must always match literally, and a single stupid
- * string cannot express such a case.
+ * Perform the initialization of a pathspec_item based on a pathspec element.
  */
-static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
-				const char *prefix, int prefixlen,
-				const char *elt)
+static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
+			       const char *prefix, int prefixlen,
+			       const char *elt)
 {
 	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
@@ -329,6 +319,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		magic |= get_global_magic(element_magic);
 	}
 
+	item->magic = magic;
+
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
 		die("BUG: 'prefix' magic is supposed to be used at worktree's root");
@@ -401,7 +393,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	/* sanity checks, pathspec matchers assume these are sane */
 	assert(item->nowildcard_len <= item->len &&
 	       item->prefix         <= item->len);
-	return magic;
 }
 
 static int pathspec_item_cmp(const void *a_, const void *b_)
@@ -500,8 +491,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, flags,
-						prefix, prefixlen, entry);
+		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
-- 
2.8.0.rc3.226.g39d4020

