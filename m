Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143F220401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdFLWOY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:24 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35951 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFLWOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:22 -0400
Received: by mail-pf0-f180.google.com with SMTP id x63so57242555pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fU3s8zSx+CcQbrsVtOohxKddjdwqjDrTKKRv2XIcHps=;
        b=s52Qyex996cNZAegryVv0YRNhLQTnVZt38WUGY4LUt+2DcZe22hvN7n970bBs6w+bk
         zNOckjYoxtZwRLxkCBww6OtfRJJNWHpq3VAbrIAHfiB0BVHINcs/wJhigLfkamVUY+u1
         2lJOxW7H4H0To5Li2p+sHi4NhjC/DcwFLsxFNGaqlMTZj5ix3BtGiWnEm3LgnAs6zTgP
         5jiCeGJZDPKMHZLHbQQq9n+tvaj7md6vLw/GMuHpnwPBQTZ9ye+0/d8iNNxYQ1wFQraq
         gNXXcWccLaVVWLfE3KMm3F/u5zy1uBRI7PbAAgsr9jgOfjQM8SzoJnH+cebdBBK+JKx+
         uxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fU3s8zSx+CcQbrsVtOohxKddjdwqjDrTKKRv2XIcHps=;
        b=Ubl0m9RKpHSmpI8ybqxqfMEw4QLVifcr9gswp0FPGz9dL0Q+OX3MJxcKLzIzZaB6DM
         bJIATAWTrsfQo399iH0wyUISuhakYy8A0F2gRLLR1EXcNJpJwCIZOmoekA8onaDv7VaH
         nzTbm/JQp0XeGVqjbgFk1X1U/WTSKFqR2PiJIC+0+giMYkj+ZTFuZgUrioOYSZjI+vJ9
         WKuzYr636TdhS5YyWYvbfY2RywXREdJ4x4sKfEqeaSQZ7tn+9k5bGmme4wZA9O0a7kgU
         QAAvdNY2rWKJBoEJEMSnymk9lhgks4f/fV5WGvEHyVbZ8a4LheBrnpMB2yfm7lxYss9m
         yK/A==
X-Gm-Message-State: AODbwcAmySy97g2AY1X1ox7RtHyZMrOF+s4341NytAqWTpqorvPwZVkm
        63XpoNmMm7TJCWXLcx8tAQ==
X-Received: by 10.98.89.155 with SMTP id k27mr50224796pfj.70.1497305660821;
        Mon, 12 Jun 2017 15:14:20 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/17] convert: convert crlf_to_git to take an index
Date:   Mon, 12 Jun 2017 15:13:53 -0700
Message-Id: <20170612221408.173876-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 03160b376..0cafb06f5 100644
--- a/convert.c
+++ b/convert.c
@@ -218,13 +218,13 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const char *path)
+static int has_cr_in_index(const struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
 	int has_cr;
 
-	data = read_blob_data_from_cache(path, &sz);
+	data = read_blob_data_from_index(istate, path, &sz);
 	if (!data)
 		return 0;
 	has_cr = memchr(data, '\r', sz) != NULL;
@@ -254,7 +254,8 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const struct index_state *istate,
+		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -286,7 +287,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
+		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
@@ -1098,7 +1100,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1118,7 +1120,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(&the_index, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-- 
2.13.1.518.g3df882009-goog

