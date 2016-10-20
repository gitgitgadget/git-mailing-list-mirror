Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8311F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbcJTVkI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:08 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35493 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbcJTVkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id s8so43662911pfj.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=dHWcm/v9SaDuCFSuDCTjwLpw61dVJvYt0IWydZ0xLKS/ERfN4juouzMuBHep7XbBvk
         bt75EvXkH7MeRDPJhdLu4ADWmIHbEB10Ol2Y+LIeJLlZjhOvSgIhH32UhPT8qAyN3x3B
         NZyb6qd0a7ShAb0DQzY9/sg4FoaMjANbsHNOtXY945cgSncL3EhZsVa6ulurZYdeolrW
         kIdy3gkOyBEkTYtS8XcFiTgCFA5s011gYmtxlKjFcNWqCy6J3oxjXcPieqA+ddSXUY0M
         /Q9SqpL24bmIk72Kamno9YFXmJmCRp4v5CTLTh08PjNbSdchnXyJS7yiPvheu6dIv8Jn
         zYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=DhNAEmCEtnhbKPPuporU0Xx+w/IP763jbj8cCWZqPXUxX0yzLqeTteUndF9Kck/vLH
         CMRSrXLyQiFZTVufjkETdiijNlsIfRrwIN+NEM4KlHvHkJLleNmoY4+DWIxL1Eml3PPv
         IARdo0HEwJ0JZ4SX1FC3yTRRlsMKqldBVkIIModzMKF4VhOGh+6MB3+UDmkln7Gg0WIa
         8nxULUZM2v4G3IpEDeclbuuxgV73uuG+3ZBha6q6hY5e1CGXquzW2wYDRUMywDiC3Dq6
         c4elqhJcFvyWIvTL56gywSGdOb8ooFh7rhT/LF6q3edLZwDXFXMunSKZmdgGyd7zzWFl
         a0ag==
X-Gm-Message-State: AA6/9RmhOea+OfbL6rjSqAZep2mPXA+7XV/gmBIOcwOiFFUEISmeYPSvW6CCJiRK5qNL56Wk
X-Received: by 10.98.89.73 with SMTP id n70mr5052949pfb.82.1476999605776;
        Thu, 20 Oct 2016 14:40:05 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 1/8] trailer: improve const correctness
Date:   Thu, 20 Oct 2016 14:39:46 -0700
Message-Id: <701ba7164b587a97ef380bc981c95c5d51db6781.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
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

