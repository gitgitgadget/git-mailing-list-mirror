Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2131F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKMHoQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 02:44:16 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44044 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMHoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 02:44:15 -0500
Received: by mail-qk1-f202.google.com with SMTP id f22so26189165qkm.11
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 13:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bE+i0cMIDNgfGeqwevWWgxf1aU55G62GW8Ai9ilrq5Y=;
        b=eJayx4ZOY0cJ1SwQUDiy0p6zo6MeQ296X2MKDmF8z6ZzMlIdG+2WYrhc2oVjL9BEsx
         GbF3XOjxvMRle1jIuRye9lQIKL60m/E36RWN0rysWPUO21qp33/6YNOlrtPZJ22xKlE6
         gr7zswrnCA430ISDcGDqY44MB3c6Syx6MviSj5CoyV1r2itL1ylGF479EChpcUtPv32p
         +luQTX85e94d2/T2q7PN9XcjfLAcgHr53IJfqGNzIHWEjFa1x40Jq9XKqJug+t3dc3ta
         7r7fyWjRh1mBBXX/MEr22S4Tlo7C4YknPpfXX8fBuwfVfYBPcQXrZrKfTfgApHhcezlx
         FGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bE+i0cMIDNgfGeqwevWWgxf1aU55G62GW8Ai9ilrq5Y=;
        b=DE3+YclEkzU0PxBIJgqHF1dqmTLLmuDjYpjdxvUhp3w5azOxCrMskN2SlGeAA2LcTC
         SVjUgi+ZmzbLVLeCY4DAhboXQmqUOWqcsy/yT4r6I+dahphtFlIa9hQ/mVb43lx+ToVu
         mJMrcdST56EjVxM7W1bAfDOtYVaTgId38+AcP358xySwTKyGjuSlRKjTOxb/UwmDJu7U
         sIoIAH7Vb/BmogFxYlkLgtftQ41oEaO0nQ6ImWYqZUQ0Px/QkILYAWiFhbh8VJ4Wl4Ay
         1dsUMML7DVm0izMLzHfE35/kYuCIci7facyfvA9BZ/Y3W1rbLoZq3ErwuBMD39OiyqRP
         /oKA==
X-Gm-Message-State: AGRZ1gKseCzyBspbi0H2wK2d77XiLELLLefRcnf/oZpOrQosAi8gI+3z
        b3TSUMBm9JwgCay5B5zaAz0pvwJX55q3T0LfYhJ/oPjLvhS6OyFlvJJeQNw5E09m0QV/a85sZUt
        FgUIwgWudwGpTOqS6jWSvbIK4YcLZcTrjd72z6ju+eM+W/Fb8b4qyoqZvdJGu4Ic=
X-Google-Smtp-Source: AJdET5fugRfpjnmhsk7nYgDjeDDhPzxkg+NNEiJw8fN1t7BPJO3b0C5hjKEybDNnfmtUAtYzgY+TaM5NPzLSYg==
X-Received: by 2002:ac8:25fc:: with SMTP id f57mr1831415qtf.12.1542059350566;
 Mon, 12 Nov 2018 13:49:10 -0800 (PST)
Date:   Mon, 12 Nov 2018 13:49:05 -0800
In-Reply-To: <cover.1542059029.git.steadmon@google.com>
Message-Id: <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1539305180.git.steadmon@google.com> <cover.1542059029.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v3 1/1] protocol: advertise multiple supported versions
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the client advertises that it supports the wire protocol
version set in the protocol.version config. However, not all services
support the same set of protocol versions. When connecting to
git-receive-pack, the client automatically downgrades to v0 if
config.protocol is set to v2, but this check is not performed for other
services.

This patch creates a protocol version registry. Individual operations
register all the protocol versions they support prior to communicating
with a server. Versions should be listed in preference order; the
version specified in protocol.version will automatically be moved to the
front of the registry.

The protocol version registry is passed to remote helpers via the
GIT_PROTOCOL environment variable.

