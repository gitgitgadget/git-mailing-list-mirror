Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB2C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjATWJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjATWJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8DA19AC
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so5076196wms.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8JoO8W1wcgDBqTd5Hya39NGP1gdBhM31YoNnivPdCY=;
        b=Pg9sybeub1pD0EqbnswBVRv60nYxvsu8EJtVQWuyeOI1gSR7jSTcryRLo3gl0fptwg
         Ypf9Jp8EMg/6Cd1HH11b/JNDMdVHxXCHAMQKs2rD3Wuq0Mhxn+FQIzR5Su1ABQDcNwXc
         UJ/vu+tZAPBHKsOsVCEm8cDQ4wSL2PVDvkyTCv5oy7k7zxYMzLNNckWVAIkHzCJ2ChZX
         0kix/RkwOfJa2rOHLFETQ+ezdzobVz+GiMQC9oBwOAIV1Qag0jsqNq7sfzzMCThsflJ/
         EDa/AjZ80+lFOXgIDnoZvIaTJ4weNX0wI2UTByrYBdiz71tu8umNcXRvQXI+3Tzbgvin
         fU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8JoO8W1wcgDBqTd5Hya39NGP1gdBhM31YoNnivPdCY=;
        b=z3ZnDdpipHtGdZ3mXtcdEvh2TyNMDK5YeLIzyH5gnKRg8lxnJOXE8CILuHwtHjD/vR
         ipfb1AR8qKGVO52DnlD1jISvK7dmQ5l7/ECTPW6lBLAigUIhLos0Gu7BXyp/Pz8RdbD2
         Sdv2UVZ1B5p4QvuPXhb019efkriJ/W20Hc3dY+ZfEZDD7ipD88Y3RZPY0k0WAxYn7so9
         iBPPc8hTXhd/X1q42LIrKBhBrWNqWXU01oClL3QXiTtp4ce33x6m5p5b206MJPhKUb3Z
         PRkd/JflgyVKqdLgfHhaMTJamFTACZMeof8ZxLwa/yFhNrXx7qwlKYrHHqfHjY5mgJKj
         OJkQ==
X-Gm-Message-State: AFqh2krhvFMpASCrHjxzxYToUXZShteHGBwKleUHJExD0L1mVgFucRVu
        2xkG6y2eDnxlOnOtyp4NuoXiUf9ZOfE=
X-Google-Smtp-Source: AMrXdXvHZk8vc9FbL7TQAkVnnZ5aHk7Mnw3OEvxvPfiFMh5RVRRPfwCbKDxUlpKBNZcz8NCCcGuUAg==
X-Received: by 2002:a05:600c:810:b0:3da:f0e:fe34 with SMTP id k16-20020a05600c081000b003da0f0efe34mr15096312wmp.32.1674252539339;
        Fri, 20 Jan 2023 14:08:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003dafa04ecc4sm3381999wmi.6.2023.01.20.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:58 -0800 (PST)
Message-Id: <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:46 +0000
Subject: [PATCH v7 08/12] test-http-server: add simple authentication
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
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
 t/helper/test-http-server.c | 232 +++++++++++++++++++++++++++++++++++-
 t/t5556-http-auth.sh        |  43 ++++++-
 2 files changed, 272 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 4191daf3c64..72c6cca7e5c 100644
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
@@ -349,7 +351,7 @@ static int is_git_request(struct req *req)
 		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
 }
 
-static enum worker_result do__git(struct req *req)
+static enum worker_result do__git(struct req *req, const char *user)
 {
 	const char *ok = "HTTP/1.1 200 OK\r\n";
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -366,10 +368,16 @@ static enum worker_result do__git(struct req *req)
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
 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s", req->uri_path.buf);
 	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
@@ -388,10 +396,217 @@ static enum worker_result do__git(struct req *req)
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
+	struct auth_module *mod;
+	for (size_t i = 0; i < auth_modules_nr; i++) {
+		mod = auth_modules[i];
+		if (!strcasecmp(mod->scheme, scheme))
+			return mod;
+	}
+
+	if (create) {
+		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
+		mod->scheme = xstrdup(scheme);
+		mod->challenge_params = NULL;
+		ALLOC_ARRAY(mod->tokens, 1);
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
+			if (split[0] && split[1]) {
+				/* trim trailing space ' ' */
+				strbuf_rtrim(split[0]);
+
+				mod = get_auth_module(split[0]->buf, 0);
+				if (mod) {
+					result = AUTH_DENY;
+
+					for_each_string_list_item(token, mod->tokens) {
+						if (!strcmp(split[1]->buf, token->string)) {
+							result = AUTH_ALLOW;
+							break;
+						}
+					}
+
+					strbuf_list_free(split);
+					goto done;
+				}
+			}
+
+			strbuf_list_free(split);
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
+	if (p[0]->len && p[0]->buf[p[0]->len - 1] == ':')
+		strbuf_setlen(p[0], p[0]->len - 1);
+
+	*scheme = strbuf_detach(p[0], NULL);
+	*val = p[1] ? strbuf_detach(p[1], NULL) : NULL;
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
+	struct auth_module *mod;
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
 			       WR_HANGUP);
@@ -655,6 +870,19 @@ int cmd_main(int argc, const char **argv)
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
index c0a47ce342b..20fd9b09aef 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -101,6 +101,7 @@ per_test_cleanup () {
 	stop_http_server &&
 	rm -f OUT.* &&
 	rm -f IN.* &&
+	rm -f auth.config
 }
 
 test_expect_success 'http auth server request parsing' '
@@ -160,11 +161,51 @@ test_expect_success 'http auth server request parsing' '
 	test_cmp OUT.http400 OUT.actual
 '
 
+test_expect_success CURL 'http auth server auth config' '
+	test_when_finished "per_test_cleanup" &&
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

