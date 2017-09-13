Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A8220286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdIMVzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:06 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:44457 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdIMVzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id e1so2194269pfk.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AL0NhZ/RfuO8p7qAQWAi9Y3QByi5tRxkXUwydHyVsaI=;
        b=DxyeQzTZQPlwa6tVihJAHMcQLSMEo6j0oBVI9X4WvMPa3xwge5oaOhp6a6I2+sOIRR
         bZYxwENIyXfgbAh3xNJzcjGbAE7oniaCBFQ++4YVLVhD403otRMQx7zlK5tHlDQNiJQU
         wbz83FC5GQcO5i/ltuJCRMPtsSYITSzN6k/D+QzFE9d8EjAnvFocycXJew03k9C0o6jv
         BykZA5Iy5dj1lmjtkyzyLQZJMIs/AjS3hlXj/IYZwrDPIuEQCGZEdg5fncaKHh5skHRI
         w0DSL4PmHlT1SotCo3tCKKlAPyPUyHmohUkjv5grbtLWumpWjfpA3qyDMcBhapSgj/gW
         RMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AL0NhZ/RfuO8p7qAQWAi9Y3QByi5tRxkXUwydHyVsaI=;
        b=mWKF7ArFhepHKl/o8cPfjxa3bcQMaSoiRBoSQQnbeK4aLmcqWJl8aVfF2rGHpvzGyg
         Uw/hwsxuBq12KqrVjUtcnYp6VsBuqwjf6/ziqoKM9u4dnN1TvDhHLSary7CNmtvnao5+
         M+hO8r5T2sAZRxP0AXm3ieN5fHjr/tdj3m6JC8YrmjBlJINJzflBp9kH9ytRffOFGK9I
         Myzi4M6orYG2zZgS1t2bRunyHBEPjaYG1QKdeCU8GtCE0hDrFYkScyCx3g7etTkBT5pg
         ZDsPDHngjPebkEoeDoCI9x4/95V6NOOWKNA4BT3VwWFFAakvJfYm/l5PL9Ub3pXxtmu6
         ozBg==
X-Gm-Message-State: AHPjjUitInT90PvFTXg1tSw9aeGJkg+MyxYmEP7kfiC4SkAE2m05ZQg2
        NeSaCpf/p6x6SY7o6h5f9w==
X-Google-Smtp-Source: AOwi7QDLRQNi0fwMns/1ICwBq3lH7kXyrPVgI2hF5iaiG166+S6mvGZqO1ZZPzIXWL/kBYLNywe0ww==
X-Received: by 10.84.248.144 with SMTP id q16mr603912pll.345.1505339701930;
        Wed, 13 Sep 2017 14:55:01 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/8] pkt-line: add packet_write function
Date:   Wed, 13 Sep 2017 14:54:41 -0700
Message-Id: <20170913215448.84674-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function which can be used to write the contents of an arbitrary
buffer.  This makes it easy to build up data in a buffer before writing
the packet instead of formatting the entire contents of the packet using
'packet_write_fmt()'.

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
2.14.1.690.gbb1197296e-goog

