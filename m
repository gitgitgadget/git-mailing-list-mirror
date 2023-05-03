Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E1C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjECXX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECXXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:23:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A883CC
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:23:53 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-18b5c8c2a49so3978023fac.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683156231; x=1685748231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjCwFBzhXfeva8DiGKPT2+/LMTvBQ6nKv2hbIsce4Pw=;
        b=W+1hWBPUDqD3JYuAt3rmK+b0DMaloVguj7CVbmM+d2gF1EZ3G8/bF+CR4rOpXa93uR
         VLKcw3e5ezaXh0cXYOZfViVwf4BV4YN0LC2RydmXDYeCzSUPl44Y0/XvwJxsUDn7jGt7
         mx2j49uz8CzfqQFvfu6Tg366YVCrs81z+x8bisqtySxi1DCD6hZyiatDbrrUk4yXlOEV
         gKdKpYsgWCmQwSNO/ilJX6oyC6Nq5WOIwRZANXElHRCWNu0K/0nKdoCELb0i+MIyCbOi
         Db1CiMHN2j/7uu+yU5vs5RKiLLJfOVAe05niKa9MyVCQsrp85O0eNTFgyEHozqLONlm1
         r/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683156231; x=1685748231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjCwFBzhXfeva8DiGKPT2+/LMTvBQ6nKv2hbIsce4Pw=;
        b=F+zQDJwjwd9gmkMsFAB4mpsXukTbXcdGKVMbxfU1Bnuq3lxv2oiFKLVS3bCVAHsfaJ
         61y0lGBy9gqEdrQO0WiBbsgvu4jBwj2h9cejtyCGSIt9GvlxwPicM3vfal+KBP4l58i+
         dbaBcIrr/qja+dBsD76BQ3YlnSFBQ9VB1LLTMrkx575B9SnJcRgCpuMVArVqgraYXB/q
         Vzl/KWvdZ3RVw8fUX2DeMAdzdGGQlvX/xKhWztMO210XrOmlkyRa80JJMLIvG/Uv9mzd
         dGdGHl62yi3g5tZaTRvIy6TklY5whhnZMUOCwdvdWu4LkXUe+f39Bd3G4SJN7CULacuS
         m55Q==
X-Gm-Message-State: AC+VfDycOgBubyXL9GGyQLU0m6ptCmw2Kpx8dVzAeYTX5u15atqSvn01
        QNFmxjx1OTDtxFudPLeVFz9ir5E41n0=
X-Google-Smtp-Source: ACHHUZ5PwdNpLBbSb2kFATv82L0XFoH/vWiZrISGO99CJ2MQnwTVT6vPy93UxrCJ/RD/DDuwfHCIjQ==
X-Received: by 2002:a05:6808:2387:b0:384:3f55:ab96 with SMTP id bp7-20020a056808238700b003843f55ab96mr862778oib.25.1683156231470;
        Wed, 03 May 2023 16:23:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d6e97000000b006a144b97e73sm1078798otr.74.2023.05.03.16.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:23:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: doc-diff: specify date
Date:   Wed,  3 May 2023 17:23:49 -0600
Message-Id: <20230503232349.59997-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise comparing the output of commits with different dates generates
unnecessary diffs.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 1694300e50..554a78a12d 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -153,6 +153,7 @@ render_tree () {
 		make -j$parallel -C "$tmp/worktree" \
 			$makemanflags \
 			GIT_VERSION=omitted \
+			GIT_DATE=1970-01-01 \
 			SOURCE_DATE_EPOCH=0 \
 			DESTDIR="$tmp/installed/$dname+" \
 			install-man &&
-- 
2.40.0+fc1

