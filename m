Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0510C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1513610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDIBKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhDIBK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DEC061762
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j4so2232653pgs.18
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wmmcB5N9lkvFJV/RgGhqGEH3esfGYwNpq0vOrZg0npU=;
        b=g9mIe96Mg8sikoekEwgCG8rJR4T7pvHSD0iKGrXHFyaN9yDUkKy58887jo37apPhhn
         Mx7RqpbGPMx0n3GCz+3KqYDS9V6Qlf3rSt196727uzesAHRRMlNTPFjEDkezNlO7gzqo
         n/RlQYGY/f2wW9SRgI+9005H5zAbDPtjea1QlXmGiBV0Q6uYuOwB3A/oYtXKm/SWU6mU
         yo1PTwhbbYH8ZUw5CkO4dkgM09qDZS3BLtF/0sv6FlhFvpBOqqgz8IWZ11OqIs+aj2nE
         epfLTVnR7zrLbwMdjznkQugCDOrMyPKcHTv9J74sOSuCHghnwRvJuJdVx+UgOwzGvCyc
         jXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wmmcB5N9lkvFJV/RgGhqGEH3esfGYwNpq0vOrZg0npU=;
        b=rQqH7OFiImMXN7imWPyWMjTgDrriv0OesXFciotwbPYuCfNDjNlxoT/jZtFliTz061
         mmIbPIrTjr0yIMb7T93sa+dsZBPJ2RRx2otJVSF58WYEcFzVPH+5xQ60+p/Lg77Er6ln
         ZGYH5azUHjqik/SVqZk6QpN1CNq0KFqAfZJKD8OyRf1BfArzF/nuRGr7mxAkrRaUIE1q
         gX8l2dxpvNjcjgY6Zdc2DS+ZGr/2NLoTcWMinxePtEhzwwAqZH20rRe54Gl07pLjZuja
         EmFRguLA+lhi+mdO0XekwT7rz5yttYWdk+P+8BTA+tDdrKNXonU733VMMvbo0mtuVt+5
         54Iw==
X-Gm-Message-State: AOAM531rX1Ao8mqrMNx57Vp2AU59ONDIb0MwSHOrIuZHcEhBRZAFhcnh
        UlW8etlXKgvPONuz8UcNQmiqRTlTov0MNlBmEZzstL8RPut1j6FxYbchHoejcu4vdH/P1C3OoET
        Bi8msH+g9/0kL9r21RX4Cl1RgYRbKeWqw654lDrtYHwUE7f8k9PSaVSj6qKYVareIwqApZsCipH
        qh
X-Google-Smtp-Source: ABdhPJz8jmLrOVLWjW1Ui2PqQFVtuIP0XekrPWQx/2UMteC7Iv98Yhr0p3IKsNYKYV9ihKfEZ6FNYw4sNrQDhEtooQuz
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:7ac8:0:b029:246:e38c:58ac with
 SMTP id v191-20020a627ac80000b0290246e38c58acmr580026pfc.10.1617930616759;
 Thu, 08 Apr 2021 18:10:16 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:10:02 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the packfile negotiation step within a Git fetch cannot be
done independent of sending the packfile, even though there is at least
one application wherein this is useful. Therefore, make it possible for
this negotiation step to be done independently. A subsequent commit will
use this for one such application - push negotiation.

This feature is for protocol v2 only. (An implementation for protocol v0
would require a separate implementation in the fetch, transport, and
transport helper code.)

In the protocol, the main hindrance towards independent negotiation is
that the server can unilaterally decide to send the packfile. This is
solved by a "wait-for-done" argument: the server will then wait for the
client to say "done". In practice, the client will never say it; instead
it will cease requests once it is satisfied.

In the client, the main change lies in the transport and transport
helper code. fetch_refs_via_pack() performs everything needed - protocol
version and capability checks, and the negotiation itself.

There are 2 code paths that do not go through fetch_refs_via_pack() that
needed to be individually excluded: the bundle transport (excluded
through requiring smart_options, which the bundle transport doesn't
support) and transport helpers that do not support takeover.
Fortunately, none of these support protocol v2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt |  8 +++
 builtin/fetch.c                         | 27 +++++++-
 fetch-pack.c                            | 89 +++++++++++++++++++++++--
 fetch-pack.h                            | 11 +++
 object.h                                |  2 +-
 t/t5701-git-serve.sh                    |  2 +-
 t/t5702-protocol-v2.sh                  | 89 +++++++++++++++++++++++++
 transport-helper.c                      | 10 +++
 transport.c                             | 30 +++++++--
 transport.h                             |  6 ++
 upload-pack.c                           | 18 +++--
 11 files changed, 275 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index a7c806a73e..0b371d8de4 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -346,6 +346,14 @@ explained below.
 	client should download from all given URIs. Currently, the
 	protocols supported are "http" and "https".
 
