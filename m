Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9319C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdJCUP2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:28 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43264 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdJCUPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id d2so1942520pfh.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3qIRAa0pdmaF2Oc7/m0Houe3/W51LAQ9D+CqTvxdRcI=;
        b=Kwunzwv0dBVS6qfcvKWBuWMy40xGkAjJ0lTmqwNz+6ZI1T8LUDwzQ9P+s6qaR4MRAn
         uzkNpiOG+0LbKPHT92wUWX7zK3md6Lm8JsYsGXc7Mj4EtLMvbtzI9P5m86/7rGgEQcBV
         fE0LqW564C/JQ0EPqSP0v6Oi+59/5tfxWiYYVe32jjR/AA8OhMW1TDEnxpMQqWJQpReu
         +YkPXN32Gm8VdNu8Xm2HCkPUv6oh/DFbnFLkfPHHRE5dKHrMzSbnlbZkem03yYRXPlkS
         sxDSdX9es3NQp3emVgpmLYjJoNyANoUjTQ3cdtGUICtKch6MP8K1Pu51RC4NszTUVr4B
         +hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3qIRAa0pdmaF2Oc7/m0Houe3/W51LAQ9D+CqTvxdRcI=;
        b=sFzJf4Et93Tp42P3Xjens/BtAZ/xHde0jF0H2Q7VH6Ub/nr9NeV04W2nBianU0V0Yv
         ItSEbAVzhdJY5mUitP10vvTv7Z6oqlmCLrrT7CPmxwpVqUN6hdUYeemwaKM30YY7xy6c
         rempARZnW1vqKX1H6QajQd7nBUAfqoZirF4CZyA+5xRuKMmy10VwQx0LX2ipBBjjwSTI
         ECO/ezos7GvKU3JQ7IIGhdTNQ5MduTm+9sWCV4gLNI4mVtWh4Gojy0VXuiSXEHiJu/hs
         mrBM7zM5cm/ADowduxArO8GB7OsOlIRDDgMMeSef3OPug2wNCP0QTO3SZSP9xZcJnVpM
         wOXg==
X-Gm-Message-State: AMCzsaVlEYjq93Crj2fU4cMPQyrawaDHmVHZqBMpI4EcFwGh16vmo5aL
        Y8a7gH8CCkUGqxiqg6mWJTUMAXtqQbM=
X-Google-Smtp-Source: AOwi7QCynTUB/rlLIsXRnldo/RNJpyTOt3IagN41aiOxmOvlixwtsnSJEFxEFx2f/+oUNGNv2X1lYg==
X-Received: by 10.99.123.4 with SMTP id w4mr6427840pgc.438.1507061723268;
        Tue, 03 Oct 2017 13:15:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 00/10] protocol transition
Date:   Tue,  3 Oct 2017 13:14:57 -0700
Message-Id: <20171003201507.3589-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
 * added a new ssh variant 'simple' and update documentation to better reflect
   the command-line parameters passed to the ssh command.
 * updated various commit messages based on feedback.
 * tighten the wording for 'GIT_PROTOCOL' to indicate that both unknown keys
   and values must be ignored.
 * added API comments for functions in protocol.h
 * updated various tests in t5700 based on reviewer feedback

Brandon Williams (9):
  pkt-line: add packet_write function
  protocol: introduce protocol extention mechanisms
  daemon: recognize hidden request arguments
  upload-pack, receive-pack: introduce protocol version 1
  connect: teach client to recognize v1 server response
  connect: tell server that the client understands v1
  http: tell server that the client understands v1
  i5700: add interop test for protocol transition
  ssh: introduce a 'simple' ssh variant

Jonathan Tan (1):
  connect: in ref advertisement, shallows are last

 Documentation/config.txt               |  44 +++-
 Documentation/git.txt                  |  15 +-
 Makefile                               |   1 +
 builtin/receive-pack.c                 |  15 ++
 cache.h                                |  10 +
 connect.c                              | 353 ++++++++++++++++++++++-----------
 daemon.c                               |  68 ++++++-
 http.c                                 |  18 ++
 pkt-line.c                             |   6 +
 pkt-line.h                             |   1 +
 protocol.c                             |  79 ++++++++
 protocol.h                             |  33 +++
 t/interop/i5700-protocol-transition.sh |  68 +++++++
 t/lib-httpd/apache.conf                |   7 +
 t/t5601-clone.sh                       |   9 +-
 t/t5700-protocol-v1.sh                 | 294 +++++++++++++++++++++++++++
 upload-pack.c                          |  18 +-
 17 files changed, 900 insertions(+), 139 deletions(-)
 create mode 100644 protocol.c
 create mode 100644 protocol.h
 create mode 100755 t/interop/i5700-protocol-transition.sh
 create mode 100755 t/t5700-protocol-v1.sh

