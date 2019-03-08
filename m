Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9C520248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCHVz6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:58 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43016 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:58 -0500
Received: by mail-qk1-f201.google.com with SMTP id a11so17207746qkk.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KHlUdRsvmRLC3jzrMK+9xcgvtvlgxxlZx9J0NjsK+mU=;
        b=SXvIRpWUIRgAwjXCSVURa7Fz/K2R2YozPAZGYmw3UJTtawPQqmRu4Amql6su4QSc7M
         wYUMftQMp5raSkyuXXFScIB7OYTVtRvjXPRnGr6E7UiytObrk4cw62lG7DclJg1RZzId
         w/x2DklXp54ZWMVlNDfAqYqPxWSDmJn6Dhj94nJ+Xp+PH5w6n2jwL26xxEbKU52mx0jy
         POKk3qoNENtyMfCow+Gyso0OMjeM7IEBSII8lp9peLw6R2iOeW10F5x8egHUF4h81XPX
         t3RI3VS3kX/sJea4x7B3zZM4f244iaUx65e71i764Ne2FYfhYiU6v37tTjv1dOsCQ46N
         dPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KHlUdRsvmRLC3jzrMK+9xcgvtvlgxxlZx9J0NjsK+mU=;
        b=P2+3xP1YrZnUnAh+toaRJZEO3FbiDyhc8Ulx2YcdNV/fBf5pa89wWFlsSrpCR0pkw9
         DuPWOqddH1TQR+hw/ttaZ5n5e7fEC7mUXFD990s8NajLTeiAB5frfme2RArj95zUus8G
         91bsSQxg3yCH7esAZF6rcWx87ySmOG50oHuy+mEuJT3uepJJYB+5l7PYAhbwpZvMW6rk
         NL1REMNp11w3bqzfO6bKa7dDGGsxEsyAx8JJ0jkSuBgXvUWx0fAHa4cqMgrlk/yyogfC
         YkUDkPPChaZf79es/SRgr0m1QtGlvny92qZPrUU+J9DKG8N+H8P+LGqg0DLlWY1aYARZ
         lPqQ==
X-Gm-Message-State: APjAAAUCEvoTvGkhhhv5iemPPc9hTXf9w6v3y7ePlFtC7lBWYDVnYckw
        6uRJAjVJJt2Ddg9iDLeC7yC8Fzo3eEKBhONyZ0Bn
X-Google-Smtp-Source: APXvYqz4ivWFO0KzzsgSuDoeVUAiHFCdlBLTwKT9N4MBMH3KekUSb6siv02TyPqFpXPnr56JTp+INziSxjZkPGWBJaEe
X-Received: by 2002:a0c:88c7:: with SMTP id 7mr12313525qvo.12.1552082156916;
 Fri, 08 Mar 2019 13:55:56 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:20 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <c7546868cff487727a09841698fe14e089f4a19f.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 8/8] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach upload-pack to send part of its packfile response as URIs.

An administrator may configure a repository with one or more
"uploadpack.blobpackfileuri" lines, each line containing an OID, a pack
hash, and a URI. A client may configure fetch.uriprotocols to be a
comma-separated list of protocols that it is willing to use to fetch
additional packfiles - this list will be sent to the server. Whenever an
object with one of those OIDs would appear in the packfile transmitted
by upload-pack, the server may exclude that object, and instead send the
URI. The client will then download the packs referred to by those URIs
before performing the connectivity check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |  76 ++++++++++++++++++++++++++++
 fetch-pack.c           | 112 +++++++++++++++++++++++++++++++++++++++--
 t/t5702-protocol-v2.sh |  57 +++++++++++++++++++++
 upload-pack.c          |  78 +++++++++++++++++++++++++---
 4 files changed, 312 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a9fac7c128..2fa962c87d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -110,6 +110,8 @@ static unsigned long window_memory_limit = 0;
 
 static struct list_objects_filter_options filter_options;
 
