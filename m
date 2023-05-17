Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A1C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 06:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjEQGzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEQGzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 02:55:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D928131
        for <git@vger.kernel.org>; Tue, 16 May 2023 23:55:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3093a778089so204301f8f.1
        for <git@vger.kernel.org>; Tue, 16 May 2023 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684306543; x=1686898543;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWO8N7Qp/IVS7gzEYwLtOoyKr+d2qdY77xW9FbaTP2Q=;
        b=KHD1r0iFO2LlxeMYeTT+0yK1BCyjdl4fO0AbAu5frJPYdIVjT83cDK4WDRmeDrPUaK
         B2EkbQG1gYi5XsZHACW+Xo3204+LY8jHj37xZhIh8zZNheP+5br0CH0ijQRHXxWfUrz6
         ddEW011gYffLCEbMlfnIXZkymhNoxquZfyGWRG/c57ezi/PLgltC7YSj7GECF40lhXn5
         6+BU5chpzdLu1vZF0U2yYZkEe3YR907jRSSeO1WJBaEniOB7LSBmKwHIt6MFZ22/V657
         0efFBfqcsOOJRAmOBbNR9sEsa/5Ab5SK22F0eaAB0pIkPYswFGMUxgtU5Wkt4lmY+fNZ
         sjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306543; x=1686898543;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWO8N7Qp/IVS7gzEYwLtOoyKr+d2qdY77xW9FbaTP2Q=;
        b=OrMjiYKhIV2JAfnxeqcx2+pzwlZvWzPjNOgyVXZOlceYueu9rVtGMWV6LyKiGg+DWG
         r0HI3tI4B8dDx0w1X5CuN0e8Med0QYewNAFMsx+TBgSDXVOiJkzb/0GO1q7E1XoovVR+
         d4+NWBvw8e+m+nSK1xyT231SDbLm9SFJ1fg7l0mS0ZyIVuQ/VVlYTA8qGXIoE7Ty4Aue
         HcUZ05PTfiLDdASchbGDNcW5n4XyTJQH4tWFon2iKOxQuJeo4odFBtcSuFovNJtrrQe/
         HWD7X5YOEk7s48ooqt9rc6NPFw8Hv4SYi5R94mFyxGvUbwNwzXoM9F8CZ5m8kTqpEXVF
         aOTw==
X-Gm-Message-State: AC+VfDzjOqnrOQJ7vX6NbPmCZZJtAIavlsJMsW+vSGxuM9BFw8uAVJ6L
        K12sLWYd+fPcauPtIdqy1U6mfF5K4g4=
X-Google-Smtp-Source: ACHHUZ4YUmb5wSa7SPvrNgprkDzPeSjsu9hR3sSaDZS8XZ/pkOY86aGeCj3Uduy7cbX5M/Bv/J50Ug==
X-Received: by 2002:a5d:680e:0:b0:309:e24:57b0 with SMTP id w14-20020a5d680e000000b003090e2457b0mr10361258wru.30.1684306542812;
        Tue, 16 May 2023 23:55:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b003012030a0c6sm1838302wrs.18.2023.05.16.23.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:55:42 -0700 (PDT)
Message-Id: <pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
References: <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 May 2023 06:55:40 +0000
Subject: [PATCH v4] credential/libsecret: store new attributes
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
    
    Patch v4 stores password_expiry_utc inside secret instead of in an
    attribute.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1469%2Fhickford%2Flibsecret-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1469/hickford/libsecret-v4
Pull-Request: https://github.com/git/git/pull/1469

