Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A4E1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdFHXlp (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:45 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35049 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdFHXll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id l89so22166473pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlkBz1SLpG2NGDB3bZlCuS09GLLXs/+bM88rSlFVQqI=;
        b=Kd4WTNbyRqXP2byFZBor00L5uh/1xs4C61lZZ+IBEf6w1FA0Rmkj2Lu6sd1JmNkpae
         kvVlKLHDxDApQZ0WY9NSGNti+SDrSg/NXflO1ylHDBWKcuLzeLf0lhR4uaA+XX/HtpOo
         IbCqY7Lc5FG8fnMhSFh6N5131Gz8bj/9jnAxZq5j/0mVuFkHBHN9fedBETq59q96Q6Y7
         D6PDfByS/epFoFwd/iNK/aBERKInirkZCghvzDzR95hqaw7+L7zGgo9ohcmKFqcE6AMM
         JzCFFzpgZ3g/YoAS+Ym47oVarKTKjK8kDoycDI5JmvntltPgnY7KaW/mvrL/fuaoGybI
         QnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlkBz1SLpG2NGDB3bZlCuS09GLLXs/+bM88rSlFVQqI=;
        b=UcruHDL4xfDlx/4wljTRnz9FGI5p00jnZnoAvspcJUfhYf9mo53KWazFyMo/lRaTky
         gO8Slp2j5AdTVw8jbLvkaLn9X6s6LCgNsnxSwLII5zz3eMQQC9LmU1hiFu1BzTjqJMMg
         kxlVnifA1q2GB9k1hOaraZVJFXgkmqFt6rLcGAtmsZz8M/ArVUHtuhWGOMAI40EghN/5
         kFNLCNmoU5uLrt3iB3m2QnJiUkI+pLbcDN64T7qn7r3amGhPJnxmeD+NVxrjBKrq5kZK
         cSvt2l2qbUVTweUbH9p4saOq0KyYKkO2Qt6Q0fcXXKNoXAXeWzHyiSPDaIr7i+1iO9k5
         vfIQ==
X-Gm-Message-State: AODbwcBQL92T5LCDrPRXrg7crUTJvdEuejiJKQc43+Vv8z88fg5KEsFM
        vgSrt+Y15yZgRKB7CC3fwg==
X-Received: by 10.98.194.73 with SMTP id l70mr8602628pfg.41.1496965300332;
        Thu, 08 Jun 2017 16:41:40 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 16/32] convert: convert get_cached_convert_stats_ascii to take an index
Date:   Thu,  8 Jun 2017 16:40:44 -0700
Message-Id: <20170608234100.188529-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

