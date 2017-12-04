Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4150E20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdLDX7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:14 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39383 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdLDX7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:10 -0500
Received: by mail-pf0-f194.google.com with SMTP id l24so9800349pfj.6
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+POLUs7CSX+Jm+fptdaJGmU/XUSw6JkdJ5Zv/K/mwvM=;
        b=CKu0g1dg39PzBQmWHff3hCPz78A7yJlz+NonsBfG0y4nI1AScFRdOLU1UVt5l/Da9A
         /kb3R98PNlv+Z+IbHUbwGenCOmvJn23fPP3tnsRqzg2bHKXqWg/BnO1PiOBD/iKYO0XC
         7X8HRAl4MDov1LUZosOUNg9SnjVuFOdznril5njNMX/jiEUFGYykEEfq+Q+L8ySH0t4R
         cU9IMs/+rvgpbFxOM9ojQ9TLkR+ZWt61iuo5bi0qVmBtwFlU9T7kaYGP+AqtwZXv2Yb2
         EnyQemNFXuNeXfDtc32+SNBg39WUaDxuJFtHi+2YpGQB/HewFUZquSePbUWUrN6mCI6s
         xseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+POLUs7CSX+Jm+fptdaJGmU/XUSw6JkdJ5Zv/K/mwvM=;
        b=os0H/jT2AnpGe1yW/+mLwzn2PhduibHLGaSHzvZ1kdA7JIzFF1P8guFkCr6jFxY/Ep
         nE93fmwsm8vEgQV8ZCrU6oZY6ILfgQv4KZnoVkPRVEqK9LxN+KIwvZQ89rOfRNCaEHQt
         Rr8VVxQYGSQyzq5JSxA0Xf64TGe2t68mhLRlJuslUBUsmjZcM74ubf/FUus2aTf4nqNL
         /I/l4JeW1RXl4GFCB5IJg4pUa1PPf1X4+DQYRRmNZWheGNO+5L3FJtMVzhbW3fz/RyAl
         JuhZ3wZy74d4kZFlZhf35aDj2uR5CvU0651dquSKrAXALJH8FP1bFRrC1mYcMa/VcYfQ
         Qdmg==
X-Gm-Message-State: AJaThX4t4z1xU9uSVRgIsTAxjByhqy057Rjd4iBKIl43L5MhPVYkdPwp
        aghAtydJI+v5Rp+g9VGsLumL+OlDhcs=
X-Google-Smtp-Source: AGs4zMbMfWua2xbhhc6LZRZ/M649VtYRTzkBJeTPv/I/Jc6GrRzElT70U7RGwCxGIs5q6c5kimiuaw==
X-Received: by 10.159.254.4 with SMTP id r4mr16356444pls.11.1512431949511;
        Mon, 04 Dec 2017 15:59:09 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:08 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 03/15] pkt-line: add delim packet support
Date:   Mon,  4 Dec 2017 15:58:11 -0800
Message-Id: <20171204235823.63299-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the design goals of protocol-v2 is to improve the semantics of
flush packets.  Currently in protocol-v1, flush packets are used both to
indicate a break in a list of packet lines as well as an indication that
one side has finished speaking.  This makes it particularly difficult
to implement proxies as a proxy would need to completely understand git
protocol instead of simply looking for a flush packet.

To do this, introduce the special deliminator packet '0001'.  A delim
packet can then be used as a deliminator between lists of packet lines
while flush packets can be reserved to indicate the end of a response.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 19 ++++++++++++++++++-
 pkt-line.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 518109bbe..222e1e310 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+void packet_delim(int fd)
+{
+	packet_trace("0001", 4, 1);
+	write_or_die(fd, "0001", 4);
+}
+
 int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
@@ -105,6 +111,12 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
+void packet_buf_delim(struct strbuf *buf)
+{
+	packet_trace("0001", 4, 1);
+	strbuf_add(buf, "0001", 4);
+}
+
 static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
@@ -297,7 +309,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_
 	if (len == 0) {
 		packet_trace("0000", 4, 0);
 		return PACKET_READ_FLUSH;
-	} else if (len >= 1 && len <= 3) {
+	} else if (len == 1) {
+		packet_trace("0001", 4, 0);
+		return PACKET_READ_DELIM;
+	} else if (len >= 2 && len <= 3) {
 		die("protocol error: bad line length character: %.4s", linelen);
 	}
 
@@ -333,6 +348,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len,
 		break;
 	case PACKET_READ_NORMAL:
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		pktlen = 0;
 		break;
@@ -447,6 +463,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 	case PACKET_READ_NORMAL:
 		reader->line = reader->buffer;
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		reader->pktlen = 0;
 		reader->line = NULL;
diff --git a/pkt-line.h b/pkt-line.h
index 2b5c7cf11..49ec80c80 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,8 +20,10 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
+void packet_delim(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
@@ -64,6 +66,7 @@ enum packet_read_status {
 	PACKET_READ_ERROR = -1,
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
+	PACKET_READ_DELIM,
 };
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
-- 
2.15.1.424.g9478a66081-goog

