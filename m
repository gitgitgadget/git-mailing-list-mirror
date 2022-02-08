Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E347C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 23:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBHX4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiBHX4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 18:56:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F0C061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 15:56:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b64-20020a256743000000b0061e169a5f19so684616ybc.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 15:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=SdoVnuDUoPD/sF8ZY8Y80jWsyFOaDXNRCe6ZWzqmG8I=;
        b=DwwISU946/yLaU3MciaxWAoJ3oxKLOdNvfRDMVjoFBAz6HdJifBqQVKWtv9eZZ7ab9
         YMeDfkmoceekGCm63uDlvY2DJlN2gOYltYGpbpR14dc0t0KGV0Izp431NT1/rgXGlW4M
         l22OJJJh56nIUbEauRFswcW+MuqNRYCIT9FUkuB6rGov7m8sV2+v6Zq+Z2zBinVPLa8J
         dcNDD14cGHxtZ3f6khm+duBdg+luFd5U6uwZKWFW1QZmQdAtv6hPdBMeInGiBRNo3h5I
         ZJy4e6XYS804OTTMw7zEdpvhNMRtdsCvfqxc4eJ/gUlI1zSSIiI4tgiQ18l5C2R2p2M7
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=SdoVnuDUoPD/sF8ZY8Y80jWsyFOaDXNRCe6ZWzqmG8I=;
        b=cbrTS1LE3X/L0tN/bhIjE7kz/U7USC3iZZQ5B2/Lo8mETpGGa3pZNHEhop2uq3b6Mr
         WjU+/KaNZ7UBC3KZX03nV0GDIs17CBtPQKCG1kPWbl64aKr4o6fqRBCvUcl2YGlwWUuI
         mHMhGi/6jcvypdLVAgDmlkSLD9e0CAuca3OdozVzUMfd7ehqZvLZfPOH6JVg5obKLZDr
         LYO6c1bMfcdxf4juLYQeEQ8bSDSjz+fulcOxmqakxfd7cql3yQ9CeMmtA+G6/J+7MMgh
         ORpeNJneypqS5n2IUIf2y8OMbrZcpNw7YPGPZ1G2xLyncCGIbzM5hqH53ZZgfAW13Exr
         V76Q==
X-Gm-Message-State: AOAM531Vn7GsbVW56k+zP3JWLf1SlcgpkQBKyTqeSzkwkaucmWPb9Jpd
        qr6Pt5NJ2KNI5zWOiqqZGeThvptUYIFMzi+QMFyc7cyJU2pfwU9yfjFp+NqtfOfOVkVz9pHyqX9
        0PdvqLKP4Kw3SpOt2hu3qcE7ErYLBKgYMDG3sqxXDHBM7bgUsfOFjInl3Rk3HNAKljg==
X-Google-Smtp-Source: ABdhPJxulRWQbyYb117bKVKAaznqXZQmf42RFSdDqO5E8ey6LhrsCBWYUHhjDl0s9alruh4oqe0p4Nw8ozCE4SM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:8d86:: with SMTP id
 o6mr6795663ybl.652.1644364595319; Tue, 08 Feb 2022 15:56:35 -0800 (PST)
Date:   Tue,  8 Feb 2022 23:56:30 +0000
In-Reply-To: <20220208231911.725273-1-calvinwan@google.com>
Message-Id: <20220208235631.732466-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220208231911.725273-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [PATCH v2] =?UTF-8?q?fetch=20=E2=80=94object-info-format:=20clien?= =?UTF-8?q?t=20option=20for=20object-info?=
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add =E2=80=98=E2=80=94object-info-format=E2=80=99 option to fetch. This opt=
ion allows
the client to make an object-info [1] command request to a server
that supports protocol v2.

The transport implementation uses vtables [2], similar to how Git
fetches refs, to determine whether a process needs to be taken over
before sending the object-info request. Different protocols
require different setups for making requests.

[1] https://lore.kernel.org/git/20210420233830.2181153-1-bga@google.com/
[2] https://lore.kernel.org/git/26f276956001a120cc9105b0071762c2fd4a45c5.15=
=3D
13287544.git.jonathantanmy@google.com/

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>

