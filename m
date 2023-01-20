Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B5C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjATWJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjATWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363BA5CCB
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1546895wmq.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJnt4vqCoq8Tp+oulxwG6ozKog0Qc4/RGRUDUNJ3DtY=;
        b=NZTY2S+UfOS4Iwt2PulyaP3JI3ZezZB1FPK/xoric6u6W97dgcc6YyXUWa7Hlxf+/U
         B35NYnvP6Cta5ZxuanngmFaz3SZFqQhVoOYSJau0ZfZCPBWOCFT6fbChlY1K+q4sVG9D
         Z+/449PvKKqFF8HldBLiaPvCuMncwU94AVwdKnjmgxS+D1hxCUmRtGRfrXHKpMbza6SY
         aFXpb11qSpsQWHiezH/0zqyK4CG6jts/NF1p8KJzuiX8mWCqWGl7P1BfeDqjDBXvqIe5
         7ilvbH3z7GXPdt7P1qd7TWDSaSBmJEwKfSsfpp/FOVte+6jUW0E6TOGJhxoykC268aQ0
         UQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJnt4vqCoq8Tp+oulxwG6ozKog0Qc4/RGRUDUNJ3DtY=;
        b=o1OJJXKN7Uidh3EmHsJU1WknkVDCsi/UhTiUtDJnM0ZDP/+wNfJyVbzo21EXO0jSK7
         NurTErW206GN8a6L07itu0EDa94tsCskgQqINtizGMVDFQMui0sk9ZA6JQ+7oWMecETe
         jGgnws4yAqP+0LftKigDS6qUU8I3a/KtLGYdeSPgrqUTL7SXegO/bzeSsHwmgBPuFpb7
         lwZHGDcFh+RqNDgm7xoz1zWyd797+yruRoCC3c2U1zDmlJyox9Bthac1aqZYpyjAZUpT
         9fTtjU8OJFG7ZAwo+U1Gbt9qNkw9EGTiepqZ2Bprr0h5ag0Vvi+qjfPVtgngnxOZCGbd
         1mjg==
X-Gm-Message-State: AFqh2kohD0DZZWgByQOEI8rshAFbL7CY+0JDoDE40hOvEhZbjkrIaNcL
        Z5+C3P1MEuEP7s3PKsnanftBtdgwLTQ=
X-Google-Smtp-Source: AMrXdXsjA+UEC0EnWGjwGP6hmkQQ7O6qBRO2mLwG7wgFrGhCNCHdYbCcL11Duzx2DlNJLNuH0Tp/+A==
X-Received: by 2002:a05:600c:b85:b0:3cf:ae53:9193 with SMTP id fl5-20020a05600c0b8500b003cfae539193mr15591170wmb.39.1674252537703;
        Fri, 20 Jan 2023 14:08:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003db12112fcfsm4136487wms.4.2023.01.20.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:57 -0800 (PST)
Message-Id: <43f1cdcbb82022521558dc649213eb4538364870.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:44 +0000
Subject: [PATCH v7 06/12] test-http-server: add HTTP request parsing
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

Add ability to parse HTTP requests to the test-http-server test helper.
Introduce `struct req` to store request information including:

 * HTTP method & version
 * Request path and query parameters
 * Headers
 * Content type and length (from `Content-Type` and `-Length` headers)

Failure to parse the request results in a 400 Bad Request response to
the client. Note that we're not trying to support all possible requests
here, but just enough to exercise all code under test.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 202 +++++++++++++++++++++++++++++++++++-
 t/t5556-http-auth.sh        |  90 ++++++++++++++++
 2 files changed, 290 insertions(+), 2 deletions(-)
 create mode 100755 t/t5556-http-auth.sh

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 7ca4ddc7999..900f5733cc1 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -81,8 +81,53 @@ enum worker_result {
 	 * Close the socket and clean up. Does not imply an error.
 	 */
 	WR_HANGUP = 2,
+
+	/*
+	 * Unexpected request message or error in request parsing.
+	 * Respond with an 400 error. Close the socket and cleanup.
+	 * Exit child-process with a non-zero status.
+	 */
+	WR_CLIENT_ERROR = 3,
+};
+
+/*
+ * Fields from a parsed HTTP request.
+ */
+struct req {
+	struct strbuf start_line;
+
+	const char *method;
+	const char *http_version;
+
+	struct strbuf uri_path;
+	struct strbuf query_args;
+
+	struct string_list header_list;
+	const char *content_type;
+	uintmax_t content_length;
+	unsigned has_content_length:1;
 };
 
