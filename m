Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2E2931C8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109163; cv=none; b=LkHvzbWZimqfnIf2+zphJHFZ+mylBUeExYVVGsjyZB4Yu4j0QD8abrScMtLU7DOjGEB767YzSxQshjdbba1FHqu5gdFCn/F9JYF0At1rysIPLxYXvQZn3dd53Z5t22W3w6J8nK95wFXGqqW3DbhlJTTXbmsv3wf9FwU5A5VKKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109163; c=relaxed/simple;
	bh=lWBL9+uwXzgpwmIaHk8Aum6MJtavV/Xy4MKMeIwKB7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHfj337ScS62TbPbecg9I6HRpBqnazgkcQG1pYU0gtZbCA3lvoZ5AXvmzL+UwJr7DIlqyQhFk+UTXe1FAn1Yf5B0oWPolAJps2I7vIWa2VItK88szKb8LmH8cEXLigVNGYJAEXAn9esfOqw7gBpeM4FJfTwaDcqqRLAdjqVXLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIAZPeeh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIAZPeeh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de008b020so993236f8f.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109160; x=1784713960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QcuorpPCv4Z5hFR1SaKAXvy+DsQ5L8UJZusEQYCdcA=;
        b=BIAZPeehFYNRTPy35UQJEBUF59fE9AIhOjbWCgJjhdJVHVYIabe9TUTd+fQ/YmJdTN
         DTot6lLWjmzrDOjbTtkAlgZiXX55pLZL7QuNQLfxKhBtGJQ92RjAKZRJqheDdmlRqm5h
         ts3CGUXLZ5hQi7gssq5+VcDboJEKzCfRWo7Zuv1W5yk087CNNcpoP1gg1izySbnY1Ito
         wGl+91uoW1f4AdJ1V0StjbhNJ7kOOwkVOtGsabz4E3EDDe01lYFW5lX7r93ZeH/i9fCs
         XFtJ9UNigt8lZ8gJ3JNCJH1UdDWJk+bxSi+oKXVjFL5R68BXKrzWJrB0+/ul3U0bmaQ9
         Z7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109160; x=1784713960;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QcuorpPCv4Z5hFR1SaKAXvy+DsQ5L8UJZusEQYCdcA=;
        b=s9bkrstV6n6b9uSTG7WpOBoornZCYqUiL77gykdmXJQcbofcmWuOyP1TB0iBD0QTHa
         hdoc2ZcBLS98oE+5lUmOz8TC6KPddDsc+HCZBVpCOxkwz1SSeOnzJU/NYqxVIeQw1b5d
         iYadj1DRCF4zocLDJMfDO8UCwqRIt74OEIx7Mo+4Zw+igcfOC642/dVxoN4M0rRCE/p3
         U1HBeUvi5UJR/gJ0VHSDoTAgpd0fcMGGoZRHK/kZOv9i92tX/ysstE5Rf2PtdKVsY+61
         3Hj9uy0FohvBkJ11CX3wg32CdHg9y4LoNUUF55L6Sqb5uUz6M0BTNJTysAxyfnJgGSa3
         EQkA==
X-Gm-Message-State: AOJu0Ywj/eAlJeXsoXo9sjH4kcDWkQeJgrwAVBZu3txr7zfsZjqg5mjV
	7Li7wYdt4V8m1h5oBnqykdo0f618df0K55Lj1Z7BI24Yr+N21OpQYmw2FsE8+KCp
