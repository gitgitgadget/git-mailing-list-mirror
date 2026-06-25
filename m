Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7633E1717
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389635; cv=none; b=MAWxGmOl5qJnC8qpchTnGcNPfA1ShGgW99F3LWh5CbJUSL/MrR7bmFozPXctbhDduuxBbO3TLRibUHsQvUQERvuFKjyWfVemaCAD1ArYYq126aO+pMmN1397ZYix0GTrRdD0orVxCd+m7TMeXYl5P7Xwb04c8ZYekGv0Bmw2Pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389635; c=relaxed/simple;
	bh=Ea3G7pf+UfvyiziUaP1UXT8Cw7JjMzcQHCa2tief3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQxd/1+09Q9aeRWZidNHKG8ayqkgQ279dmU+bYZidWEj0WqMmdjNrMh8hJgFU+qeUGDPCR8dIHu25hj/U0sp6hk7F/9PUeeLNtseihBWi8fsQgPRFtyA1lTYX5DObhr8TP394uZLzR46JY6B0+6anjihDZoEv5gz/iB+CJ32ZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP7H1q9e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP7H1q9e"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso14416305e9.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389632; x=1782994432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukLeM+Q6kbHvi1w1BE65y2jzSuw8DMzX/HyqA4ub/pk=;
        b=JP7H1q9equ3foWLfCeHS6ZTk6bq4T/wpQILS5rt6Sg2jgWuWz2jXwiuhxUisAhPqSH
         Jrv1xTGhgAjE9H2dfs5TD8NK9vJiWduQkFj9uz0lACDv/G2vvfSdX63zhFv0liXTQn6K
         6oNSKVCDGQtlRdwgWuBC/oCbd4qNbQ7DIPWaGk4qiZxy7xhLI3n17tlrZcnd67Bc/0Ys
         Nf/yLjiJs+0G+E/brndf5R4nE4ebYEo+x2tPmxMpQooH6gedmFZoKKxt4fja8qhvi0v7
         DJ2pS/+6Qb2X9nM08HAMsezvB4jLe3pr3DfkLijSMlf2ki+oqrLQK5o/2UGFA5nt6JXL
         Hbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389632; x=1782994432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukLeM+Q6kbHvi1w1BE65y2jzSuw8DMzX/HyqA4ub/pk=;
        b=tOfK3+ZHmEnouxcwPuzgn6F0fMLbApD4FYnbFowPp+o5AEmKvDT/xBe2n1zWl8g4Qs
         u2vFAMKhrPydfTgWDePXjwqBtpBixgEuitVvhhzIzTtyjmiPMYZoWiglIrkwvFGsu/Q+
         Wdg6DFeX0xryT3JuM5BNREDG/5LwcNv1CEF40dcjBdJ5mP7Beqn5bj9MLV36AvLPBhyM
         73qdxQKz5iEkEJEtbcFNqednDqEnSR26/ndJdOaNvNOBlxSZcTFKWSHZoU0j0Yyj4ka7
         mDjzIzDAwuNSx2/h2q802ncf+wEpv0mIGZxRtxMNJ6nbWfezOs6Gq8AevIByng/WXH/h
         et2A==
X-Gm-Message-State: AOJu0YwZswuRO0QSiZVwg4aMesuUI31ZYLVHTgyJuXjJDhBEMAa/AEeQ
	kRLvupE3l6ysxo4lm/CzpZiZVMxvCyGYKQUNb9U1iu2HQCQ4nsU3ERYccqubrl/T
X-Gm-Gg: AfdE7clzXDfZOvR6JVj6H8X8O35C5a7FXZdLdqsvHCWPft3egPWdVd6J+O624/nzfI8
	UAU+C+92yycT8jIp6HfceRIUYjcH2IBB5M7szDlDnYC+SpYAY/U3fUPqAjiTtwq9vjx7ETXKhlG
	8S5u1qJlGa/esEOiDHmRQSxicufjDgTKmnCey2FXjX2diAuGZiHW7YwCLPe1AQkO42zjbWLzVwf
	w92pBm1D4ab21iv6FBNTyOBj2GC3RFx2y514YTmNxHuKjInFaVnq98aO7UN3qW0ORIZWu76/xxc
	hmsi1v0y5nQImIKZvL3ZNGrNr/0QNiwe+OfPhjPYbebxFoZdekZqCfrUlkfSJIx7gfU6TVkon/m
	ru/GPyh3WPNginMXu0rakloZmUA/8JJ+XTalISDHXCHef2GSGiE6eW47bYZiTUfvjBDjFRztXY7
	alc6GVMWidOx75Ab5Ur65YV7ZdntBCwyv/piy9vg4V//DRKoIYajtc6OVnaRTSiJQ8CcG5iW0eS
	MT5kR9+vJIIWUZRbQxgRsqGSa4NHsiQT4yR6usNZUs5w9oqBwFp2kq4PYxUAYx6iruH0BgzN0QD
	8CIO7WTxpdUGhZmgFIW1gFRodDrJmsM+Hdo1BWQM42LsAhewqic4cL3OdYxRV0/NjMWsA2GVC4E
	aM/ziWWfJ8Q==
X-Received: by 2002:a05:600d:844f:10b0:490:ae52:499c with SMTP id 5b1f17b1804b1-49266899ff0mr24323005e9.21.1782389631450;
        Thu, 25 Jun 2026 05:13:51 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:50 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v14 10/13] transport: add client support for object-info
Date: Thu, 25 Jun 2026 14:13:32 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-10-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
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
index 0000000000..9c4ae9bd11
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
+			if (strtoul_szt(object_info_values.items[1 + size_index].string,
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
index f195070788..c77599f6fb 100644
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