+If the 'wait-for-done' feature is advertised, the following argument
+can be included in the client's request.
+
+    wait-for-done
+	Indicates to the server that it should never send "ready", but
+	should wait for the client to say "done" before sending the
+	packfile.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header. Most sections are sent only when the packfile is sent.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0b90de87c7..597973848a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -82,6 +82,7 @@ static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
 static int stdin_refspecs = 0;
+static int negotiate_only;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -202,6 +203,8 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV6),
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
+	OPT_BOOL(0, "negotiate-only", &negotiate_only,
+		 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
 		 N_("run 'maintenance --auto' after fetching")),
@@ -1986,7 +1989,29 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (remote) {
+	if (negotiate_only) {
+		struct oidset acked_commits = OIDSET_INIT;
+		struct oidset_iter iter;
+		const struct object_id *oid;
+
+		if (!remote)
+			die(_("Must supply remote when using --negotiate-only"));
+		gtransport = prepare_transport(remote, 1);
+		if (gtransport->smart_options) {
+			gtransport->smart_options->acked_commits = &acked_commits;
+		} else {
+			warning(_("Protocol does not support --negotiate-only, exiting."));
+			return 1;
+		}
+		if (server_options.nr)
+			gtransport->server_options = &server_options;
+		result = transport_fetch_refs(gtransport, NULL);
+
+		oidset_iter_init(&acked_commits, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			printf("%s\n", oid_to_hex(oid));
+		oidset_clear(&acked_commits);
+	} else if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
diff --git a/fetch-pack.c b/fetch-pack.c
index 512fe5450d..63054e2fc8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "commit-reach.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -45,6 +46,8 @@ static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
 #define ALTERNATE	(1U << 1)
+#define COMMON		(1U << 6)
+#define REACH_SCRATCH	(1U << 7)
 
 /*
  * After sending this many "have"s if we do not get any new ACK , we
@@ -1523,10 +1526,10 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-static void do_check_stateless_delimiter(const struct fetch_pack_args *args,
+static void do_check_stateless_delimiter(int stateless_rpc,
 					 struct packet_reader *reader)
 {
-	check_stateless_delimiter(args->stateless_rpc, reader,
+	check_stateless_delimiter(stateless_rpc, reader,
 				  _("git fetch-pack: expected response end packet"));
 }
 
@@ -1622,7 +1625,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				 */
 				state = FETCH_GET_PACK;
 			} else {
-				do_check_stateless_delimiter(args, &reader);
+				do_check_stateless_delimiter(args->stateless_rpc, &reader);
 				state = FETCH_SEND_REQUEST;
 			}
 			break;
@@ -1645,7 +1648,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				     packfile_uris.nr ? &index_pack_args : NULL,
 				     sought, nr_sought, &fsck_options.gitmodules_found))
 				die(_("git fetch-pack: fetch failed."));
-			do_check_stateless_delimiter(args, &reader);
+			do_check_stateless_delimiter(args->stateless_rpc, &reader);
 
 			state = FETCH_DONE;
 			break;
@@ -1962,6 +1965,84 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	return ref_cpy;
 }
 
+static int add_to_object_array(const struct object_id *oid, void *data)
+{
+	struct object_array *a = data;
+
+	add_object_array(parse_object(the_repository, oid), "", a);
+	return 0;
+}
+
+void negotiate_using_fetch(const struct oid_array *negotiation_tips,
+			   const struct string_list *server_options,
+			   int stateless_rpc,
+			   int fd[],
+			   struct oidset *acked_commits)
+{
+	struct fetch_negotiator negotiator;
+	struct packet_reader reader;
+	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
+	struct strbuf req_buf = STRBUF_INIT;
+	int haves_to_send = INITIAL_FLUSH;
+	int in_vain = 0;
+	int seen_ack = 0;
+	int last_iteration = 0;
+
+	fetch_negotiator_init(the_repository, &negotiator);
+	mark_tips(&negotiator, negotiation_tips);
+
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+
+	oid_array_for_each((struct oid_array *) negotiation_tips,
+			   add_to_object_array,
+			   &nt_object_array);
+
+	while (!last_iteration) {
+		int haves_added;
+		struct object_id common_oid;
+		int received_ready = 0;
+
+		strbuf_reset(&req_buf);
+		write_fetch_command_and_capabilities(&req_buf, server_options);
+
+		packet_buf_write(&req_buf, "wait-for-done");
+
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		in_vain += haves_added;
+		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
+			last_iteration = 1;
+
+		/* Send request */
+		packet_buf_flush(&req_buf);
+		if (write_in_full(fd[1], req_buf.buf, req_buf.len) < 0)
+			die_errno(_("unable to write request to remote"));
+
+		/* Process ACKs/NAKs */
+		process_section_header(&reader, "acknowledgments", 0);
+		while (process_ack(&negotiator, &reader, &common_oid,
+				   &received_ready)) {
+			struct commit *commit = lookup_commit(the_repository,
+							      &common_oid);
+			if (commit)
+				commit->object.flags |= COMMON;
+			in_vain = 0;
+			seen_ack = 1;
+			oidset_insert(acked_commits, &common_oid);
+		}
+		if (received_ready)
+			die(_("unexpected 'ready' from remote"));
+		else
+			do_check_stateless_delimiter(stateless_rpc, &reader);
+		if (can_all_from_reach_with_flag(&nt_object_array, COMMON,
+						 REACH_SCRATCH, 0,
+						 GENERATION_NUMBER_ZERO))
+			last_iteration = 1;
+	}
+	strbuf_release(&req_buf);
+}
+
 int report_unmatched_refs(struct ref **sought, int nr_sought)
 {
 	int i, ret = 0;
diff --git a/fetch-pack.h b/fetch-pack.h
index f114d72775..7c8f49aca7 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "protocol.h"
 #include "list-objects-filter-options.h"
+#include "oidset.h"
 
 struct oid_array;
 
@@ -81,6 +82,16 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct string_list *pack_lockfiles,
 		       enum protocol_version version);
 
