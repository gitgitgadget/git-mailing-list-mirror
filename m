Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03621F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965957AbcIVSxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35964 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940420AbcIVSx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:27 -0400
Received: by mail-qt0-f193.google.com with SMTP id 11so2852394qtc.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pNKtxyFiOajb4E12j5iJTRpdEfdQFYqx+EgDNHfLLo=;
        b=IKnyFRYtpbav6Mr7GkKN8AbDISYRWXnkr0VWm+5H6655sdmZY2nO7DId0L8520ZDgQ
         mwhC2mi3/S3mGh4Pgpl5ncfFVm+AyTc5CEVlWj352unaXgxraW7erMdZpg5kcJJWUemn
         vQK2ZKAwcZm8K0mfdfmDuIswMOzufySqUcMTzBIRZMUfUgiWrH0+jAT4UcmNHGlwI87v
         v9+qTKXfk0rWTyDc2Kb4cG2ac5w6N8g4y5goFHRsrfhgzK8IRX8cr2TP3lrbrPDQT2++
         VELBkjRa1aOC147PiwroB44YjSTjQDwL7QMWcHMsV0P6YwiTqjBU5Ar7UYr7L15VMDYz
         xZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pNKtxyFiOajb4E12j5iJTRpdEfdQFYqx+EgDNHfLLo=;
        b=bGbrK+oA1kYjWJ305IsVPSBB1qrFZRBxmOHD1K3Ow36Jk6e4CmlhaxRKx+RoKl+Dmb
         GmQU7cfa61an4ZkpMdb5QI9rAeGCcP/KZ7Z5iHntO/RFo3S0EcDHdrCyY7W6bpd6BshX
         BpXqUFqYuVb+8pgwvCbLRKzLmXVAPwRLVDgWE3GGK6kpycAMW48xNTCCgyOATj1kMUlK
         12PmFopAjmXNXtFwmycpsf20bkQNvpJ+Vwec9jsgYp8xL1L7fzN46w7FrMHddMI+lTz7
         P+zN9ThUX8Voqa0ZqCj3u4mqQDwp9Ftfm+Rs8U41MoorpZrJwfSZxZRuYrWZfNGUsgU9
         30Zw==
X-Gm-Message-State: AA6/9Rn5cIWu93gt+CWiyRyYEINHvtbcPMhduFwBUrJzaGflwP24IIK/vXpztfoQaT3uzgDB
X-Received: by 10.237.45.39 with SMTP id h36mr3733843qtd.155.1474570405308;
        Thu, 22 Sep 2016 11:53:25 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:24 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: [PATCH 3/6] ref-filter: Expose wrappers for ref_item functions
Date:   Thu, 22 Sep 2016 14:53:14 -0400
Message-Id: <20160922185317.349-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Ref-filter functions are useful for printing git object information
without a format specifier. However, some functions may not want to use
a complete ref-array, and just a single item instead. Expose
create/show/free functions for ref_array_items through wrappers around
the original functions.

Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
---
 ref-filter.c | 20 ++++++++++++++++++++
 ref-filter.h | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 9adbb8a..b013799 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1329,6 +1329,14 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+/* Wrapper: Create ref_array_item w/o referencing container in function name */
+struct ref_array_item *new_ref_item(const char *refname,
+						 const unsigned char *objectname,
+						 int flag)
+{
+	return new_ref_array_item(refname, objectname, flag);
+}
+
 static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	unsigned int i;
@@ -1426,6 +1434,12 @@ static void free_array_item(struct ref_array_item *item)
 	free(item);
 }
 
+/* Wrapper: Free ref_array_item w/o referencing container in function name */
+void free_ref_item(struct ref_array_item *ref_item)
+{
+	free_array_item(ref_item);
+}
+
 /* Free all memory allocated for ref_array */
 void ref_array_clear(struct ref_array *array)
 {
@@ -1637,6 +1651,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	putchar('\n');
 }
 
+/* Wrapper: Show ref_array_item w/o referencing container in function name */
+void show_ref_item(struct ref_array_item *ref_item, const char *format, int quote_style)
+{
+	show_ref_array_item(ref_item, format, quote_style);
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..0f0ffe9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -107,4 +107,14 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+/*
+ * Wrappers exposing the ref_array_item data structure independently
+ * of the container ref_array, e.g. to format-print individual refs.
+ */
+struct ref_array_item *new_ref_item(const char *refname,
+		const unsigned char *objectname, int flag);
+void show_ref_item(struct ref_array_item *ref_item, const char *format,
+		int quote_style);
+void free_ref_item(struct ref_array_item *ref_item);
+
 #endif /*  REF_FILTER_H  */
-- 
2.10.0

