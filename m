Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C039CE7B17
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 09:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjI1J7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjI1J7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 05:59:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01982126
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 02:59:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405e48d8cfdso67247685e9.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695895157; x=1696499957; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Sv6ZJJve3k0qzy6/UrRads1/ErtJGSiJyEQbK20T0=;
        b=TQ3VSfuaDH35EijVs1expQbTQhyGMv0R3QJTnKv9poOySj9WFO/oyBcG2WAf6piDrL
         MTRdFn/eQVXsZR04td9kruYaBz7ldbtEeeGkfXpnsoew00jSCdk2trXVgkhKT5SVmrB0
         YGX2KOu6sCTl/pSz7t44oTpDgxJfLfyzrAY4zd/5G19Pvn2TiOrEuON/HmHDFWC8Tovt
         XQowjrbPchS/RjpTMmcw3w56+Rla+7cYvIOjwpjh7sR916m9NzaEfDKy6oI6hatQgI3r
         EcqEZJBThk2Vc+TknVg8vjXzcXDVIDWiEvJzo6kB0A7ruozFexdDO77uZgywAVjpuUlf
         z8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695895157; x=1696499957;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5Sv6ZJJve3k0qzy6/UrRads1/ErtJGSiJyEQbK20T0=;
        b=O5uigrjHzLoFj09c70k4LJTKIrMUPSDVcRgckKSuxjXf0yPUqfJvpxxIk2/7DRKMGW
         WgRWljXNH/RzvgsbYwzyyBe6rz3fAN1HQXi7hjOaFLtPzD9I1RIjHYXY96dRWKfzchRi
         Pl7CzCxJnONgvOkUHjvh/pO4g5UdUkTUtBwWorflIi3rMFsPT3n3xhwMe3QNuby73g4W
         faBNeMnkbOXbPLegH5dZ1SKMldmnQcKtBnB7/VjA1yNHMQ8eVWTty8DG4yr04KqIqGOK
         B4KMDxJ7MuQlMIOaQmCvWCVYx8tA0ptgxN4gfmwpgTwmIPyLYJS8qEae2OyXEULwqrxG
         N6xw==
X-Gm-Message-State: AOJu0YyXEvDWZP0Qp06yU6KXdf9G9jNmXS9yrjmqfG19FpVKGQ316zh+
        YTAAVLX7OG+KE+kx56cmmj7KXC3AEDs=
X-Google-Smtp-Source: AGHT+IH1EFJaBmj2xA/V+sgV1FTrXmVSdTvLtugERxI3JHT6jgMCO9LBOGGkChOC1hiTJ8RVny61+Q==
X-Received: by 2002:a05:600c:2248:b0:404:746e:c601 with SMTP id a8-20020a05600c224800b00404746ec601mr758126wmm.9.1695895156942;
        Thu, 28 Sep 2023 02:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b0040640073d25sm4791692wms.16.2023.09.28.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:59:16 -0700 (PDT)
Message-ID: <pull.1580.git.git.1695895155985.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang) via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Sep 2023 09:59:15 +0000
Subject: [PATCH] doc: correct the 50 characters soft limit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang)" 
        <Yeking@Red54.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= 
        <Yeking@Red54.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?=
 <Yeking@Red54.com>

The soft limit of the first line of the commit message should be
"no more than 50 characters" or "50 characters or less", but not
"less than 50 character".

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
    doc: correct the 50 characters soft limit
    
    The soft limit of the first line of the commit message should be "no
    more than 50 characters" or "50 characters or less", but not "less than
    50 character".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1580%2FRed54%2Fdoc-patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1580/Red54/doc-patch-v1
Pull-Request: https://github.com/git/git/pull/1580

 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 225c6c9f2e5..a6cef5d8203 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -541,7 +541,7 @@ DISCUSSION
 ----------
 
 Though not required, it's a good idea to begin the commit message
-with a single short (less than 50 character) line summarizing the
+with a single short (no more than 50 characters) line summarizing the
 change, followed by a blank line and then a more thorough description.
 The text up to the first blank line in a commit message is treated
 as the commit title, and that title is used throughout Git.

base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
-- 
gitgitgadget
