Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DE3B2FCA
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881026; cv=none; b=UzHM+kvngWqVcT4IC5C0XhByCYj7zsN83wsGv54BNOvQH6o8LuDM+Wl4xlX3gV88V46RJUcw9+Fkzw8NgqGLZiXreYZe8s3yhv+lZnW6mHKbAfOr4PrbY3JmmUYfRsxl9r6MQoCeuDxC/KZIv4TAwGQB1br+iuNYm1kq6uVsWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881026; c=relaxed/simple;
	bh=3upcPZi+LJY0OZYRdAA4sQSQbRTKZZgN/ycBrSjFqgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC8WMWZK0Rr/mAONz86Kr9Axm6VcAiJ03LXiEv4BVoSZi/biRPAKzM+eOyIC9EdxGv/oUBO8KRWGVeZY2Bpru+Vs7nxJ2Tolns5u2yb+wlt0BzZhMJufhT354x46zca2hgmq7mf28nKj3v+mVS/e4gRS0sa584Ch/Gtsj6sxo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBCYVJZj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBCYVJZj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso31867655e9.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881023; x=1782485823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVOPNh39pxjCAa7dK/DI3XSdVsouZQmSJKQVu1eE+Lw=;
        b=UBCYVJZjDzfflecWovkApeIOJuaB1cP3CMcgiujrPeDJ6ZsXq/5G9dRdvBsHQkEFiR
         XDa72oy2zO2wPzMJPLBGC8IA62k6x1Nd75m38epWBq1QgDzUBxkuQxrUrALfe6aydgo4
         jUvmYhBZT9H0RuBW5KQMTyCb2ox2+NOZOlPVUDJaqlNr7aFRLeB/1Qc8N858NTJL6/wK
         lTvp1jvjP2UgCH4DoTdj4ZP2eB3rJqEnzz78X99dwvl4jh1JaVJvZiHwBvKXaWzk4uRm
         2UM0j7VIgM3ExloTypu26EREbTXq2J8L6ECLR8q7t8s1PqiYcRb42rxqI2jSZYXnL2+e
         EFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881023; x=1782485823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVOPNh39pxjCAa7dK/DI3XSdVsouZQmSJKQVu1eE+Lw=;
        b=ODx+fGqEe3rXWW51N5ZJn6RDmIpJvgXidkNzbE//tsNojUsFaiA06RVIo2jHtdzJzK
         ToRSp4Km2HbQ6b+okHjY0hFhSZCz/lCQF/1w2TgytjGKBS5uMxn1PBWoZgffVwFuP/fU
         ki9T1vRByoeNwJDBqGK1IxLKVD6E37H855qpQFJmabathdSIlGZUuLm8KJmPpPkk56o2
         2YkWTnNMob0cPgdvEheF/I9FxFnQvD3VqA3SqkTSNP2L+k14qE6owEdFvs6aXOZsqrQc
         kGl7sDdpvPPQMTHyGcw/z37sxHlg9hyOhfmSCGAiq8lFVr47Y94RE/7Bp85amQqi0PoZ
         iJaw==
X-Forwarded-Encrypted: i=1; AFNElJ/SiW+jAmBkhPsP7pQAlcQL85AGUSmQa/F1HboWjzGzWeHIgi5OhDZZjWLplY4QDSCMqCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAG87L0BzPuCV3iKKX1JGI8FQDMjgo9uEwVNkTODJJxZO6l1ad
	Zg4Gkn7rv0Z0nVHVFEnIhgydsa9490L7LDeY4QahmrLu3Oqw8z56UFST
