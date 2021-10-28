Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22659C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B6060FC1
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhJ1UxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhJ1UxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CAAC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m42so6955275wms.2
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sF22lQObrJDoM/89dY5Yn/wl6X5w4lC79GmCyeJSztk=;
        b=KuM6cL5w4AzsfJ9O+4kdbLLvj3VqINLUfX2MfpvWHc/V9unZsbJ54BG3EEK9LE/Ed1
         OyR89iTHuffZO27q7t+rd31W68oga+zWyaG4Etz2x1l/cQXsnTgqFaQIPiqNujTVN9aU
         tTMOWSIfRHof01K6g1afSpP+k4+W8omogUIXkWtEjoG/RzvlMuQe7NJz4y8u5YG09o44
         AHEcmXHl7VOTMsJAGpYoN6wYs+L8Qc5svL5rNRt1AOzQzNi+gVb8AbZsHZiOsQvqCW4O
         UcwdJkm+uWenPK4m8uxjLsQyDowZUt1Zn2AcMCt1cj0YiJcWIfMjqWn6aZXl/tQsYjc4
         clWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sF22lQObrJDoM/89dY5Yn/wl6X5w4lC79GmCyeJSztk=;
        b=qQW9nWFDMTZMCum0xszzTlNLN+RiuqqrGtEd9zWr4eUfZcX3LpAfgXkEU69kVzP0/3
         ztWQQPnqKiPJtATNgmWYEqkq7LgASqag4XWts9nCw9mEvqgFV5Ty4hf+d/MJHQTxl7wU
         ayK+BIcUYxMSASwTqfmmeBt+LLRO1vQZFs/ke0RIKWrzKkbeUyAt6TS4SIN/E1+qzGem
         7QcCsG8W4uREjfQ66B++0bIp17xLbQgUJfYo1wXJ2PPNlKi5ZacX75gFazFcKQEX7+U1
         5jKyC2WkmGp7XLOzgpYwEqnYGVHkMOnxT1VGrEqHFLLNFpKHKY/Yg8mRZFzCO3xefa88
         VvMw==
X-Gm-Message-State: AOAM531KdatP/YYZ/jRl6mFSiteExRPBWvVyVqTXzcSSYYyMEDtV26tZ
        DVFD8+fdOQO5ileLv9ZmkFJrCOUynK0=
X-Google-Smtp-Source: ABdhPJwvbAssAKuLAkcS9ZgrYRcYoHmUBpW0XhGY93WrVhvsiim2hmSWpT2ginkDbc+eylD/UuVzUA==
X-Received: by 2002:a05:600c:2043:: with SMTP id p3mr7305512wmg.20.1635454240131;
        Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm4691010wrs.90.2021.10.28.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:39 -0700 (PDT)
Message-Id: <6edcbae372ef63bd75ca6cc2d181f7506f35880f.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:32 +0000
Subject: [PATCH v2 2/7] test-tool genzeros: generate large amounts of data
 more efficiently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In this developer's tests, producing one gigabyte worth of NULs in a
busy loop that writes out individual bytes, unbuffered, took ~27sec.
Writing chunked 256kB buffers instead only took ~0.6sec

This matters because we are about to introduce a pair of test cases that
want to be able to produce 5GB of NULs, and we cannot use `/dev/zero`
because of the HP NonStop platform's lack of support for that device.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-genzeros.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index b1197e91a89..c061c429da9 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,7 +3,10 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
+	/* static, so that it is NUL-initialized */
+	static char zeros[256 * 1024];
 	intmax_t count;
+	ssize_t n;
 
 	if (argc > 2) {
 		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
@@ -12,9 +15,19 @@ int cmd__genzeros(int argc, const char **argv)
 
 	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
 
-	while (count < 0 || count--) {
-		if (putchar(0) == EOF)
+	/* Writing out individual NUL bytes is slow... */
+	while (count < 0)
+		if (write(1, zeros, ARRAY_SIZE(zeros) < 0))
 			return -1;
+
+	while (count > 0) {
+		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
+			  count : ARRAY_SIZE(zeros));
+
+		if (n < 0)
+			return -1;
+
+		count -= n;
 	}
 
 	return 0;
-- 
gitgitgadget

