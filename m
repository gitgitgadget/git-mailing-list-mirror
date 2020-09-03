Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E7C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B18D20786
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dQxta5Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgICWqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgICWqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16899C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so3261290qtj.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbGAMmD5p7GqMlErDXBuqILsXE1ccwaXq0IJWJhLIrU=;
        b=dQxta5JqENPbbwkOZxzJBg6C23ZyrZIZ+2qI1iBCUHDTUGgfqR+ulRI2H9+Y5uidmN
         DnVRNS+fDVB6wCm177NYbeDEBWLffQLEKPn8OIPs/ZGx9fA9guXgF3rI+xiCuRlyJNNx
         pzhqRt27FVonekccnhK3rFhLRsw1RcM12x8rTLGI3i9zVsvPFf2R3wkgWS/IuwZxm0je
         w8gPw3bZiUPtHqYUAQxEvevLuGo533aitEC6CftP89Tny7VR6g2EKJrxX+qs0u2lr5ZV
         clcYqJyjOkImyXi+g3EVhP50l9xGCg+Nmy1IhirkLzlCJr0yja+lutH9knRJWbOaVOqs
         +gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbGAMmD5p7GqMlErDXBuqILsXE1ccwaXq0IJWJhLIrU=;
        b=GtZUwXcYfHVo7I8CNTbIAHwzt3xBkmbg0QIW+u4IeeSTQhARO15i/0yGD8rEg+swAY
         WMhmhSPmmEadLdOV7I4b0+pr1HqA+RL4jqqHE9mRu5rl/c45Ro5UguGljuBUIlZ+huxy
         +0NVwO+KkJy1cHBSsMJUKEj0QKMYSsITH3G16J9vwN7yejdlumfLOjl+YY/i4ufiF0zo
         4qEx8t/zucifRYeRPcjQiPs8rlFpI+FJgQt91dxJslIDS5jXwsd+efR+heFZh/0GGzDO
         dKt5U7hZrLbhTw7JuYmyaYcM+emAHK2xDXmqIPH3+VhUwjn523o9VRWUSbIoHox48RZO
         s8Og==
X-Gm-Message-State: AOAM531ozsUBYeBMlRKiHInGJNgthuQBy2IsUUweDmO1rEZDDqfX0W86
        YO5ainP/1w5cZH5dzIhGQCJ4U8gvnOV5FxRI
X-Google-Smtp-Source: ABdhPJwm1zkqJKhZi74Nk7/qDHxWq1m/DZNnKRlSujla/+Ev+mmND9mC4iguEvFs0q71vdsY/Y/6TQ==
X-Received: by 2002:aed:2fc5:: with SMTP id m63mr5685690qtd.313.1599173168070;
        Thu, 03 Sep 2020 15:46:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id a3sm3084062qtj.21.2020.09.03.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:07 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 02/14] t4216: use an '&&'-chain
Message-ID: <d60698d2f8f2888b15729f1ec1fea4a1128f90c4.1599172907.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a759bfa9ee (t4216: add end to end tests for git log with Bloom
filters, 2020-04-06), a 'rm' invocation was added without a
corresponding '&&' chain.

When 'trace.perf' already exists, everything works fine. However, the
function can be executed without 'trace.perf' on disk (eg., when the
subset of tests run is altered with '--run'), and so the bare 'rm'
complains about a missing file.

To remove some noise from the test log, invoke 'rm' with '-f', at which
point it is sensible to place the 'rm -f' in an '&&'-chain, which is
both (1) our usual style, and (2) avoids a broken chain in the future if
more commands are added at the beginning of the function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 715912ad0f..cd89c75002 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -58,7 +58,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.27.0.2918.gc99a27ff8f

