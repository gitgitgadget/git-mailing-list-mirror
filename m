Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0AAC1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965437AbeAMGuR (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:17 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45890 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeAMGuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:16 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so321045plo.12
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCr7dHRjerGiDDk4osYQqwPwBSqz7r1iw0UEOwHdaGE=;
        b=E2zVcx+J6wbG4hYg5TLoEmQLQrZv8IBOUi0ZgFfRqHYdtEgWqRBgcYk4JzxCr5/1+M
         4VJG+l0BLmTaITq1ymC8PAfEJFbLc1392o6npIKK2V3tL3POJIZvKYZ6SG8fDT58izw/
         VaW6q3eXSRCbRWR2IEZ58cqrnx1+nGS/wTN0e/ZEKZGCusRVBZpbSMb+CqAIGwHGrgr4
         UhGOFqO6nZyYVVN93ZMLUug92532kpp1zpqWV7D8CPX8zUf8nGT7H8PzMBiPhP0sQDsD
         +lnOLCMaaWFXYbmQ9OcE4rUh6BZ+s1jetcINai1a2StbEx04Jfuj8NlU5vd+nIkeMnLg
         TEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCr7dHRjerGiDDk4osYQqwPwBSqz7r1iw0UEOwHdaGE=;
        b=EkCDjusSBW1d3J1uFX/Gctb0w6Aq5fHYDbkzXM8iEOQGDlos8JJ2QKY9MGndTKdS6g
         K+OzYSazAU8gNI4FL7BFk7um+TLqYfspeiu1+7Wx8b+Mg8jRvOxlWSpWWbkeyj6r0/gh
         qZP52746Mt4VqKLUb8POLkF81LusgLNhrJgHh6+bFpzaAn/nApXSmUAUiIktckRpy9J7
         xOaIbXiy6iTz9U6N8Pnw98X/J+K6VeS84T6Ci+zNx38tv5LDpNwFweYJ2YCYaJfbUOv6
         9s4F7DCnvz86P/Z5lesGmVawF1YWDfV4SOKEkJA/n+LKnUpvDZp6Wj8g7VpIe3P1Mu85
         puig==
X-Gm-Message-State: AKGB3mJL1nwetotsmjoVeGdRYfs64ayie6c8PBOswAq2C6xd7h23UHPX
        bvjfUSYBe79GvOaPxlOU72uDCg==
X-Google-Smtp-Source: ACJfBotChcN0kH2ViJsvnVMbNMEUs0oFvFs+oXV2JUqxb6f8HgFHo30iZnDkzqTk4eNScV/JLiwo/Q==
X-Received: by 10.84.132.100 with SMTP id 91mr28181479ple.88.1515826215441;
        Fri, 12 Jan 2018 22:50:15 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id w83sm26323124pfi.56.2018.01.12.22.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 3/7] trace.c: move strbuf_release() out of print_trace_line()
Date:   Sat, 13 Jan 2018 13:49:45 +0700
Message-Id: <20180113064949.6043-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function is about printing a trace line, not releasing the buffer it
receives too. Move strbuf_release() back outside. This makes it easier
to see how strbuf is managed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index 9784915be1..7f3b08e148 100644
--- a/trace.c
+++ b/trace.c
@@ -131,7 +131,6 @@ static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	strbuf_complete_line(buf);
 	trace_write(key, buf->buf, buf->len);
-	strbuf_release(buf);
 }
 
 static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
@@ -144,6 +143,7 @@ static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_vaddf(&buf, format, ap);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_argv_vprintf_fl(const char *file, int line,
@@ -159,6 +159,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	sq_quote_argv_pretty(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
+	strbuf_release(&buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -171,6 +172,7 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_addbuf(&buf, data);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_performance_vprintf_fl(const char *file, int line,
@@ -190,6 +192,7 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	}
 
 	print_trace_line(&trace_perf_key, &buf);
+	strbuf_release(&buf);
 }
 
 #ifndef HAVE_VARIADIC_MACROS
-- 
2.15.1.600.g899a5f85c6

