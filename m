Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE76C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C75E2078E
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcuy/7Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFMNns (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMNnm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 09:43:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B45C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 06:43:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so11685365qkb.6
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY9mb7o0hG5P32ksMLk25mmmYtiiWDj7ux1mjalmJG8=;
        b=Qcuy/7Ot/CaWTlRUeQYfzDTQEZ2IKhUVxytlkYM3wDCYDcfHuSRNaTjTaPmwmx1hEV
         +SUBtdNaGVs4akQXJzq6RlmLALi8K4SMq2suQparHk4LFFmtDzm0pCaAOIxK/j8JylvJ
         L+jJgGJMkpMoPPzlALiTMVBDVeWfMSaZtEPWHOonZjDClMVz2P+9XCGn9+1faV3sLJkd
         lxHCnBlf+wRMytPjyu+DUL5AM0CgDW6e7wcL34SmTYHMDUtwM5efiafRlpRzbIf9xs/d
         LzoTd23PB5HbhANnVTT/+mDy3HGtF7wYl+5NC+gic8IQBHAnnfPaqDl/XFtPAbkXJ3lj
         SK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY9mb7o0hG5P32ksMLk25mmmYtiiWDj7ux1mjalmJG8=;
        b=rLnQI/outyDwiqYBJ01R25EqjJ/J8wnluY69grpQdfV9v3ZTM0q5Z8DXvpGXgfLd4R
         pkFNF9+Lr65fqsmN1CxnMptxdo3zy4NO+7OMKO0F4rHO/RJOonPwv8aEkVCGC9X+RB0V
         U9mYavblMI5NFcK3xppACSDGtu008n3ZmQIgZNgFeHo0cErHNoyDTMwfX1CcU116+qFg
         gfdkzh1blKRuofPD2/bk9rgCZOWrMjprUsLE3yiYbA12n5/aXmsnwbxqIT6J3aiCGVZW
         oVDU0ot3AKKYiYMnx/RVpTZ47MzPpDfoRwP8NoSYGCqGvvsOR5d4wxlEyEpSCre/a42o
         ut2w==
X-Gm-Message-State: AOAM53297UU8BNP+mQP/1M0fxJH7gXJr0Q3OlUPWBD1YeMIoSh4G9jSQ
        a74LMgOojj0Ks7tKuRqXlcXNfNXtgE8=
X-Google-Smtp-Source: ABdhPJxht8ilHwrhqzO8jPMOCtiSYNeVpILICSSL9WzqAUsSDO6fscOh0c+wiYRqTY4+Wy3ekD+6Fw==
X-Received: by 2002:a37:a593:: with SMTP id o141mr7496054qke.0.1592055815860;
        Sat, 13 Jun 2020 06:43:35 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d56sm7336426qtb.54.2020.06.13.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 06:43:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] pkt-line: extract out PACKET_HEADER_SIZE
Date:   Sat, 13 Jun 2020 09:43:22 -0400
Message-Id: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In pkt-line and remote-curl, we have many instances of magic `4`
literals floating around which represent the number of bytes in the
packet line length header. Instead of using these magic numbers, replace
them with constant expressions.

In most cases, replace the `4` with `PACKET_HEADER_SIZE`. However, in
the case where there's a `char array[PACKET_HEADER_SIZE]`  and we are
reading data into it, replace the `4` with a `sizeof(array)` so that
it's clear that the logic has something to do with that array.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c    | 50 +++++++++++++++++++++++++-------------------------
 pkt-line.h    |  6 ++++--
 remote-curl.c | 30 +++++++++++++++---------------
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8f9bc68ee2..245a56712f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -87,43 +87,43 @@ static void packet_trace(const char *buf, unsigned int len, int write)
  */
 void packet_flush(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
+	packet_trace("0000", PACKET_HEADER_SIZE, 1);
+	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
 		die_errno(_("unable to write flush packet"));
 }
 
 void packet_delim(int fd)
 {
-	packet_trace("0001", 4, 1);
-	if (write_in_full(fd, "0001", 4) < 0)
+	packet_trace("0001", PACKET_HEADER_SIZE, 1);
+	if (write_in_full(fd, "0001", PACKET_HEADER_SIZE) < 0)
 		die_errno(_("unable to write delim packet"));
 }
 
 void packet_response_end(int fd)
 {
-	packet_trace("0002", 4, 1);
-	if (write_in_full(fd, "0002", 4) < 0)
+	packet_trace("0002", PACKET_HEADER_SIZE, 1);
+	if (write_in_full(fd, "0002", PACKET_HEADER_SIZE) < 0)
 		die_errno(_("unable to write stateless separator packet"));
 }
 
 int packet_flush_gently(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
+	packet_trace("0000", PACKET_HEADER_SIZE, 1);
+	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
 		return error(_("flush packet write failed"));
 	return 0;
 }
 
 void packet_buf_flush(struct strbuf *buf)
 {
-	packet_trace("0000", 4, 1);
-	strbuf_add(buf, "0000", 4);
+	packet_trace("0000", PACKET_HEADER_SIZE, 1);
+	strbuf_add(buf, "0000", PACKET_HEADER_SIZE);
 }
 
 void packet_buf_delim(struct strbuf *buf)
 {
-	packet_trace("0001", 4, 1);
-	strbuf_add(buf, "0001", 4);
+	packet_trace("0001", PACKET_HEADER_SIZE, 1);
+	strbuf_add(buf, "0001", PACKET_HEADER_SIZE);
 }
 
 void set_packet_header(char *buf, int size)