--- interdiff with 'origin/bw/protocol-v1'

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b78747abc..0460af37e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2084,12 +2084,31 @@ ssh.variant::
 	Depending on the value of the environment variables `GIT_SSH` or
 	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
 	auto-detects whether to adjust its command-line parameters for use
-	with plink or tortoiseplink, as opposed to the default (OpenSSH).
+	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
+	(simple).
 +
 The config variable `ssh.variant` can be set to override this auto-detection;
-valid values are `ssh`, `plink`, `putty` or `tortoiseplink`. Any other value
-will be treated as normal ssh. This setting can be overridden via the
-environment variable `GIT_SSH_VARIANT`.
+valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
+other value will be treated as normal ssh. This setting can be overridden via
+the environment variable `GIT_SSH_VARIANT`.
++
+The current command-line parameters used for each variant are as
+follows:
++
+--
+
+* `ssh` - [-p port] [-4] [-6] [-o option] [username@]host command
+
+* `simple` - [username@]host command
+
+* `plink` or `putty` - [-P port] [-4] [-6] [username@]host command
+
+* `tortoiseplink` - [-P port] [-4] [-6] -batch [username@]host command
+
+--
++
+Except for the `simple` variant, command-line parameters are likely to
+change as git gains new features.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 299f75c7b..8bc3f2147 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -518,11 +518,10 @@ other
 	If either of these environment variables is set then 'git fetch'
 	and 'git push' will use the specified command instead of 'ssh'
 	when they need to connect to a remote system.
-	The command will be given exactly two or four arguments: the
-	'username@host' (or just 'host') from the URL and the shell
-	command to execute on that remote system, optionally preceded by
-	`-p` (literally) and the 'port' from the URL when it specifies
-	something other than the default SSH port.
+	The command-line parameters passed to the configured command are
+	determined by the ssh variant.  See `ssh.variant` option in
+	linkgit:git-config[1] for details.
+
 +
 `$GIT_SSH_COMMAND` takes precedence over `$GIT_SSH`, and is interpreted
 by the shell, which allows additional arguments to be included.
@@ -700,7 +699,8 @@ of clones and fetches.
 `GIT_PROTOCOL`::
 	For internal use only.  Used in handshaking the wire protocol.
 	Contains a colon ':' separated list of keys with optional values
-	'key[=value]'.  Presence of unknown keys must be tolerated.
+	'key[=value]'.  Presence of unknown keys and values must be
+	ignored.
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cb179367b..94b7d29ea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1973,8 +1973,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		 * so just fall through after writing the version string.
 		 */
 	case protocol_v0:
-	default:
 		break;
