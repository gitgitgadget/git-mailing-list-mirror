Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE61C00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjARDa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjARDae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79753B14
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so32596417wrz.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiuOwIpPh651aZ2hK+ip9NyOtHBGpuZ3/Qaj6I00OOk=;
        b=J3U1ohbLK7XAlLR6/pTd49QgiTqhs39b6/jRhLf23tjHkA+uezbqxEJivvCPCIVrkk
         e1YoH5HF6W5TnFE6B4/buu5l30LenqByfNWj/CEcgm+dl4MPl/DESrQuykgsbQ02mSk1
         kc/YrrIh4i8Rjt4mkdZrZTzm0aAE5jWGuO14id/LwjBzsmh7HwCDbnkqD6/HKU0mmMn8
         HsnrwfcOTsyfvxrMjhrr1pnCiKt7zzWt+wE97kxCwBBEOh4Hh0SHOBLC62nMCEvu9ecF
         LKe+YSP3J2gmDlXkQC1oOzXO7EFlmihVySgwaUv7dXFyB9+k9sprZpilR12n4zyR52r2
         M2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiuOwIpPh651aZ2hK+ip9NyOtHBGpuZ3/Qaj6I00OOk=;
        b=6Wxd5bKtOu4iE6DWBX+Xi0MMPPD4byfOUihfxvU7/GAOWBUHjdoG1rwTnsfZgNqQo/
         JqdiUE2xQR36R91ab/a/4FVuJne9rjXYX/0pifZpOCP8xtHO6nipEVozlDpuY1U2SLgv
         OfX2251KqAxfPWcYzbTGd4vPSKKfo5Rium3luiAAaS1dd/jH5WkgExieMBCIMoMorHQ2
         9MuMzqFfiNRppMsosY0gXuDUuiThuXAVo1A5S9wJdt/4GHYsPkoQUpl9UI+tPBIUp1tQ
         azzczgzdgLj5yr1xwAUDnpgemlHHX2FdDzpFcfCWkGUJGqTFNsJ/gTDBBYgnJxEg7rns
         w2pg==
X-Gm-Message-State: AFqh2kqaQKLDN4jqt55k1qvepjExP1Rp7lEU4YgIkHwlJwuv4bzPnM5C
        5Y2K+qUcVvZEvD4GKFvFR/UcCA7iI1c=
X-Google-Smtp-Source: AMrXdXveg1Kh9ZZYAfgIjrYh7UXOJObS89s4bzBCiHl58pmtPmayRHNC2u8DYnPJZvXdOLFcduzD0A==
X-Received: by 2002:a5d:554f:0:b0:2be:14e:15f3 with SMTP id g15-20020a5d554f000000b002be014e15f3mr4438254wrw.53.1674012626893;
        Tue, 17 Jan 2023 19:30:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d64e2000000b002be063f6820sm8895726wri.81.2023.01.17.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:26 -0800 (PST)
Message-Id: <a1ff55dd6e25aa39f14b494f482720edf7d1eabd.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:13 +0000
Subject: [PATCH v6 08/12] test-http-server: add simple authentication
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add simple authentication to the test-http-server test helper.
Authentication schemes and sets of valid tokens can be specified via
a configuration file (in the normal gitconfig file format).
Incoming requests are compared against the set of valid schemes and
tokens and only approved if a matching token is found, or if no auth
was provided and anonymous auth is enabled.

Configuration for auth includes a simple set of three options:

[auth]
	challenge = <scheme>[:<challenge_params>]
	token = <scheme>:[<token>]*
	allowAnonymous = <bool>

`auth.challenge` allows you define what authentication schemes, and
optional challenge parameters the server should use. Scheme names are
unique and subsequently specified challenge parameters in the config
file will replace previously specified ones.

`auth.token` allows you to define the set of value token values for an
authentication scheme. This is a multi-var and each entry in the
config file will append to the set of valid tokens for that scheme.
Specifying an empty token value will clear the list of tokens so far for
that scheme, i.e. `token = <scheme>:`.

`auth.allowAnonymous` controls whether or not unauthenticated requests
(those without any `Authorization` headers) should succeed or not, and
trigger a 401 Unauthorized response.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 233 +++++++++++++++++++++++++++++++++++-
 t/t5556-http-auth.sh        |  43 ++++++-
 2 files changed, 273 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index ae17c738259..691fbfb51d6 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -7,6 +7,7 @@
 #include "version.h"
 #include "dir.h"
 #include "date.h"
+#include "config.h"
 
 #define TR2_CAT "test-http-server"
 
@@ -19,6 +20,7 @@ static const char test_http_auth_usage[] =
 "           [--timeout=<n>] [--max-connections=<n>]\n"
 "           [--reuseaddr] [--pid-file=<file>]\n"
 "           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
+"           [--auth-config=<file>]\n"
 ;
 
 static unsigned int timeout;