+static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
+
 enum missing_action {
 	MA_ERROR = 0,      /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
@@ -118,6 +120,15 @@ enum missing_action {
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
 
+struct configured_exclusion {
+	struct oidmap_entry e;
+	char *pack_hash_hex;
+	char *uri;
+};
+static struct oidmap configured_exclusions;
+
+static struct oidset excluded_by_config;
+
 /*
  * stats
  */
@@ -832,6 +843,25 @@ static off_t write_reused_pack(struct hashfile *f)
 	return reuse_packfile_offset - sizeof(struct pack_header);
 }
 
+static void write_excluded_by_configs(void)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	oidset_iter_init(&excluded_by_config, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct configured_exclusion *ex =
+			oidmap_get(&configured_exclusions, oid);
+
+		if (!ex)
+			BUG("configured exclusion wasn't configured");
+		write_in_full(1, ex->pack_hash_hex, strlen(ex->pack_hash_hex));
+		write_in_full(1, " ", 1);
+		write_in_full(1, ex->uri, strlen(ex->uri));
+		write_in_full(1, "\n", 1);
+	}
+}
+
 static const char no_split_warning[] = N_(
 "disabling bitmap writing, packs are split due to pack.packSizeLimit"
 );
@@ -1125,6 +1155,25 @@ static int want_object_in_pack(const struct object_id *oid,
 		}
 	}
 
+	if (uri_protocols.nr) {
+		struct configured_exclusion *ex =
+			oidmap_get(&configured_exclusions, oid);
+		int i;
+		const char *p;
+
+		if (ex) {
+			for (i = 0; i < uri_protocols.nr; i++) {
+				if (skip_prefix(ex->uri,
+						uri_protocols.items[i].string,
+						&p) &&
+				    *p == ':') {
+					oidset_insert(&excluded_by_config, oid);
+					return 0;
+				}
+			}
+		}
+	}
+
 	return 1;
 }
 
@@ -2726,6 +2775,29 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		const char *oid_end, *pack_end;
+		/*
+		 * Stores the pack hash. This is not a true object ID, but is
+		 * of the same form.
+		 */
+		struct object_id pack_hash;
+
+		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
+		    *oid_end != ' ' ||
+		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
+		    *pack_end != ' ')
+			die(_("value of uploadpack.blobpackfileuri must be "
+			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
+		if (oidmap_get(&configured_exclusions, &ex->e.oid))
+			die(_("object already configured in another "
+			      "uploadpack.blobpackfileuri (got '%s')"), v);
+		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
+		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
+		ex->uri = xstrdup(pack_end + 1);
+		oidmap_put(&configured_exclusions, ex);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -3318,6 +3390,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
+		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
+				N_("protocol"),
+				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
 		OPT_END(),
 	};
 
@@ -3492,6 +3567,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		return 0;
 	if (nr_result)
 		prepare_pack(window, depth);
+	write_excluded_by_configs();
 	write_pack_file();
 	if (progress)
 		fprintf_ln(stderr,
diff --git a/fetch-pack.c b/fetch-pack.c
index cf89af21d9..32695f5243 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,6 +38,7 @@ static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
 static char *negotiation_algorithm;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
+static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -755,7 +756,8 @@ static int sideband_demux(int in, int out, void *data)
 }
 
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], struct string_list *pack_lockfiles)
+		    int xd[2], struct string_list *pack_lockfiles,
+		    int only_packfile)
 {
 	struct async demux;
 	int do_keep = args->keep_pack;
@@ -815,8 +817,15 @@ static int get_pack(struct fetch_pack_args *args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
 					(uintmax_t)getpid(), hostname);
 		}
-		if (args->check_self_contained_and_connected)
+		if (only_packfile && args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+		else
+			/*
+			 * We cannot perform any connectivity checks because
+			 * not all packs have been downloaded; let the caller
+			 * have this responsibility.
+			 */
+			args->check_self_contained_and_connected = 0;
 		if (args->from_promisor)
 			argv_array_push(&cmd.args, "--promisor");
 	}
@@ -993,7 +1002,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfiles))
+	if (get_pack(args, fd, pack_lockfiles, 1))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1148,6 +1157,26 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		warning("filtering not recognized by server, ignoring");
 	}
 
+	if (server_supports_feature("fetch", "packfile-uris", 0)) {
+		int i;
+		struct strbuf to_send = STRBUF_INIT;
+
+		for (i = 0; i < uri_protocols.nr; i++) {
+			const char *s = uri_protocols.items[i].string;
+
+			if (!strcmp(s, "https") || !strcmp(s, "http")) {
+				if (to_send.len)
+					strbuf_addch(&to_send, ',');
+				strbuf_addstr(&to_send, s);
+			}
+		}
+		if (to_send.len) {
+			packet_buf_write(&req_buf, "packfile-uris %s",
+					 to_send.buf);
+			strbuf_release(&to_send);
+		}
+	}
+
 	/* add wants */
 	add_wants(args->no_dependents, wants, &req_buf);
 
