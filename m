Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A2520285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbdHXWx6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:53:58 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38412 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdHXWx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:53:56 -0400
Received: by mail-pg0-f44.google.com with SMTP id b8so4642659pgn.5
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ES/ctJx39SPBeu+cUConT11I2Gjk353qc+57fnxMO+I=;
        b=fiIpJbMjvkWy9eYiOMb4RdxKdBfZw1l3NRxDb80aqIO0RBYayezL/PAXA//EIcfqG7
         oL9Ex5tRPHFXA3in/n5knD5xMiHPvzD1B63mp5/fY+6fnFHhRmNAb2qAIHcYEENb1Kg1
         0dABo+18p+aozUyuZayKlNfgOX/d115f2sK6pD+r04pTDfg8msJuJIk0ubaWNFH4320U
         xgBf8vitTWA5IJLNqE1gHji55KGbXBW7b9nvmMedXrB3mI4WW12NHLWbqXXBDwd69Cmz
         sECE/u/fo+NUa6yHMkQPE2eQXEOPMM3DC2OyH5a/kKJqRo3h5+5o9u4CkOCrA0OsZNaD
         9BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ES/ctJx39SPBeu+cUConT11I2Gjk353qc+57fnxMO+I=;
        b=EnwsfuOSV/xPOutWB06/hDcB2LKLoFyn+LXT3YwzwpHcwr25kPoAtyWh/DpF5K2t0c
         U3s9B0jSNSDL25zrPnen22aRYQLd5tGgxOz7Zs7clMSf1PJsDv4+rfn3CzlOXgvCyLHR
         sXGBK6ro2ZCUe7lAFnl5Hs+Io2tulZmV3KE1ddPpJAsToiZFISrJykZ7UKbgYO0niCs3
         HK7G5vhSjXjtmaeNMJyVJvMXyBTwJiIwWBZ+vrwpsPoRjJRCO2f6YueeONn5DY/WsTZy
         cWVcBUWxDCAVHJjEiGkjBEfD94M0Kol/F4rSm6Hali2MUIhfBYDWgbQIh+QAVdDH+MbL
         RK2g==
X-Gm-Message-State: AHYfb5jWpNd0QfKIwgOkZFUsAp+yIQ/I1yiAQY6eCWNcargRzCFglDkZ
        J99nfU+ouoVC26AgDQ+fGw==
X-Google-Smtp-Source: ADKCNb5nNqTthYsLa9+8CVIIDgPkaKCac6apFFk83Xcd3wnw45jGYqakxH9Dv4+ZXq2r7iznVEvesg==
X-Received: by 10.84.241.139 with SMTP id b11mr8606807pll.227.1503615235983;
        Thu, 24 Aug 2017 15:53:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:53:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 1/7] pkt-line: add packet_write function
Date:   Thu, 24 Aug 2017 15:53:22 -0700
Message-Id: <20170824225328.8174-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function which can be used to write the contents of an arbitrary
buffer.  This makes it easy to build up data in a strbuf before writing
the packet.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 7db911957..cf98f371b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -188,6 +188,12 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	return error("packet write failed");
 }
 
+void packet_write(const int fd_out, const char *buf, size_t size)
+{
+	if (packet_write_gently(fd_out, buf, size))
+		die_errno("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 66ef610fc..d9e9783b1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,6 +22,7 @@
 void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_write(const int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-- 
2.14.1.342.g6490525c54-goog

