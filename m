Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AAEC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 23:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiBHXTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiBHXTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 18:19:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D24C061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 15:19:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so1163015ybb.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=9rp+P//Fr6YUNDccR62GLVT8NObfpQpr/yZXKl9oijs=;
        b=f871jTb10YTgjI0l3ekbqi7aR25n0ORDNLiOi30Y7cm/IGUvKF6znQT8wUNM/MoE2w
         g7ZDqSXzfnGhioBat38BcXBmXyQRWRr+/QIjg/ECcuxJZsNCxmKDqZTov0NYWnUZ0C35
         aFKmwPrtENZ0fDWm/L2kBXmlrVIe52PjpeM/XqLIRaTYHDVeT3LpdzdJ+ChXDYBE2//A
         cUkYFdt9O7/pJMPbUE0QBQbSiIpakk/aFOPMboQosTzUMTlP5AABKahIUml1ZvUv6Idi
         UJyoV2v6vwrHznHm1fsFuxIVNEsFP47RjQEF87BPqXN0UzAqDUsu60ddr4ZBwjATHOs2
         pQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=9rp+P//Fr6YUNDccR62GLVT8NObfpQpr/yZXKl9oijs=;
        b=r8MwmpARbL8j6RFeeIFVe65HScLOB+CT82lzG+ZB5g1JesiCwjCuu5vo3hRYUxjIOK
         8arV3R/YP1MTTPTtaTY0BgFyXUT2cV7tAFJEHwa6j2uw5nigOcPoNSAwkyzmpGJKhwx8
         wWji4JI6b8G7s8EeN1IVPeqKZ/YYqmXJJ/d32e9FOL2NuS0LoHBb0EsHKxh0dM45Ki+Q
         zJrCTqNJpF2yoISnC9CW1OmK8agyKp5VDgnyOnu5GPHg56NQPQvcH/aGisMM8yuV9t0m
         ngv95OXHYFMZByqeEj0WTOQCY/YguhostCPLkxY/IY7RhIWzD8GdixhujcmXcaJbVVo5
         ysbg==
X-Gm-Message-State: AOAM530K2MbhlcZbg+rnlgSEExKapCpvyteoOobs8pRsoVgJlmWT4OS6
        nRnqnl0S9Rt3EqAl+9URSSglRwopxNf/PPVQsxlxxknhZ93/y6XzOKXnJ/dBscuHVnLEWZKl0U1
        8mUV17ByETrzd/HYfJhqn89KIONFURMidlnzD+f5Z/qhFFbzKadbDzz4LUSy4gl86Iw==
X-Google-Smtp-Source: ABdhPJxDript2DTfAh7cDM9CCkBeUEn1DMOI6DoUURTnmcK5Ei0aOBQilCK1i6w0s8HCuJd1WOx60km23SbmyWs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:6089:: with SMTP id
 u131mr6821971ybb.67.1644362361552; Tue, 08 Feb 2022 15:19:21 -0800 (PST)
Date:   Tue,  8 Feb 2022 23:19:10 +0000
Message-Id: <20220208231911.725273-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: =?UTF-8?Q?=5BPATCH=5D_fetch_=E2=80=94object=2Dinfo=2Dformat=3A_client_option_f?=
        =?UTF-8?Q?or_object=2Dinfo?=
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
13287544.git.jonathantanmy@google.com/

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>

---
 builtin/fetch.c              | 80 ++++++++++++++++++++----------
 fetch-pack.c                 | 53 ++++++++++++++++++++
 fetch-pack.h                 |  7 +++
 t/t5583-fetch-object-info.sh | 95 ++++++++++++++++++++++++++++++++++++
 transport-helper.c           | 12 +++++
 transport-internal.h         |  1 +
 transport.c                  | 63 ++++++++++++++++++++++++
 transport.h                  |  1 +
 8 files changed, 286 insertions(+), 26 deletions(-)
 create mode 100755 t/t5583-fetch-object-info.sh

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..991063072b 100644
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
@@ -2019,6 +2028,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		int *sfjc =3D submodule_fetch_jobs_config =3D=3D -1
 			    ? &submodule_fetch_jobs_config : NULL;
@@ -2057,34 +2067,52 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 	if (dry_run)
 		write_fetch_head =3D 0;
