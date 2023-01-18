Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123BC38142
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjARDa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjARDae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070C530F2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so567125wmc.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=KArevTKHxNA9sahTX4G3fPdoLd2FzIM7U3Fu6cL7g9vT85XOZ3FO6AHgqRFFYvrLNF
         zTSTOvbN83unrcMQHCpBev6HGuT5HdyPlIvGwT/WGU0EyF37zbbEOQ9E11Me+T+vX2F4
         xH6w84JVLDHfJ/0CYkN62FMf4lttAt84G7LUy2WNIrTFRfufqKj60+Apt20Yak7gWy+t
         m3Y7oWLshHjz8mN3N1Xr17p11e+AuyTuofteUnh5S9IceiqQ7BGZ0DwPpgCy35Jr4Tc9
         Hhk0R012romINAZiFlbqBQjMKa1n1cNyx/SbmHgNoY1s7PJBVG1M50ZGfdrgoik4x/bC
         rD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=vfq9fvmUvzqeHHlfw7ulvNKeteDo/lp+FQMsULngXmX6Jp6CVrSctc0pDqom6UffL5
         X4/VnwwnG73/kGTdXHvMo7W3D3/zMpsDdVP7LliyoLEbzQ7INPadSdtl1L8hbLMQm87W
         BQ9HPC9iWCwZ2V2rJBlBu12uoMfV1y1hS0Vy82Rm9d2gOE7+R008MPmDyujrXgIJklC0
         exfEFHQCIvfZ8lBHyKUcWEBXw4F378fAuDusLv2WdvELpOdZsfNacsqRgwzdyAw5fEJ9
         uvX/37uHB8FFPRjTZMbSJgT3OPsRy/a1HpFpwLUHbdB2mSjKStCO/lwd76IYCVRXc+Dl
         WcSg==
X-Gm-Message-State: AFqh2krcdoBCz8DAKhgwkE2vVRRvMYXdTSNvGEe1sEzAFNV1whRtvOsG
        5uynVmcLF/u2mCopD+F0p6uCMRoGhvU=
X-Google-Smtp-Source: AMrXdXuKWWrAz29vN+f0Qke8FmKDwCautmDsMOTDtsKL2+sw8liOpmzlt0LCi4+aXItFcCwdAmV0OA==
X-Received: by 2002:a05:600c:54eb:b0:3da:2090:d404 with SMTP id jb11-20020a05600c54eb00b003da2090d404mr5079997wmb.18.1674012628370;
        Tue, 17 Jan 2023 19:30:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b003d9fba3c7a4sm605900wmc.16.2023.01.17.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:28 -0800 (PST)
Message-Id: <cc9a220ed1f12aef2f4df940e71adc1fad917a6b.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:15 +0000
Subject: [PATCH v6 10/12] http: replace unsafe size_t multiplication with
 st_mult
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Replace direct multiplication of two size_t parameters in curl response
stream handling callback functions with `st_mult` to guard against
overflows.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 8a5ba3f4776..a2a80318bb2 100644
--- a/http.c
+++ b/http.c
@@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
 
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
-	size_t size = eltsize * nmemb;
+	size_t size = st_mult(eltsize, nmemb);
 	struct buffer *buffer = buffer_;
 
 	if (size > buffer->buf.len - buffer->posn)
@@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
-	size_t size = eltsize * nmemb;
+	size_t size = st_mult(eltsize, nmemb);
 	struct strbuf *buffer = buffer_;
 
 	strbuf_add(buffer, ptr, size);
-- 
gitgitgadget