---
Please ignore the patch above. It was sent with a stale patch message.
 builtin/fetch.c              | 26 ++++++++++++
 fetch-pack.c                 | 53 +++++++++++++++++++++++
 fetch-pack.h                 |  7 ++++
 t/t5583-fetch-object-info.sh | 81 ++++++++++++++++++++++++++++++++++++
 transport-helper.c           | 12 ++++++
 transport-internal.h         |  1 +
 transport.c                  | 59 ++++++++++++++++++++++++++
 transport.h                  |  1 +
 8 files changed, 240 insertions(+)
 create mode 100755 t/t5583-fetch-object-info.sh

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..b48d9e93d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,9 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "protocol.h"
+#include "pkt-line.h"
+#include "connect.h"
=20
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
=20
@@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] <group>"),
 	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
 	N_("git fetch --all [<options>]"),
+	N_("git fetch --object-info-format=3D[<arguments>] <remote> [<object-ids>=
]"),
 	NULL
 };
=20
@@ -85,6 +89,7 @@ static struct string_list negotiation_tip =3D STRING_LIST=
_INIT_NODUP;
 static int fetch_write_commit_graph =3D -1;
 static int stdin_refspecs =3D 0;
 static int negotiate_only;
+static struct string_list object_info_format =3D STRING_LIST_INIT_NODUP;
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -220,6 +225,8 @@ static struct option builtin_fetch_options[] =3D {
 		 N_("write the commit-graph after fetching")),
 	OPT_BOOL(0, "stdin", &stdin_refspecs,
 		 N_("accept refspecs from stdin")),
+	OPT_STRING_LIST(0, "object-info-format", &object_info_format, N_("option"=
),
+		 N_("command request arguments")),
 	OPT_END()
 };
=20
@@ -2000,6 +2007,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	struct remote *remote =3D NULL;
 	int result =3D 0;
 	int prune_tags_ok =3D 1;
+	struct oid_array oids =3D OID_ARRAY_INIT;
+	struct object_id oid;
=20
 	packet_trace_identity("fetch");
=20
@@ -2057,6 +2066,23 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 	if (dry_run)
 		write_fetch_head =3D 0;
