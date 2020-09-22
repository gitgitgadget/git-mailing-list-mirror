Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACDC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04CC206A5
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ya9JfvnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIVWuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVWup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C3C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g72so20906443qke.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuKuUiQojQh9pX7kscp9QIJOr0+2dep8P87vTaNLNlQ=;
        b=ya9JfvnHu+gwzIObreSPNVDOlMzbmH9x1bf11qnzj6kyMVHbs0rw8q7rQW/M5nAkvH
         7yNulzIm/L7bBJZpbjHPsnoLOFU+DSBueHJgPbRYAH8Nt9/QrU899q3aNfPQXL2P5JHW
         Gc31CZ8Xbg8p0kXlMde26/rv9Ha6lYzU+C+wys3Kfp4HB67z0SqxwGLDJrn7YQ8qJV+2
         4BI1Vso/pod8eRq3sf9f6cNXPycE5TsThMonXLPk/UpCoN4yMuDGA4zAKy257EAYTiZK
         UHWbAJBiOh0FnrCo3S5iS6sJLmP+ZWoHfv8i0quETS6Ru+336y9xd2ZbSXswWszHjjnT
         GAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuKuUiQojQh9pX7kscp9QIJOr0+2dep8P87vTaNLNlQ=;
        b=tv5HknLTuN0Nm0dJNMH1A6MQd8E1MJpfp8Vd+1FPrSpIrUdXTg3sddIkibE3b+bwIe
         RPOgLBX/7CEQXzWgCmsBZsyg4tMTymXxLdsC9NFGOMhOG1a8MIB81zjyckYapRlYj6l9
         HzWAj7owFLYwqVbgQ7ZTpmWnzdAKH1hg/rjQB6oasZk8JvNT8WUe8Z49Hs+wSzD3YW7w
         cL2AOAuClOw1plkgM1hRol6gy9rDDGu6liGZ8fw4JE3rt8DZrC4f3hKzuNSZ/gh87HIu
         ZJ0cKZep1EjBowlm4mBUx0eCHZBIDzkKjmydhgnZfMIBWRrLF2Z6R+bCJEtU/HOynbM6
         1ZWw==
X-Gm-Message-State: AOAM530eW0s8jaL5s4y2pQ2rSWUnxDyVkVsjjXdcP26N0a9su3sj7lMF
        eK3z8zVKXuD1vVH15RkuKE2oY7Wf+0EkIw==
X-Google-Smtp-Source: ABdhPJxr7Jq9CdGDCKkNJlitXghYav3B5iMCoDeFo6R+Qv/cewD1xn1wLddIfHHEeB7nlSZVNozaiQ==
X-Received: by 2002:a37:5144:: with SMTP id f65mr2509221qkb.351.1600815044433;
        Tue, 22 Sep 2020 15:50:44 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:43 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 04/19] convert: add conv_attrs classification
Date:   Tue, 22 Sep 2020 19:49:18 -0300
Message-Id: <a1cf5df961dd493801ac374c3a3f3c38573a61d7.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create `enum conv_attrs_classification` to express the different ways
that attributes are handled for a blob during checkout.

This will be used in a later commit when deciding whether to add a file
to the parallel or delayed queue during checkout. For now, we can also
use it in get_stream_filter_ca() to simplify the function (as the
classifying logic is the same).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: use classification in get_stream_filter_ca()]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 26 +++++++++++++++++++-------
 convert.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index c112ea23cb..633ad6976a 100644
--- a/convert.c
+++ b/convert.c
@@ -1972,13 +1972,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
 {
 	struct stream_filter *filter = NULL;
 
-	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
-		return NULL;
-
-	if (ca->working_tree_encoding)
-		return NULL;
-
-	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+	if (classify_conv_attrs(ca) != CA_CLASS_STREAMABLE)
 		return NULL;
 
 	if (ca->ident)
@@ -2034,3 +2028,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
 	if (blob)
 		oidcpy(&dst->blob, blob);
 }
+
+enum conv_attrs_classification classify_conv_attrs(const struct conv_attrs *ca)
+{
+	if (ca->drv) {
+		if (ca->drv->process)
+			return CA_CLASS_INCORE_PROCESS;
+		if (ca->drv->smudge || ca->drv->clean)
+			return CA_CLASS_INCORE_FILTER;
+	}
+
+	if (ca->working_tree_encoding)
+		return CA_CLASS_INCORE;
+
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+		return CA_CLASS_INCORE;
+
+	return CA_CLASS_STREAMABLE;
+}
diff --git a/convert.h b/convert.h
index 262c1a1d46..523ba9b140 100644
--- a/convert.h
+++ b/convert.h
@@ -190,4 +190,37 @@ int stream_filter(struct stream_filter *,
 		  const char *input, size_t *isize_p,
 		  char *output, size_t *osize_p);
 
+enum conv_attrs_classification {
+	/*
+	 * The blob must be loaded into a buffer before it can be
+	 * smudged. All smudging is done in-proc.
+	 */
+	CA_CLASS_INCORE,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * single-file driver filter, such as rot13.
+	 */
+	CA_CLASS_INCORE_FILTER,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * long-running driver process, such as LFS. This might or
+	 * might not use delayed operations. (The important thing is
+	 * that there is a single subordinate long-running process
+	 * handling all associated blobs and in case of delayed
+	 * operations, may hold per-blob state.)
+	 */
+	CA_CLASS_INCORE_PROCESS,
+
+	/*
+	 * The blob can be streamed and smudged without needing to
+	 * completely read it into a buffer.
+	 */
+	CA_CLASS_STREAMABLE,
+};
+
+enum conv_attrs_classification classify_conv_attrs(
+	const struct conv_attrs *ca);
+
 #endif /* CONVERT_H */
-- 
2.28.0

