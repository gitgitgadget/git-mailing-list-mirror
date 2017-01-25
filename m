Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DB61F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdAYWDl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:41 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33894 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdAYWD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:29 -0500
Received: by mail-pf0-f180.google.com with SMTP id e4so60771952pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=onIEjB7w48WomxXbrfaUH5awGa5rCyliVjnGtxfSjpY=;
        b=DDRp8oGWkS54ajE0EC2R1eA2BK0bagLWx+QpYDhcdj+pNXnTHPGUVJcdYo8kQwt0MM
         qJPGC8asBcrYrOxjpDWai98yQlX7kqX6onB2Z+X9tXV5QzreQ2nf+HUUtPUcusWNnUpp
         WYX/gNkfC7H8ulvwTjsq+CywXQ7EBADV1qDfFPxbw69JvCuwY703oH1jWvdPAXnQTARI
         mvRlgmlFOV2II4ksJoJyjxyaK+u1zeAFt/O7zDnfYIy3Ug+yD6/a/AhIwt375UXglbyn
         zVe8vyskLJ+q8u/0nsc6ivuYq4Okf8QIuqKUsW1/s7J0OdLEP7YM0DgJQiHuPF0sHWeb
         ZdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=onIEjB7w48WomxXbrfaUH5awGa5rCyliVjnGtxfSjpY=;
        b=NzqRUWhalaVGZwMe7vs4OLqCqADzlWhmrMZ0P/YwAeEQWseyJqUpVFWyG7lvVSWWDC
         adLPTAa4V45aWMxezaeayuFp1nB3lIczJYBtn/8fFKDT3He80GlvdqUXLC/SYUILtnIz
         16V3Q5uy02zhpzDu1qMIkFgDCj72UcDukIYWRHLuspU7fch8kWUHIfyESH8UgYQQMOOv
         BUEH77Gy/VZssTrAlxzw8jMrlbJzT/9lYJ5priNu+MoIFIQk8Tn+k5FuqjK5uPoO0lts
         WX4RU9DVNefE3KP1rQBzFeal9ZEJ7S5tKp+/wVWWQhRudUrY6vtf/gLwmk1jcNJ4oUlO
         91tg==
X-Gm-Message-State: AIkVDXKwVOYeXaOH/emrRfl2joJYEX0wGDwl7OKdHH5ncILAFcCiUP/2XBq7oerio3XyoeYS
X-Received: by 10.84.233.136 with SMTP id l8mr6958351plk.169.1485381808205;
        Wed, 25 Jan 2017 14:03:28 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:27 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 11/14] fetch-pack: support want-ref
Date:   Wed, 25 Jan 2017 14:03:04 -0800
Message-Id: <7b01ee955db8b2d9c6c7e641f7f09436938b2af4.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch-pack to use the want-ref mechanism whenever the server
advertises it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c  |   5 +-
 fetch-pack.c          | 173 ++++++++++++++++++++++++++++++++++++--------------
 fetch-pack.h          |   2 +
 t/t5500-fetch-pack.sh |  42 ++++++++++++
 transport.c           |   2 +-
 5 files changed, 175 insertions(+), 49 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 5f14242ae..ae073ab24 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -179,8 +179,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
 	get_ref_array(&sought_refs, &nr_sought_refs, ref, sought, nr_sought);
 
-	ref = fetch_pack(&args, fd, conn, ref, dest, sought_refs, nr_sought_refs,
-			 &shallow, pack_lockfile_ptr);
+	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
+			 sought_refs, nr_sought_refs, &shallow,
+			 pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/fetch-pack.c b/fetch-pack.c
index 8cc85c19f..02149c930 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -219,11 +219,19 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 	}
 }
 
