Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7778C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjBGSSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBGSRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:34 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B63B65E
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527b1358200so68143987b3.13
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K46XHE2BLqdDbnyWSR0bU7t4XlcU/9xs6xJD00qC73Y=;
        b=at7YRqjz3SHiQJe8AZ1SoSxptRkeLigsj5bmrPaSgdELCZHGMLdJ9SjI/DMzWvVMrY
         nYPCKaBffsCAxPKs73flxXti49DBeQ8Cvea2e6FtqC/PhS+7+7FSsx76xd16SVeeIWd1
         lHFrVTIfIAs67FMfJClzvfWlVkFmTsWcMZbYDVxNNx5pomiq7Ony0q7xsLC7qxaz0pE4
         dUG1zy9otfLzADqG2K3kBeOWfTbiLzlMh2Utjvq91aLZQraNIgjaZHCe7fHrrfD6Ip2k
         FbBx91xLRmGaYwqiJhHEIo3WbrEPIsVa3/JPZMz2ADsevh80HdLc9tQ1OyfJb8cfZmDK
         mPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K46XHE2BLqdDbnyWSR0bU7t4XlcU/9xs6xJD00qC73Y=;
        b=JK/mS/GnTAafEGDviGSACnKgMSyghBbdQdzESuiFrDc481Snh0hVgy5pKDmWWkIOWS
         b22RG8BgZZQML7DckM/2gZzn2VhRvrZWXKz/VvYnq90h2bLPPjBuUb2/B8i8/usYzVzz
         n6JdFI2CZvqpIF/dxlNPrIxS9P1+pDk/xVikgxywfxQjQ4eLEjGOo5XMjj7IQuwSvX7X
         LSP+KtaxdC3HcxZsK3VEj8Jw2o8rgxRpRFp80PYbcxPxi80C73Ze9S0FxhDSULixboNL
         LzUcivr9H3VkgBV5ubLauv0FmTuc2aZe+A5VpLn6Oco3GqR4bY5SclOVvagRwb77hbj9
         KXWw==
X-Gm-Message-State: AO0yUKU+/bUtKVm5mcsrMjuCZAzu5STXq+xzRZ12yU9bikXCRVCd49VI
        WnBT0ZWbJhe00qgo5cejgM9qXMuY6yUDrG7Gn6swaloOlR6vsvd1/zlqGaLPtwpdkHrggUucdX7
        5I/iiGLWlCL8wv869XMXJxCEmcJR2D/QjtbnwDC9PhLm5U9lk/hhO8e7tTfTWqdpmkw==
X-Google-Smtp-Source: AK7set8WEgskc8fZUL5wQDI3umWME55Bv0N5HySKKy7v6mgvGT2r9bpgSFnUK5qTnwAOhAmU8rAbHlmvqwJJJ+Q=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a5b:c12:0:b0:8b6:a289:24a6 with SMTP id
 f18-20020a5b0c12000000b008b6a28924a6mr129966ybq.569.1675793838705; Tue, 07
 Feb 2023 10:17:18 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:01 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-3-calvinwan@google.com>
Subject: [PATCH v7 2/7] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index fae24ef34a..faf37c1101 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.39.1.519.gcb327c4b5f-goog

