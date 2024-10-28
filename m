Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F21EE015
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147724; cv=none; b=apAF5YmSPVrWdNd1FrYPkxuUii7WRWvoczamnfspLU47w2ev2yAqJs7v69gAsmAjXEa9jrQQ0T3hWUIsbxZd8QGzA3WUNhQln8mrQaUejrA34385c0XTnN70AHdSXvuGl1fxSuFh3FkiQCVnaGP7hVOJ1dNrARlunj+KqO9shcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147724; c=relaxed/simple;
	bh=FjiwOm43HDgJp+aZZCdq2tmPOutPb4IS1QreCIXYJu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R10GnvFnjuKgGnciAA74e7+1Tvte++pw6Oq1rQuRR84xHn7FKxX4KexDm1UrNwVrqsiUU5KrbfMX4jj3pFZ6pBHeIq5pl0Govj6WZr1Ht8zhxQPghNutKkGpWIY/TZJf5nX8xc+UwCj2ply/s41IFRbgcjFRK8qjwxzM6zQcG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7jFoDBm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7jFoDBm"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4779404276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147721; x=1730752521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLTESXYO5Q2VPO2t1ZblnTkpPaTGYqk0UFlBrBdMu3I=;
        b=j7jFoDBmGPR5KLzJhqjLmvjNexuVSeOiv0iajY0/NkUrE7qb2Akqmda50CjzALNKk+
         hwfGOsMDp+6LzNkgV6Bj0RKr/YQplM7n64IsJPA7gq5oABO/f/mNlKFIz9NSu5pgViVK
         IaUZNNIKTfUw8rpbBNxsw7OB8A4Ss9cxiNMnkAVlzUXW0PzPUedLb5rgyCHFUHWw84PB
         J7dXrWU8faSIVkngif6y2DVlhSnU3bynNXuKwu39KI5WDuo35uaJ5MlzVWIIW0T6qWEC
         96wAM+5/A9FvFU8SbvM/1H+w83f/C3fmPBvp3otj1GL1jsY03loC/kV5H3/uZBjnaOS0
         xpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147721; x=1730752521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLTESXYO5Q2VPO2t1ZblnTkpPaTGYqk0UFlBrBdMu3I=;
        b=ZQJ9W9dKu/8zxO62MSQs0LZDs/4tyN+44o7ez4cIIf+7gKrIk+/8ckD6H+ga/DV+Tg
         y38td4eqGB3E9m2cVpFmPk1kcCmbBihVaTLmOFQav0psadvnMRTUwV3yBsKpTdpo2rs8
         9VigvkKRhGgTZcuBF59giasR54SwzLAe+a22/SILX+QWfRGm9oBU9JLjSIDTpX8rzYeM
         ZenI5I3rbdq1mkr4UFUYlKStaA+X+i/9YWDTlJyxkDRnhLVNtdgGD2ZDCDFVGFVCdU+n
         CfxhQ+rDJ23x+g6I5ZEwrqTIr1gR1XeOT5cf6GB42mnLGMQ1Z4CSxuUljkqjGO34+oMe
         Y/zw==
X-Gm-Message-State: AOJu0YwA+jiu9MqxbpRcJFNve4ZDUJ7HNDgYUvXonYxX6OqZ6aZVuORq
	43Lwo2F0comtCjw+xEdxsOjz6nDcpHyT0RhZXIPU7nAZguRlKnibsiBqaIQ5
X-Google-Smtp-Source: AGHT+IHCwTNEyqDwQTQEiQB66z7oJpsTjFomIZ5U6Bdi54bKNKIMsa4W6x8ZvYZZDY7qH10nDnTjzQ==
X-Received: by 2002:a05:6902:2b84:b0:e2b:ce99:909b with SMTP id 3f1490d57ef6-e3087c36061mr6647746276.57.1730147720615;
        Mon, 28 Oct 2024 13:35:20 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:20 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 4/6] transport: add client support for object-info
Date: Mon, 28 Oct 2024 16:34:55 -0400
Message-ID: <20241028203457.19715-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028203457.19715-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Sometimes it is useful to get information about an object without having
to download it completely. The server logic has already been implemented
in “a2ba162cda (object-info: support for retrieving object info,
2021-04-20)”.

Add client functions to communicate with the server.

