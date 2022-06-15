Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiFOXgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352091AbiFOXgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B81F2F1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m24so17232234wrb.10
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uYdSgTzWqiXia98lPyBfzCkBVv/id87lXXSTSIjOsUM=;
        b=YfqBfMNAqDxT7N1wEvbJqj+pS32pjU5ikpVyTaXTqoVxmyNvQtTSMcbHyPl4lE+yX1
         VaPKvMunSyCh7YqxHsZ6n33+nyiJk5hnlmdfSKcCMrkREdDlOk6fDOA7xcAmntZGmEWR
         NrsEJQjvsJPmp12rMfB/f96PPwlg9C69x6MK7KlIYj1ViISu5ilW/B+twTvD6+gcTfyT
         fw5gSnYEsSEGeVqQHEMYQpErSbFTRUV/hB9DfkF87Q9M2QKzhErxVdZpm2NadLlyN+yA
         XX9h+/+bIgOjUVNljkwlPhMoHh4JkDv8paeI1oFo3AM38b3E9+5O+yGHVxRpXFMrTdHL
         KrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uYdSgTzWqiXia98lPyBfzCkBVv/id87lXXSTSIjOsUM=;
        b=vWEMwklgakC/Pu6aIyaCksuXj44PGxPot6qQCHrmoKcCAMWZwDVebppNDeUI/FK2Cu
         2tTgbtAP147fK7MjFrjcGRFssW/zJr8eBsbZI6kpuoqei5Frh/haw/mOtED2HCIH1ZdH
         qBoEbzRDTP9ATMw+siYxtwzw0ZgtqvuiGNX8IY8GLqLsmHiNyweb4KbYQ99uYyF/KrOQ
         Lzh0ybs7C6cdjEA7wcDAbjh3tzpRPx9H1mVBI0VxAv54iTnfKTDF0Ah2KpwTw0liNH4E
         Lp6+uQ80nI9mKSMcpptUGTL5y6LCg2qI/FK3roj1y3XjhGe36wC9gcrmCXZZEnlpIb3Y
         Wifg==
X-Gm-Message-State: AJIora9ERPHYKddPf49DXQJqZVqszGH5bXB1pTR7Ef9AIpy5qatt1Pla
        JElqiuOlL4H6p3ajQsZkwHdZX4wavdcScQ==
X-Google-Smtp-Source: AGRyM1sAIGoV1HQ2rs83vcGruYg5YGC1+nLPZKYks4r/IhlVggmFTyVxr8mpfGBLcO/JYaTBNkdzVg==
X-Received: by 2002:a5d:4fc5:0:b0:211:c8fd:3d0f with SMTP id h5-20020a5d4fc5000000b00211c8fd3d0fmr2068063wrw.10.1655336165647;
        Wed, 15 Jun 2022 16:36:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c3ac500b0039c457cea21sm300538wms.34.2022.06.15.16.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:36:05 -0700 (PDT)
Message-Id: <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:45 +0000
Subject: [PATCH 11/11] bug_fl(): add missing `va_end()` call
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

According to the manual:

	Each invocation of va_copy() must be matched by a corresponding
	invocation of va_end() in the  same function.

Note: There is another instance of `va_copy()` in `usage.c` that is
missing a `va_end()` call, in `BUG_vfl()`. It does not matter there,
though, because that function either `exit()`s or `abort()`s, anyway.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 usage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/usage.c b/usage.c
index 79900d0287f..4849eb75785 100644
--- a/usage.c
+++ b/usage.c
@@ -343,6 +343,7 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	BUG_vfl_common(file, line, fmt, ap);
 	va_end(ap);
 	trace2_cmd_error_va(fmt, cp);
+	va_end(cp);
 }
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
-- 
gitgitgadget