+	default:
+		BUG("unknown protocol version");
 	}
 
 	if (advertise_refs || !stateless_rpc) {
diff --git a/cache.h b/cache.h
index aaadac1f0..3a6b869c2 100644
--- a/cache.h
+++ b/cache.h
@@ -448,7 +448,8 @@ static inline enum object_type object_type(unsigned int mode)
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
- * 'key[=value]'.  Presence of unknown keys must be tolerated.
+ * 'key[=value]'.  Presence of unknown keys and values must be
+ * ignored.
  */
 #define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
 /* HTTP header used to handshake the wire protocol */
diff --git a/connect.c b/connect.c
index 12ebab724..65cee49b6 100644
--- a/connect.c
+++ b/connect.c
@@ -139,12 +139,12 @@ static int read_remote_ref(int in, char **src_buf, size_t *src_len,
 static int process_protocol_version(void)
 {
 	switch (determine_protocol_version_client(packet_buffer)) {
-		case protocol_v1:
-			return 1;
-		case protocol_v0:
-			return 0;
-		default:
-			die("server is speaking an unknown protocol");
+	case protocol_v1:
+		return 1;
+	case protocol_v0:
+		return 0;
+	default:
+		die("server is speaking an unknown protocol");
 	}
 }
 
@@ -776,37 +776,44 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
-static int override_ssh_variant(int *port_option, int *needs_batch)
+enum ssh_variant {
+	VARIANT_SIMPLE,
+	VARIANT_SSH,
+	VARIANT_PLINK,
+	VARIANT_PUTTY,
+	VARIANT_TORTOISEPLINK,
+};
+
+static int override_ssh_variant(enum ssh_variant *ssh_variant)
 {
-	char *variant;
+	const char *variant = getenv("GIT_SSH_VARIANT");
 
-	variant = xstrdup_or_null(getenv("GIT_SSH_VARIANT"));
-	if (!variant &&
-	    git_config_get_string("ssh.variant", &variant))
+	if (!variant && git_config_get_string_const("ssh.variant", &variant))
 		return 0;
 
-	if (!strcmp(variant, "plink") || !strcmp(variant, "putty")) {
-		*port_option = 'P';
-		*needs_batch = 0;
-	} else if (!strcmp(variant, "tortoiseplink")) {
-		*port_option = 'P';
-		*needs_batch = 1;
-	} else {
-		*port_option = 'p';
-		*needs_batch = 0;
-	}
-	free(variant);
+	if (!strcmp(variant, "plink"))
+		*ssh_variant = VARIANT_PLINK;
+	else if (!strcmp(variant, "putty"))
+		*ssh_variant = VARIANT_PUTTY;
+	else if (!strcmp(variant, "tortoiseplink"))
+		*ssh_variant = VARIANT_TORTOISEPLINK;
+	else if (!strcmp(variant, "simple"))
+		*ssh_variant = VARIANT_SIMPLE;
+	else
+		*ssh_variant = VARIANT_SSH;
+
 	return 1;
 }
 
-static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
-			       int *port_option, int *needs_batch)
+static enum ssh_variant determine_ssh_variant(const char *ssh_command,
+					      int is_cmdline)
 {
+	enum ssh_variant ssh_variant = VARIANT_SIMPLE;
 	const char *variant;
 	char *p = NULL;
 
-	if (override_ssh_variant(port_option, needs_batch))
-		return;
+	if (override_ssh_variant(&ssh_variant))
+		return ssh_variant;
 
 	if (!is_cmdline) {
 		p = xstrdup(ssh_command);
@@ -825,19 +832,21 @@ static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
 			free(ssh_argv);
 		} else {
 			free(p);
-			return;
+			return ssh_variant;
 		}
 	}
 
-	if (!strcasecmp(variant, "plink") ||
-	    !strcasecmp(variant, "plink.exe"))
-		*port_option = 'P';
+	if (!strcasecmp(variant, "ssh"))
+		ssh_variant = VARIANT_SSH;
+	else if (!strcasecmp(variant, "plink") ||
+		 !strcasecmp(variant, "plink.exe"))
+		ssh_variant = VARIANT_PLINK;
 	else if (!strcasecmp(variant, "tortoiseplink") ||
-		 !strcasecmp(variant, "tortoiseplink.exe")) {
-		*port_option = 'P';
-		*needs_batch = 1;
-	}
+		 !strcasecmp(variant, "tortoiseplink.exe"))
+		ssh_variant = VARIANT_TORTOISEPLINK;
+
 	free(p);
