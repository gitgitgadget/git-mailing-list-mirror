Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABFC9211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAKWSm (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:42 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40465 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:42 -0500
Received: by mail-qt1-f202.google.com with SMTP id 42so17792556qtr.7
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sv1aZi3YF+NGNzBUA3ciALmHzEru+YxmhOo45rDzMTw=;
        b=jBpvSFtO4Ohhj/cA4KXcyNa9J52TH6VHDCok8jIfz0LG921vklyPBLc6LJJ/kkNSgu
         0lXXQ7ldByHiQtXPtgF06acvs4cC8V/4X880v6KtwkZkkxGgsTNlWs7wjC/byKb/wv7I
         6yZikqHwctGD0IEI5T+DuaK3RKhfYuLI95GqdjwYi3sWl7zIWYPVj/olj5zMf2A22khU
         pI8MiW871/Pn3vmsUeEudl/F3SpTR/AA+61duV4A/oqjU31Hm/ka0HpooXyYWdCjus6Z
         HizrRShQk6zDZTfWPxpXXsY6czkVFrUe1kHZDHSXOe9oWk6vrbYLWzrL8f+hIsPggjUW
         CkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sv1aZi3YF+NGNzBUA3ciALmHzEru+YxmhOo45rDzMTw=;
        b=WSzsso0cLX9QBSjBAutcA//gR5+RhGIbB96T91TG1wCOhQnsvwSjdEJcWiDUnztcgk
         WRgdmB++oICRLzqYC33BO6tgG3tgQe8rrVIVlfPXBBfoHwkKNs31oxCptmacvk2CmLSD
         r1ptdNPj0RbMA3o2YSiINMoGZHgCPHmZpaH3nGC4s/kTYJ5625/zVcBzVmFJM6VdmEl4
         +O3GzC1meBoOmUqovfyplXPz4ugl7BlDqe7ptsh/jKd/9Oulg78hPRkg1C486Y5zaRZX
         Uo37DkAULoKA0bFE3TC61OjUg5Jz+wmqfUxqGir2juGtFk44qqnJBO6ucocT4qU8PI54
         VXvQ==
X-Gm-Message-State: AJcUukcR8IdFKrA9NhqYRuwqBUeWL/GUkk7YwFQWq0nAckT7sxjigTUM
        71hHZL7nw3G+X32qi39vfcRlLmidsNtkjq/OA7CZ1RTQ+IAZyTSVCML9EflMvkSOs3Puw8/fwSn
        MSN80Fl7cXvA/zsmHtbMf9izQx/JP6l2VNVwjyQ55g4tIfdf/Pa9B3yQY3+wS4RAWHKincPbNvm
        Wp
X-Google-Smtp-Source: ALg8bN4a/Uo8fBP3hjd+HIj3OGIVWX97T3pbWeIt1U0DkawwkNXIA71eIq4Hpg0cslMex01giaU3Cap5jbGLeM909o3J
X-Received: by 2002:ac8:3364:: with SMTP id u33mr1528939qta.56.1547245120964;
 Fri, 11 Jan 2019 14:18:40 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:15 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <4079a1f110086bd412fb4f56bc8b7f8a6a7a8f9f.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will teach struct packet_reader a new field that, if
set, instructs it to interpret read data as multiplexed. This will
create a dependency from pkt-line to sideband.

To avoid a circular dependency, split recv_sideband() into 2 parts: the
reading loop (left in recv_sideband()) and the processing of the
contents (in diagnose_sideband()), and move the former into pkt-line.
This reverses the direction of dependency: sideband no longer depends on
pkt-line, and pkt-line now depends on sideband.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pkt-line.c |  22 ++++++++
 pkt-line.h |  16 ++++++
 sideband.c | 156 +++++++++++++++++++++++++----------------------------
 sideband.h |  15 +++++-
 4 files changed, 125 insertions(+), 84 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 9d3e402d41..ebdc6c2530 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -439,6 +439,28 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 	return sb_out->len - orig_len;
 }
 
