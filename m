Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C4E2027D
	for <e@80x24.org>; Thu, 18 May 2017 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbdERXWM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:12 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34288 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdERXWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:10 -0400
Received: by mail-pg0-f50.google.com with SMTP id u28so29535266pgn.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5Fosy8KAO6xvxOMN1+7GUPYHk/iZWw5Qe1zggtsEg4=;
        b=Z92tb2iTPNHQjJZvMZIqVD6G6eWjWvHSJ+a9C45ANSgOyVci04PbUOrqoH2G4lCsZv
         lyAtKdNvTfRXfTWSLcjs3J+p5PXPEs0oRnw16zXMZ1lZ4DkAeyTM6VnBmGwnCxcT4gSe
         K6U2AAATwh1o7scZ/YrrV9sV2mX1YgoDPCxT4gSp00OC1zuBwV0s6lbDRaF6uV7euBJo
         aMgjCXk9aCiQ748so26NwACfHSQ+gumBdNA1U5xj4l1cbxddRC+Vbn22SZXm/QBm+BTQ
         gDs+iBcN7CmtBDLWWspyoavj2bxgkSdpGhvO2LLAJqRWt6H4YNGaN8fAg/p/c1iMl2oP
         pgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5Fosy8KAO6xvxOMN1+7GUPYHk/iZWw5Qe1zggtsEg4=;
        b=ue8vNyrCbKrH8JQqnFqUM2HvSBAw61ZzMt5Kku8FKPR0dLl3h/0kHyt6NsNTEDROfu
         iMw3XxdAhx1Psogz882oMJyuzY6wHVYsb2X35hYjiJt/lgFT4F38WjSF4ZT75/E4rh7i
         2/8RDRG3b8gvBphhtXhT9A8TI0/2DSGSgK4whqufuSesfRd9+jAGmyd5uUWv8X/RadMP
         dHiL7fcuk1K27FDea79dAHRfEfoRAwamM5z+6DFwUG/k7SL9PqO1T0esxSml0wW6k+fJ
         KViNbQc9vQ6p92WQhNar8efMHQawaXZdRCquzBdDPNH5wPtdGP7zymwDyHzcUOZXDpzh
         qBbg==
X-Gm-Message-State: AODbwcBhn0lG6FH6dmeORon/tZ7rOeyF3g1XADu5dadYP0rld9zmSDyT
        muspbTq/UPJhNCVY
X-Received: by 10.84.130.35 with SMTP id 32mr7663618plc.24.1495149729164;
        Thu, 18 May 2017 16:22:09 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 01/23] convert: convert get_cached_convert_stats_ascii to take an index
Date:   Thu, 18 May 2017 16:21:12 -0700
Message-Id: <20170518232134.163059-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
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
index 89b3ce8e5..770d8774a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -63,7 +63,8 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
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
index 8d652bf27..b1b90d6e6 100644
--- a/convert.c
+++ b/convert.c
@@ -133,11 +133,12 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
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
2.13.0.303.g4ebf302169-goog