The client currently supports requesting a list of object ids with
feature 'size' from a v2 server. If a server does not
advertise the feature, then the client falls back
to making the request through 'fetch'.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 Makefile            |  1 +
 fetch-object-info.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h | 18 +++++++++
 fetch-pack.c        |  3 ++
 fetch-pack.h        |  2 +
 transport-helper.c  | 11 +++++-
 transport.c         | 80 ++++++++++++++++++++++++++++++++++++--
 transport.h         | 11 ++++++
 8 files changed, 216 insertions(+), 5 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h

diff --git a/Makefile b/Makefile
index 8d8cc6ab90..3969ddcaa8 100644
--- a/Makefile
+++ b/Makefile
@@ -1024,6 +1024,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..4d7c2d265f
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,95 @@
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
+					  struct packet_reader *reader, struct object_info *object_info_data,
+					  const int stateless_rpc, const int fd_out)
+{
+	int size_index = -1;
+
+	switch (version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info"))
+			return -1;
+		if (unsorted_string_list_has_string(args->object_info_options, "size")
+				&& !server_supports_feature("object-info", "size", 0))
+			return -1;
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
index 0000000000..b1e545532f
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
+					  struct packet_reader *reader, struct object_info *object_info_data,
+					  int stateless_rpc, int fd_out);
+
+#endif /* FETCH_OBJECT_INFO_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index afffbcaafc..8b4143d752 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1651,6 +1651,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index b5c579cdae..cf7cedf161 100644
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
index 013ec79dc9..334b35174e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -709,8 +709,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file
+	 * remote-object-info require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -726,6 +726,13 @@ static int fetch_refs(struct transport *transport,
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
index 47fda6a773..41e157d73d 100644
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
@@ -418,6 +419,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
+	struct ref *object_info_refs = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -444,11 +446,71 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options
+		&& transport->smart_options->object_info
+		&& transport->smart_options->object_info_oids->nr > 0) {
+		struct ref *ref_itr = object_info_refs = alloc_ref("");
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
+		if (!fetch_object_info(data->version, &obj_info_args, &reader,
+			data->options.object_info_data, transport->stateless_rpc,
+			data->fd[1])) {
+			/*
+			 * If the code reaches here, fetch_object_info is successful and
+			 * remote object info are retrieved from packets (i.e. without
+			 * downloading the objects).
+			 */
+			goto cleanup;
+		}
 
-	if (!data->finished_handshake) {
-		int i;
+		/*
+		 * If the code reaches here, it means we can't retrieve object info from
+		 * packets, and we will fallback to downland the pack files.
+		 * We set quiet and no_progress to be true, so that the internal call to
+		 * fetch-pack is less verbose.
+		 */
+		args.object_info_data = data->options.object_info_data;
+		args.quiet = 1;
+		args.no_progress = 1;
+
+		/*
+		 * Allocate memory for object info data according to oids.
+		 * The actual results will be retrieved later from the downloaded
+		 * pack files.
+		 */
+		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
+			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
+			ref_itr->exact_oid = 1;
+			if (i == transport->smart_options->object_info_oids->nr - 1)
+				/* last element, no need to allocate to next */
+				ref_itr->next = NULL;
+			else
+				ref_itr->next = alloc_ref("");
+
+			ref_itr = ref_itr->next;
+		}
+
+		transport->remote_refs = object_info_refs;
+
+	} else if (!data->finished_handshake) {
 		int must_list_refs = 0;
-		for (i = 0; i < nr_heads; i++) {
+		for (int i = 0; i < nr_heads; i++) {
 			if (!to_fetch[i]->exact_oid) {
 				must_list_refs = 1;
 				break;
@@ -494,6 +556,17 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfiles, data->version);
 
 	data->finished_handshake = 0;
+
+	/* Retrieve object info data from the downloaded pack files */
+	if (args.object_info) {
+		struct ref *ref_cpy_reader = object_info_refs;
+		for (int i = 0; ref_cpy_reader; i++) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid,
+				&args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
+			ref_cpy_reader = ref_cpy_reader->next;
+		}
+	}
+
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 	data->options.connectivity_checked = args.connectivity_checked;
@@ -504,6 +577,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		ret = -1;
 
 cleanup:
+	free_refs(object_info_refs);
 	close(data->fd[0]);
 	if (data->fd[1] >= 0)
 		close(data->fd[1]);
diff --git a/transport.h b/transport.h
index 44100fa9b7..42b8ee1251 100644
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
+	 * Transport will attempt to pull only object-info. Fallbacks
+	 * to pulling entire object if object-info is not supported.
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

