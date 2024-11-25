Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57E16631C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513005; cv=none; b=uKPrICCuvx3fQJ3cdNxdXf+f0pCgFDoOzm5kj7QaAiNltJHgTocBVGU6bbG/XB2KROF6x3gXORlU268zzdHeepRtNabUPbpTcR7FBySuWrW2sZiB/VncvbLzqYJttbzb0shPIV/r5vE0fCJxleV+vpalVdBi92KntVpVu5DkyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513005; c=relaxed/simple;
	bh=eZ2McwOcyOd6CtJbxQoVGoBVHpgQ6uIMTFL2RlmyGsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeBrMkEvFnAUyDv81UWUkly+jI4SKH8qexfuHkyt8xktvf2YcmE2wCImRwyGG0wYHm9BUVxrtIScpiHbs5h3Qm0CLKPkPjoNP+otlennQgog1Gl6sQzNziHAo5JBKtCWQUiq/OPiE1aFBYIqsVK4GrbpMEcwQhsz0s5pHQq602A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbxXtczX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbxXtczX"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b14df8f821so368073285a.2
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732513002; x=1733117802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VwQCM5xvdLIjDsUEUbfLQ2eBKm0LETQ/g06II4+0CM=;
        b=lbxXtczXyt/C+RFYKemxeKpM7q2xueXApZ8Awy1WaoVKgLx8sObTSho5yWTuzwHWdE
         SulsTudIgwifG+qy/A3iO8pt3UJKgsGhyoEOFmyG2oGii7202fh9/I3tdPrSnTsqRvns
         5JPM3d+/Xwl+FfctDV7WkVoGy2oAd5QPk6zIbxwBNd6HFseD+c0Aj//6wt+gue7PU8hl
         dMsI4ryj1Cw4EYQDTR+GlIAZv7CnyFdVRF8Uh7kku/aGI73dlOQv2GSszl5wQvTApGfD
         gIQC6usv6qFwnuLYyoEB2yMTDI4jw3cd6oKWKTrG3GYABW9BGLD9pMfVJIG0pKbTm4ny
         WyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732513002; x=1733117802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VwQCM5xvdLIjDsUEUbfLQ2eBKm0LETQ/g06II4+0CM=;
        b=GO8PXDVDB6KHer9K5SP3+97IbWBkOblmxobIRr2473qFjQuJ6FYBAx/M3qLn6yyVi+
         Mbf2ywJuk3T2IUhJMRRJENxpCx0k4VRepuBLqydopMoudJyxuySzE2FXDVOeuRG1SrTr
         Lhvo3m+fZwbuzDjBR9PndIveKJQ+Eq5l4J4SMIAwxYE3vMI3EhNIr2SRvBlzx1eWgK5z
         ZtxF9UCnBN7Ik6bwXFl/szT246OiziEKYGpE5g2hVKTaDV2B9itirBxu4UYfZrr0UFGy
         b8jbl25zY+CVLf5HKYaEZ2ADZ8M2riBsuqsNNJhtKdcUZL7wVb4HCqXUSB/wS2Gr1ygT
         JB5w==
X-Gm-Message-State: AOJu0YxjLA2ipxX9raHA/UZo9tudLmoCoXz9dkbd/3QWpxSyG+sebopv
	+2dxoslcaJbfbVUbDMQVSSIREn/e3iJVPtG/3ti5Xb9hySBVPRy2JPHWyiSe
X-Gm-Gg: ASbGncuD3MlFNcf0SpyGAaA9BItLWoCNMAbfumda5tKSy0kLEM1VqLzHhJGa9ap6ZJQ
	vxVt3qdMGppCwv2iYIIuzZHmMD3taL1d4de52TsD0gXaVOHgvE/PIuhRIjWvlYNMrzuS4cqOnG2
	2WTALSii08meAtfP3KPWOva+AdfL282AsoDh7Lz/YA+ILs2pLuQhXQkKrbP96bHNURCP4wL2OXw
	Bvu2F2VgnaPi3OT+IIzOIvvtIJssa1W981KL87ZaNdAVc0TiY8oKG5jFeZx3QRbTBPkG4wpLSuO
	Zg==
X-Google-Smtp-Source: AGHT+IF/6wEez5hm9icHBZiO0tNU7FJ/4jS7ni3LmWdd9KC2ji49NYdF0x97whaCqgRtQkzD21n45g==
X-Received: by 2002:a05:620a:4454:b0:7b6:6d4e:40c5 with SMTP id af79cd13be357-7b66d4e45b0mr201690485a.21.1732513002364;
        Sun, 24 Nov 2024 21:36:42 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:41 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 5/6] transport: add client support for object-info
Date: Mon, 25 Nov 2024 00:36:15 -0500
Message-ID: <20241125053616.25170-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125053616.25170-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
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
index d06c9a8ffa..beca828963 100644
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
index eb4aface36..6e5d7df2dc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1653,6 +1653,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index bc27653cde..bf0a1877c7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -711,8 +711,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file
+	 * remote-object-info require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -728,6 +728,13 @@ static int fetch_refs(struct transport *transport,
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
index 47fda6a773..746ec19ddc 100644
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
@@ -444,8 +445,33 @@ static int fetch_refs_via_pack(struct transport *transport,
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

