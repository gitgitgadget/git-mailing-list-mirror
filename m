Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EBC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB99C20757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EoqiEGVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgD2Rgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rgs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED38C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so1037099pjb.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KWfgPTLeMs4mFOa1WtWOY/XhAUY733qIixSrxgk4CVM=;
        b=EoqiEGVTVacYjd8ZjuEaHtGam81B35X6Gianv/4raPOyevbivIsBxoJ0Z1gMZx4xwU
         q2iQGl7x4poLtBxeFTG/PbgD3udQYBVaGvM4ru4lm1BBEhin8uto10dBaIzZksUuznHr
         lXwFVoJEolqqavC8gX/aGZ+s+OJFY98x5GnfpSSF813U+SXs9+zu10afgkW1nCtvT+G1
         uDqWj6MoSZIkNjAXPIvMyOMTMrfOedBE+mRo+y0g0kCNhHKI7zQliYCDRGsfZwtfpSfp
         yw33Pbe4dMHhKs1/obLfo96KN2eq7MaWD4IkaL5lMKfyMlm5KhBurT3C/pXKZ49PmS6M
         u9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWfgPTLeMs4mFOa1WtWOY/XhAUY733qIixSrxgk4CVM=;
        b=UDhkQGrXVaOHvrdrgEtmpnk1oQSDk3iJPs5pj3zxAXIr4tSpsDQBHJ9eg8fILNqpGw
         kmE9AVYcXXWetPR1FfpIODX5ghsGG96GTuHGWM0IsGyTHW7i42UvtT6/ovAqv2qmMO8+
         w2ywbc1LaTXsKZ7EbSYw5Nal6r0NKHzHpYVOvUh21jkFamRkga+x/Sal1Yn9GLaOrja2
         K5DrmagqAF7cJQ5KmhVzM1EjaRi71LnXm6F+EG2bFv+R65wZcCQkEwi5Z98Y3pJWHbSx
         UIUVI+rbXYNXofSbTOgHIBJlJJSv+GV2VwTvguT7z8fGC42VEU6k6h0xPYBR5reMU62D
         ngkg==
X-Gm-Message-State: AGi0PubjeU3uwwCXjOPWT8t2yfSOSh/J0t3wQ+a9S1k3WZXUcVV8VRH8
        n7Ll5OUG8vk2BI6qcj3UJxjPaN65HpG+OQ==
X-Google-Smtp-Source: APiQypLREN5rr0yFUetgF3CtO8w+eMI1HvVCNlGLe8/3cm0f1/XiDCtWR/OLUPvLXyv/hpEuTdlyiA==
X-Received: by 2002:a17:90a:1fcd:: with SMTP id z13mr4344960pjz.151.1588181807827;
        Wed, 29 Apr 2020 10:36:47 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k4sm1434662pgg.88.2020.04.29.10.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:47 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:46 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 5/5] commit-graph.c: make 'commit-graph-chain's read-only
Message-ID: <864c9160675ba199b140ba961258db8d0daad004.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit, we made incremental graph layers read-only by
using 'git_mkstemp_mode' with permissions '0444'.

There is no reason that 'commit-graph-chain's should be modifiable by
the user, since they are generated at a temporary location and then
atomically renamed into place.

To ensure that these files are read-only, too, use
'hold_lock_file_for_update_mode' with the same read-only permission
bits, and let the umask and 'adjust_shared_perm' take care of the rest.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                | 3 ++-
 t/t5324-split-commit-graph.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index d05a55901d..b2dfd7701f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1378,7 +1378,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	if (ctx->split) {
 		char *lock_name = get_chain_filename(ctx->odb);
 
-		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update_mode(&lk, lock_name,
+					       LOCK_DIE_ON_ERROR, 0444);
 
 		fd = git_mkstemp_mode(ctx->graph_name, 0444);
 		if (fd < 0) {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 699c23d077..cff5a41f48 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -366,6 +366,8 @@ do
 		test_line_count = 1 graph-files &&
 		echo "$modebits" >expect &&
 		test_modebits $graphdir/graph-*.graph >actual &&
+		test_cmp expect actual &&
+		test_modebits $graphdir/commit-graph-chain >actual &&
 		test_cmp expect actual
 	'
 done <<\EOF
-- 
2.26.0.113.ge9739cdccc