@@ -153,7 +153,7 @@ static void format_packet(struct strbuf *out, const char *prefix,
 		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&out->buf[orig_len], n);
-	packet_trace(out->buf + orig_len + 4, n - 4, 1);
+	packet_trace(out->buf + orig_len + PACKET_HEADER_SIZE, n - PACKET_HEADER_SIZE, 1);
 }
 
 static int packet_write_fmt_1(int fd, int gently, const char *prefix,
@@ -199,13 +199,13 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	static char packet_write_buffer[LARGE_PACKET_MAX];
 	size_t packet_size;
 
-	if (size > sizeof(packet_write_buffer) - 4)
+	if (size > sizeof(packet_write_buffer) - PACKET_HEADER_SIZE)
 		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
-	packet_size = size + 4;
+	packet_size = size + PACKET_HEADER_SIZE;
 	set_packet_header(packet_write_buffer, packet_size);
-	memcpy(packet_write_buffer + 4, buf, size);
+	memcpy(packet_write_buffer + PACKET_HEADER_SIZE, buf, size);
 	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
 		return error(_("packet write failed"));
 	return 0;
@@ -313,7 +313,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	return ret;
 }
 
-int packet_length(const char lenbuf_hex[4])
+int packet_length(const char lenbuf_hex[PACKET_HEADER_SIZE])
 {
 	int val = hex2chr(lenbuf_hex);
 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
@@ -325,9 +325,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						int options)
 {
 	int len;
-	char linelen[4];
+	char linelen[PACKET_HEADER_SIZE];
 
-	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
+	if (get_packet_data(fd, src_buffer, src_len, linelen, sizeof(linelen), options) < 0) {
 		*pktlen = -1;
 		return PACKET_READ_EOF;
 	}
@@ -337,22 +337,22 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	if (len < 0) {
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
-		packet_trace("0000", 4, 0);
+		packet_trace("0000", PACKET_HEADER_SIZE, 0);
 		*pktlen = 0;
 		return PACKET_READ_FLUSH;
 	} else if (len == 1) {
-		packet_trace("0001", 4, 0);
+		packet_trace("0001", PACKET_HEADER_SIZE, 0);
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len == 2) {
-		packet_trace("0002", 4, 0);
+		packet_trace("0002", PACKET_HEADER_SIZE, 0);
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
-	} else if (len < 4) {
+	} else if (len < PACKET_HEADER_SIZE) {
 		die(_("protocol error: bad line length %d"), len);
 	}
 
-	len -= 4;
+	len -= sizeof(linelen);
 	if ((unsigned)len >= size)
 		die(_("protocol error: bad line length %d"), len);
 
@@ -370,7 +370,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
-		die(_("remote error: %s"), buffer + 4);
+		die(_("remote error: %s"), buffer + PACKET_HEADER_SIZE);
 
 	*pktlen = len;
 	return PACKET_READ_NORMAL;
diff --git a/pkt-line.h b/pkt-line.h
index 5b373fe4cd..d6121b8044 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -5,6 +5,8 @@
 #include "strbuf.h"
 #include "sideband.h"
 
+#define PACKET_HEADER_SIZE 4
+
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
@@ -82,7 +84,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
  * If lenbuf_hex contains non-hex characters, return -1. Otherwise, return the
  * numeric value of the length header.
  */
-int packet_length(const char lenbuf_hex[4]);
+int packet_length(const char lenbuf_hex[PACKET_HEADER_SIZE]);
 
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
@@ -211,7 +213,7 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
-#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - PACKET_HEADER_SIZE)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 struct packet_writer {
diff --git a/remote-curl.c b/remote-curl.c
index 75532a8bae..bac295c5bc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -536,7 +536,7 @@ struct rpc_state {
 	unsigned initial_buffer : 1;
 
 	/*
-	 * Whenever a pkt-line is read into buf, append the 4 characters
+	 * Whenever a pkt-line is read into buf, append the PACKET_HEADER_SIZE characters
 	 * denoting its length before appending the payload.
 	 */
 	unsigned write_line_lengths : 1;
@@ -556,7 +556,7 @@ struct rpc_state {
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
  * enough space, 0 otherwise.
  *
- * If rpc->write_line_lengths is true, appends the line length as a 4-byte
+ * If rpc->write_line_lengths is true, appends the line length as a PACKET_HEADER_SIZE-byte
  * hexadecimal string before appending the result described above.
  *
  * Writes the total number of bytes appended into appended.
@@ -569,8 +569,8 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 	int pktlen_raw;
 
 	if (rpc->write_line_lengths) {
-		left = rpc->alloc - rpc->len - 4;
-		buf = rpc->buf + rpc->len + 4;
+		left = rpc->alloc - rpc->len - PACKET_HEADER_SIZE;
+		buf = rpc->buf + rpc->len + PACKET_HEADER_SIZE;
 	} else {
 		left = rpc->alloc - rpc->len;
 		buf = rpc->buf + rpc->len;
@@ -582,7 +582,7 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 	*status = packet_read_with_status(rpc->out, NULL, NULL, buf,
 			left, &pktlen_raw, options);
 	if (*status != PACKET_READ_EOF) {
-		*appended = pktlen_raw + (rpc->write_line_lengths ? 4 : 0);
+		*appended = pktlen_raw + (rpc->write_line_lengths ? PACKET_HEADER_SIZE : 0);
 		rpc->len += *appended;
 	}
 
@@ -593,13 +593,13 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 				die(_("shouldn't have EOF when not gentle on EOF"));
 			break;
 		case PACKET_READ_NORMAL:
-			set_packet_header(buf - 4, *appended);
+			set_packet_header(buf - PACKET_HEADER_SIZE, *appended);
 			break;
 		case PACKET_READ_DELIM:
-			memcpy(buf - 4, "0001", 4);
+			memcpy(buf - PACKET_HEADER_SIZE, "0001", PACKET_HEADER_SIZE);
 			break;
 		case PACKET_READ_FLUSH:
-			memcpy(buf - 4, "0000", 4);
+			memcpy(buf - PACKET_HEADER_SIZE, "0000", PACKET_HEADER_SIZE);
 			break;
 		case PACKET_READ_RESPONSE_END:
 			die(_("remote server sent stateless separator"));
@@ -682,7 +682,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 #endif
 
 struct check_pktline_state {
-	char len_buf[4];
+	char len_buf[PACKET_HEADER_SIZE];
 	int len_filled;
 	int remaining;
 };
@@ -691,7 +691,7 @@ static void check_pktline(struct check_pktline_state *state, const char *ptr, si
 {
 	while (size) {
 		if (!state->remaining) {
-			int digits_remaining = 4 - state->len_filled;
+			int digits_remaining = sizeof(state->len_buf) - state->len_filled;
 			if (digits_remaining > size)
 				digits_remaining = size;
 			memcpy(&state->len_buf[state->len_filled], ptr, digits_remaining);
@@ -699,16 +699,16 @@ static void check_pktline(struct check_pktline_state *state, const char *ptr, si
 			ptr += digits_remaining;
 			size -= digits_remaining;
 
-			if (state->len_filled == 4) {
+			if (state->len_filled == sizeof(state->len_buf)) {
 				state->remaining = packet_length(state->len_buf);
 				if (state->remaining < 0) {
 					die(_("remote-curl: bad line length character: %.4s"), state->len_buf);
 				} else if (state->remaining == 2) {
 					die(_("remote-curl: unexpected response end packet"));
-				} else if (state->remaining < 4) {
+				} else if (state->remaining < sizeof(state->len_buf)) {
 					state->remaining = 0;
 				} else {
-					state->remaining -= 4;
+					state->remaining -= sizeof(state->len_buf);
 				}
 				state->len_filled = 0;
 			}
@@ -804,7 +804,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, PACKET_HEADER_SIZE);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
@@ -1469,7 +1469,7 @@ int cmd_main(int argc, const char **argv)
 			parse_fetch(&buf);
 
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
-			int for_push = !!strstr(buf.buf + 4, "for-push");
+			int for_push = !!strstr(buf.buf + PACKET_HEADER_SIZE, "for-push");
 			output_refs(get_refs(for_push));
 
 		} else if (starts_with(buf.buf, "push ")) {
-- 
2.27.0.132.g321788e831

