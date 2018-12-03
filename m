Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60526211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLCXh4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:56 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:53621 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:56 -0500
Received: by mail-oi1-f201.google.com with SMTP id w128so9311380oie.20
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zVdl3kFjBloHM1xxX+yiP/ndfBY95o+7TaWwx9wskf0=;
        b=Mn3j1WvOvpSHwcEqX1ekblQ58U3EaOiiMdtd17JeBQGdSQRMSCjJEi0e3QBeWEtcRj
         LtnTyrNEnIwDubwPSMIM4zgoviW496LwQyAdGYp4bRjYM7sbd6VPrQOxTvb0eiwxDtwo
         AMioVs8777gr8AqmpRN5VeXznY39/EB7KsZKqK4MWRD6b1nxu4PecvlOgAfMKvnn3Q8Y
         D7C44JelplJRj9arwPDxEOXhL9gPgwRG3bkb2J7MypYnft+2pYbaFkfhint/sTjLqUkC
         15qKUdDXyS/zG5ujgaHtsqw4fh/sfGdi6dy7s88kOATjNSOg7lcnMSPal4ETstD35Rg4
         /Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zVdl3kFjBloHM1xxX+yiP/ndfBY95o+7TaWwx9wskf0=;
        b=qdpvvzbrDj9gTXX/z7QpyZ1W37fSEMLSwM2NMcVV9JXUQGe01f0kCznqia+n97UoyT
         uWTdGatHCHpfH/abWwy6AH1fSMHJUy3msKIykj15tfqQ15ohARIshBJEJwh2X67vNOqm
         T274UOyM5TwU+eWoZRXpb4zDmvWAB63zbQRXFD++uFAX60u/bUxv1a1FJk7v8LdYByZ7
         6J+pFR863FZzCP7C44Zh7sJUAQ2H4mRVgqrevIG6fQyP4wNqz0b/TwwYLWh/KNFe/2nv
         4TyoFc17bp7DaFXpsjMWuOScLnqHpUSSqh3Rx7O0lQGUstSJYJ0tln73f3yMMNXqp37k
         bqdg==
X-Gm-Message-State: AA+aEWYTcjNhr2/JyIDj8pi6oDAq/AUIceWW+KNedLkQklBS8AUhA5L3
        +/KLmr4w3iBfszYkpPJTsFS7AEtkt/TnGkuZepjCTlPrHAyD2tFBDknUxX/5CbrYsiQtxn/lAgf
        yMPBIEvrdXvqhKnivoHJs17mnefQuA69RoPOnrnlOFfb43csr6oJ1USlwphi397y7lgR4fhe3wS
        ou
X-Google-Smtp-Source: AFSGD/Wqn42BNs3DS4QNaTKitknt0QDt0IjUA0dz/oFgVekI+ywUbLZJlVivc4uF3JlhPtLfrW0PHuYu5tAqhzAiJETg
X-Received: by 2002:aca:ec82:: with SMTP id k124mr14642973oih.36.1543880275027;
 Mon, 03 Dec 2018 15:37:55 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:38 -0800
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
Message-Id: <707a8181a0e8cd2e21989fa6da59cee38d9fadde.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 5/5] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a partial implementation of upload-pack sending part of its
packfile response as URIs.

The client is not fully implemented - it knows to ignore the
"packfile-uris" section, but because it does not actually fetch those
URIs, the returned packfile is incomplete. A test is included to show
that the appropriate URI is indeed transmitted, and that the returned
packfile is lacking exactly the expected object.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 fetch-pack.c           |  9 ++++++++
 t/t5702-protocol-v2.sh | 25 ++++++++++++++++++++++
 upload-pack.c          | 37 ++++++++++++++++++++++++++++----
 4 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7ea206c08..2abbddd3cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -117,6 +117,15 @@ enum missing_action {
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
 
+struct configured_exclusion {
+	struct oidmap_entry e;
+	char *uri;
+};
+static struct oidmap configured_exclusions;
+
+static int exclude_configured_blobs;
+static struct oidset excluded_by_config;
+
 /*
  * stats
  */
@@ -831,6 +840,23 @@ static off_t write_reused_pack(struct hashfile *f)
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
+		write_in_full(1, ex->uri, strlen(ex->uri));
+		write_in_full(1, "\n", 1);
+	}
+}
+
 static const char no_split_warning[] = N_(
 "disabling bitmap writing, packs are split due to pack.packSizeLimit"
 );
@@ -1124,6 +1150,12 @@ static int want_object_in_pack(const struct object_id *oid,
 		}
 	}
 
