Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D68EEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFPTzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 15:55:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539C3598
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 12:55:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f81b449357so10056505e9.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686945308; x=1689537308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnTnQxCNl1ehpcggs7YOjvuQzSvCYS8qzzxyl0hK00=;
        b=GWykWwUDw/jXl1khOqPlKV2PpltZztzeZgXt/JFFZWE1AGFepra8crKHbFOsbyYD27
         4L9qaL4cqBhTtlxTpZkM6jrLw102eV92+CSVwGUOlMrVxl20YuWjGjdoWkDJFPYOemrS
         HpE1hNy7xwaCdmshihskSpEI8hssrpUvHqNFa4oS6a9IhrzsEoDYO+T4CViZSkmEoWtK
         i8loRIEqbNWQXtYG76NnetLEi22X+u6g82ty9YkTEiwbNAoixupu2KQZ/KFpGS8YBJPf
         TjiFzseJmxQR/VjUwBOGqCLJkn4u3QY5cdET6TXUPtAHZjeR/PhUF0mrwcZXJHUbV0wU
         jV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686945308; x=1689537308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSnTnQxCNl1ehpcggs7YOjvuQzSvCYS8qzzxyl0hK00=;
        b=ETRvigbyj88HdQ+EWDgM2NOgzsFTAbrHzlLZ/rzKtUChrm7b7ZdhfHWtfxjDHxkoca
         PECc2rw8AX82s7bcBN3jNhXyFNQr0t2Ubq4VMWpPyXOYCX2KvWgaMREZldcoxEzMw58l
         c7dhAbRsMOA3Vfo/cRG+y8Nn9f1SHPEiGDrXl1XdOz2fE7GmQ49Vk2KTjCCJLR8fMo54
         Xuw1HcPnjvrgiK0XORN+pPKyOgc6P6dqn+1ephmUlVkTPeLkcZa3/pvS42RZHmZ4wh6C
         Tu5iq0PViDQY2X5pwssxQCPXU2RpQfAd/07foJwxuMV5zUudnGfJHbQWpGtv4TM7lEtE
         e0Ew==
X-Gm-Message-State: AC+VfDxZjx+UHgUBiAoBtd/wSPAhU4vQ6ZOH3/zs4oKAzUYuMxbGloUA
        06OKsbz3Lac1s4b0o1geEsAdsQNlxRU=
X-Google-Smtp-Source: ACHHUZ4/eUt0eoGvo4MnVne/ALce0kwZRqV2h10M93+1M0lwv+9dHZbwtvJ1m/NalFt5dpvbJxE5RQ==
X-Received: by 2002:a05:600c:a38a:b0:3f5:6e5:1688 with SMTP id hn10-20020a05600ca38a00b003f506e51688mr2579071wmb.2.1686945307777;
        Fri, 16 Jun 2023 12:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b003110b18fc3asm7795880wrs.93.2023.06.16.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 12:55:07 -0700 (PDT)
Message-Id: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com>
References: <pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jun 2023 19:55:06 +0000
Subject: [PATCH v5] credential/libsecret: store new attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
and a5c76569e7 (credential: new attribute oauth_refresh_token)
introduced new credential attributes.

libsecret assumes attribute values are non-confidential and
unchanging, so we encode the new attributes in the secret, separated by
newline:

    hunter2
    password_expiry_utc=1684189401
    oauth_refresh_token=xyzzy

This is extensible and backwards compatible. The credential protocol
already assumes that attribute values do not contain newlines.

Alternatives considered: store password_expiry_utc in a libsecret
attribute. This has the problem that libsecret creates new items
rather than overwrites when attribute values change.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: store password_expiry_utc and oauth_refresh_token
    
    Test that storing credential with expiry overwrites any old credential
    
    Rename test users for clarity

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1469%2Fhickford%2Flibsecret-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1469/hickford/libsecret-v5
Pull-Request: https://github.com/git/git/pull/1469

