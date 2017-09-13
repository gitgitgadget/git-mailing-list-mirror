Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D0D20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdIMVzT (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:19 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:45958 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdIMVzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:10 -0400
Received: by mail-pf0-f179.google.com with SMTP id q76so2187505pfq.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o091HB19pw2+k+jttdpbOHBen4dYDDkGfsXvlQ9hYmg=;
        b=s4fpidfCBjd6cu3kUfJ/tHWC5DD9zdCV7NCFYbSYg7vmviRdWyu+PILebuH4WFIv9r
         v9AEwCBu2nOeFtz9gdQ7ql2gMLhMZk9at0W31/aszQ54xVgPHS1hgHwfxofZGQcQVqdj
         yL6igegGcrYxrV0VchVEdREcNtEUVXwgnkSmR5Pn/rqJphMnwG2D4eWUp4TeAPYyemLp
         jaAl3dFgMuQLLWuOeb9wdGABoij71H3XGEvqjw4MbTN0rzg8ajhHuHCmSBoLOv63QLND
         T8vx0/xKfoz+LCCJZv7oXcTAWOPa8DgDrhkuL8C9bts7ZP6InpOzBVx5mrNgEkjT/mYI
         Sfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o091HB19pw2+k+jttdpbOHBen4dYDDkGfsXvlQ9hYmg=;
        b=EeKVhPFTUEWb4DdpBhwTE9DbRGF6WXRLSZkbHQTEujKll7y/YGtaFGO09hPwO7hpwq
         ELpTBnGO3bjbFUkL1IiKt8rSkFXEnpx639wnP0L3nAgNq/cmr9CKnqrOOQnK2+3JYwVN
         mxi1vKvTZEnhcxcreJGbXI+xN5Dg79HMAw9lHtNixLtsCJMvuijftDGHOLzAJp0zI/T5
         mRUCtEiTcoa+Q2DAEYq27hjl98ENLAVgctZhQ8eSp64iUgJ/9hOT9W18q+f4S+LpXyuI
         R3Nh+rH8mALFXLmETFCYonCGKSBnSe5FrJnczZl+hP6j61k050AgV0r9N2CWaSryLRrl
         uk2w==
X-Gm-Message-State: AHPjjUiZQgdV75ZMkb39aZ756r0UAScvEqBrQHpmFUbOO3I2UnLLvOWJ
        roIYx5zBdHP3tIBI3T4xOQ==
X-Google-Smtp-Source: ADKCNb7GcFfrLhwgw7EDKI88+UQSPOCW6/4+XfYwX9rVcNDlB0QupziC1BTtwNqHmcChIiIxKBh2fQ==
X-Received: by 10.99.122.22 with SMTP id v22mr18736031pgc.394.1505339709059;
        Wed, 13 Sep 2017 14:55:09 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 6/8] connect: tell server that the client understands v1
Date:   Wed, 13 Sep 2017 14:54:46 -0700
Message-Id: <20170913215448.84674-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the connection logic to tell a serve that it understands protocol
v1.  This is done in 2 different ways for the built in protocols.

1. git://
   A normal request is structured as "command path/to/repo\0host=..\0"
   and due to a bug in an old version of git-daemon 73bb33a94 (daemon:
   Strictly parse the "extra arg" part of the command, 2009-06-04) we
   aren't able to place any extra args (separated by NULs) besides the
   host.  In order to get around this limitation put protocol version
   information after a second NUL byte so the request is structured
   like: "command path/to/repo\0host=..\0\0version=1\0".  git-daemon can
   then parse out the version number and set GIT_PROTOCOL.

2. ssh://, file://
   Set GIT_PROTOCOL envvar with the desired protocol version.  The
   envvar can be sent across ssh by using '-o SendEnv=GIT_PROTOCOL' and
   having the server whitelist this envvar.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c              |  37 ++++++--
 t/t5700-protocol-v1.sh | 223 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+), 5 deletions(-)
 create mode 100755 t/t5700-protocol-v1.sh

diff --git a/connect.c b/connect.c
index 2702e1f2e..40b388acd 100644
--- a/connect.c
+++ b/connect.c
@@ -815,6 +815,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
+		struct strbuf request = STRBUF_INIT;
 		/*
 		 * Set up virtual host information based on where we will
 		 * connect, unless the user has overridden us in
@@ -842,12 +843,24 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
-		packet_write_fmt(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
-			     target_host, 0);
+		strbuf_addf(&request,
+			    "%s %s%chost=%s%c",
+			    prog, path, 0,
+			    target_host, 0);
+
+		/* If using a new version put that stuff here after a second null byte */
+		if (get_protocol_version_config() > 0) {
+			strbuf_addch(&request, '\0');
+			strbuf_addf(&request, "version=%d%c",
+				    get_protocol_version_config(), '\0');
+		}
+
+		packet_write(fd[1], request.buf, request.len);
+
 		free(target_host);
