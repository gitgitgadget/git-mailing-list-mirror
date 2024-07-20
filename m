Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F35D530
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447039; cv=none; b=BDvbie5fRcyRB0j0v763/lJxzm/w8O3SphZK9Abw7NS4uqQYN5WDqjwPJ/EviWBuR+jh0Foj+N+NjCSOFz6TFv4KQlxxs5oQtpP4OLKIM5dwWuv0PJKi5D7PiFOCzEVjQCTGgyNggOvHp6ERkHpttTz8REzQF/LWRX7Ox42hDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447039; c=relaxed/simple;
	bh=KlcsBUzDtx/sqVWyT/sRgryceaSyl1YaifWNObNw8ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeUSIMfTWkosz5e8HzFqy9IF614L8/zUuQ/ywEQiINCkt6S2nOf3vSAqKOPbvaDR9O8zTelF9uPljtlLDV68MVJ0X/gCTuChr6to4te5AlN6RxVjM2hcC2QQW2/FtrC2M6tJJ3OwtkiLxsXlcaJmDJJHX+IVit1/7G/RmhpRK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUDPSsoo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUDPSsoo"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9400a1ad9so1428675b6e.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447037; x=1722051837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWnaXqqHS5rotJarZ3nwzRv/FG6nNEysYZ00CFfc0Tk=;
        b=EUDPSsooIG4Zie7MSu64QaC0DudwQoQnnMhJvyw1yXDiGI6z3fop7ViZQxScGrUDzO
         NAs+SzsQlpAJPqB5/21qvYQFvj8qLpvDA60qgMWJuwYY48KsdFtPOK/tzj5oawIHASj9
         HzqS5aa+8PM3dKYs71ImIfjxYQ2IEizvjdQCoTSclxnYbFE6PrEPuxa0o3Oh1nuijApA
         xGFWi0aTE26E+nShu1N64zPAyxCdOM/zXGUUfTRpWqevEomO+Ux3wBnXX19hjdYrNUls
         G0B7Y3YbhPA4sh2XhkD3OioIupzvned0zmxMqdEuDS1mxya/cDY1s4kf3af05zc/Xjww
         /mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447037; x=1722051837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWnaXqqHS5rotJarZ3nwzRv/FG6nNEysYZ00CFfc0Tk=;
        b=h2RA4n5WKL76Ou3hhTD9QhKNTKa+Wa0SDvR/nw88pQ2/Ls8wKtCfQLfK9XPaSd8bdW
         gyW9ja0quZEoslqJiKNNn9+qzyf3MI5vx3MlSlA7zifWXfvjilSx3Ln7YE5LS+0wNzle
         tkqbhldHhm3LQVqb9Dd13HS6PBcRz0XqqPsySMpmgVZ+PSzAw7ECgU5jIaDp0MN0uiqC
         L2rFnWU+ujzjRmGIO0f9ziMVSftEH2GF8x0xiUHtTLxEo6MO0UPcwBXI3RXcmwcU1eW/
         sv4spC5585xJZr+YGK4yhkB2zy3bRA6WGYm8bkbKIAvG7Fcj1QPQrzCeFE18wDcGvtHr
         gmQg==
X-Gm-Message-State: AOJu0YwD3aO1DzP9bmR33ts4VCdwvrrS4rQQ4Z0aIUh8O5YjsZK/0aSB
	lrX7rR2YagmUed/l9UiNnI0VDGSV0uGEu8wAG6FcICxQ4TOTaL4SH3KtZ5v9RNg=
X-Google-Smtp-Source: AGHT+IFXBePLXT5qke/KHp4ULR4YKruCFQBCqiExI9z2IJcNOuWpwoQ3XNux/7TenM1pfhRhMG4ghw==
X-Received: by 2002:a05:6808:1404:b0:3d9:2e63:8330 with SMTP id 5614622812f47-3dae6078585mr1996132b6e.43.1721447036732;
        Fri, 19 Jul 2024 20:43:56 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:56 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 4/6] transport: add client support for object-info
Date: Fri, 19 Jul 2024 23:43:35 -0400
Message-ID: <20240720034337.57125-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720034337.57125-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
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
 fetch-pack.c       |  24 +++++++++
 fetch-pack.h       |  10 ++++
 transport-helper.c |   8 ++-
 transport.c        | 118 +++++++++++++++++++++++++++++++++++++++++++--
 transport.h        |  11 +++++
 5 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a605b9a499..419450c8dd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1344,6 +1344,27 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
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
@@ -1681,6 +1702,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index 09b3560ffd..841a32e80a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -699,13 +699,17 @@ static int fetch_refs(struct transport *transport,
 
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
index 12cc5b4d96..8f990fcba6 100644
--- a/transport.c
+++ b/transport.c
@@ -366,6 +366,80 @@ static struct ref *handshake(struct transport *transport, int for_push,
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
+			if (!strcmp(reader.line, "size")) {
+				size_index = i;
+				for (size_t j = 0; j < args.oids->nr; j++) {
+					object_info_data[j].sizep = xcalloc(1, sizeof(long));
+				}
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
+
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
@@ -413,6 +487,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
+	struct ref *object_info_refs = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -439,11 +514,36 @@ static int fetch_refs_via_pack(struct transport *transport,
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
+				/* last element, no need to allocat to next */
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
@@ -481,23 +581,31 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfiles, data->version);
 
 	data->finished_handshake = 0;
+	if (args.object_info) {
+		struct ref *ref_cpy_reader = object_info_refs;
+		for (int i = 0; ref_cpy_reader; i++) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
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
2.45.2

