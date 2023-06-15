Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFBEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 06:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjFOGEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjFOGD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 02:03:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A111FD4
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 23:03:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30fceb009faso277055f8f.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686809006; x=1689401006;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvDXZIUrDSHfx/uLZZ2sCzkRqMeI/G//L4WR0ZM4HB0=;
        b=dSFevCWBR0eUg0fKbvz0ZXzVxy1osUqK3rLQSwclVXVzVuB3B60JnvbqccWPQdeHHI
         rjylqU7lM/HS8lKjk6cLvBTAFe4u+u8Ua2Obr1G7W8Pg6u/7PQgWhzpWv8I+CK3bCjgv
         msYwflMCYzY1DAdC9n2OeJyD2IYaVrK+fhp/NIFD4+OJUUirEwKsJ9J4/mfo6JGgFoN8
         LQVZkSqnt71DZd5A0Bo2O92NetCGh4GMLFDseCxXqDRR8Y8VcF29+jopcNv2ByVYbOqE
         S49lRUsiQ/WX4l2opsgS1FgGWNdJQdWnJqBTxXZkS0hSMMM8KT8Q6TzPUmNtJarjXWjr
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686809006; x=1689401006;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvDXZIUrDSHfx/uLZZ2sCzkRqMeI/G//L4WR0ZM4HB0=;
        b=OCB4CJHj3gB7ybVUl/54ISRXGUiavDFUxRbCas6wan2mtUFPXrYK2tRCIxa8+39tse
         ON7bymdAJNoc4bEFPfNVDFyC54PkvQfS8wP1YtrMDUcrKfygT2rBaCoRTd+c84UetcpQ
         QaGcqg+MCCb105PcmHd83gyKSiGbqgPnp2A8uN47UqzAKpEzeVVomN4Ct2bI9YtfrhnZ
         xrUvA8JHV9snfD7T2zdKHxuiOxNQ5sjLCj40dyL58fvLweyd4RGqhcwZco/Fm+aAeAZv
         WwqYj2+g3SY63QfvQ1lT9CvLiezYDFY/MpW7dEdruO9INw0LguOGu1eSHE+DJOIiQqPU
         jJdA==
X-Gm-Message-State: AC+VfDyuM9X41hsdhVemo03W2Xi9zL9MhKJ83Gi78kP2PZn03oi+CO6L
        A5HwSUlB7YNYWkQ1uJX6yEpV5hOZCJ0=
X-Google-Smtp-Source: ACHHUZ426iNvTjxgy5mV3awdaE3yC3ORNs0hu1hSdFItRP8gxcvI0N12bAMV6MFVFje/+Mqv2E8qIQ==
X-Received: by 2002:adf:e28d:0:b0:30a:e70d:8022 with SMTP id v13-20020adfe28d000000b0030ae70d8022mr2816833wri.26.1686809005698;
        Wed, 14 Jun 2023 23:03:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020a056000194300b0030ae901bc54sm19989106wry.62.2023.06.14.23.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 23:03:25 -0700 (PDT)
Message-Id: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 06:03:22 +0000
Subject: [PATCH v3 0/2] credential: improvements to erase in helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford (2):
  credential: avoid erasing distinct password
  credential: erase all matching credentials

 Documentation/git-credential.txt   |   2 +-
 Documentation/gitcredentials.txt   |   2 +-
 builtin/credential-cache--daemon.c |  17 +++--
 builtin/credential-store.c         |  18 ++---
 credential.c                       |  11 +--
 credential.h                       |   2 +-
 t/lib-credential.sh                | 103 +++++++++++++++++++++++++++++
 7 files changed, 131 insertions(+), 24 deletions(-)


base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v3
Pull-Request: https://github.com/git/git/pull/1525

