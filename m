Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070A41F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfAPT2V (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:28:21 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44514 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfAPT2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:28:20 -0500
Received: by mail-qt1-f202.google.com with SMTP id j5so6570493qtk.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3qIlV0AGO7UUDxF5/MaZh2WPlDf9Wi4VKm5cBHBUbiM=;
        b=bYlyst9IUgMERA4w63tm4L5ojPXyfoR1/RXnUHF18+ORD+nv5Z3u+IdJkK2HMFP8xQ
         jcTZ5zaa/1XnzVQQIqN0eOeyH4iIhz4KBKCSIjUbVcvOmyZfaRAw1iU8CaMFiI3OZ67M
         LWziy15VpKSwADjRmtbpB9xvAVtSlXPuxBEW41gCdSCHbGX/RxFk9vFIlIovODFe08se
         QIh4OhDY+CV8FLnh/wxM21jqnAjghsOjm5Ns153YOca9MpIXGciJwCmSPc0svyJN2D3P
         N8fEBHD/xTWdpa7B+JpiVvDsscVghQEVNjarIcEmu7e0BVXXaHurq/D2XE1M82XcIFdy
         g5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3qIlV0AGO7UUDxF5/MaZh2WPlDf9Wi4VKm5cBHBUbiM=;
        b=dRegsmwWfcEI6yCn9JteYw6L3s3rivcpjlN7Gx5apfUgYO00sCG7q0nnqWProBpvi+
         T1FPUvsoiCAd+H0U9X1ChTITdo6gM4ECqhlM/tcXisl9l9vpSCFMuzrSUOfVY3eV2evs
         0gS2JJSFBS7kYtwQT+1IRYEkmzDHzxh+ow87TREJykBDyMpaSTMDE9efDoOjqM74BZgz
         +9aF+oFcVe/Xhaj73fBO4TEhD/wUY8QjynJxaWDFyaZYIViaSjMjDhJli5PNw8fPgNEc
         AnmmOyNMqzd522Zn+oeGli9fqZ4TszjxwcVmZ6GOn7QX3fJ0x6WB90/VUOwOZqyQ5ww6
         RRkg==
X-Gm-Message-State: AJcUukfkw8xmycMiAltmCz5xiN8tA8I7ATArMR3yNNCzRBJhr0zMjwKr
        neOs3SmJ0elK7R7pEo9E4qcVnlAPeu8l5t/URLnzAVMdKwEhkJ9Ywv4Qa6F25klLPDNCr0wguxA
        JUFM58b0fL7M8ccH2oYiCT/6Jw85rUY4IfkJYEoaem47+xZn5EqWFCFBsTiOx6hO8sovy6PFT+U
        64
X-Google-Smtp-Source: ALg8bN5vuoCRu2DQCkDF+zmYdeVGZJ7axAtnFHPbRy/YnXvHs+3Dr2IQ1DXUt8w64ekVNQriLcs1T/EpHdaiQCTCQtjg
X-Received: by 2002:a0c:8b4d:: with SMTP id d13mr5943947qvc.2.1547666899268;
 Wed, 16 Jan 2019 11:28:19 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:28:11 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <cover.1547666330.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v3 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like previous versions, this is on origin/ms/packet-err-check.

First of all, thanks to those who noticed the issue with t5409. I have
merged sg/stress-test and ran:

    make DEVELOPER=1 && (cd t && sh ./t5409-col*.sh --stress)

with no issues.

demultiplex_sideband() now requires its caller to maintain a strbuf,
since progress messages can be split across packets. I have also changed
the API of demultiplex_sideband() to hopefully make things clearer.

As for keepalive packets, I think it's best if we state that the remote
should use 0005\2 instead of 0005\1, and have made the change
accordingly. This does not need to be treated specially by the client.
(I shouldn't have a problem updating my CDN offloading patches [1] to
use 0005\2 before the packfile starts and 0005\1 after the packfile
starts.)

[1] Patches 5-8 of https://public-inbox.org/git/cover.1547244620.git.jonathantanmy@google.com/

Jonathan Tan (4):
  pkt-line: introduce struct packet_writer
  sideband: reverse its dependency on pkt-line
  {fetch,upload}-pack: sideband v2 fetch response
  tests: define GIT_TEST_SIDEBAND_ALL

 Documentation/technical/protocol-v2.txt |  10 ++
 fetch-pack.c                            |  13 +-
 pkt-line.c                              | 107 ++++++++++++--
 pkt-line.h                              |  34 +++++
 sideband.c                              | 178 ++++++++++++------------
 sideband.h                              |  25 +++-
 t/README                                |   5 +
 t/lib-httpd/apache.conf                 |   1 +
 t/t5537-fetch-shallow.sh                |   3 +-
 t/t5701-git-serve.sh                    |   2 +-
 t/t5702-protocol-v2.sh                  |   4 +-
 upload-pack.c                           | 131 ++++++++++-------
 12 files changed, 346 insertions(+), 167 deletions(-)

Interdiff against v2:
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 1b0633f59f..39b40c0dc1 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -314,8 +314,8 @@ included in the client's request:
 	Instruct the server to send the whole response multiplexed, not just
 	the packfile section. All non-flush and non-delim PKT-LINE in the
 	response (not only in the packfile section) will then start with a byte
-	indicating its sideband (1, 2, or 3), and the server may send "0005\1"
-	(a PKT-LINE of sideband 1 with no payload) as a keepalive packet.
+	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
+	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
 
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
diff --git a/pkt-line.c b/pkt-line.c
index 69162f3990..d4b71d3e82 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -442,21 +442,22 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 int recv_sideband(const char *me, int in_stream, int out)
 {
 	char buf[LARGE_PACKET_MAX + 1];
-	int retval = 0;
 	int len;
+	struct strbuf scratch = STRBUF_INIT;
+	enum sideband_type sideband_type;
 
 	while (1) {
-		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		retval = demultiplex_sideband(me, buf, len, 0);
-		switch (retval) {
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
+				  0);
+		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
+					  &sideband_type))
+			continue;
+		switch (sideband_type) {
 		case SIDEBAND_PRIMARY:
 			write_or_die(out, buf + 1, len - 1);
 			break;
-		case SIDEBAND_PROGRESS:
-			/* already written by demultiplex_sideband() */
-			break;
 		default: /* errors: message already written */
-			return retval;
+			return sideband_type;
 		}
 	}
 }
