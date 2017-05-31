Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E04220D11
	for <e@80x24.org>; Wed, 31 May 2017 21:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdEaVpJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:09 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33488 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdEaVpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:07 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so18621748pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Msp2/LLPRwjQ5k0HtWaWnn4K045fu1NXWWFn1fzC46c=;
        b=hrc+NAv9z3Y83xSWPCfZFZMXw9qvxnv9UCqEtyB6WScQkH9NnaAGWEtVnbVAPTIwN/
         p1oJy9Ov92sI880yXiG8o/c4Mqz/SacTgS0tmR9heMuYqzIaDM1ZtgtvxtkUdNthMkAn
         vBfBujPPjFAGYrwtx8JpM0H6MWzNyflrrrASGiDtOmkfi1lnxIXDGdT7W2xqy5lNEJoM
         jsp56uv4+f6uO4XGidff05Mai3Sy8qQG54xxwcUqrBx4YZK5aXWgWh6MGW846wLG5beA
         cQuTsMPh6V308R1mfYwBkcFFdEPFNk0Ri5AaZIzutG+QvzXJoiSUK7VvZ4tNnb91tU00
         D+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Msp2/LLPRwjQ5k0HtWaWnn4K045fu1NXWWFn1fzC46c=;
        b=Q6BAiDVMqF+XnGC3ymWM3fN/G7OmhWTbhJu8HM0zsoSybR2lwffYwPw9vxQmkVi4Ho
         8fC9/XUTxdDIbWhnyNlmWNzLncOStStGmIwPCOuBUCF5YH0qr9FlHq1znO5W2199nmLm
         oY/WhEi9/navD2UXWa6vzHWK34nqrXbyFEygPLcVPqyjABLbLMUd8mM0DTJHM5j+zl++
         iARLliC+P0J3Xpnn3F65ZT4KPeQ5xwnazh5MOOepLzIwY+XjV1d9wgu2fBg3ZTX9UoQr
         Oom9TjE7ZUvlAV8eSM9jrtN+szbjOKnGtIEJOxPKREi/ty1f14vAPEu8GHom3grjbxby
         ycvQ==
X-Gm-Message-State: AODbwcDZx6WMvsLGdEfuKtHC2lr10HapXh4BUsxtLl0e8ts4VNpN5vD1
        8jOmPF3l/k0b/YIaEXjDEw==
X-Received: by 10.99.60.82 with SMTP id i18mr10711543pgn.183.1496267096008;
        Wed, 31 May 2017 14:44:56 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/31] convert: convert get_cached_convert_stats_ascii to take an index
Date:   Wed, 31 May 2017 14:44:01 -0700
Message-Id: <20170531214417.38857-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 3 ++-
 convert.c          | 5 +++--
 convert.h          | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c4357dc30..f16ce0053 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -64,7 +64,8 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
 		const char *w_txt = "";
 		const char *a_txt = get_convert_attr_ascii(path);
 		if (ce && S_ISREG(ce->ce_mode))
-			i_txt = get_cached_convert_stats_ascii(ce->name);
+			i_txt = get_cached_convert_stats_ascii(&the_index,
+							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
 		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
diff --git a/convert.c b/convert.c
index 5f4a4b1f5..574003023 100644
--- a/convert.c
+++ b/convert.c
@@ -135,11 +135,12 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
 	}
 }
 
-const char *get_cached_convert_stats_ascii(const char *path)
+const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+					   const char *path)
 {
 	const char *ret;
 	unsigned long sz;
-	void *data = read_blob_data_from_cache(path, &sz);
+	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
 	return ret;
diff --git a/convert.h b/convert.h
index 82871a11d..667b7dfe0 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+struct index_state;
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
@@ -33,7 +35,8 @@ enum eol {
 };
 
 extern enum eol core_eol;
-extern const char *get_cached_convert_stats_ascii(const char *path);
+extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
 
-- 
2.13.0.506.g27d5fe0cd-goog

