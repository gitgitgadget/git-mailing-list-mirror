Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4148D211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfAKWSp (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:45 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48237 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:45 -0500
Received: by mail-qk1-f201.google.com with SMTP id p79so10737392qki.15
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n4H8iGSWXpqzX+fstyFb2cmBl2ExCJnOpQet/+NtrPw=;
        b=naVOF7iyDHb6OUOhWZM3LA8SZez3idGbowrt1oooqb1jOuyuhg83+1OEg7UH+NyWto
         SPgSlksU4DIB9ItqeX5Si7R5bgTe9K44lPH32vokCMZQnUWLJfyFAkRVJ2s2OKtAXqfv
         iMug5/2sMKg6ogNrauReQklKO2+bW09o3CdJUk6erxE53rFUhlybqy8P/Qd8i31lMkYa
         b6NRq/B2ctfIhfuz8YBp+ifh5ZBSZM0uwIvtv2URIIUQIz8VGElZNUCK5jKvjedsO/Ks
         Iiz6mQrAtQ+Nl5xLHmW1cq2OXFjRjIb97QjjyOL9/Yp1++KX4RTquIRCRQpv9IhS4nq5
         Vcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n4H8iGSWXpqzX+fstyFb2cmBl2ExCJnOpQet/+NtrPw=;
        b=DfuOfTrmbHh+Xn5HukudsS/zinzh9c+d7BR3WPLhvuHeymGLUYgr7dQ4r4Dc4AG9hV
         695J5zKbUCApCkVl/HTpEpnuK0qMVH4uWB4fGwKYSwC3i/MF4WMixhNM98QU/ecwyZ0E
         mZaYYHW6225g8UwILkXeSMw8BG52xjmM3ERJ/Un+ZJWyiaS7rDfYx6/MvsftCetnE/YW
         b/GS0kiE6QlZ2MxvHQvFa6q9cYQCkb64OThw6MuDv5zFwbXQggPKCNULmScK21pf/8gl
         Xa+U2fc5FShNW6q4a7A2sLWgoB3/e24bMYwNI7/cmUqvon040FUo5jigL3l+bPSKJrok
         ooZA==
X-Gm-Message-State: AJcUukettm+BKl4rM033UU5GJvSw46+/Z5Lq4LYZZbQ+Gw0b2y59yFoK
        FH7khunl1IoHgff5TolgjuA5qna2Xd7vEo4l3looycS5NnBN0BvQZFW4ubLViZAf2hVlziwqBaT
        4pl4UkluSmfwf1SojpQJm4c5rKpgUHesAKzBinFoFRQIm3m4fIDQzdNA9BetLtfEEDrCgDyoXRy
        84
X-Google-Smtp-Source: ALg8bN4NHtbzmYR9OwIlwdgCrGwHn8oCBLrioUlVPEYTPrCLo6nNOOceLY0SUu+vKTZMCqzxWiO2UyJ87d/MID/f89Q+
X-Received: by 2002:ac8:225d:: with SMTP id p29mr1562484qtp.48.1547245123468;
 Fri, 11 Jan 2019 14:18:43 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:16 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <673b928b4158b0aecca843302483b48da5ed8d35.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 3/4] {fetch,upload}-pack: sideband v2 fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
---
 Documentation/technical/protocol-v2.txt | 10 +++++
 fetch-pack.c                            | 12 +++++-
 pkt-line.c                              | 51 +++++++++++++++++++------
 pkt-line.h                              |  4 ++
 sideband.c                              |  7 +++-
 sideband.h                              |  2 +-
 upload-pack.c                           | 16 ++++++++
 7 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..1b0633f59f 100644
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
+	indicating its sideband (1, 2, or 3), and the server may send "0005\1"
+	(a PKT-LINE of sideband 1 with no payload) as a keepalive packet.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
diff --git a/fetch-pack.c b/fetch-pack.c
index 3f9626dbf7..b89199891d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1125,7 +1125,8 @@ static int add_haves(struct fetch_negotiator *negotiator,
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
-			      int *haves_to_send, int *in_vain)
+			      int *haves_to_send, int *in_vain,
+			      int sideband_all)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
@@ -1151,6 +1152,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "include-tag");
 	if (prefer_ofs_delta)
 		packet_buf_write(&req_buf, "ofs-delta");