+/*
+ * Execute the --negotiate-only mode of "git fetch", adding all known common
+ * commits to acked_commits.
+ */
+void negotiate_using_fetch(const struct oid_array *negotiation_tips,
+			   const struct string_list *server_options,
+			   int stateless_rpc,
+			   int fd[],
+			   struct oidset *acked_commits);
+
 /*
  * Print an appropriate error message for each sought ref that wasn't
  * matched.  Return 0 if all sought refs were matched, otherwise 1.
diff --git a/object.h b/object.h
index 59daadce21..4806fa8e66 100644
--- a/object.h
+++ b/object.h
@@ -60,7 +60,7 @@ struct object_array {
 /*
  * object flag allocation:
  * revision.h:               0---------10         15             23------26
- * fetch-pack.c:             01
+ * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11-----14  16-----19
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 509f379d49..f03bb04803 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -16,7 +16,7 @@ test_expect_success 'test capability advertisement' '
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs=unborn
-	fetch=shallow
+	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
 	0000
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..5d91f067d0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -585,6 +585,49 @@ test_expect_success 'deepen-relative' '
 	test_cmp expected actual
 '
 
+setup_negotiate_only () {
+	SERVER="$1"
+	URI="$2"
+
+	rm -rf "$SERVER" client
+
+	git init "$SERVER"
+	test_commit -C "$SERVER" one
+	test_commit -C "$SERVER" two
+
+	git clone "$URI" client
+	test_commit -C client three
+}
+
+test_expect_success 'file:// --negotiate-only' '
+	SERVER="server" &&
+	URI="file://$(pwd)/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	git -C client fetch \
+		--no-tags \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		origin >out &&
+	COMMON=$(git -C "$SERVER" rev-parse two) &&
+	grep "$COMMON" out
+'
+
+test_expect_success 'file:// --negotiate-only with protocol v0' '
+	SERVER="server" &&
+	URI="file://$(pwd)/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	test_must_fail git -c protocol.version=0 -C client fetch \
+		--no-tags \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		origin 2>err &&
+	test_i18ngrep "negotiate-only requires protocol v2" err
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
@@ -1035,6 +1078,52 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	test_i18ngrep "disallowed submodule name" err
 '
 
+test_expect_success 'http:// --negotiate-only' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	URI="$HTTPD_URL/smart/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	git -C client fetch \
+		--no-tags \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		origin >out &&
+	COMMON=$(git -C "$SERVER" rev-parse two) &&
+	grep "$COMMON" out
+'
+
+test_expect_success 'http:// --negotiate-only without wait-for-done support' '
+	SERVER="server" &&
+	URI="$HTTPD_URL/one_time_perl/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
+		>"$HTTPD_ROOT_PATH/one-time-perl" &&
+
+	test_must_fail git -C client fetch \
+		--no-tags \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		origin 2>err &&
+	test_i18ngrep "server does not support wait-for-done" err
+'
+
+test_expect_success 'http:// --negotiate-only with protocol v0' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	URI="$HTTPD_URL/smart/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	test_must_fail git -c protocol.version=0 -C client fetch \
+		--no-tags \
+		--negotiate-only \
+		--negotiation-tip=$(git -C client rev-parse HEAD) \
+		origin 2>err &&
+	test_i18ngrep "negotiate-only requires protocol v2" err
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
diff --git a/transport-helper.c b/transport-helper.c
index 4cd76366fa..4be035edb8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -684,6 +684,16 @@ static int fetch(struct transport *transport,
 		return transport->vtable->fetch(transport, nr_heads, to_fetch);
 	}
 
+	/*
+	 * If we reach here, then the server, the client, and/or the transport
+	 * helper does not support protocol v2. --negotiate-only requires
+	 * protocol v2.
+	 */
+	if (data->transport_options.acked_commits) {
+		warning(_("--negotiate-only requires protocol v2"));
+		return -1;
+	}
+
 	if (!data->get_refs_list_called)
 		get_refs_list_using_list(transport, 0);
 
