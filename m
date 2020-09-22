Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA87C4727E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA22071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="aVk5ui9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIVWun (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVWum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13EC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so20887567qke.12
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVKO0TJCnvOAmfwtGERytuGoYqOpfi8BH4ktAy+W+QI=;
        b=aVk5ui9tTKVicpMIHrstOXOwH9EJhHqF9x4+QfOq76jZhLlK3UtzsZiFbdFH0h9S3P
         eMoNW4Etqnbl0xAUxFoNUbd3MgXI0wueCYvIXLc1FiuR4orYySc4biUqvYH/2M62vZnX
         PjCuwwp2d8iwiu4B7H//tdZnLAP2zq+td5uqaQmnN65FvbxjkdMA0tOlfdXQB88zvnLJ
         KkszCM1arAY754KcaSHXNVPvPgWYbRO79xeuGAOa60iJeveb8dKGqbkjtxI7fgwzkKwZ
         l8R9qmjyalbSDdbi659D+RtIuQs9z+h5f007agU49bulc/XlBLeoKRGczgcMtqxbJ1oX
         Abjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVKO0TJCnvOAmfwtGERytuGoYqOpfi8BH4ktAy+W+QI=;
        b=VHrWKy5oRmY7Lm6EWAuN9v8VC0uHM3bQ11TnXDu4VwbCa5tvnjq6uOPcNIS3DvOx9K
         V4yGmuxoh1ENy7qQ8DRv/QnJI7NKg6IiQjEE4/7Y3ku/Ti9l2lw0WCU3rAzre+vDt7rr
         +C6b6cSML0VebqR1CbmHtlMf3v6CA6qUqkD1AOoMkpfjZF7v2WXA9MPH9UyhyBNKPSkd
         yk8hnkrr+Lps7MHw96kQwrWJq43z8X/T7k2xjreA0CBVYYLRbjDgI7t2zbVD0imSTeD7
         zSpqGcKCOMPuJfdlbfzrzKE6tvvF0yfizHUD8s+qWkSUfXg65q1KtVLCoPLBZDTUqcpj
         Sjlw==
X-Gm-Message-State: AOAM532mJ7bcT6rZOrTh9pty5p3mQk7KF74wHt0LXWoE41LAYEhdyjmS
        Fe+nzVfeqy8LWbR1nVb/O70RHpQ7Pq/TkQ==
X-Google-Smtp-Source: ABdhPJywm4yAd9VCuY6kx5T6r4cOqYgN7lhgGpYEJr/efLBS5iTDf2V7N0VyUif9mzukB+luzQgYEA==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr7293281qkg.204.1600815035847;
        Tue, 22 Sep 2020 15:50:35 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 02/19] convert: add [async_]convert_to_working_tree_ca() variants
Date:   Tue, 22 Sep 2020 19:49:16 -0300
Message-Id: <313c3bcbebb9460d62cc29692964111565043de0.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Separate the attribute gathering from the actual conversion by adding
_ca() variants of the conversion functions. These variants receive a
precomputed 'struct conv_attrs', not relying, thus, on a index state.
They will be used in a future patch adding parallel checkout support,
for two reasons:

- We will already load the conversion attributes in checkout_entry(),
  before conversion, to decide whether a path is eligible for parallel
  checkout. Therefore, it would be wasteful to load them again later,
  for the actual conversion.

- The parallel workers will be responsible for reading, converting and
  writing blobs to the working tree. They won't have access to the main
  process' index state, so they cannot load the attributes. Instead,
  they will receive the preloaded ones and call the _ca() variant of
  the conversion functions. Furthermore, the attributes machinery is
  optimized to handle paths in sequential order, so it's better to leave
  it for the main process, anyway.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: squash, remove one function definition and reword]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 convert.h |  9 +++++++++
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index 941a845692..55bcce891c 100644
--- a/convert.c
+++ b/convert.c
@@ -1447,7 +1447,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const struct index_state *istate,
+static int convert_to_working_tree_internal(const struct conv_attrs *ca,
 					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing,
@@ -1455,11 +1455,8 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 					    struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
-	struct conv_attrs ca;
-
-	convert_attrs(istate, &ca, path);
 
-	ret |= ident_to_worktree(src, len, dst, ca.ident);
+	ret |= ident_to_worktree(src, len, dst, ca->ident);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1469,24 +1466,24 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 	 * is a smudge or process filter (even if the process filter doesn't
 	 * support smudge).  The filters might expect CRLFs.
 	 */
-	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
-		ret |= crlf_to_worktree(src, len, dst, ca.crlf_action);
+	if ((ca->drv && (ca->drv->smudge || ca->drv->process)) || !normalizing) {
+		ret |= crlf_to_worktree(src, len, dst, ca->crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
 		}
 	}
 
-	ret |= encode_to_worktree(path, src, len, dst, ca.working_tree_encoding);
+	ret |= encode_to_worktree(path, src, len, dst, ca->working_tree_encoding);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
 
 	ret_filter = apply_filter(
-		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, meta, dco);
-	if (!ret_filter && ca.drv && ca.drv->required)
-		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
+		path, src, len, -1, dst, ca->drv, CAP_SMUDGE, meta, dco);
+	if (!ret_filter && ca->drv && ca->drv->required)
+		die(_("%s: smudge filter %s failed"), path, ca->drv->name);
 
 	return ret | ret_filter;
 }
@@ -1497,7 +1494,9 @@ int async_convert_to_working_tree(const struct index_state *istate,
 				  const struct checkout_metadata *meta,
 				  void *dco)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, dco);
 }
 
 int convert_to_working_tree(const struct index_state *istate,
@@ -1505,13 +1504,36 @@ int convert_to_working_tree(const struct index_state *istate,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, NULL);
+}
+
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco)
+{
+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
+}
+
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta)
+{
+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, NULL);
 }
 
 int renormalize_buffer(const struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL, NULL);
+	struct conv_attrs ca;
+	int ret;
+
+	convert_attrs(istate, &ca, path);
+	ret = convert_to_working_tree_internal(&ca, path, src, len, dst, 1, NULL, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index aeb4a1be9a..46d537d1ae 100644
--- a/convert.h
+++ b/convert.h
@@ -100,11 +100,20 @@ int convert_to_working_tree(const struct index_state *istate,
 			    const char *path, const char *src,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta);
+int convert_to_working_tree_ca(const struct conv_attrs *ca,
+			       const char *path, const char *src,
+			       size_t len, struct strbuf *dst,
+			       const struct checkout_metadata *meta);
 int async_convert_to_working_tree(const struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  const struct checkout_metadata *meta,
 				  void *dco);
+int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+				     const char *path, const char *src,
+				     size_t len, struct strbuf *dst,
+				     const struct checkout_metadata *meta,
+				     void *dco);
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
 int renormalize_buffer(const struct index_state *istate,
-- 
2.28.0