@@ -479,17 +480,19 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
 {
+	struct strbuf scratch = STRBUF_INIT;
+
 	if (reader->line_peeked) {
 		reader->line_peeked = 0;
 		return reader->status;
 	}
 
 	/*
-	 * Consume all progress and keepalive packets until a primary payload
-	 * packet is received
+	 * Consume all progress packets until a primary payload packet is
+	 * received
 	 */
 	while (1) {
-		int retval;
+		enum sideband_type sideband_type;
 		reader->status = packet_read_with_status(reader->fd,
 							 &reader->src_buffer,
 							 &reader->src_len,
@@ -499,29 +502,12 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 							 reader->options);
 		if (!reader->use_sideband)
 			break;
-		retval = demultiplex_sideband(reader->me, reader->buffer,
-					      reader->pktlen, 1);
-		switch (retval) {
-		case SIDEBAND_PROTOCOL_ERROR:
-		case SIDEBAND_REMOTE_ERROR:
-			BUG("should have died in diagnose_sideband");
-		case SIDEBAND_FLUSH:
-			goto nonprogress_received;
-		case SIDEBAND_PRIMARY:
-			if (reader->pktlen != 1)
-				goto nonprogress_received;
-			/*
-			 * Since the packet contains nothing but the sideband
-			 * designator, this is a keepalive packet. Wait for the
-			 * next one.
-			 */
+		if (demultiplex_sideband(reader->me, reader->buffer,
+					 reader->pktlen, 1, &scratch,
+					 &sideband_type))
 			break;
-		default: /* SIDEBAND_PROGRESS */
-			;
-		}
 	}
 
-nonprogress_received:
 	if (reader->status == PACKET_READ_NORMAL)
 		/* Skip the sideband designator if sideband is used */
 		reader->line = reader->use_sideband ?
diff --git a/sideband.c b/sideband.c
index 9d3051e3fe..6a16feb262 100644
--- a/sideband.c
+++ b/sideband.c
@@ -113,11 +113,12 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
+int demultiplex_sideband(const char *me, char *buf, int len,
+			 int die_on_error,
+			 struct strbuf *scratch,
+			 enum sideband_type *sideband_type)
 {
 	static const char *suffix;
-	struct strbuf outbuf = STRBUF_INIT;
-	int retval = 0;
 	const char *b, *brk;
 	int band;
 
@@ -129,14 +130,14 @@ int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
 	}
 
 	if (len == 0) {
-		retval = SIDEBAND_FLUSH;
+		*sideband_type = SIDEBAND_FLUSH;
 		goto cleanup;
 	}
 	if (len < 1) {
-		strbuf_addf(&outbuf,
+		strbuf_addf(scratch,
 			    "%s%s: protocol error: no band designator",
-			    outbuf.len ? "\n" : "", me);
-		retval = SIDEBAND_PROTOCOL_ERROR;
+			    scratch->len ? "\n" : "", me);
+		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
 		goto cleanup;
 	}
 	band = buf[0] & 0xff;
@@ -146,12 +147,11 @@ int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
 	case 3:
 		if (die_on_error)
 			die("remote error: %s", buf + 1);
-
-		strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
 			    DISPLAY_PREFIX);
