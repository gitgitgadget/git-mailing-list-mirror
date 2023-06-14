Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EDEB64DC
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFNVkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFNVkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:40:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1A180
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af56f5f52so5195590f8f.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778841; x=1689370841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3v/al3YVbEFfhDQKhnrk+4qNa0I2cPB73OttqA7p7o=;
        b=bJRSW8OaP493TZvop0QQ76OcaM8FrQKOY1SZO62TaMLfwocHBRyfKQ9S0obyF+WdeB
         41zRCQM/rdAheTHLzio+Wbh8s2Ki2SPXOCbBAIwF7cmVb33gRgSdWRatbh8KydbBGMBR
         BnAiNjEiJDmAdCeFVWZ9rnW6HlrC2qh0b1LkjX6VIOP7OZpRveBbS88PMRvGPKHywnBP
         8kBOVQjRW5ThqHnVz9xrZOz9MJeLXz4rDQcPom1Bix02l4lahPzGdgssYc0RS+y62h1T
         OhUIo2tfSt+eKmIOhOzGZjdPgeIyoc7tuvltiF5By61iA1bUhgXG68UW4dsTicy9z3A6
         adWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778841; x=1689370841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3v/al3YVbEFfhDQKhnrk+4qNa0I2cPB73OttqA7p7o=;
        b=K3qwXUDLx0GeKKhLCgJHKIFmLew0xa8AsU8qiIAhk0CW/btBiQPfzCWEBfZ4JfRSpR
         TmUqgG9jrMBmuWXDn98oSQZgbeDKPEoe2NpFBEa5njnOQWjsM26NP3zOPqUCAN4LCm2z
         yQg4HYeQscGZTWAKRdJSnVl6lYpUO6jPB1GTJ7q9TqpiWASRs6DL3SFqO+eGI6H/cmub
         /V4LGs18H5ssdH0Rn33zqZODSiNpnx05/mvvxQbNlSxYUnsA5+zGf/JTGCsNtzBeCjqK
         5ndkYwefGLzJExi9Qr2RacUjyQdKWL1ztIhhm52wnU81mOKlgX00RxA5jIQi1ihpsmVc
         fsCA==
X-Gm-Message-State: AC+VfDzYAsl1H5QBFhr8lNAt1liRO2yl0UvLDlT4/Ogg3DiH4rGERs5F
        WO/qK0soayLMWZbZd26P1KZw6x2//w8=
X-Google-Smtp-Source: ACHHUZ6f38YdRdjcie5YRq1Y+aBNPXqBKIc3ahn4h+GrSmDRBZlUtUfTht8KXRSpaIyrfrsgQjf+aQ==
X-Received: by 2002:adf:e906:0:b0:30f:be0f:fbf with SMTP id f6-20020adfe906000000b0030fbe0f0fbfmr7625724wrm.22.1686778840963;
        Wed, 14 Jun 2023 14:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0030fb98484f6sm12287875wrt.114.2023.06.14.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:40:40 -0700 (PDT)
Message-Id: <9b12f17dc7ebbab9b1625ad0c6058133b8a53323.1686778838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
        <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 21:40:38 +0000
Subject: [PATCH v2 2/2] credential: erase all matching credentials
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

`credential reject` sends the erase action to each helper, but the
exact behaviour of erase isn't specified in documentation or tests.
Some helpers (such as credential-libsecret) delete all matching
credentials, others (such as credential-cache and credential-store)
delete at most one matching credential.

Test that helpers erase all matching credentials. This behaviour is
easiest to reason about. Users expect that `echo
"url=https://example.com" | git credential reject` or `echo
"url=https://example.com\nusername=tim" | git credential reject` erase
all matching credentials.

Fix credential-cache and credential-store.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/git-credential.txt   |  4 ++--
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 15 ++++++++------
 builtin/credential-store.c         |  3 ++-
 t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 0e6d9e85ec7..04bfb918de6 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -38,8 +38,8 @@ to any configured credential helpers, which may store the credential
 for later use.
 
 If the action is `reject`, git-credential will send the description to
-any configured credential helpers, which may erase any stored
-credential matching the description.
+any configured credential helpers, which may erase stored credentials
+matching the description.
 
 If the action is `approve` or `reject`, no output should be emitted.
 
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 100f045bb1a..65d652dc40e 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -260,7 +260,7 @@ appended to its command line, which is one of:
 
 `erase`::
 
-	Remove a matching credential, if any, from the helper's storage.
+	Remove matching credentials, if any, from the helper's storage.
 
 The details of the credential will be provided on the helper's stdin
 stream. The exact format is the same as the input/output format of the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 82f376d3351..5e3a766e42d 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
 	e->expiration = time(NULL) + timeout;
 }
 
-static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
+static struct credential_cache_entry *lookup_credential(const struct credential *c)
 {
 	int i;
 	for (i = 0; i < entries_nr; i++) {
 		struct credential *e = &entries[i].item;
-		if (credential_match(c, e, match_password))
+		if (credential_match(c, e, 0))
 			return &entries[i];
 	}
 	return NULL;
@@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c, c->password != NULL);
-	if (e)
-		e->expiration = 0;
+	int i;
+	for (i = 0; i < entries_nr; i++) {
+		e = &entries[i];
+		if (credential_match(c, &e->item, c->password != NULL))
+			e->expiration = 0;
+	}
 }
 
 static timestamp_t check_expirations(void)
@@ -127,7 +130,7 @@ static void serve_one_client(FILE *in, FILE *out)
 	if (read_request(in, &c, &action, &timeout) < 0)
 		/* ignore error */ ;
 	else if (!strcmp(action.buf, "get")) {
-		struct credential_cache_entry *e = lookup_credential(&c, 0);
+		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index e0ae028b1c3..85b147e460f 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -36,7 +36,8 @@ static int parse_credential_file(const char *fn,
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
-				break;
+				if (strcmp(op, "erase"))
+					break;
 			}
 		}
 		else if (other_cb)
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index f7e4e29c5e1..3f4100b6ce2 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -45,6 +45,8 @@ helper_test_clean() {
 	reject $1 https example.com user2
 	reject $1 https example.com user4
 	reject $1 https example.com user5
+	reject $1 https example.com user6
+	reject $1 https example.com user7
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -298,6 +300,37 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) erases all matching credentials" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user6
+		password=pass1
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user7
+		password=pass1
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		protocol=https
+		host=example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		EOF
+	'
+
 	: ${GIT_TEST_LONG_CRED_BUFFER:=1024}
 	# 23 bytes accounts for "wwwauth[]=basic realm=" plus NUL
 	LONG_VALUE_LEN=$((GIT_TEST_LONG_CRED_BUFFER - 23))
-- 
gitgitgadget
