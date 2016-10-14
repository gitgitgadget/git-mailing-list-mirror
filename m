Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C361F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbcJNRiL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:38:11 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35929 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcJNRiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:38:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id ry6so48750719pac.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=leblOerdU8+EhcIE5utbxolaQsonDGr2bMREfpCag4nY6fIE2h1eIkTxjlCCTQ+Z6o
         9GgjdHcqg2hIR0uk1Q+S/8KFLgQD25+7EH75TLTPe0XnoQ3Fi4IIXidUTCotEMCVw2dF
         iiVZCdrMesL+pnR++6jLSpdGWhvTenTlIuKnMzh1zAH7JPZbDSvA0jCPepumHiWGLfoO
         YaoaY+KoK9av7Iz+AGOp7ubSXp+RnFVyjhy1SPNh0d+Hbvk0Yqz4J8m0trUiR4ne0XF9
         3UcCEl3eNro0mlwBgFj2li95DgdHyr0FO+WhLlt7OKUld82aH+0EwN/0IrUhkl0iRhnG
         7mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=S68tHMWRIhXIGq5g3YYPTQ3fWsqSG8Ey49qTzy9K3Zo=;
        b=hfdUE1U6413ud5khWPIyzIWB4+nucHgs8e4CI9Njxetgbc1kk4KwHFDQRTJDsQWegT
         erSYsu+h0//xEg/ZhTRqGsTZkywHKhtAUF8tSlGCdUFG7SLG3CR2oTOSjomPa4BIjpfa
         6i0ecxRuBevv39CnHyD5zRqNnhSKtP0q0b6/5bn2TI4e8LlLg5LGzKGR/VebXjqA0QUS
         wxc0cUe25FpeQCT67BoVQzWiRf8FgyiVOjd2GybSu6iAUZfQoCAMUgbCS2DVobIyyjHw
         rUsW7ZqsPPA1vJ8zW+Erz9DILUeL2nU68Qcvi8Fit8a6aNPJID4op+9x0IAx9S+DDncw
         KQwA==
X-Gm-Message-State: AA6/9Rn1m4A2dbIJEbu28wASlhdAR1FynmB9XklJ9dHL1uCD1QeuyvbUVlGFowOBsGY11j7J
X-Received: by 10.66.22.105 with SMTP id c9mr12379316paf.56.1476466688425;
        Fri, 14 Oct 2016 10:38:08 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b88sm28955706pfe.72.2016.10.14.10.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Oct 2016 10:38:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jnareb@gmail.com
Subject: [PATCH v3 1/6] trailer: improve const correctness
Date:   Fri, 14 Oct 2016 10:37:58 -0700
Message-Id: <701ba7164b587a97ef380bc981c95c5d51db6781.1476466609.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476466609.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476466609.git.jonathantanmy@google.com>
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

