Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76341F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfAPT23 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:28:29 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:39653 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbfAPT23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:28:29 -0500
Received: by mail-oi1-f201.google.com with SMTP id v184so2159442oie.6
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OQWztLw+DEhHfKH1ViIgKUEbGm+kTom50YytAkQyp+w=;
        b=eTcaX/AigInnAlzS5FIFF25aYC3rpySgUt0EUNRDBXJkMGm5aQ9XLCnHMWVUrSf9ug
         loAOryuQAY4Di29zxYDSgijCYyMmu3XJVmbMB+dzoF1aWJxcp6uIOxOoztKVuvrdeW+X
         Gd2e1U3PGNg6UftW9T6MVr8cWxg29qZ3YEzZJG51662ncKLylr8N/o7hk4kg3EAreHwv
         OsqNiA/kmEDoKlrDrhpDQIcxhBjJ4WrjzeMA57VU7+GzdLQfV43o5I9nNUKTGDa0fzMC
         G45/AoPHV6D0awNRSlA8UVZyenp9tjzYzF9/lZ1mYvysExjzLoqmY8BHcPu9fNfITEaf
         5tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OQWztLw+DEhHfKH1ViIgKUEbGm+kTom50YytAkQyp+w=;
        b=VO7B1wbzSHaXrpT7wyt7wZ7ZxbrBUz9izQt9WqVFzqT3Ya0xmxpxTgPR+BxgMdCGEm
         mbDQAHIPzfOvaGvAUBZLW/wFPnZ8TUYky5qLHByR0sN9OXOlXkSW1omuHevM/KorwwZ+
         aor1YzBMnVW90iUFBqm02Ku9O6yfpO9fH7idwDtae92BeDo3s0rFxNafq8JZ80nmuTzc
         9EviR+5TLs2J/8kLM2exQjCAZ9OyoRhZNpXValCSOpH8PeiW+t92n81TNoFNfgwkki8f
         LSPf3mdlZQebkgvzOsCmD8Rs4afCaWpm1rU4I0okLpIFVYKNCQMjFUwYezgeL3WDBG1f
         g9sQ==
X-Gm-Message-State: AJcUukdZy5yHQKept5ngCUadWbqbrw7Jod1Xe0KW6ASLGBR5rZdNflWI
        V27J4Zj5A6p6HpIdy7NMT+clxM6yqJJL9Z37oliqreKcMr5eImqAYzsoPJBJKabPluKQwvrUl5I
        DYP90JcTWMbof+SfbNP/xJNcWF4cosMDa8UAX2Af217fFYT8YKBhSjDUOVrZkSy/mp4a+Fgod4E
        j8
X-Google-Smtp-Source: ALg8bN6gMLBgPbiQhbOrfQ2uBGwTuCPys3SnehTU4uOpgrNAPEgVmZiKSJSaPXTjOtjSWihryXCAXM47LFLbrvz2YjpP
X-Received: by 2002:aca:504c:: with SMTP id e73mr5977261oib.21.1547666907949;
 Wed, 16 Jan 2019 11:28:27 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:28:14 -0800
In-Reply-To: <cover.1547666330.git.jonathantanmy@google.com>
Message-Id: <d5b7ea8ecee9c0110756d8d8a0060fc2df195ee7.1547666330.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547666330.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v3 3/4] {fetch,upload}-pack: sideband v2 fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a response to a fetch request has sideband support only while
the packfile is being sent, meaning that the server cannot send notices
until the start of the packfile.

Extend sideband support in protocol v2 fetch responses to the whole
response. upload-pack will advertise it if the
uploadpack.allowsidebandall configuration variable is set, and
fetch-pack will automatically request it if advertised.

If the sideband is to be used throughout the whole response, upload-pack
will use it to send errors instead of prefixing a PKT-LINE payload with
"ERR ".

This will be tested in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/protocol-v2.txt | 10 ++++++
 fetch-pack.c                            | 12 +++++--
 pkt-line.c                              | 43 ++++++++++++++++++-------
 pkt-line.h                              |  4 +++
 sideband.c                              |  5 +++
 sideband.h                              |  1 +
 upload-pack.c                           | 16 +++++++++
 7 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..39b40c0dc1 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -307,6 +307,16 @@ the 'wanted-refs' section in the server's response as explained below.
 	particular ref, where <ref> is the full name of a ref on the
 	server.
 
+If the 'sideband-all' feature is advertised, the following argument can be
+included in the client's request:
+
+    sideband-all
+	Instruct the server to send the whole response multiplexed, not just
+	the packfile section. All non-flush and non-delim PKT-LINE in the
+	response (not only in the packfile section) will then start with a byte
+	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
+	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
diff --git a/fetch-pack.c b/fetch-pack.c
index ee0847e6ae..86e9e18901 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1090,7 +1090,8 @@ static int add_haves(struct fetch_negotiator *negotiator,
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
-			      int *haves_to_send, int *in_vain)
+			      int *haves_to_send, int *in_vain,
+			      int sideband_all)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
@@ -1116,6 +1117,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "include-tag");
 	if (prefer_ofs_delta)
 		packet_buf_write(&req_buf, "ofs-delta");
+	if (sideband_all)
+		packet_buf_write(&req_buf, "sideband-all");
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
@@ -1324,6 +1327,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (server_supports_feature("fetch", "sideband-all", 0)) {
+		reader.use_sideband = 1;
+		reader.me = "fetch-pack";
+	}
 
 	while (state != FETCH_DONE) {
 		switch (state) {
@@ -1357,7 +1364,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_SEND_REQUEST:
 			if (send_fetch_request(&negotiator, fd[1], args, ref,
 					       &common,
-					       &haves_to_send, &in_vain))
+					       &haves_to_send, &in_vain,
+					       reader.use_sideband))
 				state = FETCH_GET_PACK;
 			else
 				state = FETCH_PROCESS_ACKS;