diff --git a/transport.c b/transport.c
index ef66e73090..80caeaa72f 100644
--- a/transport.c
+++ b/transport.c
@@ -392,16 +392,29 @@ static int fetch_refs_via_pack(struct transport *transport,
 	else if (data->version <= protocol_v1)
 		die_if_server_options(transport);
 
+	if (data->options.acked_commits) {
+		if (data->version < protocol_v2) {
+			warning(_("--negotiate-only requires protocol v2"));
+			ret = -1;
+		} else if (!server_supports_feature("fetch", "wait-for-done", 0)) {
+			warning(_("server does not support wait-for-done"));
+			ret = -1;
+		} else {
+			negotiate_using_fetch(data->options.negotiation_tips,
+					      transport->server_options,
+					      transport->stateless_rpc,
+					      data->fd,
+					      data->options.acked_commits);
+			ret = 0;
+		}
+		goto cleanup;
+	}
+
 	refs = fetch_pack(&args, data->fd,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
 			  to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfiles, data->version);
 
-	close(data->fd[0]);
-	close(data->fd[1]);
-	if (finish_connect(data->conn))
-		ret = -1;
-	data->conn = NULL;
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
@@ -412,6 +425,13 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret = -1;
 
+cleanup:
+	close(data->fd[0]);
+	close(data->fd[1]);
+	if (finish_connect(data->conn))
+		ret = -1;
+	data->conn = NULL;
+
 	free_refs(refs_tmp);
 	free_refs(refs);
 	return ret;
diff --git a/transport.h b/transport.h
index 4d5db0a7f2..b8b3d42e62 100644
--- a/transport.h
+++ b/transport.h
@@ -47,6 +47,12 @@ struct git_transport_options {
 	 * transport_set_option().
 	 */
 	struct oid_array *negotiation_tips;
+
+	/*
+	 * If set, whenever transport_fetch_refs() is called, add known common
+	 * commits to this oidset instead of fetching any packfiles.
+	 */
+	struct oidset *acked_commits;
 };
 
 enum transport_family {
diff --git a/upload-pack.c b/upload-pack.c
index e19583ae0f..b432ef0119 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -103,6 +103,7 @@ struct upload_pack_data {
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
+	unsigned wait_for_done : 1;
 	unsigned allow_filter : 1;
 	unsigned allow_filter_fallback : 1;
 	unsigned long tree_filter_max_depth;
@@ -1496,6 +1497,10 @@ static void process_args(struct packet_reader *request,
 			data->done = 1;
 			continue;
 		}
+		if (!strcmp(arg, "wait-for-done")) {
+			data->wait_for_done = 1;
+			continue;
+		}
 
 		/* Shallow related arguments */
 		if (process_shallow(arg, &data->shallows))
@@ -1578,7 +1583,7 @@ static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 				    oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up(data)) {
+	if (!data->wait_for_done && ok_to_give_up(data)) {
 		/* Send Ready */
 		packet_writer_write(&data->writer, "ready\n");
 		return 1;
@@ -1668,10 +1673,13 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
 		case FETCH_PROCESS_ARGS:
 			process_args(request, &data);
 
-			if (!data.want_obj.nr) {
+			if (!data.want_obj.nr && !data.wait_for_done) {
 				/*
-				 * Request didn't contain any 'want' lines,
-				 * guess they didn't want anything.
+				 * Request didn't contain any 'want' lines (and
+				 * the request does not contain
+				 * "wait-for-done", in which it is reasonable
+				 * to just send 'have's without 'want's); guess
+				 * they didn't want anything.
 				 */
 				state = FETCH_DONE;
 			} else if (data.haves.nr) {
@@ -1723,7 +1731,7 @@ int upload_pack_advertise(struct repository *r,
 		int allow_sideband_all_value;
 		char *str = NULL;
 
-		strbuf_addstr(value, "shallow");
+		strbuf_addstr(value, "shallow wait-for-done");
 
 		if (!repo_config_get_bool(the_repository,
 					 "uploadpack.allowfilter",
-- 
2.31.1.295.g9ea45b61b8-goog

