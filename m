Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BD420281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032791AbdIZX5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:57:02 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:48883 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032775AbdIZX47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:59 -0400
Received: by mail-pg0-f44.google.com with SMTP id v23so6781284pgc.5
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1wG+rTf0LOkpp9QK+L4HlWs5mMukrXOm4MHdoycIW54=;
        b=n1Pkihp9udJY3yeD01IpTNoA1n96cZfjz6f1Vp/Yzgsr4DPpRMC4KrIvKHzucis28V
         leXNBVRS/gPX6onrzvSjHMfWVjoapnXSYZMO8u0WnJnAzBTT4CFT/OtQvQj3guzbAMVO
         MHwvAZ8zT35xkYpB498oaNHLrQlGtBtct4clPnUvMI5406Xo06XLHVI55Kd+ifsZcIXF
         MCB07YTOnGBIbT7I3vVgLWQSYTyBclboaFqrgjbJthVHYZmrNvbbtCc/HDNoBV/PicwM
         sGCdaUaNBA9H7tHHtRpQblmplaDwe/plDr6BOhxLISxftLgXHkaUgzTTyFHdlHBv3c5G
         XstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1wG+rTf0LOkpp9QK+L4HlWs5mMukrXOm4MHdoycIW54=;
        b=oWgf+84RaBvgMTQUkaD6ezq67aCq3Och8Ml1PXez4s9eqC33z63U0f0jtBvBfnHBMc
         HeLEQm26D0f8BmIVCtInePlJjjaKdDsZlWUVptFKMuIhFj47lPrwvQ+lyX2lFQaWyqO1
         d0d1dtOBRYWOCvQXrFJ86N/0wM5ZrZL3QDDPJP5MWBn7JBOVh+nsx79zZpT2JZs7Ai7Z
         tKxC6vXHL/weNCjTyjX97kxVB7QvRebcaQvyU6pm50yiBl9IR6bEJF5HwCznG5gWm6HI
         BnnFRq7n1qwCPh0paB4wU7fRoGWvan4ww2UTXggmmhek82Ns38QVA/xKieTgsfiLPqjj
         FN9Q==
X-Gm-Message-State: AHPjjUg1KyTItcmsGbgz6+rHLVrF+aif3Wi/kpNLNunIUuJTPujrJoHo
        JF330grzSNKlmwU+ZTfPIjO4rvjzGTE=
X-Google-Smtp-Source: AOwi7QAh0/DKkLIk2DX2a4g69sJtQzfZyYTTlG+dD7xjrs60y/EDIcEyjE5gTdLh/m/girI81z0NGA==
X-Received: by 10.84.216.87 with SMTP id f23mr12086706plj.307.1506470217130;
        Tue, 26 Sep 2017 16:56:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 7/9] connect: tell server that the client understands v1
Date:   Tue, 26 Sep 2017 16:56:25 -0700
Message-Id: <20170926235627.79606-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
index 1805debf3..12ebab724 100644
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
2.14.1.992.g2c7b836f3a-goog

