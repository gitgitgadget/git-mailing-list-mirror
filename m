Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3867C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15DF613E1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhDTXkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhDTXkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:40:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C69C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:40:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25eb080000b02904e6f038cad5so13555028ybs.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dGsU+zFXFX3N9Wth9ksVn/h8RSNMEWCNFqWJkuEHW4g=;
        b=CQnR1gmBwvrRg3ibTvgUnNZmUmJoXC4Hdy9YeYad5JP1iOFLbk8LS425xWMBN7gDAO
         Ecv2POCuINj4esrhoqECwB+tczJ60BMOoWwN6GIZlNSQPtvmrmxBqFzOJF03aeklcspS
         m5RamPpDJRcz1gTGm5HIHy24PrUernmafXRq82BestTqrwB5Hu0X3TFBr4mmxwdSIxa8
         g7qLkl9LG7HmDBwppA/0aXN/AZmVSq5/Hdm9HNZFpYhfSyePTO8P2WD5oXMSWEUfmdFA
         4ponfwLZZ5hAI21hi4RC5fB3q6qebMk5hjUGLf6qWb6O7SuyLPxknF/jzijLzXTi3Zok
         dugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dGsU+zFXFX3N9Wth9ksVn/h8RSNMEWCNFqWJkuEHW4g=;
        b=JwBEutZoYswoUXCuYaqoqxi/6LonhcDfjtuyMr31DgCS/YH2IolGhuoD8xtkonkbGV
         u604yvO9GGv/m3Y9apDfe1vwnV8yXAfhhNlXAN5jvz0cdDGgP7Lhv2nuh2RuPxD8pUR5
         ktBLeWC3sMIZJApmc/8/4N8gET/jRgwS9w33N54vSMF0oWn0I+ZiNDpZA8JV879qbqPT
         dq4pqyR04x+F2M64aB+BhigaXPbAs8bpznfbHcomi9UGLV7guKjeJRz0LwXrG6crZbyq
         bTB8Snw0yixzTRKQ8y3+zhHzh/DBYqR2U19vZf8tuz9APLQDfBDYylMoZBIqU5Z6uGb+
         UF8w==
X-Gm-Message-State: AOAM532OCOqtePCayDYSI1Ap06DMbNwsVDXZLwGezmQgKygarCmEuqrh
        J99/IT/wK6wxJmu26ABUU5MQxTyBgPTOiqMAotiH6otzNtk8G0rN4q4BUwmxrUZtzf13qxBewkM
        JCvF28HKWKOBvi+VA2zztjr+q0atcLtlcFEg0JInj3byh2j98fw==
X-Google-Smtp-Source: ABdhPJywNpqeCNDb2XhYjJVBjR/wy/39/Mxh6dzIiohYAwGTOV/caV8eB8hjLTUJJJ8skTWhUVG1Cb0=
X-Received: from librarian2.svl.corp.google.com ([2620:15c:2ce:200:765e:c841:8f7b:7547])
 (user=bga job=sendgmr) by 2002:a25:b009:: with SMTP id q9mr28826765ybf.506.1618962002628;
 Tue, 20 Apr 2021 16:40:02 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:38:31 -0700
Message-Id: <20210420233830.2181153-1-bga@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] object-info: support for retrieving object info
From:   Bruno Albuquerque <bga@google.com>
To:     git@vger.kernel.org
Cc:     Bruno Albuquerque <bga@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information of an object without having to
download it completely.

Add the "object-info" capability that lets the client ask for
object-related information with their full hexadecimal object names.

Only sizes are returned for now.

Signed-off-by: Bruno Albuquerque <bga@google.com>
---

This version is a small change with just style fixes.

 Documentation/technical/protocol-v2.txt |  31 +++++++
 Makefile                                |   1 +
 protocol-caps.c                         | 113 ++++++++++++++++++++++++
 protocol-caps.h                         |  10 +++
 serve.c                                 |   2 +
 t/t5701-git-serve.sh                    |  26 ++++++
 6 files changed, 183 insertions(+)
 create mode 100644 protocol-caps.c
 create mode 100644 protocol-caps.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index a7c806a73e..f4ed141774 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -514,3 +514,34 @@ packet-line, and must not contain non-printable or whitespace characters. The
 current implementation uses trace2 session IDs (see
 link:api-trace2.html[api-trace2] for details), but this may change and users of
 the session ID should not rely on this fact.
+
+object-info
+~~~~~~~~~~~
+
+`object-info` is the command to retrieve information about one or more objects.
+Its main purpose is to allow a client to make decisions based on this
+information without having to fully fetch objects. Object size is the only
+information that is currently supported.
+
+An `object-info` request takes the following arguments:
+
+	size
+	Requests size information to be returned for each listed object id.
+
+	oid <oid>
+	Indicates to the server an object which the client wants to obtain
+	information for.
+
+The response of `object-info` is a list of the the requested object ids
+and associated requested information, each separated by a single space.
+
+	output = info flush-pkt
+
+	info = PKT-LINE(attrs) LF)
+		*PKT-LINE(obj-info LF)
+
+	attrs = attr | attrs SP attrs
+
+	attr = "size"
+
+	obj-info = obj-id SP obj-size
diff --git a/Makefile b/Makefile
index 21c0bf1667..3225e37b63 100644
--- a/Makefile
+++ b/Makefile
@@ -961,6 +961,7 @@ LIB_OBJS += progress.o
 LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
