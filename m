Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D78AC00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjARDbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjARDad (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5016521D3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q8so11937879wmo.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJsZr9uc7gd0E/0o2TzFzv3kDRvmk40ohT91L6SsIrA=;
        b=MyOZr+MXj1xV26+gRC5QgmPRrAl/VZmm3Yl5b66iHcPUC4RjQgS4ml6IRyR5a3PVCW
         kRLAuBD9YT2yH5dR7WDeM5z6f2SOfwNs7Cq6O1Xu2Ix5YquhBXmAhrQJKUdgOju9LjHB
         kLmKwOFoYHy4RZoWaOJzdOG9AIvH/iiUh8/ORw5y6mcYUOONJo6DMtpsrd4Y5o6Ry0j/
         nNHX5Cdd/8Kk1xF5ygwjue4DgF2OdJLs0GU7AOqK2ZKpBNbb9AicUlbl7HDqu4Jlxh3A
         zBChwThKidLxD4bNUwKcpVX9AsTz878emiMpvptALCTj6SP4XIGRndxqVs/DCnSp0MZo
         l1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJsZr9uc7gd0E/0o2TzFzv3kDRvmk40ohT91L6SsIrA=;
        b=HkkzETAMTHIAkDudaK5f2CfkgnVDfD4SrVEFnSO6AjAgchKarUmbFpRFKM5Q1ZiBjD
         V/1gS8MdD01DHkil42yaMhiw/8vjcw42pa/StQLXBtvvNzhnIaTbAV2otDqZADPRbyGY
         zs5S81dtvKYcnDUu2ePImJHupuBTCg69U21OFVIoJLheI7cboqoeJGoZgBEF8IpCwKjY
         k1GfaIaxHZPO5oniz96kVffeFu+pKzrQPzKHEaf1yGHHaR8vZIbVnvT304bbEG0RwGYc
         3N7JHHJVF3lFMqaIAqmHWEEH+XAHcuT5mblaGgQrX8LcTRg6IrfwsFZ2rMXWzp2cl6l4
         kYQw==
X-Gm-Message-State: AFqh2kqZ3X2DBmikj7h3LWnVG3cs+MOjMo202JPVPwAu0eXH4obeqDWD
        28TNqnccENP4qRTIMrkcJix9BHLtyKo=
X-Google-Smtp-Source: AMrXdXu86aio7uUZCzCG7UC1vdSOccbHELsl2822bThqFjqrvF/H4T1IdBh6Ao4KahsNuxkLemXH4g==
X-Received: by 2002:a05:600c:202:b0:3da:f80d:7230 with SMTP id 2-20020a05600c020200b003daf80d7230mr5036914wmi.8.1674012626083;
        Tue, 17 Jan 2023 19:30:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b003dafcd9b750sm578697wmq.43.2023.01.17.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:25 -0800 (PST)
Message-Id: <ab06ac9b965b827612594e3578b7be2a15ec1586.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:12 +0000
Subject: [PATCH v6 07/12] test-http-server: pass Git requests to http-backend
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

Teach the test-http-sever test helper to forward Git requests to the
`git-http-backend`.

Introduce a new test script t5556-http-auth.sh that spins up the test
HTTP server and attempts an `ls-remote` on the served repository,
without any authentication.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c |  71 ++++++++++++++++++++++++
 t/t5556-http-auth.sh        | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100755 t/t5556-http-auth.sh

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 36f4a54fe6d..ae17c738259 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -291,8 +291,79 @@ done:
 	return result;
 }
 
+static int is_git_request(struct req *req)
+{
+	static regex_t *smart_http_regex;
+	static int initialized;
+
+	if (!initialized) {
+		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
+		/*
+		 * This regular expression matches all dumb and smart HTTP
+		 * requests that are currently in use, and defined in
+		 * Documentation/gitprotocol-http.txt.
+		 *
+		 */
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
+static enum worker_result do__git(struct req *req)
+{
+	const char *ok = "HTTP/1.1 200 OK\r\n";
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int res;
+
+	/*
+	 * Note that we always respond with a 200 OK response even if the
+	 * http-backend process exits with an error. This helper is intended
+	 * only to be used to exercise the HTTP auth handling in the Git client,
+	 * and specifically around authentication (not handled by http-backend).
+	 *
+	 * If we wanted to respond with a more 'valid' HTTP response status then
+	 * we'd need to buffer the output of http-backend, wait for and grok the
+	 * exit status of the process, then write the HTTP status line followed
+	 * by the http-backend output. This is outside of the scope of this test
+	 * helper's use at time of writing.
+	 */
+	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
+		return error(_("could not send '%s'"), ok);
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
+	close(STDOUT_FILENO);
+	close(STDIN_FILENO);
+	return !!res;
+}
+
 static enum worker_result dispatch(struct req *req)
 {
+	if (is_git_request(req))
+		return do__git(req);
+
 	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
 			       WR_OK | WR_HANGUP);
 }
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
new file mode 100755
index 00000000000..ce1abffa6aa
--- /dev/null
+++ b/t/t5556-http-auth.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
+
+# Setup a repository
+#
+REPO_DIR="$TRASH_DIRECTORY"/repo
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
+PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
+
+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
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
+	rm -f OUT.*
+}
+
+test_expect_success 'http auth anonymous no challenge' '
+	test_when_finished "per_test_cleanup" &&
+
+	start_http_server &&
+
+	# Attempt to read from a protected repository
+	git ls-remote $ORIGIN_URL
+'
+
+test_done
-- 
gitgitgadget

