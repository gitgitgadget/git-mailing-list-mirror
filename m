Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF46DC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiHVTun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiHVTuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98A4DB70
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:37 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b2so8718372qkh.12
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tuvUAhGRN5xXKXxLp64O3OCnHzZvI5R33q/Tv4ZPE2c=;
        b=ZS6obIg7d7WqcUwXSr43zI5dEwcgQO3vOF5ubkZ0gg2gzTgN4ZKu8W6tP7dHpDzmus
         rSIwonyKsu3lb/lQD/UkRBk6m91SCZkFlx872yrZ+SAYBaPPfPycLZwrQ2ShY9fGz07g
         GfyAcd5g4pOvDAKl6u3S74cZ6ggkIv3K4GZCKCAc2esk02Z+Jbw3v9+esnbDB6AzPIbe
         RSKOXaQ0fO3AKgLn0/NNJ/KNG3xdde1mVZ7knY4a2y8T0O6P04wctSg3x/HPKjJWh6J2
         YNCR7zDoMRdNzmZd3Xw27F1MsJXM3NAvI98xsWQ5EhrApC/VlZI2Gr5JqaAoUSkdPcq+
         PuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tuvUAhGRN5xXKXxLp64O3OCnHzZvI5R33q/Tv4ZPE2c=;
        b=f4oH3Gq6+4/WrNzC1f0X8IYJbORU9aP7j0wf8ryAK2SFPZ8lyLZWhLDS1mauSSW7k7
         Zd1svk5zHrGVRgFj1MrsHUDNDgDYmrpvwAXX9JqUv8bTgoq81ZS+fjvvkdXyzidsJmic
         V8UQ5DBo5e1h/rSkE0Bn1DLXPFsGL5v2nnqImjVNFYFSqBVX0WJ9eRoimRODm81INnTN
         M7wslJZDT5q6jwINb2DLnMZ3Wb0363xa+0si15/U5UGCykmWdyGIekigAC0OsN6xVYI1
         T2rDtKDe/0YK/LBZfUln7SAOqlrgnc6puTQ1U/LgqCRE1oJmnmvYK6fjJ2/IkQxFE70+
         WwfQ==
X-Gm-Message-State: ACgBeo3pje/XS5Aa8MKDJRbYVVjWSRjvygQbmq/moqXK0Ftv2+g9HA9G
        U9Nriir6w+WnYyRDeNwFakX41vuiOmulzJyY
X-Google-Smtp-Source: AA6agR46Bev+nENVlSi9krC0oMCP3076gUq/FeqQX4CKhTW/3azlfFQVkq89Z/zE6LsBX3LbTPOM3Q==
X-Received: by 2002:a05:620a:385:b0:6bb:5a16:54fc with SMTP id q5-20020a05620a038500b006bb5a1654fcmr13607666qkm.46.1661197836623;
        Mon, 22 Aug 2022 12:50:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bb27-20020a05622a1b1b00b00342f917444csm9243621qtb.85.2022.08.22.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:36 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 2/7] t/lib-bitmap.sh: avoid silencing stderr
Message-ID: <d6648ed88fdc9a42cdd6a763025d99d361147500.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The midx_bitmap_partial_tests() function is responsible for setting up a
state where some (but not all) packs in the repository are covered by a
MIDX (and bitmap).

This function has redirected the `git multi-pack-index write --bitmap`'s
stderr to a file "err" since its introduction back in c51f5a6437 (t5326:
test multi-pack bitmap behavior, 2021-08-31).

This was likely a stray change left over from a slightly different
version of this test, since the file "err" is never read after being
written. This leads to confusingly-missing output, especially when the
contents of stderr are important.

Resolve this confusion by avoiding silencing stderr in this case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-bitmap.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index a95537e759..f595937094 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -440,7 +440,7 @@ midx_bitmap_partial_tests () {
 		test_commit packed &&
 		git repack &&
 		test_commit loose &&
-		git multi-pack-index write --bitmap 2>err &&
+		git multi-pack-index write --bitmap &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
-- 
2.37.0.1.g1379af2e9d