@@ -1323,6 +1352,21 @@ static void receive_wanted_refs(struct packet_reader *reader,
 		die(_("error processing wanted refs: %d"), reader->status);
 }
 
+static void receive_packfile_uris(struct packet_reader *reader,
+				  struct string_list *uris)
+{
+	process_section_header(reader, "packfile-uris", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		if (reader->pktlen < the_hash_algo->hexsz ||
+		    reader->line[the_hash_algo->hexsz] != ' ')
+			die("expected '<hash> <uri>', got: %s\n", reader->line);
+
+		string_list_append(uris, reader->line);
+	}
+	if (reader->status != PACKET_READ_DELIM)
+		die("expected DELIM");
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1344,6 +1388,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
+	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
+	int i;
+
 	fetch_negotiator_init(&negotiator, negotiation_algorithm);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -1414,9 +1461,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
 
-			/* get the pack */
+			/* get the pack(s) */
+			if (process_section_header(&reader, "packfile-uris", 1))
+				receive_packfile_uris(&reader, &packfile_uris);
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfiles))
+			if (get_pack(args, fd, pack_lockfiles,
+				     !packfile_uris.nr))
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
@@ -1426,6 +1476,50 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	for (i = 0; i < packfile_uris.nr; i++) {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		char packname[GIT_MAX_HEXSZ + 1];
+		const char *uri = packfile_uris.items[i].string +
+			the_hash_algo->hexsz + 1;
+
+		argv_array_push(&cmd.args, "http-fetch");
+		argv_array_push(&cmd.args, "--packfile");
+		argv_array_push(&cmd.args, uri);
+		cmd.git_cmd = 1;
+		cmd.no_stdin = 1;
+		cmd.out = -1;
+		if (start_command(&cmd))
+			die("fetch-pack: unable to spawn http-fetch");
+
+		if (read_in_full(cmd.out, packname, 5) < 0 ||
+		    memcmp(packname, "keep\t", 5))
+			die("fetch-pack: expected keep then TAB at start of http-fetch output");
+
+		if (read_in_full(cmd.out, packname,
+				 the_hash_algo->hexsz + 1) < 0 ||
+		    packname[the_hash_algo->hexsz] != '\n')
+			die("fetch-pack: expected hash then LF at end of http-fetch output");
+
+		packname[the_hash_algo->hexsz] = '\0';
+
+		close(cmd.out);
+
+		if (finish_command(&cmd))
+			die("fetch-pack: unable to finish http-fetch");
+
+		if (memcmp(packfile_uris.items[i].string, packname,
+			   the_hash_algo->hexsz))
+			die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
+			    uri, (int) the_hash_algo->hexsz,
+			    packfile_uris.items[i].string);
+
+		string_list_append_nodup(pack_lockfiles,
+					 xstrfmt("%s/pack/pack-%s.keep",
+						 get_object_directory(),
+						 packname));
+	}
+	string_list_clear(&packfile_uris, 0);
+
 	negotiator.release(&negotiator);
 	oidset_clear(&common);
 	return ref;
@@ -1465,6 +1559,14 @@ static void fetch_pack_config(void)
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 	git_config_get_string("fetch.negotiationalgorithm",
 			      &negotiation_algorithm);
