Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6E520229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbcJURzO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:14 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36557 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755499AbcJURzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:11 -0400
Received: by mail-pf0-f172.google.com with SMTP id e6so60469558pfk.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=Gdk0Q/djTr0houZ8FCtKMYd0+PTKDUAAnB76JOch6yKgL5nGKfREvutyquQRyg98oT
         AXvDf7t1U+rK4UJvIqdpViE+cqIRSmW25QWuP3xiWKUygeueeJo3tm99l1ts0V15+RLV
         Jr0pY4IB8CoXeJgfK6VRtS1flXDKxDX/wRvDeqPHz+PWa3W9A0qcomq4GfTw+wEY+/mR
         3Hp09qf3GbZEj4ujHB3iik6YtcLnnOJEX60kl3tAcUPerCXwWkliAjRt74YQKUIVGntz
         E0U3hMkom7eQM1UetfhcURWPRp/qwuhUZt9reWw81CudhjlbqcuTXJyyap2mgUpd/PR8
         X5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=UlEpDagb1wrgLwtYKutKndLjjS+/fBdarYKGC3pXA/wV9x/afEL9IwbtY7U/9DimOm
         HZO+mzMYobAFW5/hHSK9mTOFkLsk3mQT4Ul86sugt8yJ3BwjJHSBJPP4znTvnQxmt55K
         vIOVetyCibYxd1555eF1T291VOJ5+Po67IfCUR02XHz6YIMVj/Vp1XoOX+wqJuDWe6lC
         s14x4O4XtGoEHlPKseLh56/zLnC/Nm925+U0XGpipGraqQVVECuBb/mHFLJQrqpdKDyg
         qIPfgp7UFC/Qs3KUKgj62BZXsa7reX2yofm77aCj+zPqdoyf0O1Y5O6kyJmKa+oExrbO
         dzbw==
X-Gm-Message-State: ABUngvdbL9xQJTUVVTcALnq12v8pcOFnnXIwya6WTCxQfTcBOy92pe3VW2g/Sh7A6uxIGqBg
X-Received: by 10.99.156.10 with SMTP id f10mr3100087pge.123.1477072510017;
        Fri, 21 Oct 2016 10:55:10 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:09 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 1/8] trailer: improve const correctness
Date:   Fri, 21 Oct 2016 10:54:56 -0700
Message-Id: <701ba7164b587a97ef380bc981c95c5d51db6781.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "const char *" to "char *" in struct trailer_item and in the
return value of apply_command (since those strings are owned strings).

Change "struct conf_info *" to "const struct conf_info *" (since that
struct is not modified).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index c6ea9ac..1f191b2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -27,8 +27,8 @@ static struct conf_info default_conf_info;
 struct trailer_item {
 	struct trailer_item *previous;
 	struct trailer_item *next;
-	const char *token;
-	const char *value;
+	char *token;
+	char *value;
 	struct conf_info conf;
 };
 
@@ -95,8 +95,8 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item->conf.name);
 	free(item->conf.key);
 	free(item->conf.command);
-	free((char *)item->token);
-	free((char *)item->value);
+	free(item->token);
+	free(item->value);
 	free(item);
 }
 
@@ -215,13 +215,13 @@ static struct trailer_item *remove_first(struct trailer_item **first)
 	return item;
 }
 
-static const char *apply_command(const char *command, const char *arg)
+static char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {NULL, NULL};
-	const char *result;
+	char *result;
 
 	strbuf_addstr(&cmd, command);
 	if (arg)
@@ -425,7 +425,7 @@ static int set_if_missing(struct conf_info *item, const char *value)
 	return 0;
 }
 
-static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
+static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 {
 	*dst = *src;
 	if (src->name)
-- 
2.8.0.rc3.226.g39d4020

