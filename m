Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF1320954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdLDX7l (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:41 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37645 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdLDX73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:29 -0500
Received: by mail-pf0-f193.google.com with SMTP id n6so9806114pfa.4
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bS8eOJf3QnwvK8N8ShvOrgbetFljaNwB5nwqwjYAOSA=;
        b=MBFFtc3So9uFlO//S9BYm8l8fDb5iunNqgd9eNqfMpvMG2VlVEtp9nxIYcB+EH1lTd
         LiCXJJxLiwYmIWjXEXp2bC2lCmukO/DpdTAAm3rhs7iXBeBbX2NkFQyJyt74Vokrvkt/
         tKcKISv27KZnpLWUMlGDcSbluduvQfa1FKukJzc0m9r1XDqBCtBvyKYW8SpEowiuFRL2
         iwxHW+bBFx3UNvhfAbC7SeGwUV58g7ofVrt+nXsCDJYKCcKyZOqQFjsoB23Hy/kKd1J1
         OQat9jCTrnFHw9nKABSCV25ynVP3XCl1nG4dwolUf73FGBKizfZuD6e5V2d8fQEcmslj
         8vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bS8eOJf3QnwvK8N8ShvOrgbetFljaNwB5nwqwjYAOSA=;
        b=HkxGxp3tDbhhI+Idbfs1yiEYlNcFMtfJpBXxZJ+LJtlB9kf6G/e8/+MnZlqJDUv2Ss
         XeMdW+u7GNhruQtXzrEUhc4qbb9DMBIB2Y0CboiUvnofdLjBoHh3yqERQ+eYWcN0rYJ9
         nD5vfaARoWOBJ2hxrfmkuB+m+HFiIXceIIGG4Px/FgiqmecfgJApyU1uWR0eZJ3NtnD1
         F39B/0qYF1cu3f6HlM3mcPzy8mgYMNoxgL4Xb/Ftu4q9/aIcPqyj7IpATijy2r9v18B0
         vUrduWMR4vWXF5p9wk0ViI4U5zAnNI1nvCWOYjTc/K76/SX72ULCCp/iNVxFAPMKwweg
         N6Ug==
X-Gm-Message-State: AJaThX5LemY2B807F7lkpDQ47Z4FZa8Tv4jn72S9U2y/nWo9og++8MN+
        bAlETBhWK4O8juJduACO1i+mvlxhX6A=
X-Google-Smtp-Source: AGs4zMYsEj8B5Jq2Lu7v6vgLFGWqeIw4SxWViRd/pDij4lS4NmEnMUgbCI13FZuWICvGs4Q6hzum9Q==
X-Received: by 10.98.10.143 with SMTP id 15mr20709037pfk.89.1512431967628;
        Mon, 04 Dec 2017 15:59:27 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:26 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 15/15] fetch-pack: perform a fetch using v2
Date:   Mon,  4 Dec 2017 15:58:23 -0800
Message-Id: <20171204235823.63299-16-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When communicating with a v2 server, perform a fetch by requesting the
'fetch' command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c   |   2 +-
 fetch-pack.c           | 237 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fetch-pack.h           |   4 +-
 t/t5701-protocol-v2.sh |  26 ++++++
 transport.c            |   8 +-
 5 files changed, 270 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 061c278b4..e02c7761b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -211,7 +211,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr);