+int recv_sideband(const char *me, int in_stream, int out)
+{
+	char buf[LARGE_PACKET_MAX + 1];
+	int retval = 0;
+	int len;
+
+	while (1) {
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
+		retval = diagnose_sideband(me, buf, len);
+		switch (retval) {
+			case SIDEBAND_PRIMARY:
+				write_or_die(out, buf + 1, len - 1);
+				break;
+			case SIDEBAND_PROGRESS:
+				/* already written by diagnose_sideband() */
+				break;
+			default: /* flush or error */
+				return retval;
+		}
+	}
+}
+
 /* Packet Reader Functions */
 void packet_reader_init(struct packet_reader *reader, int fd,
 			char *src_buffer, size_t src_len,
diff --git a/pkt-line.h b/pkt-line.h
index 023ad2951d..a8e92a4b63 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "sideband.h"
 
 /*
  * Write a packetized stream, where each line is preceded by
@@ -120,6 +121,21 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
  */
 ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
 
+/*
+ * Receive multiplexed output stream over git native protocol.
+ * in_stream is the input stream from the remote, which carries data
+ * in pkt_line format with band designator.  Demultiplex it into out
+ * and err and return error appropriately.  Band #1 carries the
+ * primary payload.  Things coming over band #2 is not necessarily
+ * error; they are usually informative message on the standard error
+ * stream, aka "verbose").  A message over band #3 is a signal that
+ * the remote died unexpectedly.  A flush() concludes the stream.
+ *
+ * Returns SIDEBAND_FLUSH upon a normal conclusion, and SIDEBAND_PROTOCOL_ERROR
+ * or SIDEBAND_REMOTE_ERROR if an error occurred.
+ */
+int recv_sideband(const char *me, int in_stream, int out);
+
 struct packet_reader {
 	/* source file descriptor */
 	int fd;
diff --git a/sideband.c b/sideband.c
index 368647acf8..842a92e975 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
-#include "pkt-line.h"
 #include "sideband.h"
 #include "help.h"
 
@@ -109,103 +108,94 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 }
 
 
-/*
- * Receive multiplexed output stream over git native protocol.
- * in_stream is the input stream from the remote, which carries data
- * in pkt_line format with band designator.  Demultiplex it into out
- * and err and return error appropriately.  Band #1 carries the
- * primary payload.  Things coming over band #2 is not necessarily
- * error; they are usually informative message on the standard error
- * stream, aka "verbose").  A message over band #3 is a signal that
- * the remote died unexpectedly.  A flush() concludes the stream.
- */
-
 #define DISPLAY_PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int recv_sideband(const char *me, int in_stream, int out)
+int diagnose_sideband(const char *me, char *buf, int len)
 {
-	const char *suffix;
-	char buf[LARGE_PACKET_MAX + 1];
+	static const char *suffix;
 	struct strbuf outbuf = STRBUF_INIT;
 	int retval = 0;
+	const char *b, *brk;
+	int band;
+
+	if (!suffix) {
+		if (isatty(2) && !is_terminal_dumb())
+			suffix = ANSI_SUFFIX;
+		else
+			suffix = DUMB_SUFFIX;
+	}
 
-	if (isatty(2) && !is_terminal_dumb())
-		suffix = ANSI_SUFFIX;
-	else
-		suffix = DUMB_SUFFIX;
+	if (len == 0) {
+		retval = SIDEBAND_FLUSH;
+		goto cleanup;
+	}
+	if (len < 1) {
+		strbuf_addf(&outbuf,
+			    "%s%s: protocol error: no band designator",
+			    outbuf.len ? "\n" : "", me);
+		retval = SIDEBAND_PROTOCOL_ERROR;
+		goto cleanup;
+	}
+	band = buf[0] & 0xff;
+	buf[len] = '\0';
+	len--;
+	switch (band) {
+	case 3:
+		strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+			    DISPLAY_PREFIX);
+		maybe_colorize_sideband(&outbuf, buf + 1, len);
+
+		retval = SIDEBAND_REMOTE_ERROR;
+		break;
+	case 2:
+		b = buf + 1;
 
-	while (!retval) {
-		const char *b, *brk;
-		int band, len;
-		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		if (len == 0)
-			break;
-		if (len < 1) {
-			strbuf_addf(&outbuf,
-				    "%s%s: protocol error: no band designator",
-				    outbuf.len ? "\n" : "", me);
-			retval = SIDEBAND_PROTOCOL_ERROR;
-			break;
-		}
-		band = buf[0] & 0xff;
-		buf[len] = '\0';
-		len--;
-		switch (band) {
-		case 3:
-			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX);
-			maybe_colorize_sideband(&outbuf, buf + 1, len);
-
-			retval = SIDEBAND_REMOTE_ERROR;
-			break;
-		case 2:
-			b = buf + 1;
-
-			/*
-			 * Append a suffix to each nonempty line to clear the
-			 * end of the screen line.
-			 *
-			 * The output is accumulated in a buffer and
-			 * each line is printed to stderr using
-			 * write(2) to ensure inter-process atomicity.
-			 */
-			while ((brk = strpbrk(b, "\n\r"))) {
-				int linelen = brk - b;
-
-				if (!outbuf.len)
-					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
-				if (linelen > 0) {
-					maybe_colorize_sideband(&outbuf, b, linelen);
-					strbuf_addstr(&outbuf, suffix);
-				}
-
-				strbuf_addch(&outbuf, *brk);
-				xwrite(2, outbuf.buf, outbuf.len);
-				strbuf_reset(&outbuf);
-
-				b = brk + 1;
+		/*
+		 * Append a suffix to each nonempty line to clear the
+		 * end of the screen line.
+		 *
+		 * The output is accumulated in a buffer and
+		 * each line is printed to stderr using
+		 * write(2) to ensure inter-process atomicity.
+		 */
+		while ((brk = strpbrk(b, "\n\r"))) {
+			int linelen = brk - b;
+
+			if (!outbuf.len)
+				strbuf_addstr(&outbuf, DISPLAY_PREFIX);
+			if (linelen > 0) {
+				maybe_colorize_sideband(&outbuf, b, linelen);
+				strbuf_addstr(&outbuf, suffix);
 			}
 
-			if (*b) {
-				strbuf_addstr(&outbuf, outbuf.len ?
-					    "" : DISPLAY_PREFIX);
-				maybe_colorize_sideband(&outbuf, b, strlen(b));
-			}
-			break;
-		case 1:
-			write_or_die(out, buf + 1, len);
-			break;
-		default:
-			strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
-				    outbuf.len ? "\n" : "", me, band);
-			retval = SIDEBAND_PROTOCOL_ERROR;
-			break;
+			strbuf_addch(&outbuf, *brk);
+			xwrite(2, outbuf.buf, outbuf.len);
+			strbuf_reset(&outbuf);
+
+			b = brk + 1;
+		}
+
+		if (*b) {
+			strbuf_addstr(&outbuf, outbuf.len ?
+				    "" : DISPLAY_PREFIX);
+			maybe_colorize_sideband(&outbuf, b, strlen(b));
 		}
+		retval = SIDEBAND_PROGRESS;
+		break;
+	case 1:
+		retval = SIDEBAND_PRIMARY;
+		break;
+	default:
+		strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
+			    outbuf.len ? "\n" : "", me, band);
+		retval = SIDEBAND_PROTOCOL_ERROR;
+		break;
 	}
 
+cleanup:
 	if (outbuf.len) {
 		strbuf_addch(&outbuf, '\n');
 		xwrite(2, outbuf.buf, outbuf.len);
diff --git a/sideband.h b/sideband.h
index 7a8146f161..a56cd86287 100644
--- a/sideband.h
+++ b/sideband.h
@@ -3,8 +3,21 @@
 
 #define SIDEBAND_PROTOCOL_ERROR -2
 #define SIDEBAND_REMOTE_ERROR -1
+#define SIDEBAND_FLUSH 0
+#define SIDEBAND_PRIMARY 1
+#define SIDEBAND_PROGRESS 2
+
+/*
+ * buf and len should be the result of reading a line from a remote sending
+ * multiplexed data.
+ *
+ * Determines the nature of the result and returns it. If
+ * SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS, also
+ * prints a message (or the formatted contents of the notice in the case of
+ * SIDEBAND_PROGRESS) to stderr.
+ */
+int diagnose_sideband(const char *me, char *buf, int len);
 
-int recv_sideband(const char *me, int in_stream, int out);
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
-- 
2.19.0.271.gfe8321ec05.dirty