@@ -317,7 +319,7 @@ static int is_git_request(struct req *req)
 		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
 }
 
-static enum worker_result do__git(struct req *req)
+static enum worker_result do__git(struct req *req, const char *user)
 {
 	const char *ok = "HTTP/1.1 200 OK\r\n";
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -334,10 +336,16 @@ static enum worker_result do__git(struct req *req)
 	 * exit status of the process, then write the HTTP status line followed
 	 * by the http-backend output. This is outside of the scope of this test
 	 * helper's use at time of writing.
+	 *
+	 * The important auth responses (401) we are handling prior to getting
+	 * to this point.
 	 */
 	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
 		return error(_("could not send '%s'"), ok);
 
+	if (user)
+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
+
 	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
 			req->uri_path.buf);
@@ -359,10 +367,218 @@ static enum worker_result do__git(struct req *req)
 	return !!res;
 }
 
+enum auth_result {
+	/* No auth module matches the request. */
+	AUTH_UNKNOWN = 0,
+
+	/* Auth module denied the request. */
+	AUTH_DENY = 1,
+
+	/* Auth module successfully validated the request. */
+	AUTH_ALLOW = 2,
+};
+
+struct auth_module {
+	char *scheme;
+	char *challenge_params;
+	struct string_list *tokens;
+};
+
+static int allow_anonymous;
+static struct auth_module **auth_modules = NULL;
+static size_t auth_modules_nr = 0;
+static size_t auth_modules_alloc = 0;
+
+static struct auth_module *get_auth_module(const char *scheme, int create)
+{
+	int i;
+	struct auth_module *mod;
+	for (i = 0; i < auth_modules_nr; i++) {
+		mod = auth_modules[i];
+		if (!strcasecmp(mod->scheme, scheme))
+			return mod;
+	}
+
+	if (create) {
+		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
+		mod->scheme = xstrdup(scheme);
+		mod->challenge_params = NULL;
+		CALLOC_ARRAY(mod->tokens, 1);
+		string_list_init_dup(mod->tokens);
+
+		ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
+		auth_modules[auth_modules_nr++] = mod;
+
+		return mod;
+	}
+
+	return NULL;
+}
+
+static int is_authed(struct req *req, const char **user, enum worker_result *wr)
+{
+	enum auth_result result = AUTH_UNKNOWN;
+	struct string_list hdrs = STRING_LIST_INIT_NODUP;
+	struct auth_module *mod;
+
+	struct string_list_item *hdr;
+	struct string_list_item *token;
+	const char *v;
+	struct strbuf **split = NULL;
+	int i;
+	char *challenge;
+
+	/*
+	 * Check all auth modules and try to validate the request.
+	 * The first Authorization header that matches a known auth module
+	 * scheme will be consulted to either approve or deny the request.
+	 * If no module is found, or if there is no valid token, then 401 error.
+	 * Otherwise, only permit the request if anonymous auth is enabled.
+	 * It's atypical for user agents/clients to send multiple Authorization
+	 * headers, but not explicitly forbidden or defined.
+	 */
+	for_each_string_list_item(hdr, &req->header_list) {
+		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
+			split = strbuf_split_str(v, ' ', 2);
+			if (!split[0] || !split[1]) continue;
+
+			/* trim trailing space ' ' */
+			strbuf_setlen(split[0], split[0]->len - 1);
+
+			mod = get_auth_module(split[0]->buf, 0);
+			if (mod) {
+				result = AUTH_DENY;
+
+				for_each_string_list_item(token, mod->tokens) {
+					if (!strcmp(split[1]->buf, token->string)) {
+						result = AUTH_ALLOW;
+						break;
+					}
+				}
+
+				goto done;
+			}
+		}
+	}
+
+done:
+	switch (result) {
+	case AUTH_ALLOW:
+		trace2_printf("%s: auth '%s' ALLOW", TR2_CAT, mod->scheme);
+		*user = "VALID_TEST_USER";
+		*wr = WR_OK;
+		break;
+
+	case AUTH_DENY:
+		trace2_printf("%s: auth '%s' DENY", TR2_CAT, mod->scheme);
+		/* fall-through */
+
+	case AUTH_UNKNOWN:
+		if (result != AUTH_DENY && allow_anonymous)
+			break;
+
+		for (i = 0; i < auth_modules_nr; i++) {
+			mod = auth_modules[i];
+			if (mod->challenge_params)
+				challenge = xstrfmt("WWW-Authenticate: %s %s",
+						    mod->scheme,
+						    mod->challenge_params);
+			else
+				challenge = xstrfmt("WWW-Authenticate: %s",
+						    mod->scheme);
+			string_list_append(&hdrs, challenge);
+		}
+
+		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
+				      &hdrs, *wr);
+	}
+
+	strbuf_list_free(split);
+	string_list_clear(&hdrs, 0);
+
+	return result == AUTH_ALLOW ||
+	      (result == AUTH_UNKNOWN && allow_anonymous);
+}
+
+static int split_auth_param(const char *str, char **scheme, char **val)
+{
+	struct strbuf **p = strbuf_split_str(str, ':', 2);
+
+	if (!p[0])
+		return -1;
+
+	/* trim trailing ':' */
+	if (p[0]->len > 0 && p[0]->buf[p[0]->len - 1] == ':')
+		strbuf_setlen(p[0], p[0]->len - 1);
+
+	*scheme = strbuf_detach(p[0], NULL);
+
+	if (p[1])
+		*val = strbuf_detach(p[1], NULL);
+
+	strbuf_list_free(p);
+	return 0;
+}
+
+static int read_auth_config(const char *name, const char *val, void *data)
+{
+	int ret = 0;
+	char *scheme = NULL;
+	char *token = NULL;
+	char *challenge = NULL;
+	struct auth_module *mod = NULL;
+
+	if (!strcmp(name, "auth.challenge")) {
+		if (split_auth_param(val, &scheme, &challenge)) {
+			ret = error("invalid auth challenge '%s'", val);
+			goto cleanup;
+		}
+
+		mod = get_auth_module(scheme, 1);
+
+		/* Replace any existing challenge parameters */
+		free(mod->challenge_params);
+		mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
+	} else if (!strcmp(name, "auth.token")) {
+		if (split_auth_param(val, &scheme, &token)) {
+			ret = error("invalid auth token '%s'", val);
+			goto cleanup;
+		}
+
+		mod = get_auth_module(scheme, 1);
+
+		/*
+		 * Append to set of valid tokens unless an empty token value
+		 * is provided, then clear the existing list.
+		 */
+		if (token)
+			string_list_append(mod->tokens, token);
+		else
+			string_list_clear(mod->tokens, 1);
+	} else if (!strcmp(name, "auth.allowanonymous")) {
+		allow_anonymous = git_config_bool(name, val);
+	} else {
+		warning("unknown auth config '%s'", name);
+	}
+
+cleanup:
+	free(scheme);
+	free(token);
+	free(challenge);
+
+	return ret;
+}
+
 static enum worker_result dispatch(struct req *req)
 {
+	enum worker_result wr = WR_OK;
+	const char *user = NULL;
+
+	if (!is_authed(req, &user, &wr))
+		return wr;
+
 	if (is_git_request(req))
-		return do__git(req);
+		return do__git(req, user);
 
 	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
 			       WR_OK | WR_HANGUP);
