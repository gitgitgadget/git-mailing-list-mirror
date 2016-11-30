Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E811FF6D
	for <e@80x24.org>; Wed, 30 Nov 2016 21:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbcK3V5I (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:57:08 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33090 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcK3V5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:57:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so31343928wmu.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VITKiLC1sJG89vntNIlEngWBW7+cTQ/vDvg7Qeg98Fg=;
        b=nirtvr+Hbyc3mqWMRpiwprrSHatbr+9IxkX9cKdU+vpnbx3txqGgLjbOY8eV9+cxtM
         3e9dTirVV6+GQRLrYuNl5XH2LmhNt3NTwgJe0gbB17iV8wKMWvzqVXaje382M83WwZaT
         dhgqHa/J9ac8jY/pi0WQqD1AVSWpJogQ2AkoMNmc0gSc1r/CHumpYR9xOOzCh1rUi1qf
         7j+hVag/2Qg/yH3NThLHJMQfmhUEmnz0H9oMacwZ0E/c5lkDQVioB6hWQmUyzWrF71tj
         N0/8wczbkmmQEV7QWTrk/ProQJs3+G+zlXm1x97yeaC15I9f4gpV5ix6hADXYhFuWudL
         WE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VITKiLC1sJG89vntNIlEngWBW7+cTQ/vDvg7Qeg98Fg=;
        b=RY+0po2CSt2IXmsKd6HY9jPhrYG+SPdaZU4lBqAHQkffnwft/5mdbi3ureo0Z+nOiz
         Fh43b0gdOQ4UxFJ+KtyXKC/ePi393C+rBEIaID4gGLWqJZDtjvi4fpUyQ9KtL1a42MAN
         8+NU1m2hrkApaNEWkOpJ5aOLuoTd8rxttEwjdx78BHfxA/aWIbcvI/5gFzjDQd/WQ/HG
         XxE4VJWZbVRLYlLDvGtkqMTiHHkU4p+XJ6IoEgKE9ws576n1rD/z6M/7Z2o8yh1V8qvU
         krBfoCv1HOIIZQuWp0F0ayI5D6Z7ijCAEDEZ7E3zVk/jGRWDTXhvTdJ5BobppCBNBLi0
         DGDA==
X-Gm-Message-State: AKaTC01mFkux7LYFWOCEVxx9TRpCu7fwFGnORV4rLlNQ3GFgaV2QgqwsrOwHPMMDiTo6Ng==
X-Received: by 10.28.137.81 with SMTP id l78mr29118672wmd.36.1480539902255;
        Wed, 30 Nov 2016 13:05:02 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:01 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 09/16] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Wed, 30 Nov 2016 22:04:13 +0100
Message-Id: <20161130210420.15982-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h        | 9 +++++++++
 environment.c  | 4 ++++
 external-odb.c | 6 ++++++
 sha1_file.c    | 3 +++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index b419b9b7ce..503b618a1f 100644
--- a/cache.h
+++ b/cache.h
@@ -422,6 +422,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -698,6 +699,14 @@ void reset_shared_repository(void);
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
index 0935ec696e..8aecdd0544 100644
--- a/environment.c
+++ b/environment.c
@@ -47,6 +47,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -120,6 +121,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -185,6 +187,8 @@ static void setup_git_env(void)
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/external-odb.c b/external-odb.c
index 6dd7b2548b..a980fbfbf2 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -63,6 +63,9 @@ int external_odb_has_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 0;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next)
@@ -133,6 +136,9 @@ int external_odb_write_object(const void *buf, unsigned long len,
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 1;
+
 	/* For now accept only blobs */
 	if (strcmp(type, "blob"))
 		return 1;
diff --git a/sha1_file.c b/sha1_file.c
index 3532c1c598..92f1244205 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -556,6 +556,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.11.0.rc2.37.geb49ca6