+			 &shallow, pack_lockfile_ptr, protocol_v0);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/fetch-pack.c b/fetch-pack.c
index 105506e9a..a8ef8f3e5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1007,6 +1007,232 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
+static void add_wants(const struct ref *wants, struct strbuf *req_buf)
+{
+	for ( ; wants ; wants = wants->next) {
+		const struct object_id *remote = &wants->old_oid;
+		const char *remote_hex;
+		struct object *o;
+
+		/*
+		 * If that object is complete (i.e. it is an ancestor of a
+		 * local ref), we tell them we have it but do not have to
+		 * tell them about its ancestors, which they already know
+		 * about.
+		 *
+		 * We use lookup_object here because we are only
+		 * interested in the case we *know* the object is
+		 * reachable and we have already scanned it.
+		 */
+		if (((o = lookup_object(remote->hash)) != NULL) &&
+		    (o->flags & COMPLETE)) {
+			continue;
+		}
+
+		remote_hex = oid_to_hex(remote);
+		packet_buf_write(req_buf, "want %s\n", remote_hex);
+	}
+}
+
+/* */
+static int add_haves(struct strbuf *req_buf)
+{
+	int count = 0;
+	const struct object_id *oid;
+	while ((oid = get_rev())) {
+		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
+		if (++count >= INITIAL_FLUSH)
+			break;
+	};
+
+	return count;
+}
+
+static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+			      const struct ref *wants)
+{
+	int ret = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+
+	use_sideband = 2;
+	packet_buf_write(&req_buf, "command=fetch");
+	packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	packet_buf_delim(&req_buf);
+	if (args->use_thin_pack)
+		packet_buf_write(&req_buf, "thin-pack");
+	if (args->no_progress)
+		packet_buf_write(&req_buf, "no-progress");
+	if (args->include_tag)
+		packet_buf_write(&req_buf, "include-tag");
+	if (prefer_ofs_delta)
+		packet_buf_write(&req_buf, "ofs-delta");
+
+	/* add wants */
+	add_wants(wants, &req_buf);
+
+	/* Add initial haves */
+	ret = add_haves(&req_buf);
+
+	/* Send request */
+	packet_buf_flush(&req_buf);
+	write_or_die(fd_out, req_buf.buf, req_buf.len);
+
+	strbuf_release(&req_buf);
+	return ret;
+}
+
+static enum ack_type process_ack(const char *line, struct object_id *oid)
+{
+	const char *arg;
+
+	if (!strcmp(line, "NAK"))
+		return NAK;
+	if (skip_prefix(line, "ACK ", &arg)) {
+		if (!parse_oid_hex(arg, oid, &arg)) {
+			if (strstr(arg, "continue"))
+				return ACK_continue;
+			if (strstr(arg, "common"))
+				return ACK_common;
+			if (strstr(arg, "ready"))
+				return ACK_ready;
+			return ACK;
+		}
+	}
+	if (skip_prefix(line, "ERR ", &arg))
+		die(_("remote error: %s"), arg);
+	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
+}
+
+static int process_acks(struct packet_reader *reader)
+{
+	int got_ready = 0;
+	int got_common = 0;
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		struct object_id oid;
+		struct commit *commit;
+		enum ack_type ack = process_ack(reader->line, &oid);
+
+		switch (ack) {
+		case ACK_ready:
+			clear_prio_queue(&rev_list);
+			got_ready = 1;
+			/* fallthrough */
+		case ACK_common:
+			commit = lookup_commit(&oid);
+			mark_common(commit, 0, 1);
+			got_common = 1;
+			break;
+		case NAK:
+			break;
+		case ACK:
+		case ACK_continue:
+			die("ACK/ACK_continue not supported");
+		}
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("Error during processing acks: %d",reader->status);
+
+	/* return 0 if no common, 1 if there are common, or 2 if ready */
+	return got_ready + got_common;
+}
+
+static int send_haves(int fd_out, int *in_vain)
+{
+	int ret = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+	int haves_added = add_haves(&req_buf);
+
+	*in_vain += haves_added;
+	if (!haves_added || *in_vain >= MAX_IN_VAIN) {
+		/* Send Done */
+		packet_buf_write(&req_buf, "done\n");
+		ret = 1;
+	}
+
+	/* Send request */
+	packet_buf_flush(&req_buf);
+	write_or_die(fd_out, req_buf.buf, req_buf.len);
+
+	strbuf_release(&req_buf);
+	return ret;
+}
+
+#define FETCH_PACK_CHECK_LOCAL 0
+#define FETCH_PACK_REQUEST 1
+#define FETCH_PACK_ACKS 2
+#define FETCH_PACK_HAVES 3
+#define FETCH_PACK_GET_PACK 4
+#define FETCH_PACK_DONE 5
+
+static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
+				    int fd[2],
+				    const struct ref *orig_ref,
+				    struct ref **sought, int nr_sought,
+				    char **pack_lockfile)
+{
+	struct ref *ref = copy_ref_list(orig_ref);
+	int state = FETCH_PACK_CHECK_LOCAL;
+	struct packet_reader reader;
+	int in_vain = 0;
+	packet_reader_init(&reader, fd[0], NULL, 0);
+
+	while (state != FETCH_PACK_DONE) {
+		switch (state) {
+		case FETCH_PACK_CHECK_LOCAL:
+			sort_ref_list(&ref, ref_compare_name);
+			QSORT(sought, nr_sought, cmp_ref_by_name);
+
+			/* Filter 'ref' by 'sought' and those that aren't local */
+			if (everything_local(args, &ref, sought, nr_sought))
+				state = FETCH_PACK_DONE;
+			else
+				state = FETCH_PACK_REQUEST;
+			break;
+		case FETCH_PACK_REQUEST:
+			if (send_fetch_request(fd[1], args, ref))
+				state = FETCH_PACK_ACKS;
+			else
+				state = FETCH_PACK_GET_PACK;
+			break;
+		case FETCH_PACK_ACKS:
+			/* Process ACKs/NAKs */
+			switch (process_acks(&reader)) {
+			case 2:
+				state = FETCH_PACK_GET_PACK;
+				break;
+			case 1:
+				in_vain = 0;
+				/* fallthrough */
+			default:
+				state = FETCH_PACK_HAVES;
+				break;
+			}
+			break;
+		case FETCH_PACK_HAVES:
+			if (send_haves(fd[1], &in_vain))
+				state = FETCH_PACK_GET_PACK;
+			else
+				state = FETCH_PACK_ACKS;
+			break;
+		case FETCH_PACK_GET_PACK:
+			/* get the pack */
+			if (get_pack(args, fd, pack_lockfile))
+				die(_("git fetch-pack: fetch failed."));
+
+			state = FETCH_PACK_DONE;
+			break;
+		case FETCH_PACK_DONE:
+			break;
+		default:
+			die("invalid state");
+		}
+	}
+
+	return ref;
+}
+
 static void fetch_pack_config(void)
 {
 	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
@@ -1152,7 +1378,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile)
+		       char **pack_lockfile,
+		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
@@ -1166,8 +1393,12 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		die(_("no matching remote head"));
 	}
 	prepare_shallow_info(&si, shallow);