Clients now advertise the full list of registered versions. Servers
select the first recognized version from this advertisement.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c      |   3 ++
 builtin/clone.c        |   4 ++
 builtin/fetch-pack.c   |   4 ++
 builtin/fetch.c        |   5 ++
 builtin/ls-remote.c    |   5 ++
 builtin/pull.c         |   5 ++
 builtin/push.c         |   4 ++
 builtin/send-pack.c    |   3 ++
 connect.c              |  47 ++++++++---------
 protocol.c             | 112 ++++++++++++++++++++++++++++++++++++++---
 protocol.h             |  17 +++++++
 remote-curl.c          |  28 +++++++----
 t/t5570-git-daemon.sh  |   2 +-
 t/t5700-protocol-v1.sh |   8 +--
 t/t5702-protocol-v2.sh |  16 +++---
 transport-helper.c     |   6 +++
 16 files changed, 214 insertions(+), 55 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e74f675390..8adb9f381b 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -8,6 +8,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "sideband.h"
 
 static void create_output_file(const char *output_file)
@@ -94,6 +95,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	register_allowed_protocol_version(protocol_v0);
+
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
diff --git a/builtin/clone.c b/builtin/clone.c
index fd2c3ef090..1651a950b6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -900,6 +900,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
+	register_allowed_protocol_version(protocol_v2);
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	fetch_if_missing = 0;
 
 	packet_trace_identity("clone");
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 1a1bc63566..cba935e4d3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -57,6 +57,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	fetch_if_missing = 0;
 
+	register_allowed_protocol_version(protocol_v2);
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..2a20cf8bfd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -21,6 +21,7 @@
 #include "argv-array.h"
 #include "utf8.h"
 #include "packfile.h"
+#include "protocol.h"
 #include "list-objects-filter-options.h"
 
 static const char * const builtin_fetch_usage[] = {
@@ -1476,6 +1477,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	int prune_tags_ok = 1;
 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 
+	register_allowed_protocol_version(protocol_v2);
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	packet_trace_identity("fetch");
 
 	fetch_if_missing = 0;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1a25df7ee1..ea685e8bb9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "protocol.h"
 #include "transport.h"
 #include "ref-filter.h"
 #include "remote.h"
@@ -80,6 +81,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	memset(&ref_array, 0, sizeof(ref_array));
 
+	register_allowed_protocol_version(protocol_v2);
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
diff --git a/builtin/pull.c b/builtin/pull.c
index 681c127a07..cb64146834 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "protocol.h"
 #include "exec-cmd.h"
 #include "run-command.h"
 #include "sha1-array.h"
@@ -849,6 +850,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int autostash;
 
+	register_allowed_protocol_version(protocol_v2);
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
diff --git a/builtin/push.c b/builtin/push.c
index d09a42062c..10d8abe829 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "transport.h"
 #include "parse-options.h"
+#include "protocol.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
@@ -587,6 +588,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8e3c7490f7..f48bd1306b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -184,6 +184,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	register_allowed_protocol_version(protocol_v1);
+	register_allowed_protocol_version(protocol_v0);
+
 	git_config(send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
diff --git a/connect.c b/connect.c
index 94547e5056..a170ba1e90 100644
--- a/connect.c
+++ b/connect.c
@@ -1046,7 +1046,7 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
  */
 static struct child_process *git_connect_git(int fd[2], char *hostandport,
 					     const char *path, const char *prog,
-					     enum protocol_version version,
+					     const struct strbuf *version_advert,
 					     int flags)
 {
 	struct child_process *conn;
@@ -1085,10 +1085,9 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 		    target_host, 0);
 
 	/* If using a new version put that stuff here after a second null byte */
-	if (version > 0) {
+	if (strcmp(version_advert->buf, "version=0")) {
 		strbuf_addch(&request, '\0');
-		strbuf_addf(&request, "version=%d%c",
-			    version, '\0');
+		strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
 	}
 
 	packet_write(fd[1], request.buf, request.len);
@@ -1104,14 +1103,14 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
  */
 static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 			     enum ssh_variant variant, const char *port,
-			     enum protocol_version version, int flags)
+			     const struct strbuf *version_advert, int flags)
 {
 	if (variant == VARIANT_SSH &&
-	    version > 0) {
+	    strcmp(version_advert->buf, "version=0")) {
 		argv_array_push(args, "-o");
 		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-				 version);
+		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
+				 version_advert->buf);
 	}
 
 	if (flags & CONNECT_IPV4) {
@@ -1164,7 +1163,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
-			  const char *port, enum protocol_version version,
+			  const char *port, const struct strbuf *version_advert,
 			  int flags)
 {
 	const char *ssh;
@@ -1198,15 +1197,16 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 
 		argv_array_push(&detect.args, ssh);
 		argv_array_push(&detect.args, "-G");
-		push_ssh_options(&detect.args, &detect.env_array,
-				 VARIANT_SSH, port, version, flags);
+		push_ssh_options(&detect.args, &detect.env_array, VARIANT_SSH,
+				 port, version_advert, flags);
 		argv_array_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
 	argv_array_push(&conn->args, ssh);
-	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
+	push_ssh_options(&conn->args, &conn->env_array, variant, port,
+			 version_advert, flags);
 	argv_array_push(&conn->args, ssh_host);
 }
 
