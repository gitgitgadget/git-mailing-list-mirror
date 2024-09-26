Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E7176AC2
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314766; cv=none; b=FAuGJ5OUpiFvcomVfst38UNPu2MVTVWxMyR5iN9SOzQ7M6xaUeiIChb71pxLmNMqRKft4Cbx7iDPCz9g/Dww0207d4AoJzMboX0IeKWfTiVR9fnYwg8UJ44Jj98DJCXtYWKiRG9UbTS5MaPvLFp97FkfWnVTs75wWSftHDOL3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314766; c=relaxed/simple;
	bh=jqCJAIYH2gM8qEzSl494WvbNlBEHTeVl5/BT7n/YQqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KURTH9YGFwGPq5FWqtWi6xHSAcrmCglkNgFPajOqOVDNN0IUau30FEe2wEuJhZkIX4EbJDVWE095GoAEaztRWL4HcsywMfqneXk+EAGLz3ZPvQErOHnhCkL9gWIzBdB0jMpALzV/4gMcojehUviEhHpj7lGIrZ6oIJb7+JPB5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeBI3YV/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeBI3YV/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9ac0092d9so48590985a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314762; x=1727919562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpBThaF+V8KHlOkIfcmhn6x/OeteionodUd1DzFBnDk=;
        b=TeBI3YV/ugLR9lP+VyVaCGkXHY5K1dNJ5uV4CR/EtDLeGD3WfyT1C8oL3DBkTmTuD8
         bjZsFOaoO0i/LqsQ9aaGB6IoZ0BEbCjxWlVaIBXCsEpBo9eyly50x52prnwCCiGsNb1E
         fQp/BbNc8IG6pmlZximiDO8JY76X9wEv7yCYHSUcyPIfPPxFIDxMu5BiHHb+rj39+eJw
         JONx1VWI2t/4jRDquM4WS8IUMAFzgFBAmm7SylEW31UbJYEueZXQBEVhoFmWOaIEDKLs
         /f2bHU9m3gg6O6fbrqlrkkDBPIxKDR6rcZ0lVLzUARSZPURrAeTMNAZYZ96Noyi93u5L
         l4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314762; x=1727919562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpBThaF+V8KHlOkIfcmhn6x/OeteionodUd1DzFBnDk=;
        b=YklAA1AcqzN4hrGudk4N+I+EB3sjyBZp51t4jHNzpnrVYXGqbPx2I6WM3riBYEJEgh
         mNHpUFgCgo0prNQTCUIAFzrJrLhNn/MBL7ntw7RSqeTLJcaLBa8QUUcVjbR7dXg3m2YR
         4xpuT6GiObWNsD9RSxif81BmVPV+m2J5QnpiUNLwNS4zooDcm7itzBQzZF8sC+a/jrZo
         gx+Gas+IFP80+HXOIOPrYLY4NYO2ZIuRLJmNW/g3SwSds+1puste70YwfdGrnZ62o244
         aYKBt2KIZc+/BNSPIh6wsB0Sqy4HgVLY0EYkKF+x+4D0jdrVIB7XNOczbFYyfCsSLkT1
         7TIQ==
X-Gm-Message-State: AOJu0YwZpTsPftkqQuGjBInR4wltoLMGqCy98Js15/HHYdtarN6HGXhe
	gJMHARuoIlbd6xVSbZjM6QwuEmxr5t9HLeWoDeK67VzTlnIpaVcO6KvJUzw8
X-Google-Smtp-Source: AGHT+IFYfMb/B77lxVbVsp2Yw1MHmLxjttuLOVSUj3o6xX918Mc6NzSDVPNZjoJL1Sh+pHepJ+Rx7w==
X-Received: by 2002:a05:620a:1991:b0:7a9:c0b8:9343 with SMTP id af79cd13be357-7ace74115bdmr745119185a.31.1727314762421;
        Wed, 25 Sep 2024 18:39:22 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:21 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 4/6] transport: add client support for object-info
Date: Wed, 25 Sep 2024 21:38:54 -0400
Message-ID: <20240926013856.35527-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926013856.35527-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
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
 transport-helper.c |   8 +++-
 transport.c        | 116 +++++++++++++++++++++++++++++++++++++++++++--
 transport.h        |  11 +++++
 5 files changed, 141 insertions(+), 8 deletions(-)

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
index c688967b8c..7db74b4ad7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -709,14 +709,18 @@ static int fetch_refs(struct transport *transport,
 
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
 
+	/* fail the command explicitly to avoid further commands input. */
+	if (transport->smart_options->object_info)
+		die(_("remote-object-info requires protocol v2"));
+
 	if (!data->get_refs_list_called)
 		get_refs_list_using_list(transport, 0);
 
diff --git a/transport.c b/transport.c
index 3c4714581f..8266e347b3 100644
--- a/transport.c
+++ b/transport.c
@@ -368,6 +368,77 @@ static struct ref *handshake(struct transport *transport, int for_push,
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
@@ -415,6 +486,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
+	struct ref *object_info_refs = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -441,11 +513,36 @@ static int fetch_refs_via_pack(struct transport *transport,
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
+				ref_itr -> next = NULL;
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
@@ -483,23 +580,32 @@ static int fetch_refs_via_pack(struct transport *transport,
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
 	if (finish_connect(data->conn))
 		ret = -1;
 	data->conn = NULL;
-
 	free_refs(refs_tmp);
 	free_refs(refs);
 	list_objects_filter_release(&args.filter_options);
diff --git a/transport.h b/transport.h
index 6393cd9823..50ea2b05cf 100644
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
2.46.0