diff --git a/pkt-line.c b/pkt-line.c
index 321ff632a5..d4b71d3e82 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -449,7 +449,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 	while (1) {
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
 				  0);
-		if (!demultiplex_sideband(me, buf, len, &scratch,
+		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
 					  &sideband_type))
 			continue;
 		switch (sideband_type) {
@@ -475,25 +475,43 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer = packet_buffer;
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
+	reader->me = "git";
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
 {
+	struct strbuf scratch = STRBUF_INIT;
+
 	if (reader->line_peeked) {
 		reader->line_peeked = 0;
 		return reader->status;
 	}
 
-	reader->status = packet_read_with_status(reader->fd,
-						 &reader->src_buffer,
-						 &reader->src_len,
-						 reader->buffer,
-						 reader->buffer_size,
-						 &reader->pktlen,
-						 reader->options);
+	/*
+	 * Consume all progress packets until a primary payload packet is
+	 * received
+	 */
+	while (1) {
+		enum sideband_type sideband_type;
+		reader->status = packet_read_with_status(reader->fd,
+							 &reader->src_buffer,
+							 &reader->src_len,
+							 reader->buffer,
+							 reader->buffer_size,
+							 &reader->pktlen,
+							 reader->options);
+		if (!reader->use_sideband)
+			break;
+		if (demultiplex_sideband(reader->me, reader->buffer,
+					 reader->pktlen, 1, &scratch,
+					 &sideband_type))
+			break;
+	}
 
 	if (reader->status == PACKET_READ_NORMAL)
-		reader->line = reader->buffer;
+		/* Skip the sideband designator if sideband is used */
+		reader->line = reader->use_sideband ?
+			reader->buffer + 1 : reader->buffer;
 	else
 		reader->line = NULL;
 
@@ -515,6 +533,7 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader)
 void packet_writer_init(struct packet_writer *writer, int dest_fd)
 {
 	writer->dest_fd = dest_fd;
+	writer->use_sideband = 0;
 }
 
 void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
@@ -522,7 +541,8 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\001" : "", fmt, args);
 	va_end(args);
 }
 
@@ -531,7 +551,8 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\003" : "ERR ", fmt, args);
 	va_end(args);
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index a8e92a4b63..ad9a4a2cd7 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -162,6 +162,9 @@ struct packet_reader {
 
 	/* indicates if a line has been peeked */
 	int line_peeked;
+
+	unsigned use_sideband : 1;
+	const char *me;
 };
 
 /*
@@ -201,6 +204,7 @@ extern char packet_buffer[LARGE_PACKET_MAX];
 
 struct packet_writer {
 	int dest_fd;
+	unsigned use_sideband : 1;
 };
 
 void packet_writer_init(struct packet_writer *writer, int dest_fd);
diff --git a/sideband.c b/sideband.c
index e89d677626..6a16feb262 100644
--- a/sideband.c
+++ b/sideband.c
@@ -114,6 +114,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define DUMB_SUFFIX "        "
 
 int demultiplex_sideband(const char *me, char *buf, int len,
+			 int die_on_error,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type)
 {
@@ -144,6 +145,8 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 	len--;
 	switch (band) {
 	case 3:
+		if (die_on_error)
+			die("remote error: %s", buf + 1);
 		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
 			    DISPLAY_PREFIX);
 		maybe_colorize_sideband(scratch, buf + 1, len);
@@ -195,6 +198,8 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 	}
 
 cleanup:
+	if (die_on_error && *sideband_type == SIDEBAND_PROTOCOL_ERROR)
+		die("%s", scratch->buf);
 	if (scratch->len) {
 		strbuf_addch(scratch, '\n');
 		xwrite(2, scratch->buf, scratch->len);
diff --git a/sideband.h b/sideband.h
index 2c4f021645..227740a58e 100644
--- a/sideband.h
+++ b/sideband.h
@@ -20,6 +20,7 @@ enum sideband_type {
  * progress messages split across multiple packets.
  */
 int demultiplex_sideband(const char *me, char *buf, int len,
+			 int die_on_error,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type);
 
diff --git a/upload-pack.c b/upload-pack.c
index 60a26bbbfd..765b7695d2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -71,6 +71,8 @@ static int allow_filter;
 static int allow_ref_in_want;
 static struct list_objects_filter_options filter_options;
 
+static int allow_sideband_all;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -1046,6 +1048,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
+		allow_sideband_all = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_REPO) {
@@ -1284,6 +1288,11 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
+		if (allow_sideband_all && !strcmp(arg, "sideband-all")) {
+			data->writer.use_sideband = 1;
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
@@ -1496,6 +1505,7 @@ int upload_pack_advertise(struct repository *r,
 	if (value) {
 		int allow_filter_value;
 		int allow_ref_in_want;
+		int allow_sideband_all_value;
 
 		strbuf_addstr(value, "shallow");
 
@@ -1510,6 +1520,12 @@ int upload_pack_advertise(struct repository *r,
 					 &allow_ref_in_want) &&
 		    allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
+
+		if (!repo_config_get_bool(the_repository,
+					 "uploadpack.allowsidebandall",
+					 &allow_sideband_all_value) &&
+		    allow_sideband_all_value)
+			strbuf_addstr(value, " sideband-all");
 	}
 
 	return 1;
-- 
2.19.0.271.gfe8321ec05.dirty