@@ -621,6 +837,19 @@ int cmd_main(int argc, const char **argv)
 			pid_file = v;
 			continue;
 		}
+		if (skip_prefix(arg, "--auth-config=", &v)) {
+			if (!strlen(v)) {
+				error("invalid argument - missing file path");
+				usage(test_http_auth_usage);
+			}
+
+			if (git_config_from_file(read_auth_config, v, NULL)) {
+				error("failed to read auth config file '%s'", v);
+				usage(test_http_auth_usage);
+			}
+
+			continue;
+		}
 
 		fprintf(stderr, "error: unknown argument '%s'\n", arg);
 		usage(test_http_auth_usage);
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index ce1abffa6aa..cb5562a41bf 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -95,10 +95,51 @@ per_test_cleanup () {
 	rm -f OUT.*
 }
 
+test_expect_success CURL 'http auth server auth config' '
+	#test_when_finished "per_test_cleanup" &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = no-params
+		challenge = with-params:foo=\"bar\" p=1
+		challenge = with-params:foo=\"replaced\" q=1
+
+		token = no-explicit-challenge:valid-token
+		token = no-explicit-challenge:also-valid
+		token = reset-tokens:these-tokens
+		token = reset-tokens:will-be-reset
+		token = reset-tokens:
+		token = reset-tokens:the-only-valid-one
+
+		allowAnonymous = false
+	EOF
+
+	cat >OUT.expected <<-EOF &&
+	WWW-Authenticate: no-params
+	WWW-Authenticate: with-params foo="replaced" q=1
+	WWW-Authenticate: no-explicit-challenge
+	WWW-Authenticate: reset-tokens
+
+	Error: 401 Unauthorized
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	curl --include $ORIGIN_URL >OUT.curl &&
+	tr -d "\r" <OUT.curl | sed -n "/WWW-Authenticate/,\$p" >OUT.actual &&
+
+	test_cmp OUT.expected OUT.actual
+'
+
 test_expect_success 'http auth anonymous no challenge' '
 	test_when_finished "per_test_cleanup" &&
 
-	start_http_server &&
+	cat >auth.config <<-EOF &&
+	[auth]
+		allowAnonymous = true
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
 
 	# Attempt to read from a protected repository
 	git ls-remote $ORIGIN_URL
-- 
gitgitgadget

