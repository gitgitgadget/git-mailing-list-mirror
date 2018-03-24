Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21AA1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeCXUiI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39607 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeCXUiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so22920478lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyUTj07LwlfQ2NNC3uq6bwpsysqtW5cvP3SpeIEwNj0=;
        b=ISLnmELKsHJyjpH9u9Wu+VaQx0Nm+Onh5PARER2mMRDGDxVEf5g+WMWz86mu8QrLQN
         ZzUZ6P3Sb5Tq2PxjcBvFSljF2UkWXf6boedk7SUTYsMxsLLz0g7RiJEmt08ls6tqoLOO
         7XhKtsDz6TrKuXnf38rUAQaPnKoxvN1zVT2OH3v0BtBtMpsimxHPzpV0VRCgBj90CXi3
         tdbGI0cXnHC7mSON7/JaI3qqNxISDqLwlGi96OqdsIoDwl7wnYYAFz+SuL+3j3xbtuLU
         bGvSnooPKUjhQb3j+FkTznYqKmHvoqClJkPxYKUp6l8Ys4QDdTOlZKqaUZmKSpKp5zXZ
         tOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyUTj07LwlfQ2NNC3uq6bwpsysqtW5cvP3SpeIEwNj0=;
        b=H2tYXG7Qi8nPfyXmffAI/KY1vN08Ks2PrQ47CcdIprEpPov137M0EHFJaVFJw1RDhe
         UBbWHWG/7JxMPvSSaLb4KNwjQ4NtnDS/2bYr4SlwBVbufPqffMzyMcnukPPwbx4LK6hr
         6lBXkD5CLEvpFudxYLT/7o0AaRTsLM+se9T7i97ZCqmNt+G9h5yKK+5WJVD7RWetJl8U
         562mu3JaNDbWtfjKEWngXGFiqFfI3caIxl6l4UazMR0igeKK1tQ0JBMVoody5av+KTwc
         hFq6gM8/UMn76Rq+3k5+tK8EaA3oa/QpL8HoD2k2V3dAOeZtDZAzQbhufkmvc2Gt0pMT
         lm+A==
X-Gm-Message-State: AElRT7GRQvDCvGPHHIuEcVrbq7B7nrWs9GG6ayS3R2bTeLEgEQitVSPW
        UvrBROeFOr19YpQK3/DPZwhYhg==
X-Google-Smtp-Source: AIpwx48s4aeVrzizhr1/wC8pWBMYrE1UG8EyFSBS1Evsa49rsiYZ9KZqSgiLNnTtUwsSTaWJTTcqOQ==
X-Received: by 10.46.133.83 with SMTP id u19mr1886321ljj.110.1521923885401;
        Sat, 24 Mar 2018 13:38:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] git.c: move cmd_struct declaration up
Date:   Sat, 24 Mar 2018 21:35:18 +0100
Message-Id: <20180324203525.24159-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we need access to one of these command option
constants near the top of this file. Move this block up so we will be
able to access the command options.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/git.c b/git.c
index ceaa58ef40..bc4a5459d3 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,23 @@
 #include "help.h"
 #include "run-command.h"
 
+#define RUN_SETUP		(1<<0)
+#define RUN_SETUP_GENTLY	(1<<1)
+#define USE_PAGER		(1<<2)
+/*
+ * require working tree to be present -- anything uses this needs
+ * RUN_SETUP for reading from the configuration file.
+ */
+#define NEED_WORK_TREE		(1<<3)
+#define SUPPORT_SUPER_PREFIX	(1<<4)
+#define DELAY_PAGER_CONFIG	(1<<5)
+
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
 const char git_usage_string[] =
 	N_("git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
@@ -288,23 +305,6 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-#define RUN_SETUP		(1<<0)
-#define RUN_SETUP_GENTLY	(1<<1)
-#define USE_PAGER		(1<<2)
-/*
- * require working tree to be present -- anything uses this needs
- * RUN_SETUP for reading from the configuration file.
- */
-#define NEED_WORK_TREE		(1<<3)
-#define SUPPORT_SUPER_PREFIX	(1<<4)
-#define DELAY_PAGER_CONFIG	(1<<5)
-
-struct cmd_struct {
-	const char *cmd;
-	int (*fn)(int, const char **, const char *);
-	int option;
-};
-
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status, help;
-- 
2.17.0.rc0.348.gd5a49e0b6f