X-Gm-Gg: AfdE7clLqgm+aPagmv68OcTboFNUDMJBedd4jTkkSsYCswEb/+t53IZsyTBZ57XrG3o
	z9iq7V6an+qGutPruVajdYLw3iKzFbz4FQdMfaOyclLFxLOnQosKzaOFAxBIF/y2E41jan5pSmo
	mE0SksTE+tHzf7KokVbgKDkyWnxBtiSIcQ+vCuYwA+RC0kTIvqQ5HwgWZiUUwHJlHxam74KT2u5
	+G1g4GNq4sXoPzgJmcs8Yz8i5gjNgom6p82mFEpYVz4v7dpLh7TLCCEUGpF3srQstUjxg0seJOE
	E8GrZ8vt5g3GB9D0jolByTLFW4anJ7E357+YLjV1ObND3MgOh4wSWz8askQXouEd5xGwofAyM8H
	j6/J5msu7QqCZYC84z3yYD1N8VqNOAKaxKqbAb2UBekI0EveyyWpvGYkMMsMQaDu63hD5WGPWG6
	BTkA6z/EvOspCvIwzscsW8axH1PuqUYlvtJXgFS7Ms/eFmlIwMpIN5wGwoyFz6WPDIZUed6FLco
	EGi0s7k2vbWZHxs3vtn45CoM4V60dgIeQLrtQioUfsIyEjZr5jr0rVJq/FzbSL6IotVIvnRNS2C
	mExeZnC57DAINp+07JGIuxLwQClfj7nV21PcuZdk4Thqeu2VWpoNAvip+gaMq2UTvIrGl0eTOW/
	CMlEAaMlPvtVPNg==
X-Received: by 2002:a05:600c:1d19:b0:492:38c9:b265 with SMTP id 5b1f17b1804b1-49240a448edmr51438695e9.15.1781881022778;
        Fri, 19 Jun 2026 07:57:02 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.57.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:57:01 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 09/12] transport: add client support for object-info
Date: Fri, 19 Jun 2026 16:56:38 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-9-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Sometimes, it is beneficial to retrieve information about an object
without downloading it entirely. The server-side logic for this
functionality was implemented in commit "a2ba162cda (object-info:
support for retrieving object info, 2021-04-20)." And the wire
format is documented at
https://git-scm.com/docs/protocol-v2#_object_info.

This commit introduces client functions to interact with the server.

Currently, the client supports requesting a list of object IDs with
the 'size' feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client will return an error and exit.

Notice that the entire request is written into req_buf before being
sent to the remote. This approach follows the pattern used in the
`send_fetch_request()` logic within fetch-pack.c.
Streaming the request is not addressed in this patch.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Makefile            |  1 +
 fetch-object-info.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h | 22 +++++++++++++
 fetch-pack.c        |  3 ++
 fetch-pack.h        |  2 ++
 meson.build         |  1 +
 transport-helper.c  | 11 +++++--
 transport.c         | 28 ++++++++++++++++-
 transport.h         | 11 +++++++
 9 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1cec251f43..ec4df39a6b 100644
