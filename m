Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A15E201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754741AbdERXWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:20 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36346 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbdERXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:15 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so30747797pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKzwYI4cloQyG+bh0Fj7ZrwNDIBBYRUas5b2rchdCeI=;
        b=EAzI4gEdLjngL6FLkK2Yyc8ApCFtw83RCR7s97J4Tal/CGockmjN8+twHm+abW/U5V
         y4fudCDod3522mhScmDTaKi5Lm/xLDAl6WCbSCzNzm9OMqS1YHCw1MHcmFh7b8IV0Gd1
         kV/Ugle/bQfHs3BK9JA5Pdyi8yl9gqiRDPKxrIxTJyLF/IYao0X2MCio7unI9h8RVktv
         i3FgOQZarqDkO1sV1wZQyTLehHSWIpMOS60qqsGv4hvcriwqKOattBfqD+WAe/CuXSCB
         Bqydy57vyEYFtOUpw7KE2qasKmC7I2NGLiL01WiJgpZGkJg+MzrwTmxXjLLJbZ2cg74/
         j3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKzwYI4cloQyG+bh0Fj7ZrwNDIBBYRUas5b2rchdCeI=;
        b=JuqAMUJdFSOh8+2Rkrv8g+kEnqt6NNwu28crkL5DSGGWm39IOzbIjHrromowkCFYZq
         sYcp/r2Tg4A0pCf0M5ahM2QzoLQdnodE+kB3Hwqzy5WPLC/JvclUEGdNNDB34eRFZka2
         m3EcL/VeMC40WUxXN7lzwifz2kQ6qh1Fn2A5AuMXa086ChKVW8+JYFPQ8SRAgRX15NIl
         Jpbx2Ylyu4nR0DNAMipXzZZuIfqjvGmy4XlE0MoZWgU0JssZ6zi6DAAyE195nkp70pIN
         484FX5FN14DjxL2Jkx9kzUMcTRDZ1KVSmjVMexXQ1GZ/p0nRg1NBQmTV5NsyNBkraRNY
         3S1w==
X-Gm-Message-State: AODbwcBbdDCsO1Lls0KIMeqsGPN+9OLuT/nqhpdY3TnCeH1mhY8r5vR9
        sRe8h3K5wSLvGpak
X-Received: by 10.84.149.168 with SMTP id m37mr7759828pla.74.1495149734735;
        Thu, 18 May 2017 16:22:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 05/23] convert: convert renormalize_buffer to take an index
Date:   Thu, 18 May 2017 16:21:16 -0700
Message-Id: <20170518232134.163059-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c         | 6 ++++--
 convert.h         | 3 ++-
 ll-merge.c        | 2 +-
 merge-recursive.c | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 3d1c7e2b6..e4c8e6ad3 100644
--- a/convert.c
+++ b/convert.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
@@ -1260,14 +1261,15 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	return convert_to_working_tree_internal(path, src, len, dst, 0);
 }
 
-int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
+int renormalize_buffer(const struct index_state *istate, const char *path,
+		       const char *src, size_t len, struct strbuf *dst)
 {
 	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(&the_index, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 60cb41d6a..cecf59d1a 100644
--- a/convert.h
+++ b/convert.h
@@ -46,7 +46,8 @@ extern int convert_to_git(const struct index_state *istate,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
-extern int renormalize_buffer(const char *path, const char *src, size_t len,
+extern int renormalize_buffer(const struct index_state *istate,
+			      const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d7..d7eafb61a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -339,7 +339,7 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 static void normalize_file(mmfile_t *mm, const char *path)
 {
 	struct strbuf strbuf = STRBUF_INIT;
-	if (renormalize_buffer(path, mm->ptr, mm->size, &strbuf)) {
+	if (renormalize_buffer(&the_index, path, mm->ptr, mm->size, &strbuf)) {
 		free(mm->ptr);
 		mm->size = strbuf.len;
 		mm->ptr = strbuf_detach(&strbuf, NULL);
diff --git a/merge-recursive.c b/merge-recursive.c
index 62decd51c..cdf34c524 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1639,8 +1639,8 @@ static int blob_unchanged(struct merge_options *opt,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(path, o.buf, o.len, &o) |
-	    renormalize_buffer(path, a.buf, a.len, &a))
+	if (renormalize_buffer(&the_index, path, o.buf, o.len, &o) |
+	    renormalize_buffer(&the_index, path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
-- 
2.13.0.303.g4ebf302169-goog

