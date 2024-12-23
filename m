Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AE1D86FF
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996361; cv=none; b=NZbTZRVsNlJFXXVIbsARqjJid+CWTb73UJWL9c/eGjBUIDW5t+Qyj0Om/wWFApzw8MvamHJ2WCOpuzX1Swb4a0Z8NHq8caGK3eYuHzONZILIaOSiJS9MSI5pjDrpKN/57QKkYwYWDbKamaUDP9wLvaVkR1up+Hu9+IeaIlu1zi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996361; c=relaxed/simple;
	bh=V0O3TlwXXxuB8jbR7uQ59jfqgrijH82uwKFFfW/OTUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCeVuIPfnng4pp6YxbMBMCcukpwLVBEjgG+PXm3asSX27oUCxVzQtyawlocTC9jNOinrivQy6AZ8HxCZVBGjuUYsFIWwM/r6ZDcC8F7QfGzY2y8gMnD1GR3LEQJK/pukyZrrlrE4tEzf35TFaNS0jLEo+17nCKLsWSWJ4Mg3+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGCpH3jo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGCpH3jo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd01781b56so53417776d6.0
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996358; x=1735601158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGRwggJzHd9q46lyNDrzh8IJklhpuIWqfiSitHBTdnE=;
        b=kGCpH3jo69Qs89r/9VOIw71Eus7BqsOfRECPRe2tLYFgymU3HRL9YK8Wo4K7DGoAII
         vPkFshkdN3foUeclMuXXFQ2nJUxA/dHSm6w2t69GJ8I2+6T6nxR5AUEACs+wuXtxSgH5
         RpFMorH7oSB5MVnFERvHFb3gNwruOroiRTQ4rOkaJW20UgSjg0H0eOrcwD2uDRQBFEXA
         UgQwJqtjhhU40QyrGK2bbFvrWZjOEs1hKh05HrJjYo/8/uuZEJC6TTgIKUFtMxKW6tlW
         2kM9UIlQxJQudH+itbvZJUbCxQTriQcuhBU9QqV7dVR4b3/VadJQF5KrJWu0MlbtOb4O
         wtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996358; x=1735601158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGRwggJzHd9q46lyNDrzh8IJklhpuIWqfiSitHBTdnE=;
        b=juNlbRp5Tt7xmDDal3R+M2hjr2PJXi4LgH3079XbsLAnYP+b9mI7G02laf9O28z03L
         SQZC1QwrMJ9MQ5HYm36zNYE6EMc/t3w3z2YceeKVHXxSDcayS72l7JG4b8PX4OHeD9E4
         5nzwk81b140lSGmcBbocvobGr9r/e7lXSA7K61493aH0jIyX4MsH52/U5Dc/3PuXGJmF
         iYZaaCHt3bIqsw/JtPJHcgido93X9fQ55fuU4Kppb4XxxmKU3c6v3eMfitMoSyAoj4iz
         4JffXAOMzRjgWVNJ64y00DXu1/uOZb6djeWbTdBhIm/4BGfS3ZMNic9uritJ7rHgXSuh
         H44Q==
X-Gm-Message-State: AOJu0Yw8nlkg33Tot7t0OENUlKVTI9E98T4uqRzgzQYK/zun4oHLvnY9
	0sFfWVtNhpm5V2DDCJUDrHqenBhaowxsirGPbuahO6P6ligxKGQUUniq2Q7P
X-Gm-Gg: ASbGncsJTG7De3qmihbITRBmRNRcaDFDTLdXKojxw5pzA6Of4oEqkqxe2MXrDlLxQQu
	kW2/WOTsKJkCZDzvABqHmQyulnilHCcL5VLemNUwJ7K7X9qTURzuBlCYElfP39wH0kHN/IzfOi/
	KP0BUeLjR1cLbgBcoM7i/9SzE+CQwoqu9i5H+TGkV/jvl7tcvvfNvP8NWl7jYd+aTEGQad98w0g
	/WFPwKPf9z8RYPU9m1M2Hi5oqmLBctYES+xhjeaG2tyQw3DXNABz/yN6/8lJ3m4eceacldNj5oo
	vg5y/Z95euUos/ucbRvqburKyUH4IM4yNyL+BsPrFe9T1TsdqWIJ8h/3UxLBgg==
