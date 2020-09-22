Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A2C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656152071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Vc1D9RGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIVWu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIVWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345B8C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so20913665qkf.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0o9M053aS4Fpu58NIsI3IZY8vBtu9bdnRbtLyCPxzA=;
        b=Vc1D9RGYhwhVAFKQ/f5o1bqAkji7S/Bxr2U1wHbK9hbIRD+iRmrkCIm8qspIdc7hgC
         ua2j0SDWQD6SIQStepA6Oo6k7Afn2VkHEfW01YaESbPwsS+FIUTAHUHZyZO+5LMOu7uE
         IYmlD4MBBjknBBKfeQYilV8p+j6kTsHx8Q1B0V1lEkYI7Wk6kqlWRg67bIq4pS4LSfwM
         CWW/0ND4wrmMnGzOT2wPVXniG5S+Xw5E+OqQPbxlFEnw0nXxwXbTEsIISIoqr8BpLDKp
         oR3e4UrfMWjy7wY5HY1XTkQ7DkK7RzQArqflGOUU48t/d73XwymK593hh8dGn8YQyPBQ
         6qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0o9M053aS4Fpu58NIsI3IZY8vBtu9bdnRbtLyCPxzA=;
        b=Dn2OQ2TPokRMaoZgI6F1Fag8HwQO7w42shIZUSOct0sAGGI1q10Yc2oJMIojXqqhg5
         GYz/q7Td21qYKC5zoANfFk08jTkLWOnlTv69N7ck6Q18xtGXiM9suokkqS+ZHrtibzaT
         Rb6WoTEBDgOChjoGpNBkMIdlC40ZjyDSrl2I0n3GPcG+e/BgCzSQ/PlY0ollgaHNE3oZ
         N3ulz2k2R9cm/IORNKShdoEEnU2hxxeizrcALBlJRUinTIcRAAoToPyyoBHq5JSO2bIV
         WuQndNRNZX6//NVqsjV85vbNkdIMVr9cjn8oiLLMG/x7O2I5n4TSX3wt7UOdrPHOnq6y
         FWuA==
X-Gm-Message-State: AOAM5313p4e4r85d3NZvE6j5+rkRHyRgXO66ORSrqRFXqflEhhdmalCZ
        BZsQfu/K6/EKupqGcZRortvsnPdog4OJtQ==
X-Google-Smtp-Source: ABdhPJxzFA2aBOGkNj1ZOYGt9XH8SlHtCgVa76Arf45DCY+yiq8qb6VfkhPYL81/xE3+hHvjdZY/5Q==
X-Received: by 2002:a37:9d4d:: with SMTP id g74mr6936657qke.422.1600815056920;
        Tue, 22 Sep 2020 15:50:56 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 08/19] entry: move conv_attrs lookup up to checkout_entry()
Date:   Tue, 22 Sep 2020 19:49:22 -0300
Message-Id: <667ad0dea70cb7f0bbf8f52467f15129b3ae1325.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following patch, checkout_entry() will use conv_attrs to decide
whether an entry should be enqueued for parallel checkout or not. But
the attributes lookup only happens lower in this call stack. To avoid
the unnecessary work of loading the attributes twice, let's move it up
to checkout_entry(), and pass the loaded struct down to write_entry().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 1d2df188e5..8237859b12 100644
--- a/entry.c
+++ b/entry.c
@@ -263,8 +263,9 @@ void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 	}
 }
 
-static int write_entry(struct cache_entry *ce,
-		       char *path, const struct checkout *state, int to_tempfile)
+/* Note: ca is used (and required) iff the entry refers to a regular file. */
+static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca,
+		       const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
 	struct delayed_checkout *dco = state->delayed_checkout;
@@ -281,8 +282,7 @@ static int write_entry(struct cache_entry *ce,
 	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
-								 &ce->oid);
+		struct stream_filter *filter = get_stream_filter_ca(ca, &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
@@ -329,14 +329,17 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
-							    size, &buf, &meta, dco);
+			ret = async_convert_to_working_tree_ca(ca, ce->name,
+							       new_blob, size,
+							       &buf, &meta, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
-		} else
-			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, &meta);
+		} else {
+			ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
+							 size, &buf, &meta);
+		}
 
 		if (ret) {
 			free(new_blob);
@@ -442,6 +445,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
+	struct conv_attrs ca;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -454,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 	}
 
-	if (topath)
-		return write_entry(ce, topath, state, 1);
+	if (topath) {
+		if (S_ISREG(ce->ce_mode)) {
+			convert_attrs(state->istate, &ca, ce->name);
+			return write_entry(ce, topath, &ca, state, 1);
+		}
+		return write_entry(ce, topath, NULL, state, 1);
+	}
 
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
@@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+
 	if (nr_checkouts)
 		(*nr_checkouts)++;
-	return write_entry(ce, path.buf, state, 0);
+
+	if (S_ISREG(ce->ce_mode)) {
+		convert_attrs(state->istate, &ca, ce->name);
+		return write_entry(ce, path.buf, &ca, state, 0);
+	}
+
+	return write_entry(ce, path.buf, NULL, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
-- 
2.28.0

