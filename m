Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1AF920954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdLDX7h (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43847 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdLDX7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:22 -0500
Received: by mail-pg0-f65.google.com with SMTP id b18so9384998pgv.10
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5DVxnT0MhvA38PunuouMateX+8xkbc/6ADwghkdnHZE=;
        b=egvrkQ60l2yNhwKbnESDGD5VCaXO4P6gS2HbMzWHL4tZFog1pYbtjRHHUxuDflwUsd
         KOjAn52eRRLebLKlwIDfqPNjwiriv57ET+5m4t7AhnlO3zXbh/mqrEjHwA9sGe1pGCPh
         ebhrgNAAqKdFO7qwBLyEC2JWf3+4JbYIT38lHWfMwzz6C8g9O901oYKhMaw++v4rYC0C
         f5Xq014waGptkgTX9FNgQLfccSEmgqvLhhfNJfjIJGwOaUF3kn+4hyCHjdOJnlWoT6RU
         VQNJUrNdWmagArfy+cc7Wlklwhtk716J60QQjYJmoFt1cWVuK+CsthFD48KkD9CozP4S
         UINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5DVxnT0MhvA38PunuouMateX+8xkbc/6ADwghkdnHZE=;
        b=O6yJNMjNW/fyzaf0UOl6/BxrZvFQ4QhFDnVUXfl2JTPHs4NqPviV10Fl/wmRztydiZ
         sZCZAA3q90DWxHNaiRBkl4n/G+EIGdWNOjoHCJbgfArgCC2DxSNSbnwoEgtgEyosyVJE
         D/h9JHhB+Ri4Ncq4UrK7F5BZagW4B1opTZGxHtDPfmZ9zmgkabuMtwRe97VkQxeQiYeF
         HVhriGfdB/24OcY1yqp+Anl27BAOwMxjq8+ddTPYIl+UKpB+C4AltyF4bmQQgqVDm/JW
         HadVK1KfWGjT0And9w86etjJeXDr+180YU24JmpmbcgGor6f/ZsgnTBUo0Jc/o5i2Fni
         +O9A==
X-Gm-Message-State: AKGB3mK5x5otlghds7DiRj39wOzp2fSAOg3rdEbVwTR6AMgL4z9loUES
        B+XwtZWHckHo56eSnXjRU92N/d1B/Wk=
X-Google-Smtp-Source: AGs4zMbq7sZtFElq6ydXLftMibTblN3rNtT5SP3oYxbdnpQMJ55drYhh2k0YkOl8jcHyCWGfHmVU9w==
X-Received: by 10.159.254.8 with SMTP id r8mr3282070pls.291.1512431961413;
        Mon, 04 Dec 2017 15:59:21 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:20 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 11/15] serve: introduce git-serve
Date:   Mon,  4 Dec 2017 15:58:19 -0800
Message-Id: <20171204235823.63299-12-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce git-serve, the base server for protocol version 2.

When connecting to a server supporting protocol version 2, the server
will send a list all of its capabilities and then wait for the client to
send a command request.  Some capabilities advertised are 'commands'
which the client can request (push and fetch are examples of such
commands).  A command request is comprised of a list of capabilities,
including a command request "command=<command>", a delimiter packet,
followed by a list of parameters for the requested command.

