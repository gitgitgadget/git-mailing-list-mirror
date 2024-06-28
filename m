Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B96F31D
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601546; cv=none; b=Y2UeejmKe7X+Cw/eU6hMw8Xbh6MdSnMDnuUy+mmIDmnyj86e7qeSw7ijOsblWgQmcU5+8TyAXMB+GDwEsMcpv6EkyOr0SeMC0RxCs1+TDJPUKngS+da9rqcblA2Brq/msQlrlmpkdPOEdPkrx+FRalscJZ7U5keDxMjg5QY/2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601546; c=relaxed/simple;
	bh=0EXRJqOOTw8Ad+PqEMaRowif7YgUj9RiyVTs8qglbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWFjGc8tOyZKYgsGhP028koivQzoVqg63MAoV4uQnJvZ8qcaXAT3NBC4wWgW4Lgnyyt7Cdk+ruCbvn/zeGW+zoNSgolxXutjvoIvKaUWtKqSGYs55XRjhbySAaaxyNZtrj+4FhcdE0ruFza7qLh4Y49WfwYvSDzBBgsqPGJvuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY6+Mnoo; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY6+Mnoo"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c03abfb18so57108785a.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601543; x=1720206343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z85AKYgRFs3MopR+pp6xiAO7JDy2XkLAJdsJ8h7Qh8=;
        b=lY6+Mnoo9IgJWjJMIjBWzpO9d1CJWbpENd1jjjz5Eo4adHYAXSCyRDul3yyj5RCSRt
         4VGhOVPeZzgaAYzIpjbdgdiATTcaaXqhJoFFbcrrPxJMNisjJFSa0LkOzlq3pAKC0pn/
         cDdmwW4B9M0htUzzxCMsxUzQX+ZIHaDYBn7kTGpv017EBMj51sFBf5Wen3xUDMa+v+v/
         TVmVJUzO1dlH8rHZA655YLLPemY1tNv/1pqFrbTe/xjFlqboVX9XkvSwR22HlzxJmPI0
         WJ9+io+ZlDzWFzrPF+QETWvW6OYYgfbPWvmdwedsFG/MhkBcjXLxEbbZ9oPqov0zdWZC
         oPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601543; x=1720206343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z85AKYgRFs3MopR+pp6xiAO7JDy2XkLAJdsJ8h7Qh8=;
        b=BjxaQNq0DXPRlqiJNXUNRCOGgFRkyF+kKUr+T/01vTi/RkP+HyXZUBlRErhPYGrUm3
         Qu4UdwIZDWvJWZ1VYOBnj6eFLDdHSuWvvujQe9ARkGZurzraU/8eWcRsc5hIA1lUGC+5
         cQFgxT34cnX+0XGlYBs4rcOa25ZRy5qyFPvceASGPn0XcfZEtQsG0IShLfhhDzb4uGkX
         37eu2kLCZpBAszcYkDgyr4oQoORVDo/un9buzBEs14lwZ9YaiAjTstmOi++xLiI3DbDH
         BUfQ1oP+ZYoiv8k2PgQ4WWwdwIyJ58e8kAZNcmA+bfLBOa/tcXOdSabTkLm0pgIUmpQ7
         ALvg==
X-Gm-Message-State: AOJu0YxiDpRbKP0kVkUvtWtQ3ZNoreYvlKXBbrtyD/4eGvu3/G+Rio9j
	iBHv252mCwZBFN7xLLtLdXtzqxwqWkwkqQuLHNYoaB1CXotgMwqbmCIQtzoI
X-Google-Smtp-Source: AGHT+IFQwKWC8s5xmoBywQijyMIC/I/FHjmzf0sDCckKnbQRiQc9Owk8aSNWX1LOgliGHwsT25W6KQ==
X-Received: by 2002:a05:6214:c64:b0:6b5:ab9d:d273 with SMTP id 6a1803df08f44-6b5ab9dd357mr18772396d6.1.1719601543311;
        Fri, 28 Jun 2024 12:05:43 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:42 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 4/6] transport: add client support for object-info
Date: Fri, 28 Jun 2024 15:05:01 -0400
Message-ID: <20240628190503.67389-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
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
as “a2ba162cda (object-info: support for retrieving object info,
2021-04-20)”.

Add client functions to communicate with the server.

The client currently supports requesting a list of object ids with
features 'size' and 'type' from a v2 server. If a server does not
advertise either of the requested features, then the client falls back
to making the request through 'fetch'.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c       |  24 +++++++++++
 fetch-pack.h       |  10 +++++
 transport-helper.c |   8 +++-
 transport.c        | 102 ++++++++++++++++++++++++++++++++++++++++++---
 transport.h        |  11 +++++
 5 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index da0de9c537..d533cac1d8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1345,6 +1345,27 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
 
