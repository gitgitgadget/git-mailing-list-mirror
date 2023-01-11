Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57544C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjAKWOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjAKWNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE53E85F
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso13754097wmq.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vrHUk66dglrraLfjVBbj2TwF/Y7O64XMwZ7YW+qI48=;
        b=Q+VygEw6ae8AbnFfpCHY8W5k28DOmwr+5C1drbRCzer8UNvlU6kRL/5EPRgTqcne3J
         i04Q21edtcZeM/NrfiGFXKWTiCY/LiLp1c2GISwPWNFm55Uw6c6PKkK6Stb3OZJ5WBWz
         iEv5c+bw0i4d3W6VzWchRgr+1hwTQ1Yaevk3+VY1bL7P0G1miVVQB/ZH8Pv+zC+tAlsA
         re6+mVMNrYTgqUNAYfzHzdSoa+QaSIYPIlCuHp63NDAhlAnkfVaiHXkInsLZDEYuT0As
         T4e6vJPt+MhYfSGqrjKGIJKtscHibxFUquJHrn9O3Ie53bV9Lfvhd+xeEvcRORtEqZqC
         J2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vrHUk66dglrraLfjVBbj2TwF/Y7O64XMwZ7YW+qI48=;
        b=PU3emBuumlyT7PXH0BZbloTM05wHfj9AXddIqrf3bqtP4VHz4cBfpNkwo1BrMd/rB9
         CByZae3C8+zFIznrsURrdrsD2OCkUxAaS5fjjXjihPN8v5zBf3Jr5BnyEre9m7WOV29t
         6dXXeX2Ac6HtQYGBD/VfJ0WxyIdoKj7r6xwkagOqree6b7qYZySUfPjd1W1crnwpvCw9
         vQjgIlHqAAsn8TgiMDAtox5SK+xlcM3muK/oOZ91ZYDEzczM4U21Ii7XrjhdjrpF1pgc
         lHrZSILaXT3ng2aCm6kVDsaQnBCb/PToB/p98n7Xzm8Y1OwyT+/6O0ADc7TMZeHyhs6O
         nrlg==
X-Gm-Message-State: AFqh2kowSXjef5/OTLTWfX2p/o1yd7QsyJnaNTHK/IqMbNR8NOQlbMv/
        m/XIoFDNYKEiXQSfkeBxm0meLLjUxRM=
X-Google-Smtp-Source: AMrXdXt4UbrO9FaXrJuuLQyiWPzXAyZ1ZoEdv/DEtoEH9PUu+QJz3IibSjIGdcU9HKsUG4LKMfroRg==
X-Received: by 2002:a05:600c:3b93:b0:3d2:1bf6:5796 with SMTP id n19-20020a05600c3b9300b003d21bf65796mr54588257wms.35.1673475198477;
        Wed, 11 Jan 2023 14:13:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003cffd3c3d6csm21616924wmq.12.2023.01.11.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:17 -0800 (PST)
Message-Id: <c3c3d17a688963acc180e3bb7bbb4deb32a94304.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:06 +0000
Subject: [PATCH v5 06/10] test-http-server: add simple authentication
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
        Matthew John Cheetham <mjcheetham@github.com>,
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

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 246 +++++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 67bc16354a1..dcc326c8652 100644
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
@@ -341,6 +343,9 @@ static enum worker_result do__git(struct req *req)
 	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
 		return error(_("could not send '%s'"), ok);
 
+	if (user)
+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
+
 	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
 			req->uri_path.buf);
@@ -362,10 +367,234 @@ static enum worker_result do__git(struct req *req)
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
+static struct strvec extra_headers = STRVEC_INIT;
+
+static struct auth_module *create_auth_module(const char *scheme,
+					      const char *challenge)
+{
+	struct auth_module *mod = xmalloc(sizeof(struct auth_module));
+	mod->scheme = xstrdup(scheme);
+	mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
+	CALLOC_ARRAY(mod->tokens, 1);
+	string_list_init_dup(mod->tokens);
+	return mod;
+}
+
+static struct auth_module *get_auth_module(const char *scheme)
+{
+	int i;
+	struct auth_module *mod;
+	for (i = 0; i < auth_modules_nr; i++) {
+		mod = auth_modules[i];
+		if (!strcasecmp(mod->scheme, scheme))
+			return mod;
+	}
+
+	return NULL;
+}
+
+static int add_auth_module(struct auth_module *mod)
+{
+	if (get_auth_module(mod->scheme))
+		return error("duplicate auth scheme '%s'\n", mod->scheme);
+
+	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
+	auth_modules[auth_modules_nr++] = mod;
+
+	return 0;
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
+			mod = get_auth_module(split[0]->buf);
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
+		for (i = 0; i < extra_headers.nr; i++)
+			string_list_append(&hdrs, extra_headers.v[i]);
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
+static int split_auth_param(const char *str, char **scheme, char **val, int required_val)
+{
+	struct strbuf **p = strbuf_split_str(str, ':', 2);
+
+	if (!p[0])
+		return -1;
+
+	/* trim trailing ':' */
+	if (p[1])
+		strbuf_setlen(p[0], p[0]->len - 1);
+
+	if (required_val && !p[1])
+		return -1;
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
+		if (split_auth_param(val, &scheme, &challenge, 0)) {
+			ret = error("invalid auth challenge '%s'", val);
+			goto cleanup;
+		}
+
+		mod = create_auth_module(scheme, challenge);
+		if (add_auth_module(mod)) {
+			ret = error("failed to add auth module '%s'", val);
+			goto cleanup;
+		}
+	}
+	if (!strcmp(name, "auth.token")) {
+		if (split_auth_param(val, &scheme, &token, 1)) {
+			ret = error("invalid auth token '%s'", val);
+			goto cleanup;
+		}
+
+		mod = get_auth_module(scheme);
+		if (!mod) {
+			ret = error("auth scheme not defined '%s'\n", scheme);
+			goto cleanup;
+		}
+
+		string_list_append(mod->tokens, token);
+	}
+	if (!strcmp(name, "auth.allowanonymous")) {
+		allow_anonymous = git_config_bool(name, val);
+	}
+	if (!strcmp(name, "auth.extraheader")) {
+		strvec_push(&extra_headers, val);
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
@@ -624,6 +853,19 @@ int cmd_main(int argc, const char **argv)
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
-- 
gitgitgadget

