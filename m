Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403621730C
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803286; cv=none; b=X3p3jtDQ4F2l8ZnoYifkgSyky5rY11FELxN3sOtSC94Z4GxKe42cCU7R6YqHv9DN1d9DYKfIYrWi0oKuM3tH3Or0kalHRGR3md+fe8aM8nWkapHtLWDSjYtwCDtTYKYcIvSlnY7QRlEKkYNod+jKySKkWcAT+rAGtmcXW5X7zBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803286; c=relaxed/simple;
	bh=NXPG0MHnxFZU9SAJcAC0H1aZsGw82ZpVaDZiXdO+y4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8kn0AKXEIyVQin1U9VJUAxFttw6B/QvH0gfN/j8Vv9gbu2S7FDI3r7xilvoQ6IUe+y9xNcJxnPNXutOj4TV9Utki0Ei/04tofQJJghBPdg5ZPycRg2A2QoHD6gyiqOYZ3hbzONpvUMKHtlfNDhepWGrFcT4kOUF0zFmZI3olR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2eAg/n7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2eAg/n7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so22552036d6.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803283; x=1730408083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOqaFVsH+gqg569mEx/NPvWteSo79S2rOOsWpf7ejd0=;
        b=a2eAg/n7xXuCCEPD76BjFzlLGP8zfzEk/Pk3WLF+4yyY2SD51QXC1rhovZjARdB7O2
         mAtfEEd/hnEtdCHe5T5iyJ1dPrmmqclsqrysfXtOnSb5VaFDuJmurrYmKd7XMVhYndY/
         yXXpQK36g0I8cEzWFi2cE1wD71Z1/rJercWcfU0AuV8kMSa84TlY9PBJQTPmnZlvjvu8
         o+lhTvgEH31Ef89nuaB6aVOsr7F5JBhxUC60weK6r2lMbu7+4VGOPVjyokyARnLGow+j
         9BqeoRK75MsJAk7hST53dWd7WjuiO7WzonWibJs2nx6ir/NxF59/u3j/umz6pxYraxF+
         rfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803283; x=1730408083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOqaFVsH+gqg569mEx/NPvWteSo79S2rOOsWpf7ejd0=;
        b=RXZJnw52sTSPZ3faytuHvk2TWpVymiV7adgclSqT6s+PqjrYQlSKrqOJwhItjcidrC
         fxmzTsfgUJ9H6poUhbqnuqu9f1NeTaN9ceVGBF+zoAha2nxPuK4f63EGWAYJ7AihRkXS
         L811Ie9pM+FbsAnZyuJTRdPb1qS3oKchitJkvlBiwb3wQzY13WczG8UOAR0fdX9cXmXR
         684LEO2fia33+2XGonGFOVC1UKenFTjtF+b4QFPqX8uo1dooyoZnemdrmDp1C5noYqMW
         aq9f8cyjbw5LaAF7v3WH5I3QM8oXLeJUvL3I+S+7oNQXkpi/guNi/jwb4m+3abif3G2W
         p1gg==
X-Gm-Message-State: AOJu0YzXfpGLqvVqjAGpNHNWKK57Hurd0mouIpcdMdqqOmlz+E27SRR3
	i5OAvE3YZq8fKbnyP/I9eOPCCUbRxbx7vF6AGpFT3RWnVdRXvX4kfPDCR90F
X-Google-Smtp-Source: AGHT+IEcpsV7ZfsguZIByAqpuCBNEK4ql5pddx+OGlYgjMlc15sSKv9q2cWahtZgtjk7rJuJ5/aeMw==
X-Received: by 2002:a05:6214:449c:b0:6cb:f077:f2f7 with SMTP id 6a1803df08f44-6d090405805mr46626816d6.25.1729803283053;
        Thu, 24 Oct 2024 13:54:43 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:42 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 4/6] transport: add client support for object-info
Date: Thu, 24 Oct 2024 16:53:57 -0400
Message-ID: <20241024205359.16376-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
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
 fetch-pack.c       |   4 +-
 fetch-pack.h       |  10 ++++
 transport-helper.c |  11 ++++-
 transport.c        | 115 +++++++++++++++++++++++++++++++++++++++++++--
 transport.h        |  11 +++++
 5 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 800505f25f..1a9facc1c0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1347,7 +1347,6 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
 
-
 void send_object_info_request(int fd_out, struct object_info_args *args)
 {
 	struct strbuf req_buf = STRBUF_INIT;
@@ -1706,6 +1705,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index b5c579cdae..5a5211e355 100644
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
@@ -106,4 +114,6 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
  */
 int fetch_pack_fsck_objects(void);
 
+void send_object_info_request(int fd_out, struct object_info_args *args);
+
 #endif
diff --git a/transport-helper.c b/transport-helper.c
index 013ec79dc9..2ff9675984 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -709,8 +709,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file remote-object-info
+	 * require protocol v2.
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
index 47fda6a773..64b49c083b 100644
--- a/transport.c
+++ b/transport.c
@@ -371,6 +371,77 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	return refs;
 }
 
+static int fetch_object_info(struct transport *transport, struct object_info *object_info_data)
+{
+	int size_index = -1;
+	struct git_transport_data *data = transport->data;
+	struct object_info_args args = { 0 };
+	struct packet_reader reader;
+
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
+				&& !server_supports_feature("object-info", "size", 0))
+			return -1;
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
+			if (!strcmp(reader.line, "size")) {
+				size_index = i;
+				for (size_t j = 0; j < args.oids->nr; j++)
+					object_info_data[j].sizep = xcalloc(1, sizeof(long));
+			}
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
+
+			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
+		}
+
+		string_list_clear(&object_info_values, 0);
+	}
+	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
+
+	return 0;
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
 					struct transport_ls_refs_options *options)
 {
@@ -418,6 +489,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
+	struct ref *object_info_refs = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -444,11 +516,36 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options
+		&& transport->smart_options->object_info
+		&& transport->smart_options->object_info_oids->nr > 0) {
+		struct ref *ref_itr = object_info_refs = alloc_ref("");
+
+		if (!fetch_object_info(transport, data->options.object_info_data))
+			goto cleanup;
+
+		args.object_info_data = data->options.object_info_data;
+		args.quiet = 1;
+		args.no_progress = 1;
+		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
+			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
+			ref_itr->exact_oid = 1;
+			if (i == transport->smart_options->object_info_oids->nr - 1)
+				/* last element, no need to allocate to next */
+				ref_itr->next = NULL;
+			else
+				ref_itr->next = alloc_ref("");
 
-	if (!data->finished_handshake) {
-		int i;
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
@@ -494,16 +591,26 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfiles, data->version);
 
 	data->finished_handshake = 0;
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
 
-	if (!refs)
+	if (!refs && !args.object_info)
 		ret = -1;
 	if (report_unmatched_refs(to_fetch, nr_heads))
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