+	return ssh_variant;
 }
 
 /*
@@ -937,8 +946,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int needs_batch = 0;
-			int port_option = 'p';
+			enum ssh_variant variant;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			transport_check_allowed("ssh");
@@ -965,10 +973,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 				die("strange hostname '%s' blocked", ssh_host);
 
 			ssh = get_ssh_command();
-			if (ssh)
-				handle_ssh_variant(ssh, 1, &port_option,
-						   &needs_batch);
-			else {
+			if (ssh) {
+				variant = determine_ssh_variant(ssh, 1);
+			} else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
@@ -979,32 +986,38 @@ struct child_process *git_connect(int fd[2], const char *url,
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
-				else
-					handle_ssh_variant(ssh, 0,
-							   &port_option,
-							   &needs_batch);
+				variant = determine_ssh_variant(ssh, 0);
 			}
 
 			argv_array_push(&conn->args, ssh);
 
-			if (get_protocol_version_config() > 0) {
+			if (variant == VARIANT_SSH &&
+			    get_protocol_version_config() > 0) {
 				argv_array_push(&conn->args, "-o");
 				argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
 				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 						 get_protocol_version_config());
 			}
 
-			if (flags & CONNECT_IPV4)
-				argv_array_push(&conn->args, "-4");
-			else if (flags & CONNECT_IPV6)
-				argv_array_push(&conn->args, "-6");
-			if (needs_batch)
+			if (variant != VARIANT_SIMPLE) {
+				if (flags & CONNECT_IPV4)
+					argv_array_push(&conn->args, "-4");
+				else if (flags & CONNECT_IPV6)
+					argv_array_push(&conn->args, "-6");
+			}
+
+			if (variant == VARIANT_TORTOISEPLINK)
 				argv_array_push(&conn->args, "-batch");
-			if (port) {
-				argv_array_pushf(&conn->args,
-						 "-%c", port_option);
+
+			if (port && variant != VARIANT_SIMPLE) {
+				if (variant == VARIANT_SSH)
+					argv_array_push(&conn->args, "-p");
+				else
+					argv_array_push(&conn->args, "-P");
+
 				argv_array_push(&conn->args, port);
 			}
+
 			argv_array_push(&conn->args, ssh_host);
 		} else {
 			transport_check_allowed("file");
diff --git a/protocol.c b/protocol.c
index 369503065..43012b7eb 100644
--- a/protocol.c
+++ b/protocol.c
@@ -33,6 +33,13 @@ enum protocol_version determine_protocol_version_server(void)
 	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
 	enum protocol_version version = protocol_v0;
 
+	/*
+	 * Determine which protocol version the client has requested.  Since
+	 * multiple 'version' keys can be sent by the client, indicating that
+	 * the client is okay to speak any of them, select the greatest version
+	 * that the client has requested.  This is due to the assumption that
+	 * the most recent protocol version will be the most state-of-the-art.
+	 */
 	if (git_protocol) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 		const struct string_list_item *item;
diff --git a/protocol.h b/protocol.h
index 18f9a5235..1b2bc94a8 100644
--- a/protocol.h
+++ b/protocol.h
@@ -7,8 +7,27 @@ enum protocol_version {
 	protocol_v1 = 1,
 };
 
+/*
+ * Used by a client to determine which protocol version to request be used when
+ * communicating with a server, reflecting the configured value of the
+ * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
+ * returned.
+ */
 extern enum protocol_version get_protocol_version_config(void);
+
+/*
+ * Used by a server to determine which protocol version should be used based on
+ * a client's request, communicated via the 'GIT_PROTOCOL' environment variable
+ * by setting appropriate values for the key 'version'.  If a client doesn't
+ * request a particular protocol version, a default of 'protocol_v0' will be
+ * used.
+ */
 extern enum protocol_version determine_protocol_version_server(void);
+
+/*
+ * Used by a client to determine which protocol version the server is speaking
+ * based on the server's initial response.
+ */
 extern enum protocol_version determine_protocol_version_client(const char *server_response);
 
 #endif /* PROTOCOL_H */
diff --git a/t/interop/i5700-protocol-transition.sh b/t/interop/i5700-protocol-transition.sh
index 9e83428a8..97e8e580e 100755
--- a/t/interop/i5700-protocol-transition.sh
+++ b/t/interop/i5700-protocol-transition.sh
@@ -3,7 +3,7 @@
 VERSION_A=.
 VERSION_B=v2.0.0
 