At the end of each command a client can request that another command be
executed or can terminate the connection by sending a flush packet.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 .gitignore      |   1 +
 Makefile        |   2 +
 builtin.h       |   1 +
 builtin/serve.c |  25 ++++++++
 git.c           |   1 +
 serve.c         | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 serve.h         |   6 ++
 7 files changed, 221 insertions(+)
 create mode 100644 builtin/serve.c
 create mode 100644 serve.c
 create mode 100644 serve.h

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..2d0450c26 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,6 +140,7 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-serve
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
diff --git a/Makefile b/Makefile
index 86394b69d..710672cf4 100644
--- a/Makefile
+++ b/Makefile
@@ -862,6 +862,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
+LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
@@ -995,6 +996,7 @@ BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
+BUILTIN_OBJS += builtin/serve.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
diff --git a/builtin.h b/builtin.h
index f332a1257..3f3fdfc28 100644
--- a/builtin.h
+++ b/builtin.h
@@ -215,6 +215,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_serve(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/serve.c b/builtin/serve.c
new file mode 100644
index 000000000..2ecaad3b6
--- /dev/null
+++ b/builtin/serve.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "serve.h"
+
+static char const * const grep_usage[] = {
+	N_("git serve [<options>]"),
+	NULL
+};
+
+int cmd_serve(int argc, const char **argv, const char *prefix)
+{
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	/* ignore all unknown cmdline switches for now */
+	argc = parse_options(argc, argv, prefix, options, grep_usage,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN);
+	serve();
+
+	return 0;
+}
diff --git a/git.c b/git.c
index e32e16f2d..527086eaf 100644
--- a/git.c
+++ b/git.c
@@ -457,6 +457,7 @@ static struct cmd_struct commands[] = {
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
+	{ "serve", cmd_serve, RUN_SETUP },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/serve.c b/serve.c
new file mode 100644
index 000000000..476e73b54
--- /dev/null
+++ b/serve.c
@@ -0,0 +1,185 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "pkt-line.h"
+#include "version.h"
+#include "argv-array.h"
+#include "serve.h"
+
+static int agent_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	strbuf_addstr(value, git_user_agent_sanitized());
+	return 1;
+}
+
+struct protocol_capability {
+	const char *name;
+	int advertised; /* capability was advertised */
+	/* int advertise(struct strbuf *value, struct repository *r) */
+	int (*advertise)(struct repository *r, struct strbuf *value);
+	/* int command(struct repository *r, struct argv_array *keys, struct argv_array *args)*/
+	int (*command)(struct repository *r,
+		       struct argv_array *keys,
+		       struct argv_array *args);
+};
+
+static struct protocol_capability capabilities[] = {
+	{ "agent", 0, agent_advertise, NULL },
+};
+
+static void advertise_capabilities(void)
+{
+	struct strbuf capability = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+		struct protocol_capability *c = &capabilities[i];
+
+		c->advertised = c->advertise(the_repository, &value);
+		if (c->advertised) {
+			strbuf_addstr(&capability, c->name);
+
+			if (value.len) {
+				strbuf_addch(&capability, '=');
+				strbuf_addbuf(&capability, &value);
+			}
+
+			strbuf_addch(&capability, '\n');
+			packet_write(1, capability.buf, capability.len);
+		}
+
+		strbuf_reset(&capability);
+		strbuf_reset(&value);
+	}
+
+	packet_flush(1);
+	strbuf_release(&capability);
+	strbuf_release(&value);
+}
+
+static struct protocol_capability *get_capability(const char *key)
+{
+	int i;
+
+	if (!key)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+		struct protocol_capability *c = &capabilities[i];
+		const char *out;
+		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
+			return c;
+	}
+
+	return NULL;
+}
+
+static int is_valid_capability(const char *key)
+{
+	const struct protocol_capability *c = get_capability(key);
+
+	return c && c->advertised;
+}
+
+static int is_command(const char *key, struct protocol_capability **command)
+{
+	const char *out;
+
+	if (skip_prefix(key, "command=", &out)) {
+		struct protocol_capability *cmd = get_capability(out);
+
+		if (!cmd || !cmd->advertised || !cmd->command)
+			die("invalid cmd '%s'", out);
+		if (*command)
+			die("command already requested");
+
+		*command = cmd;
+		return 1;
+	}
+
+	return 0;
+}
+
+#define PROCESS_REQUEST_KEYS 0
+#define PROCESS_REQUEST_ARGS 1
+#define PROCESS_REQUEST_DONE 2
+
+static int process_request(void)
+{
+	int state = PROCESS_REQUEST_KEYS;
+	struct packet_reader reader;
+	struct argv_array keys = ARGV_ARRAY_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct protocol_capability *command = NULL;
+
+	packet_reader_init(&reader, 0, NULL, 0);
+
+	while (state != PROCESS_REQUEST_DONE) {
+		switch (packet_reader_read(&reader)) {
+		case PACKET_READ_ERROR:
+			BUG("invalid state");
+		case PACKET_READ_NORMAL:
+			break;
+		case PACKET_READ_FLUSH:
+			state = PROCESS_REQUEST_DONE;
+			continue;
+		case PACKET_READ_DELIM:
+			if (state != PROCESS_REQUEST_KEYS)
+				die("protocol error");
+			state = PROCESS_REQUEST_ARGS;
+			/*
+			 * maybe include a check to make sure that a
+			 * command/capabilities were given.
+			 */
+			continue;
+		}
+
+		switch (state) {
+		case PROCESS_REQUEST_KEYS:
+			/* collect request; a sequence of keys and values */
+			if (is_command(reader.line, &command) ||
+			    is_valid_capability(reader.line))
+				argv_array_push(&keys, reader.line);
+			break;
+		case PROCESS_REQUEST_ARGS:
+			/* collect arguments for the requested command */
+			argv_array_push(&args, reader.line);
+			break;
+		case PROCESS_REQUEST_DONE:
+			continue;
+		default:
+			BUG("invalid state");
+		}
+	}
+
+	/*
+	 * If no command and no keys were given then the client wanted to
+	 * terminate the connection.
+	 */
+	if (!keys.argc && !args.argc)
+		return 1;
+
+	if (!command)
+		die("no command requested");
+
+	command->command(the_repository, &keys, &args);
+
+	argv_array_clear(&keys);
+	argv_array_clear(&args);
+	return 0;
+}
+
+/* Main serve loop for protocol version 2 */
+void serve(void)
+{
+	/* serve by default supports v2 */
+	packet_write_fmt(1, "version 2\n");
+
+	advertise_capabilities();
+
+	for (;;)
+		if (process_request())
+			break;
+}
diff --git a/serve.h b/serve.h
new file mode 100644
index 000000000..1ed9685ca
--- /dev/null
+++ b/serve.h
@@ -0,0 +1,6 @@
+#ifndef SERVE_H
+#define SERVE_H
+
+extern void serve(void);
+
+#endif /* SERVE_H */
-- 
2.15.1.424.g9478a66081-goog