X-Google-Smtp-Source: AGHT+IHH2sjg8rGyeQQpkrch8wQvmb5+6c//CXsYEFKAqUaUmsAwADi1TTHbVN9kuzrqDFbU+gS3Ig==
X-Received: by 2002:a05:6214:48c:b0:6d8:7ed4:336c with SMTP id 6a1803df08f44-6dd2332ed1bmr283210816d6.9.1734996358370;
        Mon, 23 Dec 2024 15:25:58 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:58 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 5/6] transport: add client support for object-info
Date: Mon, 23 Dec 2024 19:25:22 -0400
Message-ID: <20241223232523.76236-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Sometimes, it is beneficial to retrieve information about an object
without downloading it entirely. The server-side logic for this
functionality was implemented in commit "a2ba162cda (object-info:
support for retrieving object info, 2021-04-20)."

This commit introduces client functions to interact with the server.

Currently, the client supports requesting a list of object IDs with
the ‘size’ feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client will return an error and exit.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 Makefile            |  1 +
 fetch-object-info.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h | 18 +++++++++
 fetch-pack.c        |  3 ++
 fetch-pack.h        |  2 +
 transport-helper.c  | 11 +++++-
 transport.c         | 28 +++++++++++++-
 transport.h         | 11 ++++++
 8 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h

diff --git a/Makefile b/Makefile
index 3fa4bf0d06..70e9ec0464 100644
--- a/Makefile
+++ b/Makefile
@@ -1020,6 +1020,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..2aa9f2b70d
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,92 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "pkt-line.h"
+#include "connect.h"
+#include "oid-array.h"
+#include "object-store-ll.h"
+#include "fetch-object-info.h"
+#include "string-list.h"
+
+/**
+ * send_object_info_request sends git-cat-file object-info command and its
+ * arguments into the request buffer.
+ */
+static void send_object_info_request(const int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+
+	if (args->oids) {
+		for (size_t i = 0; i < args->oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+	}
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
+/**
+ * fetch_object_info sends git-cat-file object-info command into the request buf
+ * and read the results from packets.
+ */
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
+		die(_("wrong protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	for (size_t i = 0; i < args->object_info_options->nr; i++) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+			return -1;
+		}
+		if (unsorted_string_list_has_string(args->object_info_options, reader->line)) {
+			if (!strcmp(reader->line, "size")) {
+				size_index = i;
+				for (size_t j = 0; j < args->oids->nr; j++)
+					object_info_data[j].sizep = xcalloc(1, sizeof(long));
+			}
+			continue;
+		}
+		return -1;
+	}
+
+	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++){
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, ' ', -1);
+		if (0 <= size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
+				die("object-info: not our ref %s",
+					object_info_values.items[0].string);
+
+			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
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
index 0000000000..ce1a05dc96
--- /dev/null
+++ b/fetch-object-info.h
@@ -0,0 +1,18 @@
+#ifndef FETCH_OBJECT_INFO_H
+#define FETCH_OBJECT_INFO_H
+
+#include "pkt-line.h"
+#include "protocol.h"
+#include "object-store-ll.h"
+
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
+int fetch_object_info(enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      int stateless_rpc, int fd_out);
+
+#endif /* FETCH_OBJECT_INFO_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index 51de82e414..704bc21b47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1654,6 +1654,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index 9d3470366f..119d3369f1 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info *object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -42,6 +43,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
diff --git a/transport-helper.c b/transport-helper.c
index d457b42550..9da1547b2c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -710,8 +710,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file
+	 * remote-object-info require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -727,6 +727,13 @@ static int fetch_refs(struct transport *transport,
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
index 10d820c333..5a2629de52 100644
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
@@ -464,8 +465,33 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options
+		&& transport->smart_options->object_info
+		&& transport->smart_options->object_info_oids->nr > 0) {
+		struct packet_reader reader;
+		struct object_info_args obj_info_args = { 0 };
+
+		obj_info_args.server_options = transport->server_options;
+		obj_info_args.object_info_options = transport->smart_options->object_info_options;
+		obj_info_args.oids = transport->smart_options->object_info_oids;
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
index 44100fa9b7..e61e931863 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "object-store.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -30,6 +31,12 @@ struct git_transport_options {
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
@@ -53,6 +60,10 @@ struct git_transport_options {
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
2.47.0