-: ${LIB_GIT_DAEMON_PORT:=5600}
+: ${LIB_GIT_DAEMON_PORT:=5700}
 LIB_GIT_DAEMON_COMMAND='git.b daemon'
 
 test_description='clone and fetch by client who is trying to use a new protocol'
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f771b..ee1a24c5b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -312,6 +312,8 @@ setup_ssh_wrapper () {
 			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		export GIT_SSH &&
+		GIT_SSH_VARIANT=ssh &&
+		export GIT_SSH_VARIANT &&
 		export TRASH_DIRECTORY &&
 		>"$TRASH_DIRECTORY"/ssh-output
 	'
@@ -320,7 +322,8 @@ setup_ssh_wrapper () {
 copy_ssh_wrapper_as () {
 	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
 	GIT_SSH="${1%$X}$X" &&
-	export GIT_SSH
+	export GIT_SSH &&
+	unset GIT_SSH_VARIANT
 }
 
 expect_ssh () {
@@ -362,10 +365,10 @@ test_expect_success 'bracketed hostnames are still ssh' '
 	expect_ssh "-p 123" myhost src
 '
 
-test_expect_success 'uplink is not treated as putty' '
+test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
-	expect_ssh "-p 123" myhost src
+	expect_ssh myhost src
 '
 
 test_expect_success 'plink is treated specially (as putty)' '
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 222265127..ba86a44eb 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -26,7 +26,7 @@ test_expect_success 'clone with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "version=1" log &&
+	grep "clone> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
 	grep "clone< version 1" log
 '
@@ -37,12 +37,12 @@ test_expect_success 'fetch with git:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C daemon_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C daemon_child log -1 --format=%s origin/master >actual &&
 	git -C "$daemon_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "version=1" log &&
+	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
 	grep "fetch< version 1" log
 '
@@ -56,7 +56,7 @@ test_expect_success 'pull with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "version=1" log &&
+	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
 	grep "fetch< version 1" log
 '
@@ -64,8 +64,8 @@ test_expect_success 'pull with git:// using protocol v1' '
 test_expect_success 'push with git:// using protocol v1' '
 	test_commit -C daemon_child three &&
 
-	# Since the repository being served isnt bare we need to push to
-	# another branch explicitly to avoid mangling the master branch
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -74,7 +74,7 @@ test_expect_success 'push with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "version=1" log &&
+	grep "push> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
 	grep "push< version 1" log
 '
@@ -106,7 +106,7 @@ test_expect_success 'fetch with file:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C file_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C file_child log -1 --format=%s origin/master >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -129,8 +129,8 @@ test_expect_success 'pull with file:// using protocol v1' '
 test_expect_success 'push with file:// using protocol v1' '
 	test_commit -C file_child three &&
 
-	# Since the repository being served isnt bare we need to push to
-	# another branch explicitly to avoid mangling the master branch
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -145,8 +145,10 @@ test_expect_success 'push with file:// using protocol v1' '
 # Test protocol v1 with 'ssh://' transport
 #
 test_expect_success 'setup ssh wrapper' '
-	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" &&
+	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh" &&
 	export GIT_SSH &&
+	GIT_SSH_VARIANT=ssh &&
+	export GIT_SSH_VARIANT &&
 	export TRASH_DIRECTORY &&
 	>"$TRASH_DIRECTORY"/ssh-output
 '
@@ -182,7 +184,7 @@ test_expect_success 'fetch with ssh:// using protocol v1' '
 		fetch 2>log &&
 	expect_ssh git-upload-pack &&
 
-	git -C ssh_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C ssh_child log -1 --format=%s origin/master >actual &&
 	git -C ssh_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -206,8 +208,8 @@ test_expect_success 'pull with ssh:// using protocol v1' '
 test_expect_success 'push with ssh:// using protocol v1' '
 	test_commit -C ssh_child three &&
 
-	# Since the repository being served isnt bare we need to push to
-	# another branch explicitly to avoid mangling the master branch
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 	expect_ssh git-receive-pack &&
@@ -251,7 +253,7 @@ test_expect_success 'fetch with http:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C http_child log -1 --format=%s FETCH_HEAD >actual &&
+	git -C http_child log -1 --format=%s origin/master >actual &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -274,8 +276,8 @@ test_expect_success 'pull with http:// using protocol v1' '
 test_expect_success 'push with http:// using protocol v1' '
 	test_commit -C http_child three &&
 
-	# Since the repository being served isnt bare we need to push to
-	# another branch explicitly to avoid mangling the master branch
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		push origin HEAD:client_branch && #2>log &&
 
diff --git a/upload-pack.c b/upload-pack.c
index 5cab39819..ef438e9c2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1078,9 +1078,10 @@ int cmd_main(int argc, const char **argv)
 		 * so just fall through after writing the version string.
 		 */
 	case protocol_v0:
-	default:
 		upload_pack();
 		break;
+	default:
+		BUG("unknown protocol version");
 	}
 
 	return 0;


-- 
2.14.2.920.gcf0c67979c-goog

