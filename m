Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5118C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6021D7B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjNqk3nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIRLTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgIRLTh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBBC06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so3222995pfg.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QI0CvwzbDt815bAj/1bM6TD12ES+6y22JgoOubeRZVw=;
        b=LjNqk3nulNwt6kS2PK47a+yM3OZoNin4QbgVOE1UNZQWqySYMN4I66F6QudkKV52hV
         SkFc70hspfnAdFHDD5crDKeN92KNaBaJ0w0bloQR49eKGBEa8YKn7TajwS7BKHLmgtth
         JzxctKWmhfbgWAVHtxm+4RL731tGGBQ5/Rh6aN9/k3aBOAifBrievK1zI/ctBG0FffcB
         Ucuvtr25vlxHU8BIoF88rOl7LW+LjPnHtuMvwG14cboBPWQvBWgVvCGUaI6eLpPMCsk4
         3a/tkLM84PkwY5T8jQ64hKIwgVo/5Zs5dF+4eMmb/QgH6Tj7OkkCAK4aXxDWM9xyYrIu
         k2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QI0CvwzbDt815bAj/1bM6TD12ES+6y22JgoOubeRZVw=;
        b=rFpOMa2sueybFSzgeP+twG6m3MP74ifZrq+Mlitm4252CQ3PVrG3OZZMosaztlqY7f
         IwtTdEyrFuCis5PghGLAZH8cT085lCCQByAo/GccCplVoi7EgGBC9BsyRk7cQTVffuZ5
         0C0SIXj6toY2EcyTX3dLydJpxLUK5MNSvMbQwQGg2cxblrtlhINEEs/X7gd7wZu4u2Xo
         WYujfsXeF35pHW/41rTTHJS/WGrYFQSzYNGjIPx0KqsGoSVNGiwwFCC9YWLn4U/Y/Mmq
         +pEy72Z3m/TaC6gaNc7O7lgwsHg510k48dkle9yXsx/UfhbzSPw55QmjWVYu9HdlNOrN
         1KQQ==
X-Gm-Message-State: AOAM533yqYDDZE5Yjk4/kJwqCgIlqDf/K8P73oB9OSMp+cS6lUNjDwv8
        whi+vtK/Bjr3r68WFPcqjUTbzHTD7H0=
X-Google-Smtp-Source: ABdhPJxKaFc9qtWVkvyleoRyjvu0ln7ee1tbndEIj2xMJ8hQwumtDhwFVPbCawboFBPCsPTmCKhmQQ==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a081 with SMTP id 187-20020a6219c40000b029013ed13da081mr30876132pfz.24.1600427976970;
        Fri, 18 Sep 2020 04:19:36 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x4sm3034120pff.57.2020.09.18.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 04:19:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/4] hooks--update.sample: use hash-agnostic null OID
Date:   Fri, 18 Sep 2020 04:19:05 -0700
Message-Id: <42d282988961545fb1ab6405a08368d14ffa1450.1600427894.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The update sample hook has the null OID hardcoded as 40 zeros. However,
with the introduction of SHA-256 support, this assumption no longer
holds true. Replace the hardcoded $z40 with a call to
`git rev-parse --null-oid` so the sample hook becomes hash-agnostic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--update.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 5014c4b31c..5316362af5 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -60,7 +60,7 @@ esac
 
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
-zero="0000000000000000000000000000000000000000"
+zero="$(git rev-list --null-oid)"
 if [ "$newrev" = "$zero" ]; then
 	newrev_type=delete
 else
-- 
2.28.0.618.gf4bc123cb7

