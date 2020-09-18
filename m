Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D4C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C770723119
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bfHIMk2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgIRC7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgIRC7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756EEC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cy2so2160670qvb.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8jOg6UP7g00kjSZ6nPERjjGDqtG/cJagvs6eGCfTRd4=;
        b=bfHIMk2b+CtXijJXoDUt2lwSVvjvCIfOUGe2aeLodU3EV48k9GAVsQne63pZ3D/PwP
         KlIwJuypvVKRD17cqmK2OaZqFvBlGIuRMJ+4t7jfHB4+B7kdgThopk+kYV2s6rAfexil
         tDHYM4awrJHZrhAawr9Y1yjcdf8Mu+rah95iYKKjUguSez5Tvf/ymuRD+S6EyRJzMBnR
         dQZSI/DdgePpvnWKNKbhipcNxmbvsyXiy0XpRPmUeLPqHFVrAkTsO13TRFXLCPlX+h0U
         GdeDtMBrKr7nGjEgKyOJL8NWingvs7QFgf5ojGHdiaXH3QltZtZlTgqlBSkTSCnNKlsC
         CN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jOg6UP7g00kjSZ6nPERjjGDqtG/cJagvs6eGCfTRd4=;
        b=s5EqgJXNZvYkiyJADP1Y3jkP53bxXYZi59WDXKxIYYw7xHD8S5Uhi6TbYwnj3Mugf/
         RYW8gdBTi+fO9VJS/IMKxPAybFbazR0dTixYi4Wskrnn5Tx+stsUF9Ou+gUJH8RgYCrX
         Kxyv33mzdN0L/5TPC3qZNjysFU6fOAM/MV/AeYE/FPFlMHuuqkmkYXk2Ezl/ljM0zTIQ
         UCnvFR6jj7ylZBadVArFNxliqL6P7cFSp4IDioxYiwW89mm/+UaycwtG/8iKOCSYCqcJ
         0+VMjEGjd/LRfw//6ynx0kPxqwnbolM6U6yoEdF1gxlYEfA3o3BlUS3l+l+3Uq4H1m/K
         mV2Q==
X-Gm-Message-State: AOAM533Z7JCSCtNAnihVBmur8dJkT1duVoK+vl9vim4JOiHaCgSapWGH
        muZ7LEskIUncSjSFMtE9xa8Szn07nm5AyBSW
X-Google-Smtp-Source: ABdhPJzFHZPeIxSrPShJhwn6kipTniU2HZ6Jza0FfRxJV+RBA8xgqfxInJdjqGEdrgSmihQl/0zx4g==
X-Received: by 2002:a05:6214:17ca:: with SMTP id cu10mr31300288qvb.6.1600397940435;
        Thu, 17 Sep 2020 19:59:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id o188sm1225491qke.83.2020.09.17.19.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:58:59 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:58:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 02/13] t4216: use an '&&'-chain
Message-ID: <6c2a8c9c2f19c6a41aa22f25f3bb54defae4835e.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.28.0.510.g375ecf1f36

