Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22151F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbeARJpr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41997 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755330AbeARJpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:44 -0500
Received: by mail-pg0-f66.google.com with SMTP id q67so13650708pga.9
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVb0vH+3AGlzTY3nGfpgFKBiBPrav3tdar2RztL/J50=;
        b=UN8550I7ymYjn8kE0emsFBcRWr+1lsV73qk0PsXW08XFUWhYAI4bzA+ourI1fB3fpL
         Z//4QrwMiC5hD8xIbXtt+7tfycNk2ZbvR5oD7MGOmxhZYB8f1++1vfiODzkUuY1vDLM6
         17qEjbkWyXqAxa35Z7mibXGha9tyw/RpWmdqiAp4NI2KHJwl7HTK6o0FdycDOMOfbQ1d
         KDxkGqQc/TuHecjl3kRCGHHvOOpdCm0ThXj0do/L2ZzOgAQGJcZcA2h3m5pLVcPNIvcz
         yyLBc9yrua39xASdZuArl7a5brIw9PrZuQGqs/MkDFUvlK/zGh5JO6ia++Ny45eGSMCl
         Hasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVb0vH+3AGlzTY3nGfpgFKBiBPrav3tdar2RztL/J50=;
        b=J5A6eFt65wj4ATu+ZTvBhJ2844ICa2BTUhZHcn5vl0J2YrbQfBzaW2QbrZFgWs2GfZ
         e7oZYmmikN9nzFTVCC3Q0pUC67fIxVab1sNGzozH3sj9AbKLPXYTeN+v3F75kkMaglQY
         LQa8ilcJJX9JDZZPNF28MvanDJqZb/2CjAJuXGwxQYGG+cy/hHzCC69oB/5u1dPk8AbK
         EhM9+ZVsLiJxtJEkJ7OycNs8GNYMom1YJwbjtBT6gAkrsBkxWFhh1LX0wOO9GcbdLEnP
         z+mT/lrN3g5/6VXtHJWvxFyRJNx4R706HpxwfWYgc1/q/9XrJlknPb2abTKlkEAZ/xgu
         Z8Ug==
X-Gm-Message-State: AKwxytdhfQCZ7W9i9cgIIVDlOvzcPYOVzm3wGGtAbMVdFUex5qtwEhbO
        3kOMego3RInH6nsV6yjZcNfewQ==
X-Google-Smtp-Source: ACJfBotjHPkB89P3T1SvC75chGdI8rpt6/En6tBGa1Zj4nsJK2CLQC4f8F8WA0ppMI+pzvNyrS+a2g==
X-Received: by 10.101.96.198 with SMTP id r6mr13669433pgv.420.1516268743866;
        Thu, 18 Jan 2018 01:45:43 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id m22sm12646872pfg.120.2018.01.18.01.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 3/7] trace.c: move strbuf_release() out of print_trace_line()
Date:   Thu, 18 Jan 2018 16:45:08 +0700
Message-Id: <20180118094512.27849-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180118094512.27849-1-pclouds@gmail.com>
References: <20180115105949.18328-1-pclouds@gmail.com>
 <20180118094512.27849-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