-static enum ack_type get_ack(int fd, unsigned char *result_sha1)
+/*
+ * Reads an ACK or NAK from fd. If wanted_ref_tail is not NULL, also accepts
+ * any "wanted-ref" lines before that ACK or NAK, writing them to
+ * wanted_ref_tail.
+ */
+static enum ack_type get_ack(int fd, unsigned char *result_sha1,
+			     struct ref ***wanted_ref_tail)
 {
 	int len;
-	char *line = packet_read_line(fd, &len);
+	char *line;
 	const char *arg;
+start:
+	line = packet_read_line(fd, &len);
 
 	if (!len)
 		die(_("git fetch-pack: expected ACK/NAK, got EOF"));
@@ -244,7 +252,19 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 			return ACK;
 		}
 	}
-	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
+	if (wanted_ref_tail) {
+		struct object_id oid;
+		if (skip_prefix(line, "wanted-ref ", &arg) &&
+		    !get_sha1_hex(arg, oid.hash) && arg[40] == ' ' && arg[41]) {
+			struct ref *ref = alloc_ref(arg + 41);
+			oidcpy(&ref->old_oid, &oid);
+			**wanted_ref_tail = ref;
+			*wanted_ref_tail = &ref->next;
+			goto start;
+		}
+		die(_("git fetch_pack: expected ACK/NAK or wanted-ref, got '%s'"), line);
+	}
+	die(_("git fetch_pack: expected ACK/NAK, got '%s'"), line);
 }
 
 static void send_request(struct fetch_pack_args *args,
@@ -282,29 +302,55 @@ static int next_flush(struct fetch_pack_args *args, int count)
 	return count;
 }
 
-static int find_common(struct fetch_pack_args *args,
-		       int fd[2], unsigned char *result_sha1,
-		       struct ref *refs)
+static void write_capabilities(struct strbuf *sb,
+			       const struct fetch_pack_args *args)
 {
-	int fetching;
-	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
-	const unsigned char *sha1;
-	unsigned in_vain = 0;
-	int got_continue = 0;
-	int got_ready = 0;
-	struct strbuf req_buf = STRBUF_INIT;
-	size_t state_len = 0;
+	if (multi_ack == 2)     strbuf_addstr(sb, " multi_ack_detailed");
+	if (multi_ack == 1)     strbuf_addstr(sb, " multi_ack");
+	if (no_done)            strbuf_addstr(sb, " no-done");
+	if (use_sideband == 2)  strbuf_addstr(sb, " side-band-64k");
+	if (use_sideband == 1)  strbuf_addstr(sb, " side-band");
+	if (args->deepen_relative) strbuf_addstr(sb, " deepen-relative");
+	if (args->use_thin_pack) strbuf_addstr(sb, " thin-pack");
+	if (args->no_progress)   strbuf_addstr(sb, " no-progress");
+	if (args->include_tag)   strbuf_addstr(sb, " include-tag");
+	if (prefer_ofs_delta)   strbuf_addstr(sb, " ofs-delta");
+	if (deepen_since_ok)    strbuf_addstr(sb, " deepen-since");
+	if (deepen_not_ok)      strbuf_addstr(sb, " deepen-not");
+	if (agent_supported)    strbuf_addf(sb, " agent=%s",
+					    git_user_agent_sanitized());
+}
 
