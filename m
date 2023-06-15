Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C1EB64DA
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFOTTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFOTTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:19:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE762949
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec3bso23162785e9.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686856775; x=1689448775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4lEVvgUUbgNt8Q3GnCDuWiBIzYqnUarrUqPFxRyykY=;
        b=axVGIG99gXxCBWUZkvpK6veW10Z8oxlZarYuKbClgVh7p0BQGOayZ/jq3pLTHvlk9C
         DOTWClQS71/7MMHo4MYPCJAgnpZbUqvgC7deTINguSsj3hN3i53vRt07CFri09FW8DqT
         VDz/HF+tljEg3Ow9peIOi7GX4hWErS4JJKj/zM/3L2cKJRNUjoMCdlOvE5I8cGGaiPvP
         mxwzIJaZ6uNawxvZ98TdhyiueWN38u2FDznnp+oopvZRWhB9yQ6PcTDOuQtV4SW301NW
         4GtHienaIDIgwCIP+IW8gSOQTZ6XDY39+9eLPBicJYp5W/BRSx92RdW5oEZNgPXf+BfA
         /WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686856775; x=1689448775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4lEVvgUUbgNt8Q3GnCDuWiBIzYqnUarrUqPFxRyykY=;
        b=j3cGABAccyutigXL41OlNcDb7/KP0h3oJ3ef29dJKCfzQg+JpjpHf7bUhawNXZeSkE
         /pTWwLEB4KN6gQZiE4KOZqBioU5LNtpTdy94fPPCDBxEMD5ndCvCFy45rkA4+MJNfpyE
         mSEunaP+ccdWzNkifL5E0N/ixoVBXio9heSPUkRzoM2EuK5JxdqLQdogn1hcs0iE9PiM
         el6aKGsGPfpHz5STjyJ60DPAKib2+kjYdSFagWv5d+fa3B1I4zJnXf7fCUhWVrdIEgBg
         w6njD+cgjDdaUfLZBiyKbALpg2bW7NyLeJ4/QbQLFDYCAjXMA9+6gQAoeW2ySpNAMTYx
         paxg==
X-Gm-Message-State: AC+VfDwFinkFvd/yMWa2cqh73XlCYzfznI552xoFbQbjYAiWJoSXbTWD
        qE92kRHh7NkiFdyJdqbzdeWyxyed8cw=
X-Google-Smtp-Source: ACHHUZ48gOn2jwrha4KI0IulUL9epk8BoN8j0H+M/RgvSwEbIgkGSFkhrtU11TBGaZ4frmbzed3YQQ==
X-Received: by 2002:a7b:c4d4:0:b0:3f6:692:5607 with SMTP id g20-20020a7bc4d4000000b003f606925607mr112997wmk.40.1686856775564;
        Thu, 15 Jun 2023 12:19:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c0b5100b003f7ec896cefsm35013wmr.8.2023.06.15.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:19:35 -0700 (PDT)
Message-Id: <91d4b04b5e1e5a9580c0db72b227f0f60ee0dd58.1686856773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
        <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 19:19:32 +0000
Subject: [PATCH v4 1/2] credential: avoid erasing distinct password
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

Test that credential helpers do not erase a password distinct from the
input. Such calls can happen when multiple credential helpers are
configured.

Fixes for credential-cache and credential-store.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 builtin/credential-cache--daemon.c | 14 +++---
 builtin/credential-store.c         | 15 ++++---
 credential.c                       |  7 +--
 credential.h                       |  2 +-
 t/lib-credential.sh                | 70 ++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 756c5f02aef..f64dd21d335 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -33,22 +33,22 @@ static void cache_credential(struct credential *c, int timeout)
 	e->expiration = time(NULL) + timeout;
 }
 
-static struct credential_cache_entry *lookup_credential(const struct credential *c)
+static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
 {
 	int i;
 	for (i = 0; i < entries_nr; i++) {
 		struct credential *e = &entries[i].item;
-		if (credential_match(c, e))
+		if (credential_match(c, e, match_password))
 			return &entries[i];
 	}
 	return NULL;
 }
 
-static void remove_credential(const struct credential *c)
+static void remove_credential(const struct credential *c, int match_password)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c);
+	e = lookup_credential(c, match_password);
 	if (e)
 		e->expiration = 0;
 }
@@ -127,7 +127,7 @@ static void serve_one_client(FILE *in, FILE *out)
 	if (read_request(in, &c, &action, &timeout) < 0)
 		/* ignore error */ ;
 	else if (!strcmp(action.buf, "get")) {
-		struct credential_cache_entry *e = lookup_credential(&c);
+		struct credential_cache_entry *e = lookup_credential(&c, 0);
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
@@ -151,14 +151,14 @@ static void serve_one_client(FILE *in, FILE *out)
 		exit(0);
 	}
 	else if (!strcmp(action.buf, "erase"))
