Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DFA2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 00:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764968AbdKSAmz (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 19:42:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37342 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764964AbdKSAmy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 19:42:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id v186so12510968wma.2
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 16:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSD5/vC8cXkIH6nko1T3m2M0qqMv+O9/kgus1Pu9GN8=;
        b=Q/R/yFgWBzjXFETJ85eQspDZdklerElHuD3vanBv4VZc7g9ixSrw0cAWkSInslGhAQ
         BKxFiINMWJE6qHO3+ni3ZW6krR1vunV2qPw2+e5nwop72VTLvY1jsONhBVTe+F7/vzdo
         6Cb/vgzKox02q61as+bX9jIMKRnr42DjiKTh2Zchinx9a3jn/f3653I1piEFT+6LN6vg
         LX25dEkBKASjFoTACppDtYEUNMLOd0ftVu6jnjKX7sj3QmF3+mCQjqsJqR/8YmgLnNy4
         Xi/zv0P3vZFvz2BD50OajXJRQPj/faSd6XPiiVAO2M0445JxYL08EyMeN0hsx1Mti+aw
         FOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSD5/vC8cXkIH6nko1T3m2M0qqMv+O9/kgus1Pu9GN8=;
        b=NkBZxNbq8iXS+aVXZXde6kTy6ITg31WCzcmRY6oHWvf0j/BhzIpqzoglhW23tLsC2T
         5H7zQ0sUa7JsCDx6frQdS0WLnrBznRqwAY3OeOm/RqEj9y+qMrbpo2whVolUtPXNIMbT
         UlI6mqZfCq4P4fpbMzuRPHwzP5J8JGaeBbfY/8QG37fhsXxz2okPqnflCoL7kVzXIijd
         RndcKcAgIbIi0wGD8I4DvV1sugjdGKf7bNKF2pSBRh8J88XMYytX4pJ5bL20tt/bTfZx
         S2X1rC+KWvEw3XfvCCVxwIdZ42zWRWbUd8/MoRZh9iY8ZHhgah8YgU/eKZmoSR5BVU/Y
         zZRw==
X-Gm-Message-State: AJaThX7NY06zpoRSEogF5KY/wWZJDQZcBaEwtqsPBixwhSWOqiCX3prC
        beWPbyEg/xaSRqSZmjXcVaBlPg==
X-Google-Smtp-Source: AGs4zMZ9frxXjIV6Lmw04MSEz/ZnASfVtiJnqnw7Anc3sHiHIiluzbudL2UU2hySxNlrh5MonhODJQ==
X-Received: by 10.28.194.139 with SMTP id s133mr6573310wmf.14.1511052172657;
        Sat, 18 Nov 2017 16:42:52 -0800 (PST)
Received: from p50-debian.bsdmn (cpc93788-hari17-2-0-cust762.20-2.cable.virginm.net. [82.39.98.251])
        by smtp.gmail.com with ESMTPSA id f10sm6982988wrg.20.2017.11.18.16.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 16:42:51 -0800 (PST)
From:   gennady.kupava@gmail.com
To:     git <git@vger.kernel.org>
Cc:     Gennady Kupava <gkupava@bloomberg.net>
Subject: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept
Date:   Sun, 19 Nov 2017 00:42:46 +0000
Message-Id: <20171119004247.22792-1-gennady.kupava@gmail.com>
X-Mailer: git-send-email 2.15.0.278.gca7b6c74c.dirty
In-Reply-To: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gennady Kupava <gkupava@bloomberg.net>

- to implement efficient traces with normalization, normalization
  implementation should be moved to header. as it seems better to not
  overload header file with this normalization logic, suggestion is
  just to remove it
- different macro exist specifically to handle traces with default key
- there is no use of normalization in current code
- it could be reintroduced if necessary

Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
---
 trace.c | 24 ++++--------------------
 trace.h |  4 +++-
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/trace.c b/trace.c
index cb1293ed3..d47ea28e8 100644
--- a/trace.c
+++ b/trace.c
@@ -24,26 +24,13 @@
 #include "cache.h"
 #include "quote.h"
 
-/*
- * "Normalize" a key argument by converting NULL to our trace_default,
- * and otherwise passing through the value. All caller-facing functions
- * should normalize their inputs in this way, though most get it
- * for free by calling get_trace_fd() (directly or indirectly).
- */
-static void normalize_trace_key(struct trace_key **key)
-{
-	static struct trace_key trace_default = { "GIT_TRACE" };
-	if (!*key)
-		*key = &trace_default;
-}
+struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
 {
 	const char *trace;
 
-	normalize_trace_key(&key);
-
 	/* don't open twice */
 	if (key->initialized)
 		return key->fd;
@@ -81,8 +68,6 @@ static int get_trace_fd(struct trace_key *key)
 
 void trace_disable(struct trace_key *key)
 {
-	normalize_trace_key(&key);
-
 	if (key->need_close)
 		close(key->fd);
 	key->fd = 0;
@@ -128,7 +113,6 @@ static int prepare_trace_line(const char *file, int line,
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
 	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
-		normalize_trace_key(&key);
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
 		trace_disable(key);
@@ -167,13 +151,13 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!prepare_trace_line(file, line, NULL, &buf))
+	if (!prepare_trace_line(file, line, &trace_default_key, &buf))
 		return;
 
 	strbuf_vaddf(&buf, format, ap);
 
 	sq_quote_argv(&buf, argv, 0);
-	print_trace_line(NULL, &buf);
+	print_trace_line(&trace_default_key, &buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -215,7 +199,7 @@ void trace_printf(const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, NULL, format, ap);
+	trace_vprintf_fl(NULL, 0, &trace_default_key, format, ap);
 	va_end(ap);
 }
 
diff --git a/trace.h b/trace.h
index 179b249c5..24b32f8f4 100644
--- a/trace.h
+++ b/trace.h
@@ -11,6 +11,8 @@ struct trace_key {
 	unsigned int  need_close : 1;
 };
 
+extern struct trace_key trace_default_key;
+
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 
 extern void trace_repo_setup(const char *prefix);
@@ -78,7 +80,7 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
  */
 
 #define trace_printf(...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
+	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, &trace_default_key, __VA_ARGS__)
 
 #define trace_printf_key(key, ...) \
 	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
-- 
2.14.1

