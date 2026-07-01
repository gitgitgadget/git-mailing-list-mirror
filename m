Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223F3F0759
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908345; cv=none; b=GaVEy7rcbDRR4mHda5jC1g8NdIS+zEx/1NO9dmN+R/bg8BS/1GBkg3e6wfr7mSxJxM9i8Y6Baclfseor0TYB+jNk9R4KtUx7lHfLLP7Fu9eQn0mYOqzwVmP2BhsjMBReuFpAvN3d7QSR6V4uFmlaXzACUOYAdemqacmogZtCRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908345; c=relaxed/simple;
	bh=julULjK271rQ6zbLgKMs61ggszjke+5DijDqrq4RR/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4VkZfkmBEbR1sO9oR1Q9kQsWM/sqfaU6TFFu0iGF8aa5JbCyScoidpm3z4rW+7OMhuC2PGB0d45Yi1KBsenT32FDcmOCJrR6UUL+njpK6Ryei8E3+mQ55Nnq95COQFQ5KlsVncatA0Z/eTcnJL9VyP59gn+/AbSMubnsmJhhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+h9j/kw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+h9j/kw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c19bad03so4148995e9.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908342; x=1783513142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LrtcreANb0HHMR7JC5NrMJTODrF/cUr1WWeCaI9DbA=;
        b=W+h9j/kw/mulYxfHK1qJQDmMYXzs2FcoOQc//NLDf+4ML2VApYrxRY0FAzkKtZ4Zzl
         YSzwDUiXDdSNz2T4A71f/BlUs2rbap8GxbLkjZKw+DgdlRY1KGAy1eDHk71BWgSShf1K
         r2N4gXqoZQjCkaFnq1UAbp0SJNL5nO3rE643Arb8uPwW3SOR6w8SKiisGeYhK5GIVBbh
         +JR5A4rJV5Wbh653pZz5TWAUjFwn4h1/yv9SM7E06/B+hMcgns12xwgELJgzTAZXJL5B
         g9Eoq21+9STaW0Lsn3BW6ZYH87B7YqEB8pfJoqIty9NGavB3PgMOVNJ36cSlLkghrywY
         p9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908342; x=1783513142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LrtcreANb0HHMR7JC5NrMJTODrF/cUr1WWeCaI9DbA=;
        b=amIKSXO/au0cWve9DzrfhTwJtr485Ng4jakVcGu587C6qfrQNVWPZHiOMHboqjPyIt
         RJAlsDuSIfa6nwMd9BYFAmOIPx3VI3XpFTNUhuCluPHohWKkIsalF8xg4OnDoRyVp+Xg
         ncFy24ZHE0LarrEv2jcXEo4CD0lwHx+Gi1m5B8E5UMSo5ySAeMUhb7kMd208dm/Iawza
         7PsG2SxfkUTlDQ7aJknP/nWYY4EqlZSphWbQjp2aWs5FZzcT9NGJ6GAR8UCcNgjiVklA
         TSSmgnVkoMbPKUyp2M4BuRijgG4rcHiZcNU60WFC9+egmAY7O5yt6UNZDUe8VuRED+BU
         ddEw==
X-Gm-Message-State: AOJu0YwwF1BTJF0Y3rcObQIZGSjXUmXEG1Dya2SqmyTm9noLAnN0C8+j
	T3auuYAmMQOqzBFSY8BbrEIhO7r7llQFr1nrb666x6w0ws3qOWZcbHzkIkHwUSWG
X-Gm-Gg: AfdE7cmH2Pq16Xm/du6E0Odf8kla+uJ2KjBhllYw4ZD7gk7SycAeC5f4oSy6V6TkmB1
	L3R7yueKy7PSVZYKXTH8dNYDR1RnL6rrAqywdFO0h7kbkc2jHbO2qvN7NfWnjdUowq2720mMXZz
	v1IDcWFKXzMpYBVZ2zoOQCYpvZA9mFG4mbmM+0TUIEZOjxLT1NS9UxTxqzEUG92MK/XD92OtXd0
	8MzeXDa/CQlPxi49PltJN2wkaIpFixj+KTDAxJdpiAwJoySHStOD1aIVgrwyPLSpRZAcsmyUQv7
	PmR+2UNFCKTuqYue6zewly3ijDCDb9wafj94rMD3Rbv7Q+ghqk3hUkQOtG9sK+S6Gfq3bfpa/21
	zYLxAGzm6YmRSG2p/MP50A8tCuqjwv609JRqXtLeuNhhtCc4lm5XZ220lqJmwEXCOR/sWyd5PSE
	vSH8XKA9SLYbFsdXj5ZtU7XmZUowuQZ3w4Sw7ZfD1UyiRuJqQbSJRw/eH8Sae8+mfOclamItvER
	XxjQuX/Boqh3IsOMduoEDEv/uWCWia46BYxLFGhgLP4oMGCZgl3aVntMM1gkjDBct4OOw5c+gi7
	LUjgL4zr8BNsgoEiODDMK0O299yD63u01WRG4gsPVZSTTEmeEI+XAGBSLC9GQdT6eddbJxPHWh+
	puGpM/oxtMw==
X-Received: by 2002:a05:600c:8b75:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-493c2b3ce9fmr22105495e9.2.1782908342230;
        Wed, 01 Jul 2026 05:19:02 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.19.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:19:01 -0700 (PDT)
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
Subject: [PATCH GSoC v15 10/13] transport: add client support for object-info
Date: Wed,  1 Jul 2026 14:18:44 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-10-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
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