Range-diff vs v2:

 1:  35ee1795bcd ! 1:  df3c8a15bf8 credential: avoid erasing distinct password
     @@ builtin/credential-cache--daemon.c: static void cache_credential(struct credenti
       			return &entries[i];
       	}
       	return NULL;
     -@@ builtin/credential-cache--daemon.c: static void remove_credential(const struct credential *c)
     + }
     + 
     +-static void remove_credential(const struct credential *c)
     ++static void remove_credential(const struct credential *c, int match_password)
       {
       	struct credential_cache_entry *e;
       
      -	e = lookup_credential(c);
     -+	e = lookup_credential(c, c->password != NULL);
     ++	e = lookup_credential(c, match_password);
       	if (e)
       		e->expiration = 0;
       }
     @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE
       		if (e) {
       			fprintf(out, "username=%s\n", e->item.username);
       			fprintf(out, "password=%s\n", e->item.password);
     +@@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE *out)
     + 		exit(0);
     + 	}
     + 	else if (!strcmp(action.buf, "erase"))
     +-		remove_credential(&c);
     ++		remove_credential(&c, 1);
     + 	else if (!strcmp(action.buf, "store")) {
     + 		if (timeout < 0)
     + 			warning("cache client didn't specify a timeout");
     + 		else if (!c.username || !c.password)
     + 			warning("cache client gave us a partial credential");
     + 		else {
     +-			remove_credential(&c);
     ++			remove_credential(&c, 0);
     + 			cache_credential(&c, timeout);
     + 		}
     + 	}
      
       ## builtin/credential-store.c ##
      @@ builtin/credential-store.c: static struct lock_file credential_lock;
     @@ builtin/credential-store.c: static struct lock_file credential_lock;
       				  void (*match_cb)(struct credential *),
      -				  void (*other_cb)(struct strbuf *))
      +				  void (*other_cb)(struct strbuf *),
     -+				  const char* op)
     ++				  int match_password)
       {
       	FILE *fh;
       	struct strbuf line = STRBUF_INIT;
     - 	struct credential entry = CREDENTIAL_INIT;
     - 	int found_credential = 0;
     -+	const int match_password = !strcmp(op, "erase") && c->password != NULL;
     - 
     - 	fh = fopen(fn, "r");
     - 	if (!fh) {
      @@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
       
       	while (strbuf_getline_lf(&line, fh) != EOF) {
     @@ builtin/credential-store.c: static void print_line(struct strbuf *buf)
       
       static void rewrite_credential_file(const char *fn, struct credential *c,
      -				    struct strbuf *extra)
     -+				    struct strbuf *extra, const char *op)
     ++				    struct strbuf *extra, int match_password)
       {
       	int timeout_ms = 1000;
       
     @@ builtin/credential-store.c: static void rewrite_credential_file(const char *fn,
       	if (extra)
       		print_line(extra);
      -	parse_credential_file(fn, c, NULL, print_line);
     -+	parse_credential_file(fn, c, NULL, print_line, op);
     ++	parse_credential_file(fn, c, NULL, print_line, match_password);
       	if (commit_lock_file(&credential_lock) < 0)
       		die_errno("unable to write credential store");
       }
     @@ builtin/credential-store.c: static void store_credential_file(const char *fn, st
       	}
       
      -	rewrite_credential_file(fn, c, &buf);
     -+	rewrite_credential_file(fn, c, &buf, "store");
     ++	rewrite_credential_file(fn, c, &buf, 0);
       	strbuf_release(&buf);
       }
       
     @@ builtin/credential-store.c: static void remove_credential(const struct string_li
       	for_each_string_list_item(fn, fns)
       		if (!access(fn->string, F_OK))
      -			rewrite_credential_file(fn->string, c, NULL);
     -+			rewrite_credential_file(fn->string, c, NULL, "erase");
     ++			rewrite_credential_file(fn->string, c, NULL, 1);
       }
       
       static void lookup_credential(const struct string_list *fns, struct credential *c)
     @@ builtin/credential-store.c: static void lookup_credential(const struct string_li
       
       	for_each_string_list_item(fn, fns)
      -		if (parse_credential_file(fn->string, c, print_entry, NULL))
     -+		if (parse_credential_file(fn->string, c, print_entry, NULL, "get"))
     ++		if (parse_credential_file(fn->string, c, print_entry, NULL, 0))
       			return; /* Found credential */
       }
       
     @@ t/lib-credential.sh: helper_test_clean() {
       	reject $1 https example.com user2
       	reject $1 https example.com user4
      +	reject $1 https example.com user5
     ++	reject $1 https example.com user8
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
       	reject $1 https sso.tld
     @@ t/lib-credential.sh: helper_test() {
       		EOF
       	'
       
     ++	test_expect_success "helper ($HELPER) overwrites on store" '
     ++		check approve $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		password=pass1
     ++		EOF
     ++		check approve $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		password=pass2
     ++		EOF
     ++		check fill $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		password=pass2
     ++		EOF
     ++		check reject $HELPER <<-\EOF &&
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		password=pass2
     ++		EOF
     ++		check fill $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user8
     ++		password=askpass-password
     ++		--
     ++		askpass: Password for '\''https://user8@example.com'\'':
     ++		EOF
     ++	'
     ++
     + 	test_expect_success "helper ($HELPER) can forget host" '
     + 		check reject $HELPER <<-\EOF &&
     + 		protocol=https
     +@@ t/lib-credential.sh: helper_test() {
     + 		EOF
     + 	'
     + 
      +	test_expect_success "helper ($HELPER) does not erase a password distinct from input" '
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
 2:  9b12f17dc7e ! 2:  e06d80e99a0 credential: erase all matching credentials
     @@ Commit message
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## Documentation/git-credential.txt ##
     -@@ Documentation/git-credential.txt: to any configured credential helpers, which may store the credential
     - for later use.
     +@@ Documentation/git-credential.txt: for later use.
       
       If the action is `reject`, git-credential will send the description to
     --any configured credential helpers, which may erase any stored
     + any configured credential helpers, which may erase any stored
      -credential matching the description.
     -+any configured credential helpers, which may erase stored credentials
     -+matching the description.
     ++credentials matching the description.
       
       If the action is `approve` or `reject`, no output should be emitted.
       
     @@ builtin/credential-cache--daemon.c: static void cache_credential(struct credenti
       			return &entries[i];
       	}
       	return NULL;
     -@@ builtin/credential-cache--daemon.c: static void remove_credential(const struct credential *c)
     +@@ builtin/credential-cache--daemon.c: static void remove_credential(const struct credential *c, int match_password)
       {
       	struct credential_cache_entry *e;
       
     --	e = lookup_credential(c, c->password != NULL);
     +-	e = lookup_credential(c, match_password);
      -	if (e)
      -		e->expiration = 0;
      +	int i;
      +	for (i = 0; i < entries_nr; i++) {
      +		e = &entries[i];
     -+		if (credential_match(c, &e->item, c->password != NULL))
     ++		if (credential_match(c, &e->item, match_password))
      +			e->expiration = 0;
      +	}
       }
     @@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
       			if (match_cb) {
       				match_cb(&entry);
      -				break;
     -+				if (strcmp(op, "erase"))
     -+					break;
       			}
       		}
       		else if (other_cb)
     @@ t/lib-credential.sh: helper_test_clean() {
       	reject $1 https example.com user5
      +	reject $1 https example.com user6
      +	reject $1 https example.com user7
     + 	reject $1 https example.com user8
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
     - 	reject $1 https sso.tld
      @@ t/lib-credential.sh: helper_test() {
       		EOF
       	'

-- 
gitgitgadget