=20
+	if (object_info_format.nr > 0) {
+		if (argc =3D=3D 0 || argc =3D=3D 1) {
+			die(_("must supply remote and object ids when using --object-info-forma=
t"));
+		} else {
+			remote =3D remote_get(argv[0]);
+			for (i =3D 1; i < argc; i++) {
+				if (get_oid(argv[i], &oid))
+					return error(_("malformed object name '%s'"), argv[i]);
+				oid_array_append(&oids, &oid);
+			}
+		}
+		gtransport =3D prepare_transport(remote, 0);
+		gtransport->server_options =3D &object_info_format;
+		result =3D transport_fetch_object_info(gtransport, &oids);
+		return result;
+	}
+
 	if (all) {
 		if (argc =3D=3D 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2..d1c5254aa8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1265,6 +1265,59 @@ static void write_fetch_command_and_capabilities(str=
uct strbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
=20
+static void write_object_info_command_and_capabilities(struct strbuf *req_=
buf,
+						 const struct string_list *server_options)
+{
+	const char *hash_name;
+
+	if (server_supports_v2("object-info", 1))
+		packet_buf_write(req_buf, "command=3Dobject-info");
+	if (server_supports_v2("agent", 0))
+		packet_buf_write(req_buf, "agent=3D%s", git_user_agent_sanitized());
+	if (advertise_sid && server_supports_v2("session-id", 0))
+		packet_buf_write(req_buf, "session-id=3D%s", trace2_session_id());
+	if (server_options && server_options->nr &&
+	    server_supports_v2("server-option", 1)) {
+		int i;
+		for (i =3D 0; i < server_options->nr; i++)
+			packet_buf_write(req_buf, "server-option=3D%s",
+					 server_options->items[i].string);
+	}
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo =3D hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+			    the_hash_algo->name, hash_name);
+		packet_buf_write(req_buf, "object-format=3D%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1) {
+		die(_("the server does not support algorithm '%s'"),
+		    the_hash_algo->name);
+	}
+	packet_buf_delim(req_buf);
+}
+
+void send_object_info_request(int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf =3D STRBUF_INIT;
+	int i;
+
+	write_object_info_command_and_capabilities(&req_buf, args->server_options=
);
+
+	if (string_list_has_string(args->server_options, "size"))
+		packet_buf_write(&req_buf, "size");
+
+	for (i =3D 0; i < args->oids->nr; i++) {
+		packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->oids->oid[i]));
+	}
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_=
out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
diff --git a/fetch-pack.h b/fetch-pack.h
index 7f94a2a583..2ad5ec5c64 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -68,6 +68,11 @@ struct fetch_pack_args {
 	unsigned connectivity_checked:1;
 };
=20
+struct object_info_args {
+	const struct string_list *server_options;
+	const struct oid_array *oids;
+};
+
 /*
  * sought represents remote references that should be updated from.
  * On return, the names that were found on the remote will have been
@@ -101,4 +106,6 @@ void negotiate_using_fetch(const struct oid_array *nego=
tiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
=20
+void send_object_info_request(int fd_out, struct object_info_args *args);
+
 #endif
diff --git a/t/t5583-fetch-object-info.sh b/t/t5583-fetch-object-info.sh
new file mode 100755
index 0000000000..942426b3ca
--- /dev/null
+++ b/t/t5583-fetch-object-info.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description=3D'test git fetch object-info version 2'
+
+TEST_NO_CREATE_REPO=3D1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test fetch object-info with 'git://' transport
+
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=3Dreceive-pack
+daemon_parent=3D$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+	test_commit -C "$daemon_parent" message1 a.txt
+'
+
+test_expect_success 'fetch object-info with git:// using protocol v2' '
+	(
+		cd "$daemon_parent" &&
+		object_id=3D$(git rev-parse message1:a.txt) &&
+		length=3D$(wc -c <a.txt) &&
+
+		printf "%s %d\n" "$object_id" "$length" >expect &&
+		git -c protocol.version=3D2 fetch --object-info-format=3Dsize "$GIT_DAEM=
ON_URL/parent" "$object_id" >actual &&
+		test_cmp expect actual
+	)
+'
+stop_git_daemon
+
+# Test protocol v2 with 'http://' transport
+#
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+ =20
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack tr=
ue &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" message1 a.txt
+'
+
+test_expect_success 'fetch object-info with http:// using protocol v2' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		object_id=3D$(git rev-parse message1:a.txt) &&
+		length=3D$(wc -c <a.txt) &&
+
+		printf "%s %d\n" "$object_id" "$length" >expect &&
+		git -c protocol.version=3D2 fetch --object-info-format=3Dsize "$HTTPD_UR=
L/smart/http_parent" "$object_id" >actual &&
+		test_cmp expect actual
+	)
+'
+
+# Test fetch object-info with 'file://' transport
+#
+
+test_expect_success 'create repo to be served by file:// transport' '
+	git init server &&
+	test_commit -C server message1 a.txt &&
+	git -C server config protocol.version 2
+'
+
+test_expect_success 'fetch object-info with file:// using protocol v2' '
+	(
+		cd server &&
+		object_id=3D$(git rev-parse message1:a.txt) &&
+		length=3D$(wc -c <a.txt) &&
+
+		printf "%s %d\n" "$object_id" "$length" >expect &&
+		git fetch --object-info-format=3Dsize "file://$(pwd)" "$object_id" >actu=
al &&
+		test_cmp expect actual
+	)
+'
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986..9ecda03dde 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -671,6 +671,17 @@ static int connect_helper(struct transport *transport,=
 const char *name,
 static struct ref *get_refs_list_using_list(struct transport *transport,
 					    int for_push);
=20
+static int fetch_object_info(struct transport *transport, struct oid_array=
 *oids)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->fetch_object_info(transport, oids);
+	}
+	return -1;
+}
+
 static int fetch_refs(struct transport *transport,
 		      int nr_heads, struct ref **to_fetch)
 {
@@ -1269,6 +1280,7 @@ static struct transport_vtable vtable =3D {
 	.get_refs_list	=3D get_refs_list,
 	.fetch_refs	=3D fetch_refs,
 	.push_refs	=3D push_refs,
+	.fetch_object_info =3D fetch_object_info,
 	.connect	=3D connect_helper,
 	.disconnect	=3D release_helper
 };
diff --git a/transport-internal.h b/transport-internal.h
index c4ca0b733a..04fa015011 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -59,6 +59,7 @@ struct transport_vtable {
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
+	int (*fetch_object_info)(struct transport *transport, struct oid_array *o=
ids);
 };
=20
 #endif
diff --git a/transport.c b/transport.c
index 2a3e324154..87cd14c99f 100644
--- a/transport.c
+++ b/transport.c
@@ -445,6 +445,59 @@ static int fetch_refs_via_pack(struct transport *trans=
port,
 	return ret;
 }
=20
+static int fetch_object_info(struct transport *transport, struct oid_array=
 *oids)
+{
+	int ret =3D 0;
+	struct git_transport_data *data =3D transport->data;
+	struct object_info_args args;
+	struct packet_reader reader;
+
+	memset(&args, 0, sizeof(args));
+	args.server_options =3D transport->server_options;
+	args.oids =3D oids;
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_DIE_ON_ERR_PACKET);
+	data->version =3D discover_version(&reader);
+
+	if (data->version =3D=3D protocol_unknown_version)
+		BUG("unknown protocol version");
+	else if (data->version <=3D protocol_v1)
+		die_if_server_options(transport);
+
+	switch (data->version) {
+	case protocol_v2:
+		send_object_info_request(data->fd[1], &args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("wrong protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
+		die(_("error reading object info header"));
+	}
+	if (strcmp(reader.line, "size")) {
+		die(_("expected 'size', received '%s'"), reader.line);
+	}
+	while (packet_reader_read(&reader) =3D=3D PACKET_READ_NORMAL) {
+		printf("%s\n", reader.line);
+	}
+	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless d=
elimiter expected");
+	close(data->fd[0]);
+	if (data->fd[1] >=3D 0)
+		close(data->fd[1]);
+	if (finish_connect(data->conn))
+		ret =3D -1;
+	data->conn =3D NULL;
+
+	return ret;
+}
+
 static int push_had_errors(struct ref *ref)
 {
 	for (; ref; ref =3D ref->next) {
@@ -890,6 +943,7 @@ static struct transport_vtable taken_over_vtable =3D {
 	.get_refs_list	=3D get_refs_via_connect,
 	.fetch_refs	=3D fetch_refs_via_pack,
 	.push_refs	=3D git_transport_push,
+	.fetch_object_info =3D fetch_object_info,
 	.disconnect	=3D disconnect_git
 };
=20
@@ -1043,6 +1097,7 @@ static struct transport_vtable builtin_smart_vtable =
=3D {
 	.get_refs_list	=3D get_refs_via_connect,
 	.fetch_refs	=3D fetch_refs_via_pack,
 	.push_refs	=3D git_transport_push,
+	.fetch_object_info =3D fetch_object_info,
 	.connect	=3D connect_git,
 	.disconnect	=3D disconnect_git
 };
@@ -1420,6 +1475,10 @@ const struct ref *transport_get_remote_refs(struct t=
ransport *transport,
 	return transport->remote_refs;
 }
=20
+int transport_fetch_object_info(struct transport *transport, struct oid_ar=
ray *oids) {
+	return transport->vtable->fetch_object_info(transport, oids);
+}
+
 int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
 	int rc;
diff --git a/transport.h b/transport.h
index 3f16e50c19..1c807591de 100644
--- a/transport.h
+++ b/transport.h
@@ -278,6 +278,7 @@ const struct ref *transport_get_remote_refs(struct tran=
sport *transport,
  * This can only be called after fetching the remote refs.
  */
 const struct git_hash_algo *transport_get_hash_algo(struct transport *tran=
sport);
+int transport_fetch_object_info(struct transport *transport, struct oid_ar=
ray *oids);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
=20
 /*

base-commit: b23dac905bde28da47543484320db16312c87551
--=20
2.33.0.664.g0785eb7698

