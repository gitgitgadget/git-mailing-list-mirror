Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496B020954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdLDX7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:10 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44587 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdLDX7H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id j9so9382780pgc.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nA+uuwuCjgIbE8SFwuMh1Nv5UF7j6xwn3xdGv5xlWY=;
        b=cDowveOnIStRskVIGv689eirfpliQvtGfqFmD+1OoltV0EV3i9/4mqha2ZQMw+UVCy
         Uf1b1SOuqHYLjnkDekapUs9TTOE/OZ5fRRdbb7d86eN/H+PKm0QhZp2r1Lekl6RFYg8Z
         iHjO0izqyHLgoOXLwPwsz3atcDb7LXFTIBJeWqpSO8Z00TBJ4QX1vmGvBpyMHWjMPLXa
         HCwMLjl+9TueP0jizHi5PWUCl7tDUs40XYUkf0IqEjuWx4kgdWPGCn3BKdpXXCyBs2hh
         lxUUSGMKYjSb1fxOQmtLQ289B4hl5UqVbbwOJQypa4eTqZzxxMu7n6YhU/lgks7sBzJ3
         mUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nA+uuwuCjgIbE8SFwuMh1Nv5UF7j6xwn3xdGv5xlWY=;
        b=pW+sCxzn9oUbOiTFLO6i5b8i0nudN275RX+4Jqyrzf5gQiF1noFgGLCrLoXnWHfptP
         GSM9/0o2rf0bE18diGhRuEp9LBoy74WlZMzdHSbLBUnyi4b8Z0XbQ9c+dY1/p151Iis+
         /1GwFjRojsWbVvzh4SL3i+vdn3N8hEFukh86nFJvKqVV6d3VeS+RXDImIFYtjJQc1c68
         ys/dyhELONw3kTg36ku9tIG8q5OkrRbtjtVc+QrAWL++VaRB90DCUVQt2QcDZZUfOZY7
         tkqbFpGPIficmlL4qlOhrhGZm3svfIy5pi7+E64GHi+3VzK6+z/cv8Gpk7AN4dWCAq0t
         /jBA==
X-Gm-Message-State: AJaThX4cRT+1ClskZgP2dBdFD5JRYr3OIKn6q+rORVcMRox3D7EKNAjX
        8Jng34jGL/i3j53z1ZVqusVvvqEA4fw=
X-Google-Smtp-Source: AGs4zMbLvUcVJ+yJmSRbmoD/kekbur+eZIg3OugAxbvHlCsPvT5IdQHuQ0TyhYL/vYdb1VfTxGxYhg==
X-Received: by 10.99.124.9 with SMTP id x9mr15465357pgc.68.1512431946395;
        Mon, 04 Dec 2017 15:59:06 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 01/15] pkt-line: introduce packet_read_with_status
Date:   Mon,  4 Dec 2017 15:58:09 -0800
Message-Id: <20171204235823.63299-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current pkt-line API encodes the status of a pkt-line read in the
length of the read content.  An error is indicated with '-1', a flush
with '0' (which can be confusing since a return value of '0' can also
indicate an empty pkt-line), and a positive integer for the length of
the read content otherwise.  This doesn't leave much room for allowing
the addition of additional special packets in the future.

To solve this introduce 'packet_read_with_status()' which reads a packet
and returns the status of the read encoded as an 'enum packet_status'
type.  This allows for easily identifying between special and normal
packets as well as errors.  It also enables easily adding a new special
packet in the future.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
 pkt-line.h |  8 ++++++++
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 7006b3587..ac619f05b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
 }
 
-int packet_read(int fd, char **src_buf, size_t *src_len,
-		char *buffer, unsigned size, int options)
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options)
 {
-	int len, ret;
+	int len;
 	char linelen[4];
 
-	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
-	if (ret < 0)
-		return ret;
+	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
+		return PACKET_READ_ERROR;
+
 	len = packet_length(linelen);
 	if (len < 0)
 		die("protocol error: bad line length character: %.4s", linelen);
-	if (!len) {
+
+	if (len == 0) {
 		packet_trace("0000", 4, 0);
-		return 0;
+		return PACKET_READ_FLUSH;
+	} else if (len >= 1 && len <= 3) {
+		die("protocol error: bad line length character: %.4s", linelen);
 	}
+
 	len -= 4;
-	if (len >= size)
+	if ((len < 0) || ((unsigned)len >= size))
 		die("protocol error: bad line length %d", len);
-	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
-	if (ret < 0)
-		return ret;
+
+	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
+		return PACKET_READ_ERROR;
 
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
@@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
-	return len;
+	*pktlen = len;
+	return PACKET_READ_NORMAL;
+}
+
+int packet_read(int fd, char **src_buffer, size_t *src_len,
+		char *buffer, unsigned size, int options)
+{
+	enum packet_read_status status;
+	int pktlen;
+
+	status = packet_read_with_status(fd, src_buffer, src_len,
+					 buffer, size, &pktlen,
+					 options);
+	switch (status) {
+	case PACKET_READ_ERROR:
+		pktlen = -1;
+		break;
+	case PACKET_READ_NORMAL:
+		break;
+	case PACKET_READ_FLUSH:
+		pktlen = 0;
+		break;
+	}
+
+	return pktlen;
 }
 
 static char *packet_read_line_generic(int fd,
diff --git a/pkt-line.h b/pkt-line.h
index 3dad583e2..f1545929b 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -60,8 +60,16 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
  * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
  * present) is removed from the buffer before returning.
  */
+enum packet_read_status {
+	PACKET_READ_ERROR = -1,
+	PACKET_READ_NORMAL,
+	PACKET_READ_FLUSH,
+};
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
-- 
2.15.1.424.g9478a66081-goog