@@ -1226,16 +1226,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 {
 	char *hostandport, *path;
 	struct child_process *conn;
+	struct strbuf version_advert = STRBUF_INIT;
 	enum protocol protocol;
-	enum protocol_version version = get_protocol_version_config();
 
-	/*
-	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
-	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
-		version = protocol_v0;
+	get_client_protocol_version_advertisement(&version_advert);
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -1250,7 +1244,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
-		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
+		conn = git_connect_git(fd, hostandport, path, prog,
+				       &version_advert, flags);
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1293,12 +1288,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
-			fill_ssh_args(conn, ssh_host, port, version, flags);
+			fill_ssh_args(conn, ssh_host, port, &version_advert,
+				      flags);
 		} else {
 			transport_check_allowed("file");
-			if (version > 0) {
-				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-						 version);
+			if (strcmp(version_advert.buf, "version=0")) {
+				argv_array_pushf(&conn->env_array,
+						 GIT_PROTOCOL_ENVIRONMENT "=%s",
+						 version_advert.buf);
 			}
 		}
 		argv_array_push(&conn->args, cmd.buf);
diff --git a/protocol.c b/protocol.c
index 5e636785d1..54d2ab991b 100644
--- a/protocol.c
+++ b/protocol.c
@@ -2,18 +2,43 @@
 #include "config.h"
 #include "protocol.h"
 
+static enum protocol_version *allowed_versions;
+static int nr_allowed_versions;
+static int alloc_allowed_versions;
+static int have_advertised_versions_already = 0;
+
+static const char protocol_v0_string[] = "0";
+static const char protocol_v1_string[] = "1";
+static const char protocol_v2_string[] = "2";
+
 static enum protocol_version parse_protocol_version(const char *value)
 {
-	if (!strcmp(value, "0"))
+	if (!strcmp(value, protocol_v0_string))
 		return protocol_v0;
-	else if (!strcmp(value, "1"))
+	else if (!strcmp(value, protocol_v1_string))
 		return protocol_v1;
-	else if (!strcmp(value, "2"))
+	else if (!strcmp(value, protocol_v2_string))
 		return protocol_v2;
 	else
 		return protocol_unknown_version;
 }
 
+/* Return the text representation of a wire protocol version. */
+static const char *format_protocol_version(enum protocol_version version)
+{
+	switch (version) {
+	case protocol_v0:
+		return protocol_v0_string;
+	case protocol_v1:
+		return protocol_v1_string;
+	case protocol_v2:
+		return protocol_v2_string;
+	case protocol_unknown_version:
+		die(_("Unrecognized protocol version"));
+	}
+	die(_("Unrecognized protocol_version"));
+}
+
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
@@ -30,6 +55,76 @@ enum protocol_version get_protocol_version_config(void)
 	return protocol_v0;
 }
 
