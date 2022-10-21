Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B95BFA373E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJURIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJURIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4D28E07C
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t4so2652843wmj.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r9Sbql5TP5U2KeqRbixAhzyb4722wcFjGJfMXFTIu0=;
        b=dCrtkaOejlrf/hV0HrisvWRW6n8yr+CkAWh1OQaOjOgG7ouQSGtJIJluBn23t+vtHl
         /StjkKfq1b0IHv4iWMuncgBfMQeKmS3oMSeCM4lSFLXKdwlRu1CDn6lb+hn3hxYTao4z
         pkKQf/+u1vLbycqLp59z9ltyLMqb/y0pJwB2W/nLghnlr3VWsugy5np1aW/M7IatTtLS
         rDgbfShIARQDDQcu5z33B256cGTGg8z99saKfDE7PKGfvSOor/cD0jtQ36M5SP51XBox
         uawP95daIwCCab5vWsog0JtYkVYw54fozmuUXhFqxMd7PW0VPfybPxgw3kL56sdNj/h8
         BDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r9Sbql5TP5U2KeqRbixAhzyb4722wcFjGJfMXFTIu0=;
        b=KgzBUbUiWNch+LUr1Dmioi0xHmOSE2tWFT7sbzOUbIpWjgGRRU78Df0m1x/IoAi3KE
         bGG8faSvcZIoI1Nc5li6KBT6TY14WhEslKcCnV0PCmfIvlMVmQy7uDuRbQK+k7hf7fxk
         CfirOOXBtTJK/goEi00F+uxih+JIvfLZM5B+/tlcF3RYfxD/kSxuZ6BDu5tE2PJUSQlA
         YGL1F+6V6x+Nc34/zbi1jXFGp6c+wi6Xi8cPN+RkYM03C9yBzWlsCQWLcUwYTiWap+/Y
         +RmOaTq8W4dKtrICo72zLbkd/qg7CCLfp+x0G+aew3ww26setoVrPZxVBOAVE0Qwjz2w
         0Yqw==
X-Gm-Message-State: ACrzQf3yBsSPLwwZk1J41kYROVPU5Iv8fod/5oPWOVBZpIWP4xG4Tfrp
        GtDY1o0j/9mrSNnIUYs/Kjq4/BnDOuo=
X-Google-Smtp-Source: AMsMyM7X4ZXyIjN0AXlg0NqFtx97UZrwONrKOMD8q89SkccekwuJLQs+f9bTjhpjos4zQi3fvsqCeA==
X-Received: by 2002:a05:600c:3509:b0:3c6:fd36:ef19 with SMTP id h9-20020a05600c350900b003c6fd36ef19mr14209849wmq.191.1666372096867;
        Fri, 21 Oct 2022 10:08:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b0023655e51c33sm1695002wrx.4.2022.10.21.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:16 -0700 (PDT)
Message-Id: <f3f13ed8c8238f396163dd0e6a3d6c948c2b879b.1666372083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
        <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:08:03 +0000
Subject: [PATCH v2 6/6] t5556-http-auth: add test for HTTP auth hdr logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a series of tests to exercise the HTTP authentication header parsing
and the interop with credential helpers. Credential helpers can respond
to requests that contain WWW-Authenticate information with the ability
to select the response Authenticate header scheme.

Introduce a mini HTTP server helper that provides a frontend for the
git-http-backend, with support for arbitrary authentication schemes.
The test-http-server is based heavily on the git-daemon, and forwards
all successfully authenticated requests to the http-backend.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Makefile                                  |    2 +
 contrib/buildsystems/CMakeLists.txt       |   13 +
 t/helper/.gitignore                       |    1 +
 t/helper/test-credential-helper-replay.sh |   14 +
 t/helper/test-http-server.c               | 1134 +++++++++++++++++++++
 t/t5556-http-auth.sh                      |  260 +++++
 6 files changed, 1424 insertions(+)
 create mode 100755 t/helper/test-credential-helper-replay.sh
 create mode 100644 t/helper/test-http-server.c
 create mode 100755 t/t5556-http-auth.sh

diff --git a/Makefile b/Makefile
index d93ad956e58..39b130f711d 100644
--- a/Makefile
+++ b/Makefile
@@ -1500,6 +1500,8 @@ else
 	endif
 	BASIC_CFLAGS += $(CURL_CFLAGS)
 
