Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB52C6FD1F
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 21:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCNVcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCNVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 17:32:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C536466
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 14:32:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so15613583wrh.9
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678829533;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VyR56x1Y/cFRF/s13+ydv307/8HFwTrq/3CF2eBrs2s=;
        b=GWk9fKndmztbMPLm06v+dUKMkMMGfvxh+alhYu+0GR/xGXxL2LK41dGc33lXhikGxT
         CXIiMMEfXDXRvj3qWk9FwEwOKnnmR9ic8QjcEXUVkXW2NaVk+TrfbJnZcmmaTSS8tIfX
         NR78tXkJvSkNL6LOY8L+tpeS0qz48dHZzinIACHllm3gaT3CagrQ/kvYZOWIGyYoCq4m
         p0BNNiMeFKxAmUHdnWyB+NkMvcHtZbgcMZrOsmOiYVsnu/3WnoaV4ISMGqU/OAKtES8i
         MlVG9baD/aO/viDKPTAM72D+Qb7yoXQxCPgENv38NktJ+Yqk9F8jcSCwbnt/Kl+h+KbR
         R6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829533;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyR56x1Y/cFRF/s13+ydv307/8HFwTrq/3CF2eBrs2s=;
        b=hirzK/3B19TvEnD77Ar3APJLdPv3tDpVQzcDHQ+lENR/zSZblHnxSDG6LYrZkNddPp
         fHfChDASpPF6rnUO0yaDI+Ugnv96kxas0ScKj0xnK9Wq7AiGH7AoN9v0iqVsPaffFoYQ
         7VLI1InA9Mcc1pfSNxb2dwbDQPDUWANak/lDJQBsrf4g7o+uLOfUlbvuxQYqiN4r/yvM
         I043CuaNdFc4cZZ07XIzu2AeJ4ikk+nXZlwL+XBYlQ4ZopUNpwO8EdqSN3J6aOnMfLTS
         jDR8mncxwnyeXpR/3DN+EBJsDif0rI2zdZoIeyAZVO2vQWvXwohpKzA+mP0Wbn15ClaX
         r5iQ==
X-Gm-Message-State: AO0yUKVbPNBi3/iVjqO5GOqdE4/Eqa0j9RvgcQ3d06Qr1du+/Z4m7tGt
        jedKg6U4NmyopMZpBxNFZz13vnHKHSM=
X-Google-Smtp-Source: AK7set+TY7V8jxIhpD9HuUvWwoAEb5+CShm68NkgB/HAiTETTebfV3h9jsA9V61Ena/0SazYr+Nx9A==
X-Received: by 2002:a5d:574d:0:b0:2cf:efa5:5322 with SMTP id q13-20020a5d574d000000b002cfefa55322mr65026wrw.14.1678829532806;
        Tue, 14 Mar 2023 14:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b002cda9aa1dc1sm3036770wru.111.2023.03.14.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:32:12 -0700 (PDT)
Message-Id: <pull.1469.git.git.1678829531648.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 21:32:11 +0000
Subject: [PATCH] credential/libsecret: support password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: store password_expiry_utc

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1469%2Fhickford%2Flibsecret-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1469/hickford/libsecret-v1
Pull-Request: https://github.com/git/git/pull/1469

 .../libsecret/git-credential-libsecret.c      | 42 ++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 2c5d76d789f..3f2b530db79 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -39,6 +39,7 @@ struct credential {
 	char *path;
 	char *username;
 	char *password;
+	char *password_expiry_utc;
 };
 
 #define CREDENTIAL_INIT { 0 }
@@ -54,6 +55,20 @@ struct credential_operation {
 
 /* ----------------- Secret Service functions ----------------- */
 
+static const SecretSchema schema = {
+	"org.git.Password",
+	SECRET_SCHEMA_NONE,
+	{
+		{  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
+		{  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
+		{  NULL, 0 },
+	}
+};
+
 static char *make_label(struct credential *c)
 {
 	if (c->port)
@@ -78,6 +93,9 @@ static GHashTable *make_attr_list(struct credential *c)
 		g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
 	if (c->path)
 		g_hash_table_insert(al, "object", g_strdup(c->path));
+	if (c->password_expiry_utc)
+		g_hash_table_insert(al, "password_expiry_utc",
+			g_strdup(c->password_expiry_utc));
 
 	return al;
 }
@@ -101,9 +119,11 @@ static int keyring_get(struct credential *c)
 
 	attributes = make_attr_list(c);
 	items = secret_service_search_sync(service,
-					   SECRET_SCHEMA_COMPAT_NETWORK,
+					   &schema,
 					   attributes,
-					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
+					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK |
+					   // for backwards compatibility
+					   SECRET_SCHEMA_DONT_MATCH_NAME,
 					   NULL,
 					   &error);
 	g_hash_table_unref(attributes);
@@ -128,6 +148,12 @@ static int keyring_get(struct credential *c)
 			c->username = g_strdup(s);
 		}
 
+		s = g_hash_table_lookup(attributes, "password_expiry_utc");
+		if (s) {
+			g_free(c->password_expiry_utc);
+			c->password_expiry_utc = g_strdup(s);
+		}
+
 		s = secret_value_get_text(secret);
 		if (s) {
 			g_free(c->password);
@@ -162,7 +188,7 @@ static int keyring_store(struct credential *c)
 
 	label = make_label(c);
 	attributes = make_attr_list(c);
-	secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret_password_storev_sync(&schema,
 				    attributes,
 				    NULL,
 				    label,
@@ -198,7 +224,7 @@ static int keyring_erase(struct credential *c)
 		return EXIT_FAILURE;
 
 	attributes = make_attr_list(c);
-	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret_password_clearv_sync(&schema,
 				    attributes,
 				    NULL,
 				    &error);
@@ -238,6 +264,7 @@ static void credential_clear(struct credential *c)
 	g_free(c->path);
 	g_free(c->username);
 	g_free(c->password);
+	g_free(c->password_expiry_utc);
 
 	credential_init(c);
 }
@@ -285,6 +312,9 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "username")) {
 			g_free(c->username);
 			c->username = g_strdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			g_free(c->password_expiry_utc);
+			c->password_expiry_utc = g_strdup(value);
 		} else if (!strcmp(key, "password")) {
 			g_free(c->password);
 			c->password = g_strdup(value);
@@ -312,9 +342,11 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
 
 static void credential_write(const struct credential *c)
 {
-	/* only write username/password, if set */
+	/* only write username/password/expiry, if set */
 	credential_write_item(stdout, "username", c->username);
 	credential_write_item(stdout, "password", c->password);
+	credential_write_item(stdout, "password_expiry_utc",
+		c->password_expiry_utc);
 }
 
 static void usage(const char *name)

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
