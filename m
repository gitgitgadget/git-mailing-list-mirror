Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F19C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C42206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCFOcU3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFNHcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgFNHcK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 03:32:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9AC03E96F
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e2so6363129qvw.7
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkyLT5s0aT+WT5dDtGzFepyerMsf3FomxlFUygRwe7M=;
        b=kCFOcU3kXTEoFtrk6MQyyg4R9LF7Sa1oGfU2yQHG2sDnhSYI07p4pEWTcvfmp5/Eyi
         4YvFqS9CSrLVaCXY7bUr8/4U3QUp0/gB57KRiJZmc/R/npGgCYp5I1SFBQHUHCYJRgIT
         BSviyj7cr4u5pYzyfDIPeLLFvqBOR3TlYZ97M0UidpkoYAd65itEWS9IAa9BLBpzVIyx
         7602KsxIabgkuXtyhvgfFr4zJrdPqcaX6PMymw9CRG0LPjVdJyrKF6wyN6E1uSAiWDgJ
         d5DG75aOqkrQ3/Aqf8mZhDqEkqIV+ZkQsL9+tGj+k0VXpbNrWXcu72xtT1kkLk2DkIU/
         R0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkyLT5s0aT+WT5dDtGzFepyerMsf3FomxlFUygRwe7M=;
        b=JsgUr7HOAowd3Bt9lHBS+GQ+i3Soc5gaFEpkII39+v/FBtlV7slDG/wWEy8dCdiX1G
         de0ZR6zraeagrUw2cbJapX6CzsRxdTVWS5YXrsKCrgWUmB6nPmic9XNUPliEYHFf7e31
         s9nVB1T8kWEX3a6O8VxlQ1AeGoCkyZNuVasZN/q0hKo5tuqoS2INWQd4KMM7EtqnK4Q+
         Q0UHrxMe8meY49TP8KySwqwI25GXjlfp8Kb4BnhC49QS28uScYCZaBjfznZ1ynDJpeB3
         c9D7dwx9JmZRVUn3DCF4mN/BeDXKJfSyXYxbVixhGjbjU4VjCrJ1pJf+kCVo18td1kCe
         LlHw==
X-Gm-Message-State: AOAM531TAETLjniZJsY7biy+frQwqFzWO5+ngCmun24/YdLUAoUfzi/L
        +RPWfMyXNSjJagw91i3Us0m7xY0DwlU=
X-Google-Smtp-Source: ABdhPJx51kEAReQfzewMm8VFkENRfyjABF7Qy/yiFIQiYlZORHjOqVI0YS1n3IPArECtf4uS7yBboQ==
X-Received: by 2002:a0c:aed6:: with SMTP id n22mr20007486qvd.70.1592119928664;
        Sun, 14 Jun 2020 00:32:08 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id a82sm8834341qkb.29.2020.06.14.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:32:07 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] pkt-line: war on magical `4` literal
Date:   Sun, 14 Jun 2020 03:31:57 -0400
Message-Id: <cover.1592119902.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many instances of the literal `4` in packet line-related code.
This series replaces these instances with either functions that can
generate the number or an appropriately-named constant.

Changes since v1:

* Introduce patch 1-2 so that the string length is used to generate the
  `4` where appropriate

Denton Liu (3):
  remote-curl: use strlen() instead of magic numbers
  pkt-line: use string versions of functions
  pkt-line: extract out PACKET_HEADER_SIZE

 pkt-line.c    | 66 +++++++++++++++++++++++++++++----------------------
 pkt-line.h    |  6 +++--
 remote-curl.c | 35 ++++++++++++++-------------
 3 files changed, 60 insertions(+), 47 deletions(-)