-	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
+static void write_wants(struct strbuf *sb, const struct fetch_pack_args *args,
+			const struct refspec *refspecs, int nr_refspec,
+			struct ref *refs)
+{
+	int capabilities_written = 0;
 
-	for_each_ref(rev_list_insert_ref_oid, NULL);
-	for_each_alternate_ref(insert_one_alternate_ref, NULL);
+	if (refspecs) {
+		int i;
+		for (i = 0; i < nr_refspec; i++) {
+			const char *to_send = (refspecs[i].src && refspecs[i].src[0])
+				? refspecs[i].src : "HEAD";
+			if (i == 0) {
+				struct strbuf c = STRBUF_INIT;
+				write_capabilities(&c, args);
+				packet_buf_write(sb, "want-ref %s%s\n",
+						 to_send, c.buf);
+				strbuf_release(&c);
+			} else
+				packet_buf_write(sb, "want-ref %s\n", to_send);
+
+			/* write everything that refname_match supports */
+			packet_buf_write(sb, "want-ref refs/%s\n", to_send);
+			packet_buf_write(sb, "want-ref refs/tags/%s\n", to_send);
+			packet_buf_write(sb, "want-ref refs/heads/%s\n", to_send);
+			packet_buf_write(sb, "want-ref refs/remotes/%s\n", to_send);
+			packet_buf_write(sb, "want-ref refs/remotes/%s/HEAD\n", to_send);
+		}
+		return;
+	}
 
-	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_oid.hash;
 		const char *remote_hex;
@@ -326,30 +372,41 @@ static int find_common(struct fetch_pack_args *args,
 		}
 
 		remote_hex = sha1_to_hex(remote);
-		if (!fetching) {
+		if (!capabilities_written) {
 			struct strbuf c = STRBUF_INIT;
-			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
-			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
-			if (no_done)            strbuf_addstr(&c, " no-done");
-			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
-			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
-			if (args->deepen_relative) strbuf_addstr(&c, " deepen-relative");
-			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
-			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
-			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
-			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
-			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
-			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
-			if (agent_supported)    strbuf_addf(&c, " agent=%s",
-							    git_user_agent_sanitized());
-			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
+			write_capabilities(&c, args);
+			packet_buf_write(sb, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
+			capabilities_written = 1;
 		} else
-			packet_buf_write(&req_buf, "want %s\n", remote_hex);
-		fetching++;
+			packet_buf_write(sb, "want %s\n", remote_hex);
 	}
+}
+
+static int find_common(struct fetch_pack_args *args,
+		       int fd[2], unsigned char *result_sha1,
+		       struct strbuf *wants, struct ref **wanted_refs)
+{
+	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
+	const unsigned char *sha1;
+	unsigned in_vain = 0;
+	int got_continue = 0;
+	int got_ready = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+	size_t state_len = 0;
+
+	if (args->stateless_rpc && multi_ack == 1)
+		die(_("--stateless-rpc requires multi_ack_detailed"));
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
 
-	if (!fetching) {
+	for_each_ref(rev_list_insert_ref_oid, NULL);
+	for_each_alternate_ref(insert_one_alternate_ref, NULL);
+
+	strbuf_swap(&req_buf, wants);
+
+	if (!req_buf.len) {
 		strbuf_release(&req_buf);
 		packet_flush(fd[1]);
 		return 1;
@@ -435,7 +492,7 @@ static int find_common(struct fetch_pack_args *args,
 
 			consume_shallow_list(args, fd[0]);
 			do {
-				ack = get_ack(fd[0], result_sha1);
+				ack = get_ack(fd[0], result_sha1, NULL);
 				if (ack)
 					print_verbose(args, _("got %s %d %s"), "ack",
 						      ack, sha1_to_hex(result_sha1));
@@ -504,7 +561,9 @@ static int find_common(struct fetch_pack_args *args,
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, fd[0]);
 	while (flushes || multi_ack) {
-		int ack = get_ack(fd[0], result_sha1);
+		struct ref *wr = NULL, **wr_tail = &wr;
+		int ack = get_ack(fd[0], result_sha1, &wr_tail);
+		*wanted_refs = wr;
 		if (ack) {
 			print_verbose(args, _("got %s (%d) %s"), "ack",
 				      ack, sha1_to_hex(result_sha1));
@@ -835,6 +894,7 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
+				 const struct refspec *refspecs, int nr_refspec,
 				 const struct ref **sought, int nr_sought,
 				 struct shallow_info *si,
 				 char **pack_lockfile)
@@ -843,6 +903,10 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	unsigned char sha1[20];
 	const char *agent_feature;
 	int agent_len;
+	int ref_in_want = 0;
+	struct strbuf wants = STRBUF_INIT;
+	struct ref *wanted_refs = NULL;
+	int want_ref_used = 0;
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -907,17 +971,26 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("Server does not support --shallow-exclude"));
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (server_supports("ref-in-want"))
+		ref_in_want = 1;
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(args, fd, sha1, ref) < 0)
+
+	if (ref_in_want && refspecs) {
+		write_wants(&wants, args, refspecs, nr_refspec, NULL);
+		want_ref_used = 1;
+	} else
+		write_wants(&wants, args, NULL, 0, ref);
+	if (find_common(args, fd, sha1, &wants, &wanted_refs) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
 			warning(_("no common commits"));
+	strbuf_release(&wants);
 
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
@@ -932,6 +1005,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
+	if (want_ref_used) {
+		free_refs(ref);
+		return wanted_refs;
+	}
+
+	if (wanted_refs)
+		die("Protocol error: we are not using ref-in-want but server still sends wanted-ref");
 	return ref;
 }
 
@@ -1082,6 +1162,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
+		       const struct refspec *refspecs, int nr_refspec,
 		       const struct ref **sought, int nr_sought,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile)
@@ -1098,8 +1179,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		die(_("no matching remote head"));
 	}
 	prepare_shallow_info(&si, shallow);
-	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-				&si, pack_lockfile);
+	ref_cpy = do_fetch_pack(args, fd, ref, refspecs, nr_refspec,
+				sought, nr_sought, &si, pack_lockfile);
 	reprepare_packed_git();
 	update_shallow(args, ref_cpy, &si);
 	clear_shallow_info(&si);
diff --git a/fetch-pack.h b/fetch-pack.h
index 6e4fdbb68..06eb0fb28 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -5,6 +5,7 @@
 #include "run-command.h"
 
 struct sha1_array;
+struct refspec;
 
 struct fetch_pack_args {
 	const char *uploadpack;
@@ -38,6 +39,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
+		       const struct refspec *refspecs, int nr_refspec,
 		       const struct ref **sought,
 		       int nr_sought,
 		       struct sha1_array *shallow,
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index cb1b7d949..18fe23c97 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -563,6 +563,25 @@ test_expect_success 'fetch-pack can fetch refs using a partial name' '
 	grep "$(printf "%s refs/heads/one" $(git -C server rev-parse --verify one))" actual
 '
 
+test_expect_success 'fetch-pack can fetch refs using a partial name using want-ref' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		git config uploadpack.advertiseRefInWant true
+		test_commit 1 &&
+		test_commit 2 &&
+		git checkout -b one
+	) &&
+	rm -f trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git fetch-pack server one >actual &&
+	echo here &&
+	grep " want-ref " trace &&
+	! grep " want " trace &&
+
+	grep "$(printf "%s refs/heads/one" $(git -C server rev-parse --verify one))" actual
+'
+
 test_expect_success 'fetch-pack can fetch refs using a glob' '
 	rm -rf server &&
 	git init server &&
@@ -585,6 +604,29 @@ test_expect_success 'fetch-pack can fetch refs using a glob' '
 	grep "$(printf "%s refs/heads/onc" $(git -C server rev-parse --verify onc))" actual
 '
 
+test_expect_success 'fetch-pack can fetch refs using a glob using want-ref' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		git config uploadpack.advertiseRefInWant true
+		test_commit 1 &&
+		test_commit 2 &&
+		git checkout -b ona &&
+		git checkout -b onb &&
+		test_commit 3 &&
+		git checkout -b onc
+	) &&
+	rm -f trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git fetch-pack server "refs/heads/on*" >actual &&
+	grep " want-ref " trace &&
+	! grep " want " trace &&
+
+	grep "$(printf "%s refs/heads/ona" $(git -C server rev-parse --verify ona))" actual &&
+	grep "$(printf "%s refs/heads/onb" $(git -C server rev-parse --verify onb))" actual &&
+	grep "$(printf "%s refs/heads/onc" $(git -C server rev-parse --verify onc))" actual
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
diff --git a/transport.c b/transport.c
index 5ed3fc68e..85a4c5369 100644
--- a/transport.c
+++ b/transport.c
@@ -239,7 +239,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, to_fetch, nr_heads, &data->shallow,
+			  dest, NULL, 0, to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
-- 
2.11.0.483.g087da7b7c-goog