-		maybe_colorize_sideband(&outbuf, buf + 1, len);
+		maybe_colorize_sideband(scratch, buf + 1, len);
 
-		retval = SIDEBAND_REMOTE_ERROR;
+		*sideband_type = SIDEBAND_REMOTE_ERROR;
 		break;
 	case 2:
 		b = buf + 1;
@@ -167,46 +167,45 @@ int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
 		while ((brk = strpbrk(b, "\n\r"))) {
 			int linelen = brk - b;
 
-			if (!outbuf.len)
-				strbuf_addstr(&outbuf, DISPLAY_PREFIX);
+			if (!scratch->len)
+				strbuf_addstr(scratch, DISPLAY_PREFIX);
 			if (linelen > 0) {
-				maybe_colorize_sideband(&outbuf, b, linelen);
-				strbuf_addstr(&outbuf, suffix);
+				maybe_colorize_sideband(scratch, b, linelen);
+				strbuf_addstr(scratch, suffix);
 			}
 
-			strbuf_addch(&outbuf, *brk);
-			xwrite(2, outbuf.buf, outbuf.len);
-			strbuf_reset(&outbuf);
+			strbuf_addch(scratch, *brk);
+			xwrite(2, scratch->buf, scratch->len);
+			strbuf_reset(scratch);
 
 			b = brk + 1;
 		}
 
 		if (*b) {
-			strbuf_addstr(&outbuf, outbuf.len ?
+			strbuf_addstr(scratch, scratch->len ?
 				    "" : DISPLAY_PREFIX);
-			maybe_colorize_sideband(&outbuf, b, strlen(b));
+			maybe_colorize_sideband(scratch, b, strlen(b));
 		}
-		retval = SIDEBAND_PROGRESS;
-		break;
+		return 0;
 	case 1:
-		retval = SIDEBAND_PRIMARY;
+		*sideband_type = SIDEBAND_PRIMARY;
 		break;
 	default:
-		strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
-			    outbuf.len ? "\n" : "", me, band);
-		retval = SIDEBAND_PROTOCOL_ERROR;
+		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
+			    scratch->len ? "\n" : "", me, band);
+		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
 		break;
 	}
 
 cleanup:
-	if (die_on_error && retval == SIDEBAND_PROTOCOL_ERROR)
-		die("%s", outbuf.buf);
-	if (outbuf.len) {
-		strbuf_addch(&outbuf, '\n');
-		xwrite(2, outbuf.buf, outbuf.len);
+	if (die_on_error && *sideband_type == SIDEBAND_PROTOCOL_ERROR)
+		die("%s", scratch->buf);
+	if (scratch->len) {
+		strbuf_addch(scratch, '\n');
+		xwrite(2, scratch->buf, scratch->len);
 	}
-	strbuf_release(&outbuf);
-	return retval;
+	strbuf_release(scratch);
+	return 1;
 }
 
 /*
diff --git a/sideband.h b/sideband.h
index f75c4fde2a..227740a58e 100644
--- a/sideband.h
+++ b/sideband.h
@@ -1,21 +1,28 @@
 #ifndef SIDEBAND_H
 #define SIDEBAND_H
 
-#define SIDEBAND_PROTOCOL_ERROR -2
-#define SIDEBAND_REMOTE_ERROR -1
-#define SIDEBAND_FLUSH 0
-#define SIDEBAND_PRIMARY 1
-#define SIDEBAND_PROGRESS 2
+enum sideband_type {
+	SIDEBAND_PROTOCOL_ERROR = -2,
+	SIDEBAND_REMOTE_ERROR = -1,
+	SIDEBAND_FLUSH = 0,
+	SIDEBAND_PRIMARY = 1
+};
 
 /*
- * Inspects a multiplexed packet read from the remote and returns which
- * sideband it is for.
+ * Inspects a multiplexed packet read from the remote. If this packet is a
+ * progress packet and thus should not be processed by the caller, returns 0.
+ * Otherwise, returns 1, releases scratch, and sets sideband_type.
  *
- * If SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS,
- * also prints a message (or the formatted contents of the notice in the case
- * of SIDEBAND_PROGRESS) to stderr.
+ * If this packet is SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or a
+ * progress packet, also prints a message to stderr.
+ *
+ * scratch must be a struct strbuf allocated by the caller. It is used to store
+ * progress messages split across multiple packets.
  */
-int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error);
+int demultiplex_sideband(const char *me, char *buf, int len,
+			 int die_on_error,
+			 struct strbuf *scratch,
+			 enum sideband_type *sideband_type);
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
-- 
2.19.0.271.gfe8321ec05.dirty