-		remove_credential(&c);
+		remove_credential(&c, 1);
 	else if (!strcmp(action.buf, "store")) {
 		if (timeout < 0)
 			warning("cache client didn't specify a timeout");
 		else if (!c.username || !c.password)
 			warning("cache client gave us a partial credential");
 		else {
-			remove_credential(&c);
+			remove_credential(&c, 0);
 			cache_credential(&c, timeout);
 		}
 	}
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 30c6ccf56c0..0937230bced 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -13,7 +13,8 @@ static struct lock_file credential_lock;
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
-				  void (*other_cb)(struct strbuf *))
+				  void (*other_cb)(struct strbuf *),
+				  int match_password)
 {
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
@@ -30,7 +31,7 @@ static int parse_credential_file(const char *fn,
 	while (strbuf_getline_lf(&line, fh) != EOF) {
 		if (!credential_from_url_gently(&entry, line.buf, 1) &&
 		    entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+		    credential_match(c, &entry, match_password)) {
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
@@ -60,7 +61,7 @@ static void print_line(struct strbuf *buf)
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
-				    struct strbuf *extra)
+				    struct strbuf *extra, int match_password)
 {
 	int timeout_ms = 1000;
 
@@ -69,7 +70,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
 		print_line(extra);
-	parse_credential_file(fn, c, NULL, print_line);
+	parse_credential_file(fn, c, NULL, print_line, match_password);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -91,7 +92,7 @@ static void store_credential_file(const char *fn, struct credential *c)
 					is_rfc3986_reserved_or_unreserved);
 	}
 
-	rewrite_credential_file(fn, c, &buf);
+	rewrite_credential_file(fn, c, &buf, 0);
 	strbuf_release(&buf);
 }
 
@@ -138,7 +139,7 @@ static void remove_credential(const struct string_list *fns, struct credential *
 		return;
 	for_each_string_list_item(fn, fns)
 		if (!access(fn->string, F_OK))
-			rewrite_credential_file(fn->string, c, NULL);
+			rewrite_credential_file(fn->string, c, NULL, 1);
 }
 
 static void lookup_credential(const struct string_list *fns, struct credential *c)
@@ -146,7 +147,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, print_entry, NULL))
+		if (parse_credential_file(fn->string, c, print_entry, NULL, 0))
 			return; /* Found credential */
 }
 
diff --git a/credential.c b/credential.c
index 023b59d5711..8825c6f1320 100644
--- a/credential.c
+++ b/credential.c
@@ -33,13 +33,14 @@ void credential_clear(struct credential *c)
 }
 
 int credential_match(const struct credential *want,
-		     const struct credential *have)
+		     const struct credential *have, int match_password)
 {
 #define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
 	return CHECK(protocol) &&
 	       CHECK(host) &&
 	       CHECK(path) &&
-	       CHECK(username);
+	       CHECK(username) &&
+	       (!match_password || CHECK(password));
 #undef CHECK
 }
 
@@ -102,7 +103,7 @@ static int match_partial_url(const char *url, void *cb)
 		warning(_("skipping credential lookup for key: credential.%s"),
 			url);
 	else
-		matches = credential_match(&want, c);
+		matches = credential_match(&want, c, 0);
 	credential_clear(&want);
 
 	return matches;
diff --git a/credential.h b/credential.h
index b8e2936d1dc..acc41adf548 100644
--- a/credential.h
+++ b/credential.h
@@ -211,6 +211,6 @@ void credential_from_url(struct credential *, const char *url);
 int credential_from_url_gently(struct credential *, const char *url, int quiet);
 
 int credential_match(const struct credential *want,
-		     const struct credential *have);
+		     const struct credential *have, int match_password);
 
 #endif /* CREDENTIAL_H */
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index f1ab92ba35c..77baec53b6a 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -44,6 +44,8 @@ helper_test_clean() {
 	reject $1 https example.com user1
 	reject $1 https example.com user2
 	reject $1 https example.com user4
+	reject $1 https example.com user-distinct-pass
+	reject $1 https example.com user-overwrite
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -167,6 +169,49 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) overwrites on store" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		password=pass1
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		--
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		password=pass2
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		--
+		protocol=https
+		host=example.com
+		username=user-overwrite
+		password=askpass-password
+		--
+		askpass: Password for '\''https://user-overwrite@example.com'\'':
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) can forget host" '
 		check reject $HELPER <<-\EOF &&
 		protocol=https
@@ -221,6 +266,31 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) does not erase a password distinct from input" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-distinct-pass
+		password=pass1
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-distinct-pass
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user-distinct-pass
+		--
+		protocol=https
+		host=example.com
+		username=user-distinct-pass
+		password=pass1
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) can forget user" '
 		check reject $HELPER <<-\EOF &&
 		protocol=https
-- 
gitgitgadget