+void register_allowed_protocol_version(enum protocol_version version)
+{
+	if (have_advertised_versions_already)
+		BUG(_("attempting to register an allowed protocol version after advertisement"));
+
+	ALLOC_GROW(allowed_versions, nr_allowed_versions + 1,
+		   alloc_allowed_versions);
+	allowed_versions[nr_allowed_versions++] = version;
+}
+
+void register_allowed_protocol_versions_from_env(void)
+{
+	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
+	const char *version_str;
+	struct string_list version_list = STRING_LIST_INIT_DUP;
+	struct string_list_item *version;
+
+	if (!git_protocol)
+		return;
+
+	string_list_split(&version_list, git_protocol, ':', -1);
+	for_each_string_list_item(version, &version_list) {
+		if (skip_prefix(version->string, "version=", &version_str))
+			register_allowed_protocol_version(
+				parse_protocol_version(version_str));
+	}
+	string_list_clear(&version_list, 0);
+}
+
+void get_client_protocol_version_advertisement(struct strbuf *advert)
+{
+	int tmp_nr = nr_allowed_versions;
+	enum protocol_version *tmp_allowed_versions, config_version;
+	strbuf_reset(advert);
+
+	have_advertised_versions_already = 1;
+
+	config_version = get_protocol_version_config();
+	if (config_version == protocol_v0) {
+		strbuf_addstr(advert, "version=0");
+		return;
+	}
+
+	if (tmp_nr > 0) {
+		ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
+		copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
+			   sizeof(enum protocol_version));
+	} else {
+		ALLOC_ARRAY(tmp_allowed_versions, 1);
+		tmp_nr = 1;
+		tmp_allowed_versions[0] = config_version;
+	}
+
+	if (tmp_allowed_versions[0] != config_version)
+		for (int i = 1; i < nr_allowed_versions; i++)
+			if (tmp_allowed_versions[i] == config_version) {
+				enum protocol_version swap =
+					tmp_allowed_versions[0];
+				tmp_allowed_versions[0] =
+					tmp_allowed_versions[i];
+				tmp_allowed_versions[i] = swap;
+			}
+
+	strbuf_addf(advert, "version=%s",
+		    format_protocol_version(tmp_allowed_versions[0]));
+	for (int i = 1; i < tmp_nr; i++)
+		strbuf_addf(advert, ":version=%s",
+			    format_protocol_version(tmp_allowed_versions[i]));
+}
+
 enum protocol_version determine_protocol_version_server(void)
 {
 	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
@@ -38,9 +133,10 @@ enum protocol_version determine_protocol_version_server(void)
 	/*
 	 * Determine which protocol version the client has requested.  Since
 	 * multiple 'version' keys can be sent by the client, indicating that
-	 * the client is okay to speak any of them, select the greatest version
-	 * that the client has requested.  This is due to the assumption that
-	 * the most recent protocol version will be the most state-of-the-art.
+	 * the client is okay to speak any of them, select the first
+	 * recognizable version that the client has requested.  This is due to
+	 * the assumption that the protocol versions will be listed in
+	 * preference order.
 	 */
 	if (git_protocol) {
 		struct string_list list = STRING_LIST_INIT_DUP;
@@ -53,8 +149,10 @@ enum protocol_version determine_protocol_version_server(void)
 
 			if (skip_prefix(item->string, "version=", &value)) {
 				v = parse_protocol_version(value);
-				if (v > version)
+				if (v != protocol_unknown_version) {
 					version = v;
+					break;
+				}
 			}
 		}
 
diff --git a/protocol.h b/protocol.h
index 2ad35e433c..b67b2259de 100644
--- a/protocol.h
+++ b/protocol.h
@@ -16,6 +16,23 @@ enum protocol_version {
  */
 extern enum protocol_version get_protocol_version_config(void);
 
+/*
+ * Register an allowable protocol version for a given operation. Registration
+ * must occur before attempting to advertise a version to a server process.
+ */
+extern void register_allowed_protocol_version(enum protocol_version version);
+
+/*
+ * Register allowable protocol versions from the GIT_PROTOCOL environment var.
+ */
+extern void register_allowed_protocol_versions_from_env(void);
+
+/*
+ * Fill a strbuf with a version advertisement string suitable for use in the
+ * GIT_PROTOCOL environment variable or similar version negotiation field.
+ */
+extern void get_client_protocol_version_advertisement(struct strbuf *advert);
+
 /*
  * Used by a server to determine which protocol version should be used based on
  * a client's request, communicated via the 'GIT_PROTOCOL' environment variable
diff --git a/remote-curl.c b/remote-curl.c
index fb28309e85..537f8c7aac 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -330,6 +330,20 @@ static int get_protocol_http_header(enum protocol_version version,
 	return 0;
 }
 
+static int get_client_protocol_http_header(const struct strbuf *version_advert,
+					   struct strbuf *header)
+{
+	if (version_advert->len > 0 &&
+	    strcmp(version_advert->buf, "version=0")) {
+		strbuf_addf(header, GIT_PROTOCOL_HEADER ": %s",
+			    version_advert->buf);
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -339,11 +353,11 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct strbuf refs_url = STRBUF_INIT;
 	struct strbuf effective_url = STRBUF_INIT;
 	struct strbuf protocol_header = STRBUF_INIT;
+	struct strbuf version_advert = STRBUF_INIT;
 	struct string_list extra_headers = STRING_LIST_INIT_DUP;
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
-	enum protocol_version version = get_protocol_version_config();
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -360,16 +374,10 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
-	/*
-	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
-	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", service))
-		version = protocol_v0;
+	get_client_protocol_version_advertisement(&version_advert);
 
 	/* Add the extra Git-Protocol header */
-	if (get_protocol_http_header(version, &protocol_header))
+	if (get_client_protocol_http_header(&version_advert, &protocol_header))
 		string_list_append(&extra_headers, protocol_header.buf);
 
 	memset(&http_options, 0, sizeof(http_options));
@@ -1327,6 +1335,8 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
+	register_allowed_protocol_versions_from_env();
+
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		error("remote-curl: usage: git remote-curl <remote> [<url>]");
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..d528e91630 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -186,7 +186,7 @@ test_expect_success 'hostname cannot break out of directory' '
 test_expect_success 'daemon log records all attributes' '
 	cat >expect <<-\EOF &&
 	Extended attribute "host": localhost
-	Extended attribute "protocol": version=1
+	Extended attribute "protocol": version=1:version=2:version=0
 	EOF
 	>daemon.log &&
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..2e56c79233 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -26,7 +26,7 @@ test_expect_success 'clone with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "clone> .*\\\0\\\0version=1\\\0$" log &&
+	grep "clone> .*\\\0\\\0version=1.*\\\0$" log &&
 	# Server responded using protocol v1
 	grep "clone< version 1" log
 '
@@ -42,7 +42,7 @@ test_expect_success 'fetch with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
+	grep "fetch> .*\\\0\\\0version=1.*\\\0$" log &&
 	# Server responded using protocol v1
 	grep "fetch< version 1" log
 '
@@ -56,7 +56,7 @@ test_expect_success 'pull with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
+	grep "fetch> .*\\\0\\\0version=1.*\\\0$" log &&
 	# Server responded using protocol v1
 	grep "fetch< version 1" log
 '
@@ -74,7 +74,7 @@ test_expect_success 'push with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "push> .*\\\0\\\0version=1\\\0$" log &&
+	grep "push> .*\\\0\\\0version=1.*\\\0$" log &&
 	# Server responded using protocol v1
 	grep "push< version 1" log
 '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3beeed4546..78c17c25e4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -24,7 +24,7 @@ test_expect_success 'list refs with git:// using protocol v2' '
 		ls-remote --symref "$GIT_DAEMON_URL/parent" >actual &&
 
 	# Client requested to use protocol v2
-	grep "git> .*\\\0\\\0version=2\\\0$" log &&
+	grep "git> .*\\\0\\\0version=2.*\\\0$" log &&
 	# Server responded using protocol v2
 	grep "git< version 2" log &&
 
@@ -56,7 +56,7 @@ test_expect_success 'clone with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "clone> .*\\\0\\\0version=2\\\0$" log &&
+	grep "clone> .*\\\0\\\0version=2.*\\\0$" log &&
 	# Server responded using protocol v2
 	grep "clone< version 2" log
 '
@@ -74,7 +74,7 @@ test_expect_success 'fetch with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	grep "fetch> .*\\\0\\\0version=2.*\\\0$" log &&
 	# Server responded using protocol v2
 	grep "fetch< version 2" log
 '
@@ -90,7 +90,7 @@ test_expect_success 'pull with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	grep "fetch> .*\\\0\\\0version=2.*\\\0$" log &&
 	# Server responded using protocol v2
 	grep "fetch< version 2" log
 '
@@ -476,7 +476,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_when_finished "rm -f log" &&
 	# Till v2 for push is designed, make sure that if a client has
 	# protocol.version configured to use v2, that the client instead falls
-	# back and uses v0.
+	# back to previous versions.
 
 	test_commit -C http_child three &&
 
@@ -489,10 +489,8 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
 	test_cmp expect actual &&
 
-	# Client didnt request to use protocol v2
-	! grep "Git-Protocol: version=2" log &&
-	# Server didnt respond using protocol v2
-	! grep "git< version 2" log
+	# Server responded with version 1
+	grep "git< version 1" log
 '
 
 
diff --git a/transport-helper.c b/transport-helper.c
index 143ca008c8..ac1937f1e1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -105,6 +105,7 @@ static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf version_advert = STRBUF_INIT;
 	struct child_process *helper;
 	int duped;
 	int code;
@@ -127,6 +128,11 @@ static struct child_process *get_helper(struct transport *transport)
 		argv_array_pushf(&helper->env_array, "%s=%s",
 				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
+	get_client_protocol_version_advertisement(&version_advert);
+	if (version_advert.len > 0)
+		argv_array_pushf(&helper->env_array, "%s=%s",
+				 GIT_PROTOCOL_ENVIRONMENT, version_advert.buf);
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
2.19.1.930.g4563a0d9d0-goog

