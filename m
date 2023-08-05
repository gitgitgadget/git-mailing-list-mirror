Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12060EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjHEFEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFEo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F904ED3
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31771bb4869so2485115f8f.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211881; x=1691816681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+OogCcDE6SBXq8d85cFls+RFceySrodLASDp6pcyd4=;
        b=UvB4bFktUuhRclRpCkJAmN9/ckuk9AUDIJSpQTwiZ7ONx7Ns6VI38ZX5hKSYx7eUQD
         cLnWAH1X6FA5TR70ReRzgIZ7GhM9kaeU6TUYOd6QGtjYQcP0FF9Yr2j73cECASyA7pei
         y35RgpCLW6lcLKg9EjZIgJGt6aQvmujpVsdM/bbkn+Vn/I9mfsSoiBWAvIgHnH3wfDWS
         xsprBB37WnlbJmpgGvsvKhyWAgYTDaKoBIAkNzM/nIxej8SzaF1Dp90wwjRI0ly84Upn
         +EmQmgIpbmkpjoXXMvGj41IDDJYgYDWfh21FHWaR28TQ7m4Fni7t8bE+rcXaam3bJGu3
         /vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211881; x=1691816681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+OogCcDE6SBXq8d85cFls+RFceySrodLASDp6pcyd4=;
        b=SQj35d0Dp6CgmEsNSPWlODkAQpbd3vAasPNsI9cxMO3aKwBR6tNZc5HEeAaagecte9
         TEJy9nSJkCP3Snh7GG31qrmkjcOngN1EbMp3V4n6+u73/gLBoEOkMAVvxDaUaZtF3F+F
         zwbrQYqCRCLjfcXFNEilKBXugQk3GNc3NE6I4d6TVnbVluoropzuatOmaGCv8TdBTUnP
         qLcVuQ/5FcpCISBkS6fHJOSDeCU2+A9omq4w8lNfAfN/ahHUVDa4C8yHbMUn1PI5Zy3e
         ictZm6Cp43vmEHiwepzYfjYD4aJTR9lSdVF3ftV8QBa90qyQr7oOzDbB7pcQWhxx5YhR
         s0lA==
X-Gm-Message-State: AOJu0YxcP/DAyc/IwRsFUuPO4hI/w+zme5IQJp9pdYoPFgOG7c7RlEPa
        Hgd8Z9TbXiAVM4BaTpZ9VnQbAukzbyY=
X-Google-Smtp-Source: AGHT+IGpuhFHq2HvvizFLuKxAMN5fYGb8uyeLi/Mws5tY8cKtsD6Mb7bSmb5ZhvojHQn9dktZ4Zfjg==
X-Received: by 2002:adf:e909:0:b0:317:3f70:9dc4 with SMTP id f9-20020adfe909000000b003173f709dc4mr2577453wrm.31.1691211881391;
        Fri, 04 Aug 2023 22:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe711000000b00317afc7949csm4112592wrm.50.2023.08.04.22.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:41 -0700 (PDT)
Message-ID: <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:35 +0000
Subject: [PATCH 1/5] trailer: separate public from internal portion of
 trailer_iterator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The fields here are not meant to be used by downstream callers, so put
them behind an anonymous struct named as
"__private_to_trailer_c__do_not_use" to warn against their use.

Internally, use a "#define" to keep the code tidy.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 12 +++++++-----
 trailer.h |  6 ++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index f408f9b058d..dff3fafe865 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1214,20 +1214,22 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	trailer_info_release(&info);
 }
 
+#define private __private_to_trailer_c__do_not_use
+
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&iter->info, msg, &opts);
-	iter->cur = 0;
+	trailer_info_get(&iter->private.info, msg, &opts);
+	iter->private.cur = 0;
 }
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->cur < iter->info.trailer_nr) {
-		char *trailer = iter->info.trailers[iter->cur++];
+	while (iter->private.cur < iter->private.info.trailer_nr) {
+		char *trailer = iter->private.info.trailers[iter->private.cur++];
 		int separator_pos = find_separator(trailer, separators);
 
 		if (separator_pos < 1)
@@ -1245,7 +1247,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->info);
+	trailer_info_release(&iter->private.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 795d2fccfd9..db57e028650 100644
--- a/trailer.h
+++ b/trailer.h
@@ -119,8 +119,10 @@ struct trailer_iterator {
 	struct strbuf val;
 
 	/* private */
-	struct trailer_info info;
-	size_t cur;
+	struct {
+		struct trailer_info info;
+		size_t cur;
+	} __private_to_trailer_c__do_not_use;
 };
 
 /*
-- 
gitgitgadget