+	if (sideband_all)
+		packet_buf_write(&req_buf, "sideband-all");
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
@@ -1359,6 +1362,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (server_supports_feature("fetch", "sideband-all", 0)) {
+		reader.use_sideband = 1;
+		reader.me = "fetch-pack";
+	}
 
 	while (state != FETCH_DONE) {
 		switch (state) {
@@ -1392,7 +1399,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index ebdc6c2530..71b17e6b93 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -447,7 +447,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		retval = diagnose_sideband(me, buf, len);
+		retval = diagnose_sideband(me, buf, len, 0);
 		switch (retval) {
 			case SIDEBAND_PRIMARY:
 				write_or_die(out, buf + 1, len - 1);
@@ -483,16 +483,42 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 		return reader->status;
 	}
 
-	reader->status = packet_read_with_status(reader->fd,
-						 &reader->src_buffer,
-						 &reader->src_len,
-						 reader->buffer,
-						 reader->buffer_size,
-						 &reader->pktlen,
-						 reader->options);
+	while (1) {
+		int retval;
+		reader->status = packet_read_with_status(reader->fd,
+							 &reader->src_buffer,
+							 &reader->src_len,
+							 reader->buffer,
+							 reader->buffer_size,
+							 &reader->pktlen,
+							 reader->options);
+		if (!reader->use_sideband)
+			break;
+		retval = diagnose_sideband(reader->me, reader->buffer,
+					   reader->pktlen, 1);
+		switch (retval) {
+			case SIDEBAND_PROTOCOL_ERROR:
+			case SIDEBAND_REMOTE_ERROR:
+				BUG("should have died in diagnose_sideband");
+			case SIDEBAND_FLUSH:
+				goto nonprogress;
+			case SIDEBAND_PRIMARY:
+				if (reader->pktlen != 1)
+					goto nonprogress;
+				/*
+				 * Since pktlen is 1, this is a keepalive
+				 * packet. Wait for the next one.
+				 */
+				break;
+			default: /* SIDEBAND_PROGRESS */
+				;
+		}
+	}
 
+nonprogress:
 	if (reader->status == PACKET_READ_NORMAL)
-		reader->line = reader->buffer;
+		reader->line = reader->use_sideband ?
+			reader->buffer + 1 : reader->buffer;
 	else
 		reader->line = NULL;
 
@@ -514,6 +540,7 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader)
 void packet_writer_init(struct packet_writer *writer, int dest_fd)
 {
 	writer->dest_fd = dest_fd;
+	writer->use_sideband = 0;
 }
 
 void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
@@ -521,7 +548,8 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\1" : "", fmt, args);
 	va_end(args);
 }
 
@@ -530,7 +558,8 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\3" : "ERR ", fmt, args);
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
index 842a92e975..cbeab380ae 100644
--- a/sideband.c
+++ b/sideband.c
@@ -113,7 +113,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int diagnose_sideband(const char *me, char *buf, int len)
+int diagnose_sideband(const char *me, char *buf, int len, int die_on_error)
 {
 	static const char *suffix;
 	struct strbuf outbuf = STRBUF_INIT;
@@ -144,6 +144,9 @@ int diagnose_sideband(const char *me, char *buf, int len)
 	len--;
 	switch (band) {
 	case 3:
+		if (die_on_error)
+			die("remote error: %s", buf + 1);
+
 		strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
 			    DISPLAY_PREFIX);
 		maybe_colorize_sideband(&outbuf, buf + 1, len);
@@ -196,6 +199,8 @@ int diagnose_sideband(const char *me, char *buf, int len)
 	}
 
 cleanup:
+	if (die_on_error && retval == SIDEBAND_PROTOCOL_ERROR)
+		die("%s", outbuf.buf);
 	if (outbuf.len) {
 		strbuf_addch(&outbuf, '\n');
 		xwrite(2, outbuf.buf, outbuf.len);
diff --git a/sideband.h b/sideband.h
index a56cd86287..3786670694 100644
--- a/sideband.h
+++ b/sideband.h
@@ -16,7 +16,7 @@
  * prints a message (or the formatted contents of the notice in the case of
  * SIDEBAND_PROGRESS) to stderr.
  */
-int diagnose_sideband(const char *me, char *buf, int len);
+int diagnose_sideband(const char *me, char *buf, int len, int die_on_error);
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
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