+	if (exclude_configured_blobs &&
+	    oidmap_get(&configured_exclusions, oid)) {
+		oidset_insert(&excluded_by_config, oid);
+		return 0;
+	}
+
 	return 1;
 }
 
@@ -2728,6 +2760,19 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		const char *end;
+
+		if (parse_oid_hex(v, &ex->e.oid, &end) || *end != ' ')
+			die(_("value of uploadpack.blobpackfileuri must be "
+			      "of the form '<sha-1> <uri>' (got '%s')"), v);
+		if (oidmap_get(&configured_exclusions, &ex->e.oid))
+			die(_("object already configured in another "
+			      "uploadpack.blobpackfileuri (got '%s')"), v);
+		ex->uri = xstrdup(end + 1);
+		oidmap_put(&configured_exclusions, ex);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -3314,6 +3359,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
+		OPT_BOOL(0, "exclude-configured-blobs", &exclude_configured_blobs,
+			 N_("respect uploadpack.blobpackfileuri")),
 		OPT_END(),
 	};
 
@@ -3487,6 +3534,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		return 0;
 	if (nr_result)
 		prepare_pack(window, depth);
+	write_excluded_by_configs();
 	write_pack_file();
 	if (progress)
 		fprintf_ln(stderr,
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..6e1985ab55 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1413,6 +1413,15 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_wanted_refs(&reader, sought, nr_sought);
 
 			/* get the pack */
+			if (process_section_header(&reader, "packfile-uris", 1)) {
+				/* skip the whole section */
+				process_section_header(&reader, "packfile-uris", 0);
+				while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+					/* do nothing */
+				}
+				if (reader.status != PACKET_READ_DELIM)
+					die("expected DELIM");
+			}
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile))
 				die(_("git fetch-pack: fetch failed."));
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..ccb1fc510e 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -588,6 +588,31 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
+test_expect_success 'part of packfile response provided as URI' '
+	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	echo my-blob >"$HTTPD_DOCUMENT_ROOT_PATH/http_parent/my-blob" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" add my-blob &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" commit -m x &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" hash-object my-blob >h &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" config \
+		"uploadpack.blobpackfileuri" \
+		"$(cat h) https://example.com/a-uri" &&
+
+	# NEEDSWORK: "git clone" fails here because it ignores the URI provided
+	# instead of fetching it.
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" \
+		git -c protocol.version=2 clone \
+		"$HTTPD_URL/smart/http_parent" http_child 2>err &&
+	# Although "git clone" fails, we can still check that the server
+	# provided the URI we requested and that the error message pinpoints
+	# the object that is missing.
+	grep "clone< uri https://example.com/a-uri" log &&
+	test_i18ngrep "did not receive expected object $(cat h)" err
+'
+
 stop_httpd
 
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index aa2589b858..a8eef697ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -104,6 +104,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 struct output_state {
 	char buffer[8193];
 	int used;
+	unsigned packfile_uris_started : 1;
 	unsigned packfile_started : 1;
 	struct strbuf progress_buf;
 };
@@ -129,10 +130,35 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os,
 	}
 	os->used += readsz;
 
-	if (!os->packfile_started) {
-		os->packfile_started = 1;
-		if (use_protocol_v2)
-			packet_write_fmt(1, "packfile\n");
+	while (!os->packfile_started) {
+		char *p;
+		if (os->used >= 4 && !memcmp(os->buffer, "PACK", 4)) {
+			os->packfile_started = 1;
+			if (use_protocol_v2) {
+				if (os->packfile_uris_started)
+					packet_delim(1);
+				packet_write_fmt(1, "packfile\n");
+			}
+			break;
+		}
+		if ((p = memchr(os->buffer, '\n', os->used))) {
+			if (!os->packfile_uris_started) {
+				os->packfile_uris_started = 1;
+				if (!use_protocol_v2)
+					BUG("packfile_uris requires protocol v2");
+				packet_write_fmt(1, "packfile-uris\n");
+			}
+			*p = '\0';
+			packet_write_fmt(1, "uri %s\n", os->buffer);
+
+			os->used -= p - os->buffer + 1;
+			memmove(os->buffer, p, os->used);
+		} else {
+			/*
+			 * Incomplete line.
+			 */
+			return readsz;
+		}
 	}
 
 	if (os->used > 1) {
@@ -205,6 +231,9 @@ static void create_pack_file(const struct object_array *have_obj,
 					 filter_options.filter_spec);
 		}
 	}
+	if (use_protocol_v2)
+		argv_array_push(&pack_objects.args,
+				"--exclude-configured-blobs");
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
-- 
2.19.0.271.gfe8321ec05.dirty