+#define REQ__INIT { \
+	.start_line = STRBUF_INIT, \
+	.uri_path = STRBUF_INIT, \
+	.query_args = STRBUF_INIT, \
+	.header_list = STRING_LIST_INIT_NODUP, \
+	.content_type = NULL, \
+	.content_length = 0, \
+	.has_content_length = 0, \
+}
+
+static void req__release(struct req *req)
+{
+	strbuf_release(&req->start_line);
+
+	strbuf_release(&req->uri_path);
+	strbuf_release(&req->query_args);
+
+	string_list_clear(&req->header_list, 0);
+}
+
 static enum worker_result send_http_error(int fd, int http_code,
 					  const char *http_code_name,
 					  int retry_after_seconds,
@@ -143,8 +188,150 @@ done:
 	return wr;
 }
 
+/*
+ * Read the HTTP request up to the start of the optional message-body.
+ * We do this byte-by-byte because we have keep-alive turned on and
+ * cannot rely on an EOF.
+ *
+ * https://tools.ietf.org/html/rfc7230
+ *
+ * We cannot call die() here because our caller needs to properly
+ * respond to the client and/or close the socket before this
+ * child exits so that the client doesn't get a connection reset
+ * by peer error.
+ */
+static enum worker_result req__read(struct req *req, int fd)
+{
+	struct strbuf h = STRBUF_INIT;
+	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
+	int nr_start_line_fields;
+	const char *uri_target;
+	const char *query;
+	char *hp;
+	const char *hv;
+
+	enum worker_result result = WR_OK;
+
+	/*
+	 * Read line 0 of the request and split it into component parts:
+	 *
+	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
+	 *
+	 */
+	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
+		result = WR_HANGUP;
+		goto done;
+	}
+
+	strbuf_trim_trailing_newline(&req->start_line);
+
+	nr_start_line_fields = string_list_split(&start_line_fields,
+						 req->start_line.buf,
+						 ' ', -1);
+	if (nr_start_line_fields != 3) {
+		logerror("could not parse request start-line '%s'",
+			 req->start_line.buf);
+		result = WR_CLIENT_ERROR;
+		goto done;
+	}
+
+	req->method = xstrdup(start_line_fields.items[0].string);
+	req->http_version = xstrdup(start_line_fields.items[2].string);
+
+	uri_target = start_line_fields.items[1].string;
+
+	if (strcmp(req->http_version, "HTTP/1.1")) {
+		logerror("unsupported version '%s' (expecting HTTP/1.1)",
+			 req->http_version);
+		result = WR_CLIENT_ERROR;
+		goto done;
+	}
+
+	query = strchr(uri_target, '?');
+
+	if (query) {
+		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+		strbuf_addstr(&req->query_args, query + 1);
+	} else {
+		strbuf_addstr(&req->uri_path, uri_target);
+		strbuf_trim_trailing_dir_sep(&req->uri_path);
+	}
+
+	/*
+	 * Read the set of HTTP headers into a string-list.
+	 */
+	while (1) {
+		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
+			goto done;
+		strbuf_trim_trailing_newline(&h);
+
+		if (!h.len)
+			goto done; /* a blank line ends the header */
+
+		hp = strbuf_detach(&h, NULL);
+		string_list_append(&req->header_list, hp);
+
+		/* also store common request headers as struct req members */
+		if (skip_iprefix(hp, "Content-Type: ", &hv)) {
+			req->content_type = hv;
+		} else if (skip_iprefix(hp, "Content-Length: ", &hv)) {
+			/*
+			 * Content-Length is always non-negative, but has no
+			 * upper bound according to RFC 7230 (§3.3.2).
+			 */
+			intmax_t len = 0;
+			if (sscanf(hv, "%"PRIdMAX, &len) != 1 || len < 0 ||
+			    len == INTMAX_MAX) {
+				logerror("invalid content-length: '%s'", hv);
+				result = WR_CLIENT_ERROR;
+				goto done;
+			}
+
+			req->content_length = (uintmax_t)len;
+			req->has_content_length = 1;
+		}
+	}
+
+	/*
+	 * We do not attempt to read the <message-body>, if it exists.
+	 * We let our caller read/chunk it in as appropriate.
+	 */
+
+done:
+	string_list_clear(&start_line_fields, 0);
+
+	/*
+	 * This is useful for debugging the request, but very noisy.
+	 */
+	if (trace2_is_enabled()) {
+		struct string_list_item *item;
+		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
+		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
+		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
+		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
+		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
+		if (req->has_content_length)
+			trace2_printf("%s: clen: %"PRIuMAX, TR2_CAT,
+				      req->content_length);
+		if (req->content_type)
+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
+		for_each_string_list_item(item, &req->header_list)
+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
+	}
+
+	return result;
+}
+
+static enum worker_result dispatch(struct req *req)
+{
+	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
+			       WR_HANGUP);
+}
+
 static enum worker_result worker(void)
 {
+	struct req req = REQ__INIT;
 	char *client_addr = getenv("REMOTE_ADDR");
 	char *client_port = getenv("REMOTE_PORT");
 	enum worker_result wr = WR_OK;
@@ -155,9 +342,20 @@ static enum worker_result worker(void)
 	set_keep_alive(0, logerror);
 
 	while (1) {
-		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
-				     NULL, WR_HANGUP);
+		req__release(&req);
+
+		alarm(timeout);
+		wr = req__read(&req, 0);
+		alarm(0);
+
+		if (wr == WR_CLIENT_ERROR)
+			wr = send_http_error(STDOUT_FILENO, 400, "Bad Request",
+					     -1, NULL, wr);
+
+		if (wr != WR_OK)
+			break;
 
+		wr = dispatch(&req);
 		if (wr != WR_OK)
 			break;
 	}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