Interdiff against v1:
diff --git a/pkt-line.c b/pkt-line.c
index 245a56712f..f1fe0888c1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -81,49 +81,59 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
+static inline void packet_trace_str(const char *buf, int write)
+{
+	packet_trace(buf, strlen(buf), write);
+}
+
+static inline void control_packet_write(int fd, const char *s, const char *type)
+{
+	packet_trace_str(s, 1);
+	if (write_str_in_full(fd, s) < 0)
+		die_errno(_("unable to write %s packet"), type);
+}
+
 /*
  * If we buffered things up above (we don't, but we should),
  * we'd flush it here
  */
 void packet_flush(int fd)
 {
-	packet_trace("0000", PACKET_HEADER_SIZE, 1);
-	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
-		die_errno(_("unable to write flush packet"));
+	control_packet_write(fd, "0000", "flush");
 }
 
 void packet_delim(int fd)
 {
-	packet_trace("0001", PACKET_HEADER_SIZE, 1);
-	if (write_in_full(fd, "0001", PACKET_HEADER_SIZE) < 0)
-		die_errno(_("unable to write delim packet"));
+	control_packet_write(fd, "0001", "delim");
 }
 
 void packet_response_end(int fd)
 {
-	packet_trace("0002", PACKET_HEADER_SIZE, 1);
-	if (write_in_full(fd, "0002", PACKET_HEADER_SIZE) < 0)
-		die_errno(_("unable to write stateless separator packet"));
+	control_packet_write(fd, "0002", "stateless separator");
 }
 
 int packet_flush_gently(int fd)
 {
-	packet_trace("0000", PACKET_HEADER_SIZE, 1);
-	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
+	packet_trace_str("0000", 1);
+	if (write_str_in_full(fd, "0000") < 0)
 		return error(_("flush packet write failed"));
 	return 0;
 }
 
+static inline void control_packet_buf_write(struct strbuf *buf, const char *s)
+{
+	packet_trace_str(s, 1);
+	strbuf_addstr(buf, s);
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
-	packet_trace("0000", PACKET_HEADER_SIZE, 1);
-	strbuf_add(buf, "0000", PACKET_HEADER_SIZE);
+	control_packet_buf_write(buf, "0000");
 }
 
 void packet_buf_delim(struct strbuf *buf)
 {
-	packet_trace("0001", PACKET_HEADER_SIZE, 1);
-	strbuf_add(buf, "0001", PACKET_HEADER_SIZE);
+	control_packet_buf_write(buf, "0001");
 }
 
 void set_packet_header(char *buf, int size)
@@ -337,15 +347,15 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	if (len < 0) {
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
-		packet_trace("0000", PACKET_HEADER_SIZE, 0);
+		packet_trace_str("0000", 0);
 		*pktlen = 0;
 		return PACKET_READ_FLUSH;
 	} else if (len == 1) {
-		packet_trace("0001", PACKET_HEADER_SIZE, 0);
+		packet_trace_str("0001", 0);
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len == 2) {
-		packet_trace("0002", PACKET_HEADER_SIZE, 0);
+		packet_trace_str("0002", 0);
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < PACKET_HEADER_SIZE) {
diff --git a/remote-curl.c b/remote-curl.c
index bac295c5bc..7ba1280a41 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -536,8 +536,8 @@ struct rpc_state {
 	unsigned initial_buffer : 1;
 
 	/*
-	 * Whenever a pkt-line is read into buf, append the PACKET_HEADER_SIZE characters
-	 * denoting its length before appending the payload.
+	 * Whenever a pkt-line is read into buf, append the PACKET_HEADER_SIZE
+	 * characters denoting its length before appending the payload.
 	 */
 	unsigned write_line_lengths : 1;
 
@@ -556,8 +556,9 @@ struct rpc_state {
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
  * enough space, 0 otherwise.
  *
- * If rpc->write_line_lengths is true, appends the line length as a PACKET_HEADER_SIZE-byte
- * hexadecimal string before appending the result described above.
+ * If rpc->write_line_lengths is true, appends the line length as a
+ * PACKET_HEADER_SIZE-byte hexadecimal string before appending the result
+ * described above.
  *
  * Writes the total number of bytes appended into appended.
  */
@@ -596,10 +597,10 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 			set_packet_header(buf - PACKET_HEADER_SIZE, *appended);
 			break;
 		case PACKET_READ_DELIM:
-			memcpy(buf - PACKET_HEADER_SIZE, "0001", PACKET_HEADER_SIZE);
+			memcpy(buf - strlen("0001"), "0001", strlen("0001"));
 			break;
 		case PACKET_READ_FLUSH:
-			memcpy(buf - PACKET_HEADER_SIZE, "0000", PACKET_HEADER_SIZE);
+			memcpy(buf - strlen("0000"), "0000", strlen("0000"));
 			break;
 		case PACKET_READ_RESPONSE_END:
 			die(_("remote server sent stateless separator"));
-- 
2.27.0.132.g321788e831

