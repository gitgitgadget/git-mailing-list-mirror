Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63041FAE7
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeCSNca (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40167 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeCSNcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id z8so8897589wrh.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/O3y7OvggKWTM3T3KGJUmMlWpreTgCbNgWMhKn230Bo=;
        b=CHkcJKu5bKT6CZAE/YDX/MrHpXZFTUPsJkGHSwkybheq4LYDWQP0kT8sr7hoPcPFbn
         0NcZTbBgWmuZR4FMwprlGKnHL/SNAAI7ddWgImLWhYyI++k9Gna/l9dooxnL9C22ztKP
         h78kOpqK5DHNDs8kXu5itS+7iUNdzWM+PE5D6BauBdImpXQ0pqP6RORSd2t+Y54anz2T
         Qm6sytYenaovloMSKPeTp58cLwMVs+iS3NUztPwy2AgUlNumhr+b0GPw27fqLbHxkr8D
         SpcRtJsrJaOGyNFVxI2dh5yjwId20IC8gOT68NDCqX8329d+47FMt/8wAXShntqYCmMo
         BSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/O3y7OvggKWTM3T3KGJUmMlWpreTgCbNgWMhKn230Bo=;
        b=Du7VIglq0TNYtqxiDRliWYqdi/eIBsBGwhggUQxPkQl+svzf+L+7r7QN/RUSjn0I0/
         2SZ8yVDHbJsS+Bk3klIg0LNqT1P/U9Y7ezUqevlvu5emwP735EBinXF5HhPxRTFdN1o0
         WrHCtYi/5UroneBAp5JnvL2HoYT/qmvq2GpotI0/lWW9TAt9tZPzVKWZ+sQd7uzjOYpM
         ihq1p8hdFGXrN7xQPSgfck8cOWVqkmc8+JLbvGT4z4u7Z0k2sDOEDyrDCC+ijGRIL4FB
         HbJ2t6iEerOLS8Z1iaoyHNz0K7WbJo17+gE2/LanWmjwJXYFl2Q1Y+JkkhnIprbWPJ32
         wdjQ==
X-Gm-Message-State: AElRT7FdVeeIUfuVd3ptTEoUscd7lmI5JF3leONfY4JWRfxkeHwrYFB8
        Fzy86h9vGBctKxkLoFqJp+e+pBk1
X-Google-Smtp-Source: AG47ELsDloK2V0h0+DNwrE637deCcMj233wJDE+rwFFy7VDvB2ongh0cJelBZvhImIsKuGrvOkLJaw==
X-Received: by 10.223.135.14 with SMTP id a14mr9978428wra.261.1521466332306;
        Mon, 19 Mar 2018 06:32:12 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 03/36] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Mon, 19 Mar 2018 14:31:14 +0100
Message-Id: <20180319133147.15413-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new environment variable will be used to perform git
commands without involving any external odb mechanism.

This makes it possible for example to create new blobs that
will not be sent to an external odb even if the external odb
supports "put_*" instructions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h        | 9 +++++++++
 environment.c  | 4 ++++
 external-odb.c | 3 +--
 sha1_file.c    | 3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 2ac7d63e5c..4aa0129cf8 100644
--- a/cache.h
+++ b/cache.h
@@ -413,6 +413,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -799,6 +800,14 @@ void reset_shared_repository(void);
 extern int check_replace_refs;
 extern char *git_replace_ref_base;
 
+/*
+ * Do external odbs need to be used this run?  This variable is
+ * initialized to true unless $GIT_NO_EXTERNAL_ODB is set, but it
+ * maybe set to false by some commands that do not want external
+ * odbs to be active.
+ */
+extern int use_external_odb;
+
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
diff --git a/environment.c b/environment.c
index d6dd64662c..92f682cb9b 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -119,6 +120,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -158,6 +160,8 @@ void setup_git_env(void)
 	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	free(git_namespace);
 	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/external-odb.c b/external-odb.c
index f3ea491333..390958dbfe 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -43,7 +43,7 @@ static void external_odb_init(void)
 {
 	static int initialized;
 
-	if (initialized)
+	if (initialized || !use_external_odb)
 		return;
 	initialized = 1;
 
@@ -69,4 +69,3 @@ int external_odb_has_object(const unsigned char *sha1)
 			return 1;
 	return 0;
 }
-
diff --git a/sha1_file.c b/sha1_file.c
index 3f00fc716e..f2e078e840 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -669,6 +669,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.17.0.rc0.37.g8f476fabe9