+void send_object_info_request(int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
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
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1682,6 +1703,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d26517..16e4dc0824 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info **object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -42,6 +43,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
@@ -68,6 +70,12 @@ struct fetch_pack_args {
 	unsigned connectivity_checked:1;
 };
 
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
 /*
  * sought represents remote references that should be updated from.
  * On return, the names that were found on the remote will have been
@@ -101,4 +109,6 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+void send_object_info_request(int fd_out, struct object_info_args *args);
+
 #endif
diff --git a/transport-helper.c b/transport-helper.c
index 9820947ab2..670d1e7068 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -697,13 +697,17 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file remote-object-info
+	 * require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
 		return -1;
 	}
+	if (transport->smart_options->object_info) {
+		// fail the command explicitly to avoid further commands input
+		die(_("remote-object-info requires protocol v2"));
+	}
 
 	if (!data->get_refs_list_called)
 		get_refs_list_using_list(transport, 0);
diff --git a/transport.c b/transport.c
index 83ddea8fbc..2847aa3f3c 100644
--- a/transport.c
+++ b/transport.c
@@ -363,6 +363,73 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	return refs;
 }
 
+static int fetch_object_info(struct transport *transport, struct object_info **object_info_data)
+{
+	int size_index = -1;
+	struct git_transport_data *data = transport->data;
+	struct object_info_args args;
+	struct packet_reader reader;
+
+	memset(&args, 0, sizeof(args));
+	args.server_options = transport->server_options;
+	args.object_info_options = transport->smart_options->object_info_options;
+	args.oids = transport->smart_options->object_info_oids;
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_GENTLE_ON_EOF |
+			PACKET_READ_DIE_ON_ERR_PACKET);
+	data->version = discover_version(&reader);
+
+	transport->hash_algo = reader.hash_algo;
+
+	switch (data->version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info"))
+			return -1;
+		if (unsorted_string_list_has_string(args.object_info_options, "size")
+				&& !server_supports_feature("object-info", "size", 0)) {
+			return -1;
+		}
+		send_object_info_request(data->fd[1], &args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("wrong protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	for (size_t i = 0; i < args.object_info_options->nr; i++) {
+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
+			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
+			return -1;
+		}
+		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
+			if (!strcmp(reader.line, "size"))
+				size_index = i;
+			continue;
+		}
+		return -1;
+	}
+
+	for (size_t i = 0; packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr; i++){
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader.line, ' ', -1);
+		if (0 <= size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
+				die("object-info: not our ref %s",
+					object_info_values.items[0].string);
+			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
+		}
+	}
+	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
+
+	return 0;
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
 					struct transport_ls_refs_options *options)
 {
@@ -410,6 +477,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
+	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -436,11 +504,27 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
-
-	if (!data->finished_handshake) {
-		int i;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options && transport->smart_options->object_info) {
+		struct ref *ref = object_info_refs;
+
+		if (!fetch_object_info(transport, data->options.object_info_data))
+			goto cleanup;
+		args.object_info_data = data->options.object_info_data;
+		args.quiet = 1;
+		args.no_progress = 1;
+		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
+			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
+			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
+			temp_ref->exact_oid = 1;
+			ref->next = temp_ref;
+			ref = ref->next;
+		}
+		transport->remote_refs = object_info_refs->next;
+	} else if (!data->finished_handshake) {
 		int must_list_refs = 0;
-		for (i = 0; i < nr_heads; i++) {
+		for (int i = 0; i < nr_heads; i++) {
 			if (!to_fetch[i]->exact_oid) {
 				must_list_refs = 1;
 				break;
@@ -478,11 +562,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfiles, data->version);
 
 	data->finished_handshake = 0;
+	if (args.object_info) {
+		struct ref *ref_cpy_reader = object_info_refs->next;
+		for (int i = 0; ref_cpy_reader; i++) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
+			ref_cpy_reader = ref_cpy_reader->next;
+		}
+	}
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 	data->options.connectivity_checked = args.connectivity_checked;
 
-	if (!refs)
+	if (!refs && !args.object_info)
 		ret = -1;
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret = -1;
@@ -498,6 +589,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	free_refs(refs_tmp);
 	free_refs(refs);
 	list_objects_filter_release(&args.filter_options);
+	free_refs(object_info_refs);
 	return ret;
 }
 
diff --git a/transport.h b/transport.h
index 6393cd9823..5a3cda1860 100644
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
+	struct object_info **object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {
-- 
2.45.2