+	if (!uri_protocols.nr) {
+		char *str;
+
+		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
+			string_list_split(&uri_protocols, str, ',', -1);
+			free(str);
+		}
+	}
 
 	git_config(fetch_pack_config_cb, NULL);
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..6784dfe279 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -656,6 +656,63 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
+configure_exclusion () {
+	git -C "$1" hash-object "$2" >objh &&
+	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$1" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+	cat objh
+}
+
+test_expect_success 'part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	echo other-blob >"$P/other-blob" &&
+	git -C "$P" add other-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion "$P" other-blob >h2 &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that my-blob and other-blob are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 1 out.objectlist
+		then
+			if grep $(cat h) out
+			then
+				>hfound
+			fi &&
+			if grep $(cat h2) out
+			then
+				>h2found
+			fi
+		fi
+	done &&
+	test -f hfound &&
+	test -f h2found &&
+
+	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
+	ls http_child/.git/objects/pack/* >filelist &&
+	test_line_count = 6 filelist
+'
+
 stop_httpd
 
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 987d2e139b..d36e1fc06a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,9 +105,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 struct output_state {
 	char buffer[8193];
 	int used;
+	unsigned packfile_uris_started : 1;
+	unsigned packfile_started : 1;
 };
 
-static int relay_pack_data(int pack_objects_out, struct output_state *os)
+static int relay_pack_data(int pack_objects_out, struct output_state *os,
+			   int write_packfile_line)
 {
 	/*
 	 * We keep the last byte to ourselves
@@ -128,6 +131,37 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
 	}
 	os->used += readsz;
 
+	while (!os->packfile_started) {
+		char *p;
+		if (os->used >= 4 && !memcmp(os->buffer, "PACK", 4)) {
+			os->packfile_started = 1;
+			if (write_packfile_line) {
+				if (os->packfile_uris_started)
+					packet_delim(1);
+				packet_write_fmt(1, "\1packfile\n");
+			}
+			break;
+		}
+		if ((p = memchr(os->buffer, '\n', os->used))) {
+			if (!os->packfile_uris_started) {
+				os->packfile_uris_started = 1;
+				if (!write_packfile_line)
+					BUG("packfile_uris requires sideband-all");
+				packet_write_fmt(1, "\1packfile-uris\n");
+			}
+			*p = '\0';
+			packet_write_fmt(1, "\1%s\n", os->buffer);
+
+			os->used -= p - os->buffer + 1;
+			memmove(os->buffer, p + 1, os->used);
+		} else {
+			/*
+			 * Incomplete line.
+			 */
+			return readsz;
+		}
+	}
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1);
 		os->buffer[0] = os->buffer[os->used - 1];
@@ -141,7 +175,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
 }
 
 static void create_pack_file(const struct object_array *have_obj,
-			     const struct object_array *want_obj)
+			     const struct object_array *want_obj,
+			     const struct string_list *uri_protocols)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	struct output_state output_state = {0};
@@ -192,6 +227,11 @@ static void create_pack_file(const struct object_array *have_obj,
 					 expanded_filter_spec.buf);
 		}
 	}
+	if (uri_protocols) {
+		for (i = 0; i < uri_protocols->nr; i++)
+			argv_array_pushf(&pack_objects.args, "--uri-protocol=%s",
+					 uri_protocols->items[0].string);
+	}
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -278,7 +318,8 @@ static void create_pack_file(const struct object_array *have_obj,
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			int result = relay_pack_data(pack_objects.out,
-						     &output_state);
+						     &output_state,
+						     !!uri_protocols);
 
 			if (result == 0) {
 				close(pack_objects.out);
@@ -1123,7 +1164,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj);
+		create_pack_file(&have_obj, &want_obj, 0);
 	}
 }
 
@@ -1138,6 +1179,7 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
+	struct string_list uri_protocols;
 
 	struct packet_writer writer;
 
@@ -1157,6 +1199,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->wants = wants;
@@ -1164,6 +1207,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
+	data->uri_protocols = uri_protocols;
 	packet_writer_init(&data->writer, 1);
 }
 
@@ -1322,9 +1366,17 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
+		if (skip_prefix(arg, "packfile-uris ", &p)) {
+			string_list_split(&data->uri_protocols, p, ',', -1);
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
+
+	if (data->uri_protocols.nr && !data->writer.use_sideband)
+		string_list_clear(&data->uri_protocols, 0);
 }
 
 static int process_haves(struct oid_array *haves, struct oid_array *common,
@@ -1514,8 +1566,13 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data, &want_obj);
 
-			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj);
+			if (data.uri_protocols.nr) {
+				create_pack_file(&have_obj, &want_obj,
+						 &data.uri_protocols);
+			} else {
+				packet_write_fmt(1, "packfile\n");
+				create_pack_file(&have_obj, &want_obj, NULL);
+			}
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
@@ -1536,6 +1593,7 @@ int upload_pack_advertise(struct repository *r,
 		int allow_filter_value;
 		int allow_ref_in_want;
 		int allow_sideband_all_value;
+		char *str = NULL;
 
 		strbuf_addstr(value, "shallow");
 
@@ -1557,6 +1615,14 @@ int upload_pack_advertise(struct repository *r,
 					   &allow_sideband_all_value) &&
 		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
+
+		if (!repo_config_get_string(the_repository,
+					    "uploadpack.blobpackfileuri",
+					    &str) &&
+		    str) {
+			strbuf_addstr(value, " packfile-uris");
+			free(str);
+		}
 	}
 
 	return 1;
-- 
2.19.0.271.gfe8321ec05.dirty

