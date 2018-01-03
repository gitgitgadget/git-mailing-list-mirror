Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572631F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeACATf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:35 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37981 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeACATR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:17 -0500
Received: by mail-io0-f196.google.com with SMTP id 87so471254ior.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i0CaELZwld/RgmZyfIcwReMs01fcs6piIRAeibnVjV8=;
        b=GMRXmjATBhHi2MpH7kkG8YrsOINGU2UyFfZYzpturWZNWwBHHstuK+TZo9bpTEmfD9
         5RE3OZefb6xDqIKED+zgxEv9CqcW2B5ITV5dTwcV9lofsm2xq9/EOrtFeyp418sySVrR
         64aHS03+aQWKLWHDwCJ0xRVErWRYh7/8cfIe+Z4ljjbAG8xATKmtB2TZNz38o1eVvFp/
         +PBTuEIEhHXk5waG3qCCcEf6Bp2z38nVIYZ1GDNb1f7D7Iz6E/nqXk/227mfrbqujvUJ
         kOsaZkHFGz3Qu6ddNqVK9yC4y69e3n6wf0iNkojNQQTXJ7lsTzjn0ApmwfJBNxwsGAP7
         xw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i0CaELZwld/RgmZyfIcwReMs01fcs6piIRAeibnVjV8=;
        b=jbOgIYnSOSMW7l2ejbC2Sqs+Fm8DF6UZO/3hvQThgeQ+0+rATRqYQeKBJDg8po5o/u
         AFbojjClA7cAr/P29QeOTQ6DTWwaYXo9tNoTIqHpomf3/t4XEKTx72WUpZvPDZwR9Nwj
         hgWaybeF6II6V5rHucQuqKH+ptSYDPa/uyYY9KVedQVnY7zwh2ZNanVo9fgUTn/hgkMD
         K0jo9O5ckuDBx1SvOPWGGShXryx0YnStKQXs4JCXLzeMcm4oX7kqaoOve2NWHXUdPo+o
         GKeYRDFaZavz9eCzimlICu4Rzc88RctQzLqa3s/W1cFT/6nYicNjXtnRrbBMcobOfnpM
         ZR8Q==
X-Gm-Message-State: AKGB3mJQ5dnoaB8v0/FzS6UGDGjkZFg3aVnD+6imc1kn7pxvZFrjMRea
        66Nd4J+VTNMC7+PIN68oPx0Pt3zXujg=
X-Google-Smtp-Source: ACJfBovpl90YkqjfJJlUFOyigJ8o7YMcjiwL90ZQ9ovOaMRTWe1QgSZswqZ/eBJbMd1fu2cauIYkNQ==
X-Received: by 10.107.160.209 with SMTP id j200mr64576951ioe.212.1514938756888;
        Tue, 02 Jan 2018 16:19:16 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 24/26] pkt-line: add packet_buf_write_len function
Date:   Tue,  2 Jan 2018 16:18:26 -0800
Message-Id: <20180103001828.205012-25-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'packet_buf_write_len()' function which allows for writing an
arbitrary length buffer into a 'struct strbuf' and formatting it in
packet-line format.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 16 ++++++++++++++++
 pkt-line.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 3159cbe10..e9968b7df 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -215,6 +215,22 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
+{
+	size_t orig_len, n;
+
+	orig_len = buf->len;
+	strbuf_addstr(buf, "0000");
+	strbuf_add(buf, data, len);
+	n = buf->len - orig_len;
+
+	if (n > LARGE_PACKET_MAX)
+		die("protocol error: impossibly long line");
+
+	set_packet_header(&buf->buf[orig_len], n);
+	packet_trace(buf->buf + orig_len + 4, n - 4, 1);
+}
+
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
 	static char buf[LARGE_PACKET_DATA_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 97b6dd1c7..d411fcb30 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -26,6 +26,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
-- 
2.15.1.620.gb9897f4670-goog