--- a/Makefile
+++ b/Makefile
@@ -1159,6 +1159,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..ae035c9598
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,90 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "pkt-line.h"
+#include "connect.h"
+#include "oid-array.h"
+#include "odb.h"
+#include "fetch-object-info.h"
+#include "string-list.h"
+
+/* Sends git-cat-file object-info command and its arguments into the request buffer. */
+static void send_object_info_request(const int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+
+	if (args->oids)
+		for (size_t i = 0; i < args->oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
+int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      const int stateless_rpc, const int fd_out)
+{
+	int size_index = -1;
+
+	switch (version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info"))
+			die(_("object-info capability is not enabled on the server"));
+		send_object_info_request(fd_out, args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("unsupported protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	for (size_t i = 0; i < args->object_info_options->nr; i++) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			check_stateless_delimiter(stateless_rpc, reader,
+						  "stateless delimiter expected");
+			return -1;
+		}
+
+		if (!string_list_has_string(args->object_info_options, reader->line))
+			return -1;
+
+		if (!strcmp(reader->line, "size")) {
+			size_index = i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));
+		}
+	}
+
+	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, " ", -1);
+		if (0 <= size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
+				FREE_AND_NULL(object_info_data[i].sizep);
+				string_list_clear(&object_info_values, 0);
+				continue;
+			}
+			if (strtoul_ul(object_info_values.items[1 + size_index].string,
+				       10, object_info_data[i].sizep))
+				die("object-info: ref %s has invalid size %s",
+				    object_info_values.items[0].string,
+				    object_info_values.items[1 + size_index].string);
+		}
+
+		string_list_clear(&object_info_values, 0);
+	}
+	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+
+	return 0;
+}
diff --git a/fetch-object-info.h b/fetch-object-info.h
new file mode 100644
index 0000000000..d35284bd6b
--- /dev/null
+++ b/fetch-object-info.h
@@ -0,0 +1,22 @@
+#ifndef FETCH_OBJECT_INFO_H
+#define FETCH_OBJECT_INFO_H
+
+#include "pkt-line.h"
+#include "protocol.h"
+#include "odb.h"
+
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
+/*
+ * Sends git-cat-file object-info command into the request buf and read the
+ * results from packets.
+ */
+int fetch_object_info(enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      int stateless_rpc, int fd_out);
+
+#endif /* FETCH_OBJECT_INFO_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index cdebd3476f..a86c93fc52 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1742,6 +1742,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index 6d0dec7f41..5a428f11ed 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info *object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -43,6 +44,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
diff --git a/meson.build b/meson.build
index 3247697f74..145c6882eb 100644
--- a/meson.build
+++ b/meson.build
@@ -347,6 +347,7 @@ libgit_sources = [
   'exec-cmd.c',
   'fetch-negotiator.c',
   'fetch-pack.c',
+  'fetch-object-info.c',
   'fmt-merge-msg.c',
   'fsck.c',
   'fsmonitor.c',
diff --git a/transport-helper.c b/transport-helper.c
index 8a71354d50..fdb0590417 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,8 +727,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file
+	 * remote-object-info require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -744,6 +744,13 @@ static int fetch_refs(struct transport *transport,
 		free_refs(dummy);
 	}
 
+	/* fail the command explicitly to avoid further commands input. */
+	if (transport->smart_options->object_info)
+		die(_("remote-object-info requires protocol v2"));
+
+	if (!data->get_refs_list_called)
+		get_refs_list_using_list(transport, 0);
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
diff --git a/transport.c b/transport.c
index 0f5ec30247..7d3246e12b 100644
--- a/transport.c
+++ b/transport.c
@@ -9,6 +9,7 @@
 #include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "fetch-object-info.h"
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
@@ -467,8 +468,33 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
 	args.negotiation_include_tips = data->options.negotiation_include_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options->object_info
+	    && transport->smart_options->object_info_oids->nr > 0) {
+		struct packet_reader reader;
+		struct object_info_args obj_info_args = { 0 };
+
+		obj_info_args.server_options = transport->server_options;
+		obj_info_args.oids = transport->smart_options->object_info_oids;
+		obj_info_args.object_info_options = transport->smart_options->object_info_options;
+		string_list_sort(obj_info_args.object_info_options);
+
+		connect_setup(transport, 0);
+		packet_reader_init(&reader, data->fd[0], NULL, 0,
+				PACKET_READ_CHOMP_NEWLINE |
+				PACKET_READ_GENTLE_ON_EOF |
+				PACKET_READ_DIE_ON_ERR_PACKET);
+
+		data->version = discover_version(&reader);
+		transport->hash_algo = reader.hash_algo;
+
+		ret = fetch_object_info(data->version, &obj_info_args, &reader,
+					data->options.object_info_data, transport->stateless_rpc,
+					data->fd[1]);
+		goto cleanup;
 
-	if (!data->finished_handshake) {
+	} else if (!data->finished_handshake) {
 		int i;
 		int must_list_refs = 0;
 		for (i = 0; i < nr_heads; i++) {
diff --git a/transport.h b/transport.h
index 7e5867cffa..bd60b10af4 100644
--- a/transport.h
+++ b/transport.h
@@ -6,6 +6,7 @@
 #include "list-objects-filter-options.h"
 #include "string-list.h"
 #include "connect.h"
+#include "odb.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -31,6 +32,12 @@ struct git_transport_options {
 	 */
 	unsigned connectivity_checked:1;
 
+	/*
+	 * Transport will attempt to retrieve only object-info.
+	 * If object-info is not supported, the operation will error and exit.
+	 */
+	unsigned object_info : 1;
+
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -55,6 +62,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info *object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {

-- 
2.54.0
