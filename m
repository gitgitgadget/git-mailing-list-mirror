Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0490C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiADSPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiADSPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:51 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F211C061799
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kc16so35192200qvb.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMumUQ2hzoDKMXFY3lwDuDhafwwkP0GDPscap3ppkSk=;
        b=hkVQm6Yk3kPHzqyIXELe1On9ydagw0NtAtdJFdJ4YACX451OZmQmEYwiP4hKPZYJTX
         9SCCf6nfE3Z1Pb7mho0BjCAO2zq0Tju9VB+3/4Bj0L7xu7ApdPhVkvyWBXaGPkwqK1HE
         T3C8JTMQEHjZwetz3gWuwz0wa4Lgm+ZJqBe9M8zoBnV2VvXPSmwagXCZxMmrVbsfFuyu
         bfuXQo4mTtHngoYDB1WxvLWUxZUOtt4YdEb+qNm3aQg7B/U2wOxCMkHWqGB+2iNyJpVr
         bDLwzn336BspGyyBzhmomBH+G3+7Yw7hxS641pZ7yMLjkx4cY9V66Vkqkhga4V9Mw74J
         sdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMumUQ2hzoDKMXFY3lwDuDhafwwkP0GDPscap3ppkSk=;
        b=mktvX7LAZTI0Mo6RoVbKSsgtAirGREs2LRu7mQyPkT4eR0E5wliYOnO/3oKqK3rj4J
         GripTcep1XfV3mvPwGtkeD1O+dVJytcgD4LD7GXEMMsuSPvFH0C2Wo4llSr652+uiqW/
         6eHHBZX+hI29aPvkqimoUvDnFAxiNV1aGa6O98v4RC8Oi1ibJKEFv4ZMkx/z5QlBxDf/
         UoeD/rXZAY6xbDhCTDwVhCKjHWM2t1bu9DE0QcFK4Se05UxFqBKL3jwuIz/gmwyEti8E
         blyEcsSHhWDj6dlbgD+Sfm+GcIqFtknHDB6/M1H2rxOiGL6CIxnFAwl4OgMnbHRef6aU
         A4Qg==
X-Gm-Message-State: AOAM5315qw9qVbiMGTyzn2w47H9LNxhtody5RoVmkW944J1rjN7jU+fP
        dSWTUJ3kPNysGeplGd3yhvM0wyYNvgcI2aIZ
X-Google-Smtp-Source: ABdhPJw4JaeZMm8kvqdB2q8rVbJf5s1QeWZeb8ht+OIeOLQE4mBQ+pcRO38VorRPNS4a4C9cuCD8Zw==
X-Received: by 2002:a05:6214:4110:: with SMTP id kc16mr46695780qvb.49.1641320150065;
        Tue, 04 Jan 2022 10:15:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t30sm30255954qkj.125.2022.01.04.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:49 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 4/9] t5326: drop unnecessary setup
Message-ID: <5818621ea8ae6cb4bb1364621c33016edc208438.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.multiPackIndex config became true by default back in 18e449f86b
(midx: enable core.multiPackIndex by default, 2020-09-25), so it is no
longer necessary to enable it explicitly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 353282310d..1a9581af30 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -19,10 +19,6 @@ midx_pack_source () {
 
 setup_bitmap_history
 
-test_expect_success 'enable core.multiPackIndex' '
-	git config core.multiPackIndex true
-'
-
 test_expect_success 'create single-pack midx with bitmaps' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap &&
-- 
2.34.1.25.gb3157a20e6

