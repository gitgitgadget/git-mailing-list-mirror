Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01923C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKBWKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKBWJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71521391
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2152615wme.5
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvXDn+rrjem7Hg0M8fnuF0bVApTee9PoBQCoroxyf5w=;
        b=kBT5ZrvKl8jxYsPKF/j/oAWz/Q0vbLe/F/61pTQs4yuXR6R9UZ9tVfhzU9emx8SjbD
         S2L5h14W0HfOW7Z91Y4GoEuOAQaSEKnwL9KACvsjDypjA9Sc8ETDrddSZg2rFt3P/42k
         HaFhy8TDv/jNr5KTcKKx3Dw/gYw/HZ8HZWTJBNbrrTET2UcGUdNJYuqQO446Ccykv8zY
         KhbTCFCT9/qUxPiRMSCbC6DTcm8fL/PUuQxqFjEs3PXf1++/z7TEoIioXZpRL/b5UNUC
         sGcamJjTdVSgdbdXDha79EkNnZQMNEQcZcE7nSHJEA0xmHg9IqMRWwY6CdgE0dKFNkU6
         7ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvXDn+rrjem7Hg0M8fnuF0bVApTee9PoBQCoroxyf5w=;
        b=Y5v25LTu1gj27R7eCnzBEKo3LvFe9onGHWlQI+TwCS/WQetVPrxflhwdMegkJlOqze
         6P1YzsDbrz5VcLRvnSpOiVgWJn/e6QnJzzVgin2sE1GM61oOOUfHAOZKvTcANtqqakuS
         wpjwwwZDXaFgyeBIieheDvNWF2IFowaWgwyPhQe+rutcLAmbdsu1nVe/KOdA4jSaj8Jk
         +U78ozGgsYLS9Zfjrdk9Jh6RMbMuYhQgOm6GERfNnLIrlHsFhEoUdABeUT99SLWzOGnv
         yLQbKpLR08KyGe4QEuji3zzjkHNGxqE9gbFZgjnZVnvNth2c8oywmZ6JpoTnJQ+VuUQ3
         e8Qw==
X-Gm-Message-State: ACrzQf2fHuvOpgZOymhUr3BeDNZYkzMU0bE58vz/RVwh6Jn6jAbpD2Xv
        fMsXhPyHmd6XLWvOXanZL7QB7OR4n0g=
X-Google-Smtp-Source: AMsMyM6R+1lJ1uqvwriXXexTkIqqA6mRgN3FlT1QrxBCfGX8Yo3ZD3eEF5iGgbS5oe2UZl54bN6xWQ==
X-Received: by 2002:a05:600c:3594:b0:3ca:f978:5b97 with SMTP id p20-20020a05600c359400b003caf9785b97mr17872003wmq.64.1667426982763;
        Wed, 02 Nov 2022 15:09:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b002366d1cc198sm14236388wrn.41.2022.11.02.15.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:42 -0700 (PDT)
Message-Id: <5fb248c074acff1552874d98b28f746e1e43eac5.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:27 +0000
Subject: [PATCH v3 09/11] test-http-server: pass Git requests to http-backend
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
        Matthew John Cheetham <mjcheetham@github.com>,
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
 t/helper/test-http-server.c |  56 +++++++++++++++++++
 t/t5556-http-auth.sh        | 105 ++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100755 t/t5556-http-auth.sh

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 7bde678e264..9f1d6b58067 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -305,8 +305,64 @@ done:
 	return result;
 }
 
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
 static enum worker_result dispatch(struct req *req)
 {
+	if (is_git_request(req))
+		return do__git(req, NULL);
+
 	return send_http_error(1, 501, "Not Implemented", -1, NULL,
 			       WR_OK | WR_HANGUP);
 }
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
new file mode 100755
index 00000000000..78da151f122
--- /dev/null
+++ b/t/t5556-http-auth.sh
@@ -0,0 +1,105 @@
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
+	start_http_server --allow-anonymous &&
+
+	# Attempt to read from a protected repository
+	git ls-remote $ORIGIN_URL
+'
+
+test_done
-- 
gitgitgadget