+	TEST_PROGRAMS_NEED_X += test-http-server
+
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 787738e6fa3..45251695ce0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -989,6 +989,19 @@ set(wrapper_scripts
 set(wrapper_test_scripts
 	test-fake-ssh test-tool)
 
+if(CURL_FOUND)
+       list(APPEND wrapper_test_scripts test-http-server)
+
+       add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
+       target_link_libraries(test-http-server common-main)
+
+       if(MSVC)
+               set_target_properties(test-http-server
+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
+               set_target_properties(test-http-server
+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
+       endif()
+endif()
 
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 8c2ddcce95f..1a94ab6eed5 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,2 +1,3 @@
 /test-tool
 /test-fake-ssh
+test-http-server
diff --git a/t/helper/test-credential-helper-replay.sh b/t/helper/test-credential-helper-replay.sh
new file mode 100755
index 00000000000..03e5e63dad6
--- /dev/null
+++ b/t/helper/test-credential-helper-replay.sh
@@ -0,0 +1,14 @@
+cmd=$1
+teefile=$cmd-actual.cred
+catfile=$cmd-response.cred
+rm -f $teefile
+while read line;
+do
+	if test -z "$line"; then
+		break;
+	fi
+	echo "$line" >> $teefile
+done
+if test "$cmd" = "get"; then
+	cat $catfile
+fi
diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
new file mode 100644
index 00000000000..92139c04c90
--- /dev/null
+++ b/t/helper/test-http-server.c
@@ -0,0 +1,1134 @@
+#include "config.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "trace2.h"
+#include "version.h"
+#include "dir.h"
+#include "date.h"
+
+#define TR2_CAT "test-http-server"
+
+static const char *pid_file;
+static int verbose;
+static int reuseaddr;
+
+static const char test_http_auth_usage[] =
+"http-server [--verbose]\n"
+"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
+"           [--reuseaddr] [--pid-file=<file>]\n"
+"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
+"           [--anonymous-allowed]\n"
+"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
+;
+
+/* Timeout, and initial timeout */
+static unsigned int timeout;
+static unsigned int init_timeout;
+
+static void logreport(const char *label, const char *err, va_list params)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
+	strbuf_vaddf(&msg, err, params);
+	strbuf_addch(&msg, '\n');
+
+	fwrite(msg.buf, sizeof(char), msg.len, stderr);
+	fflush(stderr);
+
+	strbuf_release(&msg);
+}
+
+__attribute__((format (printf, 1, 2)))
+static void logerror(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	logreport("error", err, params);
+	va_end(params);
+}
+
+__attribute__((format (printf, 1, 2)))
+static void loginfo(const char *err, ...)
+{
+	va_list params;
+	if (!verbose)
+		return;
+	va_start(params, err);
+	logreport("info", err, params);
+	va_end(params);
+}
+
+static void set_keep_alive(int sockfd)
+{
+	int ka = 1;
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
+		if (errno != ENOTSOCK)
+			logerror("unable to set SO_KEEPALIVE on socket: %s",
+				strerror(errno));
+	}
+}
+
+//////////////////////////////////////////////////////////////////
+// The code in this section is used by "worker" instances to service
+// a single connection from a client.  The worker talks to the client
+// on 0 and 1.
+//////////////////////////////////////////////////////////////////
+
+enum worker_result {
+	/*
+	 * Operation successful.
+	 * Caller *might* keep the socket open and allow keep-alive.
+	 */
+	WR_OK       = 0,
+	/*
+	 * Various errors while processing the request and/or the response.
+	 * Close the socket and clean up.
+	 * Exit child-process with non-zero status.
+	 */
+	WR_IO_ERROR = 1<<0,
+	/*
+	 * Close the socket and clean up.  Does not imply an error.
+	 */
+	WR_HANGUP   = 1<<1,
+
+	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
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
+	ssize_t content_length;
+};
+
+#define REQ__INIT { \
+	.start_line = STRBUF_INIT, \
+	.uri_path = STRBUF_INIT, \
+	.query_args = STRBUF_INIT, \
+	.header_list = STRING_LIST_INIT_NODUP, \
+	.content_type = NULL, \
+	.content_length = -1 \
+	}
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
+static enum worker_result send_http_error(
+	int fd,
+	int http_code, const char *http_code_name,
+	int retry_after_seconds, struct string_list *response_headers,
+	enum worker_result wr_in)
+{
+	struct strbuf response_header = STRBUF_INIT;
+	struct strbuf response_content = STRBUF_INIT;
+	struct string_list_item *h;
+	enum worker_result wr;
+
+	strbuf_addf(&response_content, "Error: %d %s\r\n",
+		    http_code, http_code_name);
+	if (retry_after_seconds > 0)
+		strbuf_addf(&response_content, "Retry-After: %d\r\n",
+			    retry_after_seconds);
+
+	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
+	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
+	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
+	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
+	if (retry_after_seconds > 0)
+		strbuf_addf  (&response_header, "Retry-After: %d\r\n", retry_after_seconds);
+	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
+	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
+	if (response_headers)
+		for_each_string_list_item(h, response_headers)
+			strbuf_addf(&response_header, "%s\r\n", h->string);
+	strbuf_addstr(&response_header, "\r\n");
+
+	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
+		logerror("unable to write response header");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
+		logerror("unable to write response content body");
+		wr = WR_IO_ERROR;
+		goto done;
+	}
+
+	wr = wr_in;
+
+done:
+	strbuf_release(&response_header);
+	strbuf_release(&response_content);
+
+	return wr;
+}
+
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
+		result = WR_OK | WR_HANGUP;
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
+		result = WR_IO_ERROR;
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
+		result = WR_IO_ERROR;
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
+		/* store common request headers separately */
+		if (skip_prefix(hp, "Content-Type: ", &hv)) {
+			req->content_type = hv;
+		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
+			req->content_length = strtol(hv, &hp, 10);
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
+		if (req->content_length >= 0)
+			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
+		if (req->content_type)
+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
+		for_each_string_list_item(item, &req->header_list)
+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
+	}
+
+	return result;
+}
+
+static int is_git_request(struct req *req)
+{
+	static regex_t *smart_http_regex;
+	static int initialized;
+
+	if (!initialized) {
+		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
+		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
+			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
+			    REG_EXTENDED)) {
+			warning("could not compile smart HTTP regex");
+			smart_http_regex = NULL;
+		}
+		initialized = 1;
+	}
+
+	return smart_http_regex &&
+		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
+}
+
+static enum worker_result do__git(struct req *req, const char *user)
+{
+	const char *ok = "HTTP/1.1 200 OK\r\n";
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int res;
+
+	if (write(1, ok, strlen(ok)) < 0)
+		return error(_("could not send '%s'"), ok);
+
+	if (user)
+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
+
+	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
+	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
+			req->uri_path.buf);
+	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
+	if (req->query_args.len)
+		strvec_pushf(&cp.env, "QUERY_STRING=%s",
+				req->query_args.buf);
+	if (req->content_type)
+		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
+				req->content_type);
+	if (req->content_length >= 0)
+		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
+				(intmax_t)req->content_length);
+	cp.git_cmd = 1;
+	strvec_push(&cp.args, "http-backend");
+	res = run_command(&cp);
+	close(1);
+	close(0);
+	return !!res;
+}
+
+enum auth_result {
+	AUTH_UNKNOWN = 0,
+	AUTH_DENY = 1,
+	AUTH_ALLOW = 2,
+};
+
+struct auth_module {
+	const char *scheme;
+	const char *challenge_params;
+	struct string_list *tokens;
+};
+
+static int allow_anonymous;
+static struct auth_module **auth_modules = NULL;
+static size_t auth_modules_nr = 0;
+static size_t auth_modules_alloc = 0;
+
+static struct auth_module *get_auth_module(struct strbuf *scheme)
+{
+	int i;
+	struct auth_module *mod;
+	for (i = 0; i < auth_modules_nr; i++) {
+		mod = auth_modules[i];
+		if (!strcasecmp(mod->scheme, scheme->buf))
+			return mod;
+	}
+
+	return NULL;
+}
+
+static void add_auth_module(struct auth_module *mod)
+{
+	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
+	auth_modules[auth_modules_nr++] = mod;
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
+	/* ask all auth modules to validate the request */
+	for_each_string_list_item(hdr, &req->header_list) {
+		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
+			split = strbuf_split_str(v, ' ', 2);
+			if (!split[0] || !split[1]) continue;
+
+			// trim trailing space ' '
+			strbuf_setlen(split[0], split[0]->len - 1);
+
+			mod = get_auth_module(split[0]);
+			if (mod) {
+
+				for_each_string_list_item(token, mod->tokens) {
+					if (!strcmp(split[1]->buf, token->string)) {
+						result = AUTH_ALLOW;
+						goto done;
+					}
+				}
+
+				if (result != AUTH_UNKNOWN)
+					goto done;
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
+		if (allow_anonymous)
+			break;
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
+		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
+	}
+
+	strbuf_list_free(split);
+	string_list_clear(&hdrs, 0);
+
+	return result == AUTH_ALLOW ||
+	      (result == AUTH_UNKNOWN && allow_anonymous);
+}
+
+static enum worker_result dispatch(struct req *req)
+{
+	enum worker_result wr = WR_OK;
+	const char *user = NULL;
+
+	if (!is_authed(req, &user, &wr))
+		return wr;
+
+	if (is_git_request(req))
+		return do__git(req, user);
+
+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
+			       WR_OK | WR_HANGUP);
+}
+
+static enum worker_result worker(void)
+{
+	struct req req = REQ__INIT;
+	char *client_addr = getenv("REMOTE_ADDR");
+	char *client_port = getenv("REMOTE_PORT");
+	enum worker_result wr = WR_OK;
+
+	if (client_addr)
+		loginfo("Connection from %s:%s", client_addr, client_port);
+
+	set_keep_alive(0);
+
+	while (1) {
+		req__release(&req);
+
+		alarm(init_timeout ? init_timeout : timeout);
+		wr = req__read(&req, 0);
+		alarm(0);
+
+		if (wr & WR_STOP_THE_MUSIC)
+			break;
+
+		wr = dispatch(&req);
+		if (wr & WR_STOP_THE_MUSIC)
+			break;
+	}
+
+	close(0);
+	close(1);
+
+	return !!(wr & WR_IO_ERROR);
+}
+
+//////////////////////////////////////////////////////////////////
+// This section contains the listener and child-process management
+// code used by the primary instance to accept incoming connections
+// and dispatch them to async child process "worker" instances.
+//////////////////////////////////////////////////////////////////
+
+static int addrcmp(const struct sockaddr_storage *s1,
+		   const struct sockaddr_storage *s2)
+{
+	const struct sockaddr *sa1 = (const struct sockaddr*) s1;
+	const struct sockaddr *sa2 = (const struct sockaddr*) s2;
+
+	if (sa1->sa_family != sa2->sa_family)
+		return sa1->sa_family - sa2->sa_family;
+	if (sa1->sa_family == AF_INET)
+		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
+		    &((struct sockaddr_in *)s2)->sin_addr,
+		    sizeof(struct in_addr));
+#ifndef NO_IPV6
+	if (sa1->sa_family == AF_INET6)
+		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
+		    &((struct sockaddr_in6 *)s2)->sin6_addr,
+		    sizeof(struct in6_addr));
+#endif
+	return 0;
+}
+
+static int max_connections = 32;
+
+static unsigned int live_children;
+
+static struct child {
+	struct child *next;
+	struct child_process cld;
+	struct sockaddr_storage address;
+} *firstborn;
+
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct child *newborn, **cradle;
+
+	newborn = xcalloc(1, sizeof(*newborn));
+	live_children++;
+	memcpy(&newborn->cld, cld, sizeof(*cld));
+	memcpy(&newborn->address, addr, addrlen);
+	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
+		if (!addrcmp(&(*cradle)->address, &newborn->address))
+			break;
+	newborn->next = *cradle;
+	*cradle = newborn;
+}
+
+/*
+ * This gets called if the number of connections grows
+ * past "max_connections".
+ *
+ * We kill the newest connection from a duplicate IP.
+ */
+static void kill_some_child(void)
+{
+	const struct child *blanket, *next;
+
+	if (!(blanket = firstborn))
+		return;
+
+	for (; (next = blanket->next); blanket = next)
+		if (!addrcmp(&blanket->address, &next->address)) {
+			kill(blanket->cld.pid, SIGTERM);
+			break;
+		}
+}
+
+static void check_dead_children(void)
+{
+	int status;
+	pid_t pid;
+
+	struct child **cradle, *blanket;
+	for (cradle = &firstborn; (blanket = *cradle);)
+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+			const char *dead = "";
+			if (status)
+				dead = " (with error)";
+			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
+
+			/* remove the child */
+			*cradle = blanket->next;
+			live_children--;
+			child_process_clear(&blanket->cld);
+			free(blanket);
+		} else
+			cradle = &blanket->next;
+}
+
+static struct strvec cld_argv = STRVEC_INIT;
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct child_process cld = CHILD_PROCESS_INIT;
+
+	if (max_connections && live_children >= max_connections) {
+		kill_some_child();
+		sleep(1);  /* give it some time to die */
+		check_dead_children();
+		if (live_children >= max_connections) {
+			close(incoming);
+			logerror("Too many children, dropping connection");
+			return;
+		}
+	}
+
+	if (addr->sa_family == AF_INET) {
+		char buf[128] = "";
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
+		strvec_pushf(&cld.env, "REMOTE_ADDR=%s", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
+				 ntohs(sin_addr->sin_port));
+#ifndef NO_IPV6
+	} else if (addr->sa_family == AF_INET6) {
+		char buf[128] = "";
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
+		strvec_pushf(&cld.env, "REMOTE_ADDR=[%s]", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
+				 ntohs(sin6_addr->sin6_port));
+#endif
+	}
+
+	strvec_pushv(&cld.args, cld_argv.v);
+	cld.in = incoming;
+	cld.out = dup(incoming);
+
+	if (cld.out < 0)
+		logerror("could not dup() `incoming`");
+	else if (start_command(&cld))
+		logerror("unable to fork");
+	else
+		add_child(&cld, addr, addrlen);
+}
+
+static void child_handler(int signo)
+{
+	/*
+	 * Otherwise empty handler because systemcalls will get interrupted
+	 * upon signal receipt
+	 * SysV needs the handler to be rearmed
+	 */
+	signal(SIGCHLD, child_handler);
+}
+
+static int set_reuse_addr(int sockfd)
+{
+	int on = 1;
+
+	if (!reuseaddr)
+		return 0;
+	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+			  &on, sizeof(on));
+}
+
+struct socketlist {
+	int *list;
+	size_t nr;
+	size_t alloc;
+};
+
+static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
+{
+#ifdef NO_IPV6
+	static char ip[INET_ADDRSTRLEN];
+#else
+	static char ip[INET6_ADDRSTRLEN];
+#endif
+
+	switch (family) {
+#ifndef NO_IPV6
+	case AF_INET6:
+		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
+		break;
+#endif
+	case AF_INET:
+		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
+		break;
+	default:
+		xsnprintf(ip, sizeof(ip), "<unknown>");
+	}
+	return ip;
+}
+
+#ifndef NO_IPV6
+
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	int socknum = 0;
+	char pbuf[NI_MAXSERV];
+	struct addrinfo hints, *ai0, *ai;
+	int gai;
+	long flags;
+
+	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+	hints.ai_flags = AI_PASSIVE;
+
+	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
+	if (gai) {
+		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
+		return 0;
+	}
+
+	for (ai = ai0; ai; ai = ai->ai_next) {
+		int sockfd;
+
+		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (sockfd < 0)
+			continue;
+		if (sockfd >= FD_SETSIZE) {
+			logerror("Socket descriptor too large");
+			close(sockfd);
+			continue;
+		}
+
+#ifdef IPV6_V6ONLY
+		if (ai->ai_family == AF_INET6) {
+			int on = 1;
+			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
+				   &on, sizeof(on));
+			/* Note: error is not fatal */
+		}
+#endif
+
+		if (set_reuse_addr(sockfd)) {
+			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+			close(sockfd);
+			continue;
+		}
+
+		set_keep_alive(sockfd);
+
+		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			logerror("Could not bind to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+		if (listen(sockfd, 5) < 0) {
+			logerror("Could not listen to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+
+		flags = fcntl(sockfd, F_GETFD, 0);
+		if (flags >= 0)
+			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
+		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+		socklist->list[socklist->nr++] = sockfd;
+		socknum++;
+	}
+
+	freeaddrinfo(ai0);
+
+	return socknum;
+}
+
+#else /* NO_IPV6 */
+
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	struct sockaddr_in sin;
+	int sockfd;
+	long flags;
+
+	memset(&sin, 0, sizeof sin);
+	sin.sin_family = AF_INET;
+	sin.sin_port = htons(listen_port);
+
+	if (listen_addr) {
+		/* Well, host better be an IP address here. */
+		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
+			return 0;
+	} else {
+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
+	}
+
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0)
+		return 0;
+
+	if (set_reuse_addr(sockfd)) {
+		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	set_keep_alive(sockfd);
+
+	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
+		logerror("Could not bind to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	if (listen(sockfd, 5) < 0) {
+		logerror("Could not listen to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	flags = fcntl(sockfd, F_GETFD, 0);
+	if (flags >= 0)
+		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
+	ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+	socklist->list[socklist->nr++] = sockfd;
+	return 1;
+}
+
+#endif
+
+static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	if (!listen_addr->nr)
+		setup_named_sock("127.0.0.1", listen_port, socklist);
+	else {
+		int i, socknum;
+		for (i = 0; i < listen_addr->nr; i++) {
+			socknum = setup_named_sock(listen_addr->items[i].string,
+						   listen_port, socklist);
+
+			if (socknum == 0)
+				logerror("unable to allocate any listen sockets for host %s on port %u",
+					 listen_addr->items[i].string, listen_port);
+		}
+	}
+}
+
+static int service_loop(struct socketlist *socklist)
+{
+	struct pollfd *pfd;
+	int i;
+
+	CALLOC_ARRAY(pfd, socklist->nr);
+
+	for (i = 0; i < socklist->nr; i++) {
+		pfd[i].fd = socklist->list[i];
+		pfd[i].events = POLLIN;
+	}
+
+	signal(SIGCHLD, child_handler);
+
+	for (;;) {
+		int i;
+		int nr_ready;
+		int timeout = (pid_file ? 100 : -1);
+
+		check_dead_children();
+
+		nr_ready = poll(pfd, socklist->nr, timeout);
+		if (nr_ready < 0) {
+			if (errno != EINTR) {
+				logerror("Poll failed, resuming: %s",
+				      strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+		else if (nr_ready == 0) {
+			/*
+			 * If we have a pid_file, then we watch it.
+			 * If someone deletes it, we shutdown the service.
+			 * The shell scripts in the test suite will use this.
+			 */
+			if (!pid_file || file_exists(pid_file))
+				continue;
+			goto shutdown;
+		}
+
+		for (i = 0; i < socklist->nr; i++) {
+			if (pfd[i].revents & POLLIN) {
+				union {
+					struct sockaddr sa;
+					struct sockaddr_in sai;
+#ifndef NO_IPV6
+					struct sockaddr_in6 sai6;
+#endif
+				} ss;
+				socklen_t sslen = sizeof(ss);
+				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+				if (incoming < 0) {
+					switch (errno) {
+					case EAGAIN:
+					case EINTR:
+					case ECONNABORTED:
+						continue;
+					default:
+						die_errno("accept returned");
+					}
+				}
+				handle(incoming, &ss.sa, sslen);
+			}
+		}
+	}
+
+shutdown:
+	loginfo("Starting graceful shutdown (pid-file gone)");
+	for (i = 0; i < socklist->nr; i++)
+		close(socklist->list[i]);
+
+	return 0;
+}
+
+static int serve(struct string_list *listen_addr, int listen_port)
+{
+	struct socketlist socklist = { NULL, 0, 0 };
+
+	socksetup(listen_addr, listen_port, &socklist);
+	if (socklist.nr == 0)
+		die("unable to allocate any listen sockets on port %u",
+		    listen_port);
+
+	loginfo("Ready to rumble");
+
+	/*
+	 * Wait to create the pid-file until we've setup the sockets
+	 * and are open for business.
+	 */
+	if (pid_file)
+		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
+
+	return service_loop(&socklist);
+}
+
+//////////////////////////////////////////////////////////////////
+// This section is executed by both the primary instance and all
+// worker instances.  So, yes, each child-process re-parses the
+// command line argument and re-discovers how it should behave.
+//////////////////////////////////////////////////////////////////
+
+int cmd_main(int argc, const char **argv)
+{
+	int listen_port = 0;
+	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
+	int worker_mode = 0;
+	int i;
+	struct auth_module *mod = NULL;
+
+	trace2_cmd_name("test-http-server");
+	setup_git_directory_gently(NULL);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		const char *v;
+
+		if (skip_prefix(arg, "--listen=", &v)) {
+			string_list_append(&listen_addr, xstrdup_tolower(v));
+			continue;
+		}
+		if (skip_prefix(arg, "--port=", &v)) {
+			char *end;
+			unsigned long n;
+			n = strtoul(v, &end, 0);
+			if (*v && !*end) {
+				listen_port = n;
+				continue;
+			}
+		}
+		if (!strcmp(arg, "--worker")) {
+			worker_mode = 1;
+			trace2_cmd_mode("worker");
+			continue;
+		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--timeout=", &v)) {
+			timeout = atoi(v);
+			continue;
+		}
+		if (skip_prefix(arg, "--init-timeout=", &v)) {
+			init_timeout = atoi(v);
+			continue;
+		}
+		if (skip_prefix(arg, "--max-connections=", &v)) {
+			max_connections = atoi(v);
+			if (max_connections < 0)
+				max_connections = 0; /* unlimited */
+			continue;
+		}
+		if (!strcmp(arg, "--reuseaddr")) {
+			reuseaddr = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--pid-file=", &v)) {
+			pid_file = v;
+			continue;
+		}
+		if (skip_prefix(arg, "--allow-anonymous", &v)) {
+			allow_anonymous = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--auth=", &v)) {
+			struct strbuf **p = strbuf_split_str(v, ':', 2);
+
+			if (!p[0]) {
+				error("invalid argument '%s'", v);
+				usage(test_http_auth_usage);
+			}
+
+			// trim trailing ':'
+			if (p[1])
+				strbuf_setlen(p[0], p[0]->len - 1);
+
+			if (get_auth_module(p[0])) {
+				error("duplicate auth scheme '%s'\n", p[0]->buf);
+				usage(test_http_auth_usage);
+			}
+
+			mod = xmalloc(sizeof(struct auth_module));
+			mod->scheme = xstrdup(p[0]->buf);
+			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
+			mod->tokens = xmalloc(sizeof(struct string_list));
+			string_list_init_dup(mod->tokens);
+
+			add_auth_module(mod);
+
+			strbuf_list_free(p);
+			continue;
+		}
+		if (skip_prefix(arg, "--auth-token=", &v)) {
+			struct strbuf **p = strbuf_split_str(v, ':', 2);
+			if (!p[0]) {
+				error("invalid argument '%s'", v);
+				usage(test_http_auth_usage);
+			}
+
+			if (!p[1]) {
+				error("missing token value '%s'\n", v);
+				usage(test_http_auth_usage);
+			}
+
+			// trim trailing ':'
+			strbuf_setlen(p[0], p[0]->len - 1);
+
+			mod = get_auth_module(p[0]);
+			if (!mod) {
+				error("auth scheme not defined '%s'\n", p[0]->buf);
+				usage(test_http_auth_usage);
+			}
+
+			string_list_append(mod->tokens, p[1]->buf);
+			strbuf_list_free(p);
+			continue;
+		}
+
+		fprintf(stderr, "error: unknown argument '%s'\n", arg);
+		usage(test_http_auth_usage);
+	}
+
+	/* avoid splitting a message in the middle */
+	setvbuf(stderr, NULL, _IOFBF, 4096);
+
+	if (listen_port == 0)
+		listen_port = DEFAULT_GIT_PORT;
+
+	/*
+	 * If no --listen=<addr> args are given, the setup_named_sock()
+	 * code will use receive a NULL address and set INADDR_ANY.
+	 * This exposes both internal and external interfaces on the
+	 * port.
+	 *
+	 * Disallow that and default to the internal-use-only loopback
+	 * address.
+	 */
+	if (!listen_addr.nr)
+		string_list_append(&listen_addr, "127.0.0.1");
+
+	/*
+	 * worker_mode is set in our own child process instances
+	 * (that are bound to a connected socket from a client).
+	 */
+	if (worker_mode)
+		return worker();
+
+	/*
+	 * `cld_argv` is a bit of a clever hack. The top-level instance
+	 * of test-http-server does the normal bind/listen/accept stuff.
+	 * For each incoming socket, the top-level process spawns
+	 * a child instance of test-http-server *WITH* the additional
+	 * `--worker` argument. This causes the child to set `worker_mode`
+	 * and immediately call `worker()` using the connected socket (and
+	 * without the usual need for fork() or threads).
+	 *
+	 * The magic here is made possible because `cld_argv` is static
+	 * and handle() (called by service_loop()) knows about it.
+	 */
+	strvec_push(&cld_argv, argv[0]);
+	strvec_push(&cld_argv, "--worker");
+	for (i = 1; i < argc; ++i)
+		strvec_push(&cld_argv, argv[i]);
+
+	/*
+	 * Setup primary instance to listen for connections.
+	 */
+	return serve(&listen_addr, listen_port);
+}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
new file mode 100755
index 00000000000..43f1791a0fe
--- /dev/null
+++ b/t/t5556-http-auth.sh
@@ -0,0 +1,260 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+. ./test-lib.sh
+
+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
+
+# Setup a repository
+#
+REPO_DIR="$(pwd)"/repo
+
+# Setup some lookback URLs where test-http-server will be listening.
+# We will spawn it directly inside the repo directory, so we avoid
+# any need to configure directory mappings etc - we only serve this
+# repository from the root '/' of the server.
+#
+HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
+ORIGIN_URL=http://$HOST_PORT/
+
+# The pid-file is created by test-http-server when it starts.
+# The server will shutdown if/when we delete it (this is easier than
+# killing it by PID).
+#
+PID_FILE="$(pwd)"/pid-file.pid
+SERVER_LOG="$(pwd)"/OUT.server.log
+
+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
+CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
+	&& export CREDENTIAL_HELPER
+
+test_expect_success 'setup repos' '
+	test_create_repo "$REPO_DIR" &&
+	git -C "$REPO_DIR" branch -M main
+'
+
+stop_http_server () {
+	if ! test -f "$PID_FILE"
+	then
+		return 0
+	fi
+	#
+	# The server will shutdown automatically when we delete the pid-file.
+	#
+	rm -f "$PID_FILE"
+	#
+	# Give it a few seconds to shutdown (mainly to completely release the
+	# port before the next test start another instance and it attempts to
+	# bind to it).
+	#
+	for k in 0 1 2 3 4
+	do
+		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
+		then
+			return 0
+		fi
+		sleep 1
+	done
+
+	echo "stop_http_server: timeout waiting for server shutdown"
+	return 1
+}
+
+start_http_server () {
+	#
+	# Launch our server into the background in repo_dir.
+	#
+	(
+		cd "$REPO_DIR"
+		test-http-server --verbose \
+			--listen=127.0.0.1 \
+			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
+			--reuseaddr \
+			--pid-file="$PID_FILE" \
+			"$@" \
+			2>"$SERVER_LOG" &
+	)
+	#
+	# Give it a few seconds to get started.
+	#
+	for k in 0 1 2 3 4
+	do
+		if test -f "$PID_FILE"
+		then
+			return 0
+		fi
+		sleep 1
+	done
+
+	echo "start_http_server: timeout waiting for server startup"
+	return 1
+}
+
+per_test_cleanup () {
+	stop_http_server &&
+	rm -f OUT.* &&
+	rm -f *.cred
+}
+
+test_expect_success 'http auth anonymous no challenge' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server --allow-anonymous &&
+
+	# Attempt to read from a protected repository
+	git ls-remote $ORIGIN_URL
+'
+
+test_expect_success 'http auth www-auth headers to credential helper bearer valid' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=bearer:secret-token &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-token
+	authtype=bearer
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-token
+	authtype=bearer
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
+'
+
+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=basic:$USERPASS64 &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	authtype=basic
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	authtype=basic
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
+'
+
+test_expect_success 'http auth www-auth headers to credential helper custom scheme' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server \
+		--auth=foobar:alg=test\ widget=1 \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=foobar:SECRET-FOOBAR-VALUE &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=foobar alg=test widget=1
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=SECRET-FOOBAR-VALUE
+	authtype=foobar
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=SECRET-FOOBAR-VALUE
+	authtype=foobar
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
+'
+
+test_expect_success 'http auth www-auth headers to credential helper invalid' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=bearer:secret-token &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >erase-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-token
+	authtype=bearer
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-token
+	authtype=bearer
+	EOF
+
+	test_must_fail git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp erase-expected.cred erase-actual.cred
+'
+
+test_done
-- 
gitgitgadget
