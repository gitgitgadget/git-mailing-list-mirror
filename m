Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7AC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2C9206A5
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ONFmlFx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIVWul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVWul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB305C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g72so20906296qke.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDZhLyY8O/bBF56bscc+8yXTxs+B4Uzf1MqZWEQZLp4=;
        b=ONFmlFx5Y8s69azLKVNnMMrwoCrpXei6BUmNxWqIUQ7wHm4z6Qrfy9xfBW3yZTEXUh
         9al76BiJiNjWgLftwTNm+OH/u+bczZIFEXRN4qQT2dScAzjzQ1MG+BIIRoK3+bI4wYC+
         ZZ4QRbatuTNMOXXd0RoWebOo0kGFigS//gtvvxipMr+6C3hTCLP/Dy4OqoVnlhCewZog
         A9ga1yKAu00wbndr1BvxmBsz9TgXIgigzk7I/VRDehKIkInUcxdnDDqdhlM2tK8vWABU
         VprueQ9kHic5qMmHJoGEu3NHTFOlwsZgG3lg18+p0KWmELWIMqP1i9hQsob7yL9EFvI+
         Mpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDZhLyY8O/bBF56bscc+8yXTxs+B4Uzf1MqZWEQZLp4=;
        b=Rgw2Wl7pVCrhGxoJR7JJ+x1/oIm7oqWsSze3ieHjilXtAtR6+h7ymJlsOgZ4P3Xb4E
         +8MsRhj+8RHzUEKZaBpo+ddpsP5OjWsdV18H+PPgUSFWJcsANxBSzeOlBWp7nNwL9QuG
         EJHmkLlPoDQrdhL0kHAn+QV89PZQbUgwic4Ey+CHPld04PpAXwnxgjn+KY4UghkAdp69
         +umV8S6gFt7IzM7tsWRnD7INxaoDtyj0ZcTS3Ma4U+nuWNcY+YYLzXGiEOYFAH2XKXNh
         VUDJN/imFohRlLVIJ+y47nzhJYN89rYsNng8AdLq7Q09wKWHx6L7yPfNqsY0kUFwvpwC
         einw==
X-Gm-Message-State: AOAM5307WIViVoHUuAdE9qgm2UpgZF71bI0WBLmwmUM5ShhrSOH8OlcM
        I6G+FTO60TipaJxOh09o6W7j3eN8QYVILQ==
X-Google-Smtp-Source: ABdhPJzAkFEfXEotXtPI28Z8hgGiaTFWmwleAR0XM/5CNONywZkCBDi1QXwxqaixQVhWBZkOVSNY7Q==
X-Received: by 2002:a37:a207:: with SMTP id l7mr7432088qke.64.1600815040492;
        Tue, 22 Sep 2020 15:50:40 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 03/19] convert: add get_stream_filter_ca() variant
Date:   Tue, 22 Sep 2020 19:49:17 -0300
Message-Id: <29bbdb78e98667393f17e167f3d72d1bfbb302bd.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Like the previous patch, we will also need to call get_stream_filter()
with a precomputed `struct conv_attrs`, when we add support for parallel
checkout workers. So add the _ca() variant which takes the conversion
attributes struct as a parameter.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: move header comment to ca() variant and reword msg]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 28 +++++++++++++++++-----------
 convert.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/convert.c b/convert.c
index 55bcce891c..c112ea23cb 100644
--- a/convert.c
+++ b/convert.c
@@ -1960,34 +1960,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
 }
 
 /*
- * Return an appropriately constructed filter for the path, or NULL if
+ * Return an appropriately constructed filter for the given ca, or NULL if
  * the contents cannot be filtered without reading the whole thing
  * in-core.
  *
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const struct index_state *istate,
-					const char *path,
-					const struct object_id *oid)
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid)
 {
-	struct conv_attrs ca;
 	struct stream_filter *filter = NULL;
 
-	convert_attrs(istate, &ca, path);
-	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
+	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
 		return NULL;
 
-	if (ca.working_tree_encoding)
+	if (ca->working_tree_encoding)
 		return NULL;
 
-	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
-	if (ca.ident)
+	if (ca->ident)
 		filter = ident_filter(oid);
 
-	if (output_eol(ca.crlf_action) == EOL_CRLF)
+	if (output_eol(ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
 	else
 		filter = cascade_filter(filter, &null_filter_singleton);
@@ -1995,6 +1992,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
 	return filter;
 }
 
+struct stream_filter *get_stream_filter(const struct index_state *istate,
+					const char *path,
+					const struct object_id *oid)
+{
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return get_stream_filter_ca(&ca, oid);
+}
+
 void free_stream_filter(struct stream_filter *filter)
 {
 	filter->vtbl->free(filter);
diff --git a/convert.h b/convert.h
index 46d537d1ae..262c1a1d46 100644
--- a/convert.h
+++ b/convert.h
@@ -169,6 +169,8 @@ struct stream_filter; /* opaque */
 struct stream_filter *get_stream_filter(const struct index_state *istate,
 					const char *path,
 					const struct object_id *);
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
 
-- 
2.28.0