Range-diff vs v3:

 1:  b46594c8897 ! 1:  07452a10372 credential/libsecret: support password_expiry_utc
     @@ Metadata
      Author: M Hickford <mirth.hickford@gmail.com>
      
       ## Commit message ##
     -    credential/libsecret: support password_expiry_utc
     +    credential/libsecret: store new attributes
      
          d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
     -    introduced this attribute.
     +    and a5c76569e7 (credential: new attribute oauth_refresh_token)
     +    introduced new credential attributes.
     +
     +    libsecret assumes attribute values are non-confidential and
     +    unchanging, so we encode the new attributes in the secret, separated by
     +    newline:
     +
     +        hunter2
     +        password_expiry_utc=1684189401
     +        oauth_refresh_token=xyzzy
     +
     +    This is extensible and backwards compatible. The credential protocol
     +    already assumes that attribute values do not contain newlines.
     +
     +    Alternatives considered: store password_expiry_utc in a libsecret
     +    attribute. This has the problem that libsecret creates new items
     +    rather than overwrites when attribute values change.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
     @@ contrib/credential/libsecret/git-credential-libsecret.c: struct credential {
       	char *username;
       	char *password;
      +	char *password_expiry_utc;
     ++	char *oauth_refresh_token;
       };
       
       #define CREDENTIAL_INIT { 0 }
     @@ contrib/credential/libsecret/git-credential-libsecret.c: struct credential_opera
       
      +static const SecretSchema schema = {
      +	"org.git.Password",
     -+	/* Ignore schema name for backwards compatibility with previous versions */
     ++	/* Ignore schema name during search for backwards compatibility */
      +	SECRET_SCHEMA_DONT_MATCH_NAME,
      +	{
     ++		/*
     ++		 * libsecret assumes attribute values are non-confidential and
     ++		 * unchanging, so we can't include oauth_refresh_token or
     ++		 * password_expiry_utc.
     ++		 */
      +		{  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
      +		{  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
      +		{  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
      +		{  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
      +		{  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
     -+		{  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
      +		{  NULL, 0 },
      +	}
      +};
     @@ contrib/credential/libsecret/git-credential-libsecret.c: struct credential_opera
       static char *make_label(struct credential *c)
       {
       	if (c->port)
     -@@ contrib/credential/libsecret/git-credential-libsecret.c: static GHashTable *make_attr_list(struct credential *c)
     - 		g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
     - 	if (c->path)
     - 		g_hash_table_insert(al, "object", g_strdup(c->path));
     -+	if (c->password_expiry_utc)
     -+		g_hash_table_insert(al, "password_expiry_utc",
     -+			g_strdup(c->password_expiry_utc));
     - 
     - 	return al;
     - }
      @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(struct credential *c)
       
       	attributes = make_attr_list(c);
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(
       					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
       					   NULL,
      @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(struct credential *c)
     - 			c->username = g_strdup(s);
     - 		}
     + 		SecretItem *item;
     + 		SecretValue *secret;
     + 		const char *s;
     ++		gchar **parts;
     + 
     + 		item = items->data;
     + 		secret = secret_item_get_secret(item);
     +@@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(struct credential *c)
       
     -+		s = g_hash_table_lookup(attributes, "password_expiry_utc");
     -+		if (s) {
     -+			g_free(c->password_expiry_utc);
     -+			c->password_expiry_utc = g_strdup(s);
     -+		}
     -+
       		s = secret_value_get_text(secret);
       		if (s) {
     - 			g_free(c->password);
     +-			g_free(c->password);
     +-			c->password = g_strdup(s);
     ++			/*
     ++			 * Passwords and other attributes encoded in following format:
     ++			 *   hunter2
     ++			 *   password_expiry_utc=1684189401
     ++			 *   oauth_refresh_token=xyzzy
     ++			 */
     ++			parts = g_strsplit(s, "\n", 0);
     ++			if (g_strv_length(parts) >= 1) {
     ++				g_free(c->password);
     ++				c->password = g_strdup(parts[0]);
     ++			}
     ++			for (int i = 1; i < g_strv_length(parts); i++) {
     ++				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {
     ++					g_free(c->password_expiry_utc);
     ++					c->password_expiry_utc = g_strdup(&parts[i][20]);
     ++				} else if (g_str_has_prefix(parts[i], "oauth_refresh_token=")) {
     ++					g_free(c->oauth_refresh_token);
     ++					c->oauth_refresh_token = g_strdup(&parts[i][20]);
     ++				}
     ++			}
     ++			g_strfreev(parts);
     + 		}
     + 
     + 		g_hash_table_unref(attributes);
     +@@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_store(struct credential *c)
     + 	char *label = NULL;
     + 	GHashTable *attributes = NULL;
     + 	GError *error = NULL;
     ++	GString *secret = NULL;
     + 
     + 	/*
     + 	 * Sanity check that what we are storing is actually sensible.
      @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_store(struct credential *c)
       
       	label = make_label(c);
       	attributes = make_attr_list(c);
      -	secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
     ++	secret = g_string_new(c->password);
     ++	if (c->password_expiry_utc) {
     ++		g_string_append_printf(secret, "\npassword_expiry_utc=%s",
     ++			c->password_expiry_utc);
     ++	}
     ++	if (c->oauth_refresh_token) {
     ++		g_string_append_printf(secret, "\noauth_refresh_token=%s",
     ++			c->oauth_refresh_token);
     ++	}
      +	secret_password_storev_sync(&schema,
       				    attributes,
       				    NULL,
       				    label,
     +-				    c->password,
     ++				    secret->str,
     + 				    NULL,
     + 				    &error);
     ++	g_string_free(secret, TRUE);
     + 	g_free(label);
     + 	g_hash_table_unref(attributes);
     + 
      @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_erase(struct credential *c)
       		return EXIT_FAILURE;
       
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static void credential_
       	g_free(c->username);
       	g_free(c->password);
      +	g_free(c->password_expiry_utc);
     ++	g_free(c->oauth_refresh_token);
       
       	credential_init(c);
       }
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static int credential_r
       		} else if (!strcmp(key, "password")) {
       			g_free(c->password);
       			c->password = g_strdup(value);
     -@@ contrib/credential/libsecret/git-credential-libsecret.c: static void credential_write_item(FILE *fp, const char *key, const char *value)
     - 
     - static void credential_write(const struct credential *c)
     - {
     --	/* only write username/password, if set */
     -+	/* only write username/password/expiry, if set */
     + 			while (*value)
     + 				*value++ = '\0';
     ++		} else if (!strcmp(key, "oauth_refresh_token")) {
     ++			g_free(c->oauth_refresh_token);
     ++			c->oauth_refresh_token = g_strdup(value);
     ++			while (*value)
     ++				*value++ = '\0';
     + 		}
     + 		/*
     + 		 * Ignore other lines; we don't know what they mean, but
     +@@ contrib/credential/libsecret/git-credential-libsecret.c: static void credential_write(const struct credential *c)
     + 	/* only write username/password, if set */
       	credential_write_item(stdout, "username", c->username);
       	credential_write_item(stdout, "password", c->password);
      +	credential_write_item(stdout, "password_expiry_utc",
      +		c->password_expiry_utc);
     ++	credential_write_item(stdout, "oauth_refresh_token",
     ++		c->oauth_refresh_token);
       }
       
       static void usage(const char *name)
     @@ t/lib-credential.sh: helper_test_clean() {
       	reject $1 https example.com user1
       	reject $1 https example.com user2
      +	reject $1 https example.com user3
     + 	reject $1 https example.com user4
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
     - 	reject $1 https sso.tld
      @@ t/lib-credential.sh: helper_test_timeout() {
       	'
       }
     @@ t/lib-credential.sh: helper_test_timeout() {
      +	'
      +}
      +
     - write_script askpass <<\EOF
     - echo >&2 askpass: $*
     - what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
     + helper_test_oauth_refresh_token() {
     + 	HELPER=$1
     + 
      
       ## t/t0301-credential-cache.sh ##
      @@ t/t0301-credential-cache.sh: test_atexit 'git credential-cache exit'
     + 
       # test that the daemon works with no special setup
       helper_test cache
     - 
      +helper_test_password_expiry_utc cache
     -+
     + helper_test_oauth_refresh_token cache
     + 
       test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
     - 	test_when_finished "
     - 		git credential-cache exit &&
      
       ## t/t0303-credential-external.sh ##
     -@@ t/t0303-credential-external.sh: else
     - 	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
     - fi
     +@@ t/t0303-credential-external.sh: test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
     + helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
       
     + helper_test "$GIT_TEST_CREDENTIAL_HELPER"
      +helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
     -+
     - # clean afterwards so that we are good citizens
     - # and don't leave cruft in the helper's storage, which
     - # might be long-term system storage
     ++helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
     + 
     + if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
     + 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"


 .../libsecret/git-credential-libsecret.c      | 78 +++++++++++++++++--
 t/lib-credential.sh                           | 30 +++++++
 t/t0301-credential-cache.sh                   |  1 +
 t/t0303-credential-external.sh                |  2 +
 4 files changed, 105 insertions(+), 6 deletions(-)

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
index f1ab92ba35c..4ad498adbc4 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -43,6 +43,7 @@ helper_test_clean() {
 	reject $1 https example.com store-user
 	reject $1 https example.com user1
 	reject $1 https example.com user2
+	reject $1 https example.com user3
 	reject $1 https example.com user4
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
@@ -328,6 +329,35 @@ helper_test_timeout() {
 	'
 }
 
+helper_test_password_expiry_utc() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) stores password_expiry_utc" '
+		check approve $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user3
+		password=pass
+		password_expiry_utc=9999999999
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets password_expiry_utc" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user3
+		--
+		protocol=https
+		host=example.com
+		username=user3
+		password=pass
+		password_expiry_utc=9999999999
+		--
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

base-commit: 0df2c180904f6b709766f9c24669a9d01543f915
-- 
gitgitgadget
