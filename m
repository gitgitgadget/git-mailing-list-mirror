Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866C62036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbdJCUPn (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:43 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:53989 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdJCUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:41 -0400
Received: by mail-pg0-f45.google.com with SMTP id j70so5316346pgc.10
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FD9hIe6JRhNa0tTHEFtI5+uTdjMFOioB2NB9gveS9Yg=;
        b=NkQgEhz0qc+hvfyR9Z/h4J2umZm1vqoqgyEU6wgjMgftH6agcl74Ne7jHNw6HEfyKH
         5OPrvTZbOCUrIOjTkfWD7fcdALBwOOAcuQVJQOEj9IdoioSq6kEABeJrAf9tk8PzDDEE
         j5gvWPbsTEiEl/ODYkpSxj05zvcw8VcEAPzP6h5GT44ZynzeorjxWBpszTDJIoaP9/bK
         Gh0kDey58Jwyw5T2v1f+yz/VeZh+ZNZBTu1uo+akBLtgz10c6kvHkY10HcOAwyr/MjZ5
         jmrJBPVsX2wV8K1VHa7MEf/0LkZ54adeFnnK0xDSqIxzBvCJyyg6lmYq/P6HcyuGr6BZ
         6JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FD9hIe6JRhNa0tTHEFtI5+uTdjMFOioB2NB9gveS9Yg=;
        b=T1cRT8IjPINmvnsNAHLcR/hk7hPxpRHYo9UD7NWYsMbC6xVrJzfGwylUCPkp+IUVqE
         djs11b1+PIj4YhYevJyYEUHiXQpD7DAVqSyMAOAhevcK8uEhlmF2m14mFWxLJDwLbLGs
         ecbsrS23ropd1vkDPPptgON/aPoYjk4rO6MOqKB9ohrOez9wrVnaVHZNOfemyIEP933R
         PE2QOIqIhuRg4QNMidhzYHQskLsdVL8yp9GRLZArlVYx7+4PeQ2dv8WGtrJtkVGSOg9n
         89PDSxxlZlW4VwisbcuzrT29DIkLLV2cH5oBB7sW3wpHY0OBpRxtZek1Jq4gsPwWRS+D
         1QpA==
X-Gm-Message-State: AHPjjUjAYVSyvbT41G3/Lf3vVU9v49tnCsiYxii2h+W2NVKVkUKdHMF2
        3vRzxAaTAtZ6+DzniuRhVaBIsW6OWmE=
X-Google-Smtp-Source: AOwi7QAMYABy8Q7kPLdLhC+j/5Mk0esNSVzDNgCjWd22KWdpjkB/p7wHao1oH377s3ThWWO1wdKNzA==
X-Received: by 10.99.120.197 with SMTP id t188mr16338784pgc.3.1507061739715;
        Tue, 03 Oct 2017 13:15:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 10/10] ssh: introduce a 'simple' ssh variant
Date:   Tue,  3 Oct 2017 13:15:07 -0700
Message-Id: <20171003201507.3589-11-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the 'ssh' transport, the '-o' option is used to specify an
environment variable which should be set on the remote end.  This allows
git to send additional information when contacting the server,
requesting the use of a different protocol version via the
'GIT_PROTOCOL' environment variable like so: "-o SendEnv=GIT_PROTOCOL"

Unfortunately not all ssh variants support the sending of environment
variables to the remote end.  To account for this, only use the '-o'
option for ssh variants which are OpenSSH compliant.  This is done by
checking that the basename of the ssh command is 'ssh' or the ssh
variant is overridden to be 'ssh' (via the ssh.variant config).

Previously if an ssh command's basename wasn't 'plink' or
'tortoiseplink' git assumed that the command was an OpenSSH variant.
Since user configured ssh commands may not be OpenSSH compliant, tighten
this constraint and assume a variant of 'simple' if the basename of the
command doesn't match the variants known to git.  The new ssh variant
'simple' will only have the host and command to execute ([username@]host
command) passed as parameters to the ssh command.

Update the Documentation to better reflect the command-line options sent
to ssh commands based on their variant.

Reported-by: Jeffrey Yasskin <jyasskin@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt |  27 ++++++++++--
 Documentation/git.txt    |   9 ++--
 connect.c                | 107 ++++++++++++++++++++++++++---------------------
 t/t5601-clone.sh         |   9 ++--
 t/t5700-protocol-v1.sh   |   2 +
 5 files changed, 95 insertions(+), 59 deletions(-)

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
index 7518ea3af..8bc3f2147 100644
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
diff --git a/connect.c b/connect.c
index b8695a2fa..65cee49b6 100644
--- a/connect.c
+++ b/connect.c
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
index b0779d362..ba86a44eb 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -147,6 +147,8 @@ test_expect_success 'push with file:// using protocol v1' '
 test_expect_success 'setup ssh wrapper' '
 	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh" &&
 	export GIT_SSH &&
+	GIT_SSH_VARIANT=ssh &&
+	export GIT_SSH_VARIANT &&
 	export TRASH_DIRECTORY &&
 	>"$TRASH_DIRECTORY"/ssh-output
 '
-- 
2.14.2.920.gcf0c67979c-goog