+		strbuf_release(&request);
 	} else {
+		const char *const *var;
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
 
@@ -859,7 +872,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		sq_quote_buf(&cmd, path);
 
 		/* remove repo-local variables from the environment */
-		conn->env = local_repo_env;
+		for (var = local_repo_env; *var; var++)
+			argv_array_push(&conn->env_array, *var);
+
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
@@ -912,6 +927,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			argv_array_push(&conn->args, ssh);
+
+			if (get_protocol_version_config() > 0) {
+				argv_array_push(&conn->args, "-o");
+				argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+						 get_protocol_version_config());
+			}
+
 			if (flags & CONNECT_IPV4)
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
@@ -926,6 +949,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 			argv_array_push(&conn->args, ssh_host);
 		} else {
 			transport_check_allowed("file");
+			if (get_protocol_version_config() > 0) {
+				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+						 get_protocol_version_config());
+			}
 		}
 		argv_array_push(&conn->args, cmd.buf);
 
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
new file mode 100755
index 000000000..1988bbce6
--- /dev/null
+++ b/t/t5700-protocol-v1.sh
@@ -0,0 +1,223 @@
+#!/bin/sh
+
+test_description='test git wire-protocol transition'
+
+TEST_NO_CREATE_REPO=1
+
+. ./test-lib.sh
+
+# Test protocol v1 with 'git://' transport
+#
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=receive-pack
+daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+	test_commit -C "$daemon_parent" one
+'
+
+test_expect_success 'clone with git:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=1 \
+		clone "$GIT_DAEMON_URL/parent" daemon_child 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "version=1" log &&
+	# Server responded using protocol v1
+	grep "clone< version 1" log
+'
+
+test_expect_success 'fetch with git:// using protocol v1' '
+	test_commit -C "$daemon_parent" two &&
+
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
+		fetch 2>log &&
+
+	git -C daemon_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "version=1" log &&
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'pull with git:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
+		pull 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "version=1" log &&
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'push with git:// using protocol v1' '
+	test_commit -C daemon_child three &&
+
+	# Since the repository being served isnt bare we need to push to
+	# another branch explicitly to avoid mangling the master branch
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
+		push origin HEAD:client_branch 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "version=1" log &&
+	# Server responded using protocol v1
+	grep "push< version 1" log
+'
+
+stop_git_daemon
+
+# Test protocol v1 with 'file://' transport
+#
+test_expect_success 'create repo to be served by file:// transport' '
+	git init file_parent &&
+	test_commit -C file_parent one
+'
+
+test_expect_success 'clone with file:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=1 \
+		clone "file://$(pwd)/file_parent" file_child 2>log &&
+
+	git -C file_child log -1 --format=%s >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "clone< version 1" log
+'
+
+test_expect_success 'fetch with file:// using protocol v1' '
+	test_commit -C file_parent two &&
+
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
+		fetch 2>log &&
+
+	git -C file_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'pull with file:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
+		pull 2>log &&
+
+	git -C file_child log -1 --format=%s >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'push with file:// using protocol v1' '
+	test_commit -C file_child three &&
+
+	# Since the repository being served isnt bare we need to push to
+	# another branch explicitly to avoid mangling the master branch
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
+		push origin HEAD:client_branch 2>log &&
+
+	git -C file_child log -1 --format=%s >actual &&
+	git -C file_parent log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "push< version 1" log
+'
+
+# Test protocol v1 with 'ssh://' transport
+#
+test_expect_success 'setup ssh wrapper' '
+	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" &&
+	export GIT_SSH &&
+	export TRASH_DIRECTORY &&
+	>"$TRASH_DIRECTORY"/ssh-output
+'
+
+expect_ssh () {
+	test_when_finished '(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)' &&
+	echo "ssh: -o SendEnv=GIT_PROTOCOL myhost $1 '$PWD/ssh_parent'" >"$TRASH_DIRECTORY/ssh-expect" &&
+	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+}
+
+test_expect_success 'create repo to be served by ssh:// transport' '
+	git init ssh_parent &&
+	test_commit -C ssh_parent one
+'
+
+test_expect_success 'clone with ssh:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=1 \
+		clone "ssh://myhost:$(pwd)/ssh_parent" ssh_child 2>log &&
+	expect_ssh git-upload-pack &&
+
+	git -C ssh_child log -1 --format=%s >actual &&
+	git -C ssh_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "clone< version 1" log
+'
+
+test_expect_success 'fetch with ssh:// using protocol v1' '
+	test_commit -C ssh_parent two &&
+
+	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
+		fetch 2>log &&
+	expect_ssh git-upload-pack &&
+
+	git -C ssh_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C ssh_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'pull with ssh:// using protocol v1' '
+	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
+		pull 2>log &&
+	expect_ssh git-upload-pack &&
+
+	git -C ssh_child log -1 --format=%s >actual &&
+	git -C ssh_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'push with ssh:// using protocol v1' '
+	test_commit -C ssh_child three &&
+
+	# Since the repository being served isnt bare we need to push to
+	# another branch explicitly to avoid mangling the master branch
+	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
+		push origin HEAD:client_branch 2>log &&
+	expect_ssh git-receive-pack &&
+
+	git -C ssh_child log -1 --format=%s >actual &&
+	git -C ssh_parent log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "push< version 1" log
+'
+
+test_done
-- 
2.14.1.690.gbb1197296e-goog