Introduce client-side support for the object-info capability.

Add its own function for object-info separate from existing fetch
infrastructure.

Currently, the client supports requesting a list of object IDs with
the `size` feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client returns an error and exit.

Note that:

1. the entire request is written into `req_buf` before being sent to the
   remote. This approach follows the pattern used in the
   `send_fetch_request()` logic within 'fetch-pack.c'. Streaming the
   request is not addressed in this patch.

2. When the server does not recognize an OID, following the v2 protocol,
   the server returns "<OID> SP", when this happens,
   `fetch_object_info()` sets the corresponding size pointer to NULL so
   that callers can detect and handle it.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Makefile             |  1 +
 fetch-object-info.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h  | 22 ++++++++++++
 fetch-pack.h         |  1 +
 meson.build          |  1 +
 transport-helper.c   | 13 +++++--
 transport-internal.h |  8 +++++
 transport.c          | 46 +++++++++++++++++++++++++
 transport.h          | 10 ++++++
 9 files changed, 195 insertions(+), 2 deletions(-)

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
index 0000000000..03cfb70338
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,95 @@
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
+/* Sends object-info command and its arguments into the request buffer. */
+static void send_object_info_request(const int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+	else
+		BUG("only size should be in object_info_options");
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
+		} else {
+			BUG("only size is supported");
+		}
+	}
+
+	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, " ", -1);
+		if (size_index >= 0) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
+				FREE_AND_NULL(object_info_data[i].sizep);
+				string_list_clear(&object_info_values, 0);
+				continue;
+			}
+
+			if (strtoumax_szt(object_info_values.items[1 + size_index].string,
+					  10, object_info_data[i].sizep))
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
diff --git a/fetch-pack.h b/fetch-pack.h
index 6d0dec7f41..0fba340a84 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info *object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
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
index f195070788..f97e6d7b29 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,8 +727,7 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -784,6 +783,15 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
+static int fetch_object_info_helper(struct transport *transport)
+{
+	get_helper(transport);
+	if (process_connect(transport, 0))
+		return transport->vtable->fetch_object_info(transport);
+
+	die(_("object-info requires protocol v2"));
+}
+
 struct push_update_ref_state {
 	struct ref *hint;
 	struct ref_push_report *report;
@@ -1330,6 +1338,7 @@ static struct transport_vtable vtable = {
 	.get_refs_list	= get_refs_list,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
+	.fetch_object_info = fetch_object_info_helper,
 	.push_refs	= push_refs,
 	.connect	= connect_helper,
 	.disconnect	= release_helper
diff --git a/transport-internal.h b/transport-internal.h
index 051f3ab0dc..60db0bedcd 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -45,6 +45,14 @@ struct transport_vtable {
 	 **/
 	int (*fetch_refs)(struct transport *transport, int refs_nr, struct ref **refs);
 
+	/*
+	 * Fetch object info (only size currently) from remote without
+	 * downloading the objects.
+	 *
+	 * Uses object-info capability of v2 protocol.
+	 */
+	int (*fetch_object_info)(struct transport *transport);
+
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
 	 * then, for any refs where peer_ref is set and
diff --git a/transport.c b/transport.c
index 0f5ec30247..602b1c5512 100644
--- a/transport.c
+++ b/transport.c
@@ -1,3 +1,4 @@
+#include "compat/posix.h"
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
@@ -9,6 +10,7 @@
 #include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "fetch-object-info.h"
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
@@ -432,6 +434,48 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
+static int fetch_object_info_via_pack(struct transport *transport)
+{
+	int ret = 0;
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	struct object_info_args args = { 0 };
+
+	args.server_options = transport->server_options;
+	args.oids = transport->smart_options->object_info_oids;
+	args.object_info_options = transport->smart_options->object_info_options;
+	string_list_sort(args.object_info_options);
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+
+	data->version = discover_version(&reader);
+	transport->hash_algo = reader.hash_algo;
+
+	ret = fetch_object_info(data->version, &args, &reader,
+				data->options.object_info_data,
+				transport->stateless_rpc, data->fd[1]);
+
+	close(data->fd[0]);
+	if (data->fd[1] >= 0)
+		close(data->fd[1]);
+	if (finish_connect(data->conn))
+		ret = -1;
+	data->conn = NULL;
+
+	return ret;
+}
+
+int transport_fetch_object_info(struct transport *transport)
+{
+	if (!transport->vtable->fetch_object_info)
+		die(_("remote does not support object-info"));
+	return transport->vtable->fetch_object_info(transport);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -1004,6 +1048,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
 };
@@ -1169,6 +1214,7 @@ static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
 	.disconnect	= disconnect_git
diff --git a/transport.h b/transport.h
index 7e5867cffa..9e85a4cd35 100644
--- a/transport.h
+++ b/transport.h
@@ -6,6 +6,7 @@
 #include "list-objects-filter-options.h"
 #include "string-list.h"
 #include "connect.h"
+#include "odb.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -55,6 +56,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info *object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {
@@ -309,6 +314,11 @@ int transport_get_remote_bundle_uri(struct transport *transport);
 const struct git_hash_algo *transport_get_hash_algo(struct transport *transport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 
+/*
+ * Fetch the object info from remote
+ */
+int transport_fetch_object_info(struct transport *transport);
+
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe
  * functions. This will necessarily leave behind some data structures which

-- 
2.54.0