new file mode 100755
index 00000000000..06efc85ca53
--- /dev/null
+++ b/t/t5556-http-auth.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+# Setup a repository
+#
+REPO_DIR="$TRASH_DIRECTORY"/repo
+
+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
+
+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
+
+test_expect_success 'setup repos' '
+	test_create_repo "$REPO_DIR" &&
+	git -C "$REPO_DIR" branch -M main
+'
+
+run_http_server_worker() {
+	(
+		cd "$REPO_DIR"
+		test-http-server --worker "$@" 2>"$SERVER_LOG" | tr -d "\r"
+	)
+}
+
+per_test_cleanup () {
+	rm -f OUT.* &&
+	rm -f IN.* &&
+}
+
+test_expect_success 'http auth server request parsing' '
+	test_when_finished "per_test_cleanup" &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		allowAnonymous = true
+	EOF
+
+	echo "HTTP/1.1 400 Bad Request" >OUT.http400 &&
+	echo "HTTP/1.1 200 OK" >OUT.http200 &&
+
+	cat >IN.http.valid <<-EOF &&
+	GET /info/refs HTTP/1.1
+	Content-Length: 0
+	EOF
+
+	cat >IN.http.badfirstline <<-EOF &&
+	/info/refs GET HTTP
+	EOF
+
+	cat >IN.http.badhttpver <<-EOF &&
+	GET /info/refs HTTP/999.9
+	EOF
+
+	cat >IN.http.ltzlen <<-EOF &&
+	GET /info/refs HTTP/1.1
+	Content-Length: -1
+	EOF
+
+	cat >IN.http.badlen <<-EOF &&
+	GET /info/refs HTTP/1.1
+	Content-Length: not-a-number
+	EOF
+
+	cat >IN.http.overlen <<-EOF &&
+	GET /info/refs HTTP/1.1
+	Content-Length: 9223372036854775807
+	EOF
+
+	run_http_server_worker \
+		--auth-config="$TRASH_DIRECTORY/auth.config" <IN.http.valid \
+		| head -n1 >OUT.actual &&
+	test_cmp OUT.http200 OUT.actual &&
+
+	run_http_server_worker <IN.http.badfirstline | head -n1 >OUT.actual &&
+	test_cmp OUT.http400 OUT.actual &&
+
+	run_http_server_worker <IN.http.ltzlen | head -n1 >OUT.actual &&
+	test_cmp OUT.http400 OUT.actual &&
+
+	run_http_server_worker <IN.http.badlen | head -n1 >OUT.actual &&
+	test_cmp OUT.http400 OUT.actual &&
+
+	run_http_server_worker <IN.http.overlen | head -n1 >OUT.actual &&
+	test_cmp OUT.http400 OUT.actual
+'
+
+test_done
-- 
gitgitgadget

