Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4A72047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdHCJWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:22:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34101 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdHCJT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id x64so1444434wmg.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zi3wKmMrWlqXiMErusZTXlpbVeIvRcTELHJRClrIZOM=;
        b=NtPzK08ns6C7mMpi0UZLnP3LOOhX84HmzBrWdwYW18qdHdu4NNUtVwboKo1Fan+3NG
         bxpvZDQdH4MGdZlEKfLdNuNLjLzIv8dptsSdkzR12YUdZyZiQW82iFxYW9oAr7RkdUiK
         MLwnuFF2AJOt1uffVpziQ8yYlVn12qru2pd14apcqF7b4+uo2L/MJvIkzMFSe2EtPVkh
         8ubmFgLMiLGm4aFnpNvSqAY5LMzhBNS2XN0+wZSqH3TAy9sZo/mD0GRlN6+94cVIlXtA
         HOPFybrhI1g9HXAmjz3Lt+J4GAF2Bh9qG0D6hko/hDIutjPAXWsU1BA2d8hLPqYjyWcg
         F8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zi3wKmMrWlqXiMErusZTXlpbVeIvRcTELHJRClrIZOM=;
        b=oI3beyOLKpwl04JEi9oAC2bCO42StL8KFplKz9417tUyh+GNAfuMGI/q896ucVQRZL
         CnuM4Nm++mI/e+DzhdsboV8LnnovcOSYkIehFZnLoLFeO3PRxujy2mSOTZmwrAY6/y8m
         SAGlDNbOzqpcX+UHDVDFJjJdd5ASNK9wBBl8urGKaIPUW8GpmvfWWfs0vguEXS8WCo84
         1yZnL0DzA62UOzR56LvHCoU5qVob54tV1thm8L17uMIO5GIDjD6Fvsh4KBV68HaAky8r
         5FRFbhF1ATcmbTNy+syPC1dbjL3CKk4+rYFQMh4xednVKDXpYywTcU6YJ4/TiY0hycrU
         RSjg==
X-Gm-Message-State: AHYfb5gFAxIzHKA9T4TNV7CL1XrskDLtsdj7O+cDrsVllyJosGEoNNc4
        EB7CBpkpMs+Eb6yl
X-Received: by 10.28.236.70 with SMTP id k67mr699443wmh.30.1501751997328;
        Thu, 03 Aug 2017 02:19:57 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:56 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 16/40] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Thu,  3 Aug 2017 11:19:02 +0200
Message-Id: <20170803091926.1755-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
 external-odb.c | 6 ++++++
 sha1_file.c    | 3 +++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 13694069b1..73ebd99830 100644
--- a/cache.h
+++ b/cache.h
@@ -430,6 +430,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -767,6 +768,14 @@ void reset_shared_repository(void);
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
index 3fd4b10845..bbccabef6b 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -116,6 +117,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -154,6 +156,8 @@ void setup_git_env(void)
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
diff --git a/external-odb.c b/external-odb.c
index a4f8c72e1c..52cb448d01 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -65,6 +65,9 @@ int external_odb_has_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 0;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
@@ -124,6 +127,9 @@ int external_odb_put_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 1;
+
 	/* For now accept only blobs */
 	if (strcmp(type, "blob"))
 		return 1;
diff --git a/sha1_file.c b/sha1_file.c
index 6f6406fb36..3735720bfc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -642,6 +642,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