-	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-				&si, pack_lockfile);
+	if (version == protocol_v2)
+		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
+					   pack_lockfile);
+	else
+		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
+					&si, pack_lockfile);
 	reprepare_packed_git();
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43a8..7afca7305 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -3,6 +3,7 @@
 
 #include "string-list.h"
 #include "run-command.h"
+#include "protocol.h"
 
 struct oid_array;
 
@@ -43,7 +44,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct ref **sought,
 		       int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile);
+		       char **pack_lockfile,
+		       enum protocol_version version);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/t/t5701-protocol-v2.sh b/t/t5701-protocol-v2.sh
index 4bf4d61ac..c788ea597 100755
--- a/t/t5701-protocol-v2.sh
+++ b/t/t5701-protocol-v2.sh
@@ -25,4 +25,30 @@ test_expect_success 'list refs with file:// using protocol v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'clone with file:// using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		clone "file://$(pwd)/file_parent" file_child 2>log &&
+
+	git -C file_child log -1 --format=%s >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "clone< version 2" log
+'
+
+test_expect_success 'fetch with file:// using protocol v2' '
+	test_commit -C file_parent two &&
+
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=2 \
+		fetch origin 2>log &&
+
+	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v1
+	grep "fetch< version 2" log
+'
+
 test_done
diff --git a/transport.c b/transport.c
index ddd0d6174..50354abed 100644
--- a/transport.c
+++ b/transport.c
@@ -252,14 +252,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		refs = fetch_pack(&args, data->fd, data->conn,
+				  refs_tmp ? refs_tmp : transport->remote_refs,
+				  dest, to_fetch, nr_heads, &data->shallow,
+				  &transport->pack_lockfile, data->version);
+		packet_flush(data->fd[1]);
 		break;
 	case protocol_v1:
 	case protocol_v0:
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile);
+				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
-- 
2.15.1.424.g9478a66081-goog

