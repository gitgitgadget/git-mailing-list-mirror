Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E46120437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbdJPR4M (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:56:12 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:43643 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbdJPRzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:55 -0400
Received: by mail-it0-f51.google.com with SMTP id k70so3581326itk.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sE5oNtadRdLhCnA69/D8HUYutPTlhuxEv/i6plkz+8M=;
        b=l4//UIjo8i6DQtyaj3XlQeW4PhvMChn0ZyRhf4eoPfX1RYy2SemyjRxvnlkM2xgedv
         IHdct+DqYrql1H3HoBmfE5+Qwmey4gL+Uxm9ASiSBa0+7lCwuydSwQNk5qnGDuLc5hQC
         3VNGEV+hfzPHh7S/kES9v2hMVf5VAUbhHv6+cwBE8gGbpDOZZpSB0Inom+tk1knXR3Eq
         96MJJSFqdbsjP/Po9GLoXv2lg3cvn5gAwBlCjCyvswQles1/71fvG/2gyt5BteJP+y/p
         pF8+xL/lipMwbEkLwjv0NH9QQB1pDDbESQdpeCth1A4uoKw7jXCpNiYsBsE4rgnlJ2/n
         yw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sE5oNtadRdLhCnA69/D8HUYutPTlhuxEv/i6plkz+8M=;
        b=h6oLynUkgxhZ/xejd8dV8j9eXXYoGjYWMt0xFL1JLdCoJXxKRcX6fnSH94K91jSsbr
         vE47mBOQpdNvGFBzNz0zQfw0cX79TfoCOPbaabD5iyBgbRQAQpGIO0AsWe07Eh/Ty0Dk
         1T5HwuHx0FajjPOMNSnsAVMnPErRUFCMB0CHV2V456BOyk3FzCDrT76p1i1QY5ZRgy+3
         QTbzPWowoOwETLpX1Ux8Yg3pnKnuGzrDyEMfEs3sdqr7gNh+Cku5EKRMHce71yqeEN6F
         MvTN6d7B39qkAEJPS/n5wSEFYg8ypY4W+o8DI5yBKqhIIfK14bNmBrPftg41p+/W+Eu0
         2zAQ==
X-Gm-Message-State: AMCzsaVKF9df42bGLtFF6KIxmJOxy2A45HDtPC6hZ8qJ5OjijncgxzaL
        /C3YAwucIPwXvfNDAw//0zargH1xS6Y=
X-Google-Smtp-Source: ABhQp+QMBgdMolxpPPmuJcHomMhgPzE8gT0MNJSgJk7KQ6cIhOmlx2rzNSA91xvCyB4tnsuQ5j5qjw==
X-Received: by 10.36.33.71 with SMTP id e68mr2104656ita.111.1508176554513;
        Mon, 16 Oct 2017 10:55:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 07/11] connect: tell server that the client understands v1
Date:   Mon, 16 Oct 2017 10:55:28 -0700
Message-Id: <20171016175532.73459-8-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the connection logic to tell a serve that it understands protocol
v1.  This is done in 2 different ways for the builtin transports, both
of which ultimately set 'GIT_PROTOCOL' to 'version=1' on the server.

1. git://
   A normal request to git-daemon is structured as
   "command path/to/repo\0host=..\0" and due to a bug introduced in
   49ba83fb6 (Add virtualization support to git-daemon, 2006-09-19) we
   aren't able to place any extra arguments (separated by NULs) besides
   the host otherwise the parsing of those arguments would enter an
   infinite loop.  This bug was fixed in 73bb33a94 (daemon: Strictly
   parse the "extra arg" part of the command, 2009-06-04) but a check
   was put in place to disallow extra arguments so that new clients
   wouldn't trigger this bug in older servers.

   In order to get around this limitation git-daemon was taught to
   recognize additional request arguments hidden behind a second
   NUL byte.  Requests can then be structured like:
   "command path/to/repo\0host=..\0\0version=1\0key=value\0".
   git-daemon can then parse out the extra arguments and set
   'GIT_PROTOCOL' accordingly.

   By placing these extra arguments behind a second NUL byte we can
   skirt around both the infinite loop bug in 49ba83fb6 (Add
   virtualization support to git-daemon, 2006-09-19) as well as the
   explicit disallowing of extra arguments introduced in 73bb33a94
   (daemon: Strictly parse the "extra arg" part of the command,
   2009-06-04) because both of these versions of git-daemon check for a
   single NUL byte after the host argument before terminating the
   argument parsing.

2. ssh://, file://
   Set 'GIT_PROTOCOL' environment variable with the desired protocol
   version.  With the file:// transport, 'GIT_PROTOCOL' can be set
   explicitly in the locally running git-upload-pack or git-receive-pack
   processes.  With the ssh:// transport and OpenSSH compliant ssh
   programs, 'GIT_PROTOCOL' can be sent across ssh by using '-o
   SendEnv=GIT_PROTOCOL' and having the server whitelist this
   environment variable.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c              |  37 ++++++--
 t/t5700-protocol-v1.sh | 223 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+), 5 deletions(-)
 create mode 100755 t/t5700-protocol-v1.sh

diff --git a/connect.c b/connect.c
index a5e708a61..b8695a2fa 100644
--- a/connect.c
+++ b/connect.c
@@ -871,6 +871,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
+		struct strbuf request = STRBUF_INIT;
 		/*
 		 * Set up virtual host information based on where we will
 		 * connect, unless the user has overridden us in
@@ -898,13 +899,25 @@ struct child_process *git_connect(int fd[2], const char *url,
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
 		struct strbuf cmd = STRBUF_INIT;
+		const char *const *var;
 
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
@@ -917,7 +930,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		sq_quote_buf(&cmd, path);
 
 		/* remove repo-local variables from the environment */
-		conn->env = local_repo_env;
+		for (var = local_repo_env; *var; var++)
+			argv_array_push(&conn->env_array, *var);
+
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
@@ -971,6 +986,14 @@ struct child_process *git_connect(int fd[2], const char *url,
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
@@ -985,6 +1008,10 @@ struct child_process *git_connect(int fd[2], const char *url,
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
index 000000000..6551932da
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
+	grep "clone> .*\\\0\\\0version=1\\\0$" log &&
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
+	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
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
+	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
+	# Server responded using protocol v1
+	grep "fetch< version 1" log
+'
+
+test_expect_success 'push with git:// using protocol v1' '
+	test_commit -C daemon_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
+		push origin HEAD:client_branch 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v1
+	grep "push> .*\\\0\\\0version=1\\\0$" log &&
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
+	git -C file_child log -1 --format=%s origin/master >actual &&
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
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
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
+	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh" &&
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
+	git -C ssh_child log -1 --format=%s origin/master >actual &&
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
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
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
2.15.0.rc0.271.g36b669edcc-goog