X-Gm-Gg: AfdE7claOaxAF9RntdEqg8/el/hmc6wGxEJjzmIQcsmA8xENlBwttK/fXg0lkujgVGr
	BhjIR4Mr66aXyxRDlfUGtL4LhFnvCqGjtcOe0szP8bC4tpbU4Y2/3kOMvApJlvGhM4rQcmGeleQ
	+oFCTJqCN9/1cBtlsjb0bFUCtqbzQqQhQXLxDB1/rO/7juEDEefCLQyGujuUPmzKPgyQeWxQYRo
	nuh/ql/b1Jbm0URgF8ThzA4n5IpF15D7/dh/aFClvXWxt86qKjDDoqN43spWeQNY9fA3Ot5VrSc
	Pkq9MBoX83RwDWAGatYdthuR/2uN3BcuNhyNN6U6wjZoITo5BaUHZPJ7F0Mbj1ES8gc3ZpbXLA9
	QjN8ADEoS+kx4ao9jvYv5dnYKwsChhMF7eI/uwkkcpIGQkcHG10ZBJa8mDll4ZqHfMnJBBh1BRJ
	egQ+z1mbqz2k7Zo1QZ198IuyGJwNP3E7vBr4PkWh7ERjXB1ZyK+9CZp5Ijk4+kw1kwwxr169LaB
	VtLhiQygJmMNz79iJ1UrOPV64+T7+cih74CBSCLasgKmikMb3QC68sj1sDrSisjUlcP/FK7fIZB
	npsk7bfmmZ/8/6HNnAbQwSA5zu+5O6k24ih6wJN5iMn5CtG/rQBjQU5LK2ifSAn4digWrQd4c21
	3ACCENaWGpQ==
X-Received: by 2002:a05:6000:2dc9:b0:473:c2ec:7a79 with SMTP id ffacd0b85a97d-47f2dc92701mr20829879f8f.12.1784109159636;
        Wed, 15 Jul 2026 02:52:39 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:38 -0700 (PDT)
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
Subject: [PATCH GSoC v18 10/13] transport: add client support for object-info
Date: Wed, 15 Jul 2026 11:52:18 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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
the size feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client returns an error and exit.

Note that:

1. the entire request is written into req_buf before being sent to the
   remote. This approach follows the pattern used in the
   send_fetch_request() logic within 'fetch-pack.c'. Streaming the
   request is not addressed in this patch.

2. When the server does not recognize an OID, following the v2 protocol,
   the server returns "<OID> SP", when this happens,
   fetch_object_info() sets the corresponding size pointer to NULL so
   that callers can detect and handle it.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Makefile             |   1 +
 fetch-object-info.c  | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h  |  22 ++++++++++
 fetch-pack.h         |   1 +
 meson.build          |   1 +
 transport-helper.c   |  10 +++++
 transport-internal.h |   8 ++++
 transport.c          |  45 +++++++++++++++++++
 transport.h          |  10 +++++
 9 files changed, 219 insertions(+)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..cdabdb3771 100644
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
index 0000000000..5f98840c7c
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,121 @@
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
+static size_t parse_object_size(const char *s, size_t *res)
+{
+	uintmax_t uim;
+
+	if (!s[0] || s[strspn(s, "0123456789")])
+		return -1;
+	errno = 0;
+	uim = strtoumax(s, NULL, 10);
+	if (errno || uim > SIZE_MAX)
+		return -1;
+	*res = uim;
+	return 0;
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
+				object_info_data[j].sizep =
+					xcalloc(1, sizeof(*object_info_data[j].sizep));
+		} else {
+			BUG("only size is supported");
+		}
+	}
+
+	for (size_t i = 0;
+	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
+	     i < args->oids->nr;
+	     i++) {
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, " ", -1);
+
+		if (object_info_values.nr < 2)
+			die("object-info: malformed response from the server: %s",
+			    reader->line);
+
+		if (!strcmp(object_info_values.items[1].string, "")) {
+			FREE_AND_NULL(object_info_data[i].sizep);
+			string_list_clear(&object_info_values, 0);
+			continue;
+		}
+
+		if (args->object_info_options->nr + 1 != object_info_values.nr)
+			die("object-info: unexpected number of attributes: %s",
+			    reader->line);
+
+		if (size_index >= 0 &&
+		    parse_object_size(object_info_values.items[size_index + 1].string,
+				      object_info_data[i].sizep))
+			die("object-info: ref %s has invalid size %s",
+			    object_info_values.items[0].string,
+			    object_info_values.items[size_index + 1].string);
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
index ca235801cf..19fad57da9 100644
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
index f195070788..623463dcea 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -784,6 +784,15 @@ static int fetch_refs(struct transport *transport,
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
@@ -1330,6 +1339,7 @@ static struct transport_vtable vtable = {
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
index fc144f0aed..9342680531 100644
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
@@ -432,6 +433,48 @@ static int get_bundle_uri(struct transport *transport)
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
@@ -1004,6 +1047,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
 };
@@ -1169,6 +1213,7 @@ static struct transport_vtable builtin_smart_vtable = {
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