Range-diff vs v4:

 1:  07452a10372 ! 1:  38e02c5e24e credential/libsecret: store new attributes
     @@ t/lib-credential.sh: helper_test_clean() {
       	reject $1 https example.com store-user
       	reject $1 https example.com user1
       	reject $1 https example.com user2
     -+	reject $1 https example.com user3
     ++	reject $1 https example.com user-expiry
     ++	reject $1 https example.com user-expiry-overwrite
       	reject $1 https example.com user4
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
     @@ t/lib-credential.sh: helper_test_timeout() {
      +		check approve $HELPER <<-\EOF
      +		protocol=https
      +		host=example.com
     -+		username=user3
     ++		username=user-expiry
      +		password=pass
      +		password_expiry_utc=9999999999
      +		EOF
     @@ t/lib-credential.sh: helper_test_timeout() {
      +		check fill $HELPER <<-\EOF
      +		protocol=https
      +		host=example.com
     -+		username=user3
     ++		username=user-expiry
      +		--
      +		protocol=https
      +		host=example.com
     -+		username=user3
     ++		username=user-expiry
      +		password=pass
      +		password_expiry_utc=9999999999
      +		--
      +		EOF
      +	'
     ++
     ++	test_expect_success "helper ($HELPER) overwrites when password_expiry_utc changes" '
     ++		check approve $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		password=pass1
     ++		password_expiry_utc=9999999998
     ++		EOF
     ++		check approve $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		password=pass2
     ++		password_expiry_utc=9999999999
     ++		EOF
     ++		check fill $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		password=pass2
     ++		password_expiry_utc=9999999999
     ++		EOF
     ++		check reject $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		password=pass2
     ++		EOF
     ++		check fill $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user-expiry-overwrite
     ++		password=askpass-password
     ++		--
     ++		askpass: Password for '\''https://user-expiry-overwrite@example.com'\'':
     ++		EOF
     ++	'
      +}
      +
       helper_test_oauth_refresh_token() {


 .../libsecret/git-credential-libsecret.c      | 78 +++++++++++++++++--
 t/lib-credential.sh                           | 77 ++++++++++++++++++
 t/t0301-credential-cache.sh                   |  1 +
 t/t0303-credential-external.sh                |  2 +
 4 files changed, 152 insertions(+), 6 deletions(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index ef681f29d5b..31cf32ad969 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -39,6 +39,8 @@ struct credential {
 	char *path;
 	char *username;
 	char *password;
+	char *password_expiry_utc;
+	char *oauth_refresh_token;
 };
 
 #define CREDENTIAL_INIT { 0 }
@@ -54,6 +56,25 @@ struct credential_operation {
 
 /* ----------------- Secret Service functions ----------------- */
 
+static const SecretSchema schema = {
+	"org.git.Password",
+	/* Ignore schema name during search for backwards compatibility */
+	SECRET_SCHEMA_DONT_MATCH_NAME,
+	{
+		/*
+		 * libsecret assumes attribute values are non-confidential and
+		 * unchanging, so we can't include oauth_refresh_token or
+		 * password_expiry_utc.
+		 */
+		{  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
+		{  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  NULL, 0 },
+	}
+};
+
 static char *make_label(struct credential *c)
 {
 	if (c->port)
@@ -101,7 +122,7 @@ static int keyring_get(struct credential *c)
 
 	attributes = make_attr_list(c);
 	items = secret_service_search_sync(service,
-					   SECRET_SCHEMA_COMPAT_NETWORK,
+					   &schema,
 					   attributes,
 					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
 					   NULL,
@@ -117,6 +138,7 @@ static int keyring_get(struct credential *c)
 		SecretItem *item;
 		SecretValue *secret;
 		const char *s;
+		gchar **parts;
 
 		item = items->data;
 		secret = secret_item_get_secret(item);
@@ -130,8 +152,27 @@ static int keyring_get(struct credential *c)
 
 		s = secret_value_get_text(secret);
 		if (s) {
-			g_free(c->password);
-			c->password = g_strdup(s);
+			/*
+			 * Passwords and other attributes encoded in following format:
+			 *   hunter2
+			 *   password_expiry_utc=1684189401
+			 *   oauth_refresh_token=xyzzy
+			 */
+			parts = g_strsplit(s, "\n", 0);
+			if (g_strv_length(parts) >= 1) {
+				g_free(c->password);
+				c->password = g_strdup(parts[0]);
+			}
+			for (int i = 1; i < g_strv_length(parts); i++) {
+				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {
+					g_free(c->password_expiry_utc);
+					c->password_expiry_utc = g_strdup(&parts[i][20]);
+				} else if (g_str_has_prefix(parts[i], "oauth_refresh_token=")) {
+					g_free(c->oauth_refresh_token);
+					c->oauth_refresh_token = g_strdup(&parts[i][20]);
+				}
+			}
+			g_strfreev(parts);
 		}
 
 		g_hash_table_unref(attributes);
@@ -148,6 +189,7 @@ static int keyring_store(struct credential *c)
 	char *label = NULL;
 	GHashTable *attributes = NULL;
 	GError *error = NULL;
+	GString *secret = NULL;
 
 	/*
 	 * Sanity check that what we are storing is actually sensible.
@@ -162,13 +204,23 @@ static int keyring_store(struct credential *c)
 
 	label = make_label(c);
 	attributes = make_attr_list(c);
-	secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret = g_string_new(c->password);
+	if (c->password_expiry_utc) {
+		g_string_append_printf(secret, "\npassword_expiry_utc=%s",
+			c->password_expiry_utc);
+	}
+	if (c->oauth_refresh_token) {
+		g_string_append_printf(secret, "\noauth_refresh_token=%s",
+			c->oauth_refresh_token);
+	}
+	secret_password_storev_sync(&schema,
 				    attributes,
 				    NULL,
 				    label,
-				    c->password,
+				    secret->str,
 				    NULL,
 				    &error);
+	g_string_free(secret, TRUE);
 	g_free(label);
 	g_hash_table_unref(attributes);
 
@@ -198,7 +250,7 @@ static int keyring_erase(struct credential *c)
 		return EXIT_FAILURE;
 
 	attributes = make_attr_list(c);
-	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret_password_clearv_sync(&schema,
 				    attributes,
 				    NULL,
 				    &error);
@@ -238,6 +290,8 @@ static void credential_clear(struct credential *c)
 	g_free(c->path);
 	g_free(c->username);
 	g_free(c->password);
+	g_free(c->password_expiry_utc);
+	g_free(c->oauth_refresh_token);
 
 	credential_init(c);
 }
@@ -284,11 +338,19 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "username")) {
 			g_free(c->username);
 			c->username = g_strdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			g_free(c->password_expiry_utc);
+			c->password_expiry_utc = g_strdup(value);
 		} else if (!strcmp(key, "password")) {
 			g_free(c->password);
 			c->password = g_strdup(value);
 			while (*value)
 				*value++ = '\0';
+		} else if (!strcmp(key, "oauth_refresh_token")) {
+			g_free(c->oauth_refresh_token);
+			c->oauth_refresh_token = g_strdup(value);
+			while (*value)
+				*value++ = '\0';
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -314,6 +376,10 @@ static void credential_write(const struct credential *c)
 	/* only write username/password, if set */
 	credential_write_item(stdout, "username", c->username);
 	credential_write_item(stdout, "password", c->password);
+	credential_write_item(stdout, "password_expiry_utc",
+		c->password_expiry_utc);
+	credential_write_item(stdout, "oauth_refresh_token",
+		c->oauth_refresh_token);
 }
 
 static void usage(const char *name)
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index f1ab92ba35c..72f52cfedb2 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -43,6 +43,8 @@ helper_test_clean() {
 	reject $1 https example.com store-user
 	reject $1 https example.com user1
 	reject $1 https example.com user2
+	reject $1 https example.com user-expiry
+	reject $1 https example.com user-expiry-overwrite
 	reject $1 https example.com user4
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
@@ -328,6 +330,81 @@ helper_test_timeout() {
 	'
 }
 
+helper_test_password_expiry_utc() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) stores password_expiry_utc" '
+		check approve $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user-expiry
+		password=pass
+		password_expiry_utc=9999999999
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets password_expiry_utc" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user-expiry
+		--
+		protocol=https
+		host=example.com
+		username=user-expiry
+		password=pass
+		password_expiry_utc=9999999999
+		--
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) overwrites when password_expiry_utc changes" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		password=pass1
+		password_expiry_utc=9999999998
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		password=pass2
+		password_expiry_utc=9999999999
+		EOF
+		check fill $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		--
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		password=pass2
+		password_expiry_utc=9999999999
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		--
+		protocol=https
+		host=example.com
+		username=user-expiry-overwrite
+		password=askpass-password
+		--
+		askpass: Password for '\''https://user-expiry-overwrite@example.com'\'':
+		EOF
+	'
+}
+
 helper_test_oauth_refresh_token() {
 	HELPER=$1
 
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index c02a3b5969c..8300faadea9 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -29,6 +29,7 @@ test_atexit 'git credential-cache exit'
 
 # test that the daemon works with no special setup
 helper_test cache
+helper_test_password_expiry_utc cache
 helper_test_oauth_refresh_token cache
 
 test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index f028fd14182..095574bfc6e 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -45,6 +45,8 @@ test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
 helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
 
 helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
+helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
 
 if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"

base-commit: 9e49351c3060e1fa6e0d2de64505b7becf157f28
-- 
gitgitgadget