=20
-	if (all) {
-		if (argc =3D=3D 1)
-			die(_("fetch --all does not take a repository argument"));
-		else if (argc > 1)
-			die(_("fetch --all does not make sense with refspecs"));
-		(void) for_each_remote(get_one_remote_for_fetch, &list);
-	} else if (argc =3D=3D 0) {
-		/* No arguments -- use default remote */
-		remote =3D remote_get(NULL);
-	} else if (multiple) {
-		/* All arguments are assumed to be remotes or groups */
-		for (i =3D 0; i < argc; i++)
-			if (!add_remote_or_group(argv[i], &list))
-				die(_("no such remote or remote group: %s"),
-				    argv[i]);
-	} else {
-		/* Single remote or group */
-		(void) add_remote_or_group(argv[0], &list);
-		if (list.nr > 1) {
-			/* More than one remote */
-			if (argc > 1)
-				die(_("fetching a group and specifying refspecs does not make sense"))=
;
+	if (object_info_format.nr > 0) {
+		if (argc =3D=3D 0 || argc =3D=3D 1) {
+			die(_("must supply remote and object ids when using --object-info-forma=
t"));
 		} else {
-			/* Zero or one remotes */
 			remote =3D remote_get(argv[0]);
-			prune_tags_ok =3D (argc =3D=3D 1);
-			argc--;
-			argv++;
+			for (i =3D 1; i < argc; i++) {
+				if (get_oid(argv[i], &oid))
+					return error(_("malformed object name '%s'"), argv[i]);
+				oid_array_append(&oids, &oid);
+			}
+		}
+		gtransport =3D prepare_transport(remote, 0);
+		gtransport->server_options =3D &object_info_format;
+		result =3D transport_fetch_object_info(gtransport, &oids);
+
+		return result;=09
+	} else {
+		if (all) {
+			if (argc =3D=3D 1)
+				die(_("fetch --all does not take a repository argument"));
+			else if (argc > 1)
+				die(_("fetch --all does not make sense with refspecs"));
+			(void) for_each_remote(get_one_remote_for_fetch, &list);
+		} else if (argc =3D=3D 0) {
+			/* No arguments -- use default remote */
+			remote =3D remote_get(NULL);
+		} else if (multiple) {
+			/* All arguments are assumed to be remotes or groups */
+			for (i =3D 0; i < argc; i++)
+				if (!add_remote_or_group(argv[i], &list))
+					die(_("no such remote or remote group: %s"),
+					    argv[i]);
+		} else {
+			/* Single remote or group */
+			(void) add_remote_or_group(argv[0], &list);
+			if (list.nr > 1) {
+				/* More than one remote */
+				if (argc > 1)
+					die(_("fetching a group and specifying refspecs does not make sense")=
);
+			} else {
+				/* Zero or one remotes */
+				remote =3D remote_get(argv[0]);
+				prune_tags_ok =3D (argc =3D=3D 1);
+				argc--;
+				argv++;
+			}
 		}
 	}
=20
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
index 0000000000..93b09da3b1
--- /dev/null
+++ b/t/t5583-fetch-object-info.sh
@@ -0,0 +1,95 @@
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
+initial_directory=3D$pwd
+
+# Test fetch object-info with 'git://' transport
+#
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
+	test_when_finished "cd '$initial_directory'" &&
+
+	cd "$daemon_parent" &&
+
+	cat >actual <<-EOF &&
+	$(GIT_TRACE_PACKET=3D1 git -c protocol.version=3D2 fetch --object-info-fo=
rmat=3Dsize "$GIT_DAEMON_URL/parent" $(git rev-parse message1:a.txt))
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse message1:a.txt) $(wc -c <a.txt | xargs)
+	EOF
+
+	test_cmp expect actual
+'
+stop_git_daemon
+
+# Test protocol v2 with 'http://' transport
+#
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack tr=
ue &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" message1 a.txt
+'
+
+test_expect_success 'fetch object-info with http:// using protocol v2' '
+	test_when_finished "cd '$initial_directory'" &&
+
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+	cat >actual <<-EOF &&
+	$(git -c protocol.version=3D2 fetch --object-info-format=3Dsize "$HTTPD_U=
RL/smart/http_parent" $(git rev-parse message1:a.txt))
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse message1:a.txt) $(wc -c <a.txt | xargs)
+	EOF
+
+	test_cmp expect actual
+'
+
+# Test fetch object-info with 'file://' transport
+#
+
+test_expect_success 'create repo to be serbed by file:// transport' '
+	git init server &&
+	test_commit -C server message1 a.txt &&
+	git -C server config protocol.version 2
+'
+
+test_expect_success 'fetch object-info with file:// using protocol v2' '
+	test_when_finished "cd '$initial_directory'" &&
+
+	cd server &&
+
+	cat >actual <<-EOF &&
+	$(git fetch --object-info-format=3Dsize "file://$(pwd)" $(git rev-parse m=
essage1:a.txt))
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse message1:a.txt) $(wc -c <a.txt | xargs)
+	EOF
+
+	test_cmp expect actual
+'
+
+test_done
\ No newline at end of file
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
index 2a3e324154..0e1bf3c4cd 100644
--- a/transport.c
+++ b/transport.c
@@ -445,6 +445,62 @@ static int fetch_refs_via_pack(struct transport *trans=
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
+			PACKET_READ_GENTLE_ON_EOF |
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
+=09
+	close(data->fd[0]);
+
+	if (data->fd[1] >=3D 0) {
+		close(data->fd[1]);
+	}
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
@@ -890,6 +946,7 @@ static struct transport_vtable taken_over_vtable =3D {
 	.get_refs_list	=3D get_refs_via_connect,
 	.fetch_refs	=3D fetch_refs_via_pack,
 	.push_refs	=3D git_transport_push,
+	.fetch_object_info =3D fetch_object_info,
 	.disconnect	=3D disconnect_git
 };
=20
@@ -1043,6 +1100,7 @@ static struct transport_vtable builtin_smart_vtable =
=3D {
 	.get_refs_list	=3D get_refs_via_connect,
 	.fetch_refs	=3D fetch_refs_via_pack,
 	.push_refs	=3D git_transport_push,
+	.fetch_object_info =3D fetch_object_info,
 	.connect	=3D connect_git,
 	.disconnect	=3D disconnect_git
 };
@@ -1420,6 +1478,11 @@ const struct ref *transport_get_remote_refs(struct t=
ransport *transport,
 	return transport->remote_refs;
 }
=20
+int transport_fetch_object_info(struct transport *transport, struct oid_ar=
ray *oids) {
+	transport->vtable->fetch_object_info(transport, oids);
+	return 1;
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