+LIB_OBJS += protocol-caps.o
 LIB_OBJS += prune-packed.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
diff --git a/protocol-caps.c b/protocol-caps.c
new file mode 100644
index 0000000000..13a9e63a04
--- /dev/null
+++ b/protocol-caps.c
@@ -0,0 +1,113 @@
+#include "git-compat-util.h"
+#include "protocol-caps.h"
+#include "gettext.h"
+#include "pkt-line.h"
+#include "strvec.h"
+#include "hash.h"
+#include "object.h"
+#include "object-store.h"
+#include "string-list.h"
+#include "strbuf.h"
+
+struct requested_info {
+	unsigned size : 1;
+};
+
+/*
+ * Parses oids from the given line and collects them in the given
+ * oid_str_list. Returns 1 if parsing was successful and 0 otherwise.
+ */
+static int parse_oid(const char *line, struct string_list *oid_str_list)
+{
+	const char *arg;
+
+	if (!skip_prefix(line, "oid ", &arg))
+		return 0;
+
+	string_list_append(oid_str_list, arg);
+
+	return 1;
+}
+
+/*
+ * Validates and send requested info back to the client. Any errors detected
+ * are returned as they are detected.
+ */
+static void send_info(struct repository *r, struct packet_writer *writer,
+		      struct string_list *oid_str_list,
+		      struct requested_info *info)
+{
+	struct string_list_item *item;
+	struct strbuf send_buffer = STRBUF_INIT;
+
+	if (!oid_str_list->nr)
+		return;
+
+	if (info->size)
+		packet_writer_write(writer, "size");
+
+	for_each_string_list_item (item, oid_str_list) {
+		const char *oid_str = item->string;
+		struct object_id oid;
+		unsigned long object_size;
+
+		if (get_oid_hex(oid_str, &oid) < 0) {
+			packet_writer_error(
+				writer,
+				"object-info: protocol error, expected to get oid, not '%s'",
+				oid_str);
+			continue;
+		}
+
+		strbuf_addstr(&send_buffer, oid_str);
+
+		if (info->size) {
+			if (oid_object_info(r, &oid, &object_size) < 0) {
+				strbuf_addstr(&send_buffer, " ");
+			} else {
+				strbuf_addf(&send_buffer, " %lu", object_size);
+			}
+		}
+
+		packet_writer_write(writer, "%s",
+				    strbuf_detach(&send_buffer, NULL));
+	}
+}
+
+int cap_object_info(struct repository *r, struct strvec *keys,
+		    struct packet_reader *request)
+{
+	struct requested_info info;
+	struct packet_writer writer;
+	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
+
+	packet_writer_init(&writer, 1);
+
+	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
+		if (!strcmp("size", request->line)) {
+			info.size = 1;
+			continue;
+		}
+
+		if (parse_oid(request->line, &oid_str_list))
+			continue;
+
+		packet_writer_error(&writer,
+				    "object-info: unexpected line: '%s'",
+				    request->line);
+	}
+
+	if (request->status != PACKET_READ_FLUSH) {
+		packet_writer_error(
+			&writer, "object-info: expected flush after arguments");
+		die(_("object-info: expected flush after arguments"));
+	}
+
+	send_info(r, &writer, &oid_str_list, &info);
+
+	string_list_clear(&oid_str_list, 1);
+
+	packet_flush(1);
+
+	return 0;
+}
diff --git a/protocol-caps.h b/protocol-caps.h
new file mode 100644
index 0000000000..6351648e37
--- /dev/null
+++ b/protocol-caps.h
@@ -0,0 +1,10 @@
+#ifndef PROTOCOL_CAPS_H
+#define PROTOCOL_CAPS_H
+
+struct repository;
+struct strvec;
+struct packet_reader;
+int cap_object_info(struct repository *r, struct strvec *keys,
+		    struct packet_reader *request);
+
+#endif /* PROTOCOL_CAPS_H */
\ No newline at end of file
diff --git a/serve.c b/serve.c
index ac20c72763..aa8209f147 100644
--- a/serve.c
+++ b/serve.c
@@ -5,6 +5,7 @@
 #include "version.h"
 #include "strvec.h"
 #include "ls-refs.h"
+#include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
 
@@ -78,6 +79,7 @@ static struct protocol_capability capabilities[] = {
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
 	{ "session-id", session_id_advertise, NULL },
+	{ "object-info", always_advertise, cap_object_info },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 509f379d49..73e74a9c54 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -19,6 +19,7 @@ test_expect_success 'test capability advertisement' '
 	fetch=shallow
 	server-option
 	object-format=$(test_oid algo)
+	object-info
 	0000
 	EOF
 
@@ -240,4 +241,29 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 	grep "unexpected line: .this-is-not-a-command." err
 '
 
+# Test the basics of object-info
+#
+test_expect_success 'basics of object-info' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	oid $(git rev-parse two:two.t)
+	oid $(git rev-parse two:two.t)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	size
+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.31.1.368.gbe11c130af-goog

