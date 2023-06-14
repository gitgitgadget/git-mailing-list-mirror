Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0930BEB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFNVkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFNVko (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:40:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68F268A
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so7156317f8f.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778840; x=1689370840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBv1VcAAqTx5dof3yXNidamA5vfrduJYKrzYxppl+04=;
        b=Qfp0xx8Uf3us6qB4t0yt8niohVVdrXCOlj3u2B6+cbDEETQ+z1RAK6H8SUtGczuwY5
         LdrBfeo6BCYWJDAEdw5PsL3EefnyLqmOH31z61JDHGd2Q4hbHV7YFmIxFm4aWorAgksp
         EcJFLMrprd6p933KyOU0T7gvgxnglQRlJvDJ55kfWj48JQKRMgwkdpB1LoS2W6YfmW30
         FY+dtWvCD0R89Tz8EQf13gNXVFgXEZA4uMJaFxv7VTCkMqzQZMdu++zRYwAn5qsXJxGH
         lMtTZcK412pV718OU35W65D2b4cIqFHLxEDgQe1W8wGxjNUfyLjEwN+/7BMuvplEfdWX
         Kp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778840; x=1689370840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBv1VcAAqTx5dof3yXNidamA5vfrduJYKrzYxppl+04=;
        b=RlKJjtR75l5bf/vGG4mwA/K44MSc27fS3ktqQZLqPtdyVceuq6hwehF4A/vFujn6DH
         JollSPuyky81JGQc5IUL3fNJmQm4gHS+oeJvI2S+qw+bgJq53gBJtJZmZXzafo0jOP/n
         YiCd9argaSCljyuT45rP+eF4EmaxOs/jobMYOd/d930ZS3noFkYlPM7hdc2eJERDNx+a
         McR2J5TaCnsAPd8toWOvjLsqWEjuJkaWWRCiYt5ASmGkSbohSjN/kobOOBqBERY7fzp/
         Yi2pWjIk3JDYuK9e1XmK3aKb7/txJAYJZ+YSDYdMSlTQPUVxW6POi/1GoWxjZGhw3SfB
         YXbg==
X-Gm-Message-State: AC+VfDwTuSAbKuxig/Uaq5/w2ira2s3JoKZ/eMilHLGoZQQ9msyl/WaS
        Ic6JYCn/k7bNkw2g6eDQjuP1uxf+XRM=
X-Google-Smtp-Source: ACHHUZ6Lqnx6LHClUY0lfxxXnhkeEy5BYPD8vVdUTOMA1DQUw0D5aHQVM5JvgQ6B5wsGVlyRwYZiVw==
X-Received: by 2002:a05:6000:196e:b0:30e:5729:b5a5 with SMTP id da14-20020a056000196e00b0030e5729b5a5mr10620330wrb.38.1686778839814;
        Wed, 14 Jun 2023 14:40:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm17035583wrt.47.2023.06.14.14.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:40:39 -0700 (PDT)
Message-Id: <35ee1795bcdb974cdb9ca0f55ddf8f8a5bc562ae.1686778838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
        <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 21:40:37 +0000
Subject: [PATCH v2 1/2] credential: avoid erasing distinct password
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
 builtin/credential-cache--daemon.c |  8 ++++----
 builtin/credential-store.c         | 18 ++++++++++--------
 credential.c                       | 11 ++++++-----
 credential.h                       |  2 +-
 t/lib-credential.sh                | 26 ++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 756c5f02aef..82f376d3351 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
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
@@ -48,7 +48,7 @@ static void remove_credential(const struct credential *c)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c);
+	e = lookup_credential(c, c->password != NULL);
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
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 30c6ccf56c0..e0ae028b1c3 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -13,12 +13,14 @@ static struct lock_file credential_lock;
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
-				  void (*other_cb)(struct strbuf *))
+				  void (*other_cb)(struct strbuf *),
+				  const char* op)
 {
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	const int match_password = !strcmp(op, "erase") && c->password != NULL;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -29,8 +31,8 @@ static int parse_credential_file(const char *fn,
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
 		if (!credential_from_url_gently(&entry, line.buf, 1) &&
-		    entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+			entry.username && entry.password &&
+			credential_match(c, &entry, match_password)) {
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
@@ -60,7 +62,7 @@ static void print_line(struct strbuf *buf)
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
-				    struct strbuf *extra)
+				    struct strbuf *extra, const char *op)
 {
 	int timeout_ms = 1000;
 
@@ -69,7 +71,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
 		print_line(extra);
-	parse_credential_file(fn, c, NULL, print_line);
+	parse_credential_file(fn, c, NULL, print_line, op);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -91,7 +93,7 @@ static void store_credential_file(const char *fn, struct credential *c)
 					is_rfc3986_reserved_or_unreserved);
 	}
 
-	rewrite_credential_file(fn, c, &buf);
+	rewrite_credential_file(fn, c, &buf, "store");
 	strbuf_release(&buf);
 }
 
@@ -138,7 +140,7 @@ static void remove_credential(const struct string_list *fns, struct credential *
 		return;
 	for_each_string_list_item(fn, fns)
 		if (!access(fn->string, F_OK))
-			rewrite_credential_file(fn->string, c, NULL);
+			rewrite_credential_file(fn->string, c, NULL, "erase");
 }
 
 static void lookup_credential(const struct string_list *fns, struct credential *c)
@@ -146,7 +148,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, print_entry, NULL))
+		if (parse_credential_file(fn->string, c, print_entry, NULL, "get"))
 			return; /* Found credential */
 }
 
diff --git a/credential.c b/credential.c
index 023b59d5711..9157ff0865e 100644
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
-	       CHECK(host) &&
-	       CHECK(path) &&
-	       CHECK(username);
+		CHECK(host) &&
+		CHECK(path) &&
+		CHECK(username) &&
+		(!match_password || CHECK(password));
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
index f1ab92ba35c..f7e4e29c5e1 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -44,6 +44,7 @@ helper_test_clean() {
 	reject $1 https example.com user1
 	reject $1 https example.com user2
 	reject $1 https example.com user4
+	reject $1 https example.com user5
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -221,6 +222,31 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) does not erase a password distinct from input" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user5
+		password=pass1
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user5
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user5
+		--
+		protocol=https
+		host=example.com
+		username=user5
+		password=pass1
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) can forget user" '
 		check reject $HELPER <<-\EOF &&
 		protocol=https
-- 
gitgitgadget

