Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA54DC433E3
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8912B20684
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uQ5zhV2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbgGVU3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVU3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 16:29:44 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985FC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:29:44 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so1631673qvk.6
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5D3/gGEdNiZqPVq5sV3LgR2ud+onT6HQWFJ6WDYdqYM=;
        b=uQ5zhV2a0RAO3tAGjh1KHts8pgZaXqhz8Am6xXBQ62a6uArCgAzhmf7A57gWN2kaMx
         6nEYu9Z8Zxrk99rWZWspcTZMFLsLl+rE9a+E34xL6OXVp/xCHzR8tc0LuOb7bDFDfkW6
         buGs1fE2Xby3bRig3GhJhmAevn8JfhQs/a/7xMKiACM8C9ysh0mygZ9a7q++JaC0WgH8
         Kqw8txVWa8HbqGajOLqr/YSUKU+lJA94R68mwtmYX6uJKoABAjtwA7EkCc80zDRxWqAb
         9Ezu6enTM0L4TPe4SRxPE1Llf85XZ6R6eTSOxuyoKEhRTFBuIHQjyVth5LROAB+zJFTj
         RgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5D3/gGEdNiZqPVq5sV3LgR2ud+onT6HQWFJ6WDYdqYM=;
        b=ImBbcd6X1eDGELcGod7bgYecYqeIXidPxGz2SFaGIrfASv+NiqWVDTZKYBPJY+FTs7
         9yarOT7vwA3qvxH5Qjh7L1TcVjPGGEmMFmDWFGCKzOvpY8gsRuDoyIl2yE3XFuO8P6O/
         /Bb/wLgbYmiREWrfJ4mdEWonhggkAhOr/STsI6nWrW1sASWLrEjVMIM8cJfyp7BuJX74
         dUX8liSfquUlrB1aA5tKHR+HOMnrqgy4gBeGNYmuUTin0G1FYiyjHNIUOd1Pe07sKZ+H
         OIdPH9IB1KMyCClcNBDwOLAfpdVFfh4K+s/iz2Nw8TZR8tE0PDlhTHhQ2lnE7447QfRN
         ZZvQ==
X-Gm-Message-State: AOAM531v3DsVTDmMDCo82Ni4q7F7OJPAG7ZcEbRXO//7bk9fTDGIMcnF
        OeOYEevkmZxC5cNWdgDrK4XFBExwOQJgDw==
X-Google-Smtp-Source: ABdhPJx+eej6CPvijf/FnjOEUILMMfQRxPQgU9lF6bWK3iWWD4HG5lSWAhdBXma+32YS634aASv4ug==
X-Received: by 2002:a0c:83c4:: with SMTP id k62mr1759486qva.19.1595449782932;
        Wed, 22 Jul 2020 13:29:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id w44sm634302qtj.86.2020.07.22.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:29:42 -0700 (PDT)
Date:   Wed, 22 Jul 2020 16:29:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] Documentation/RelNotes: fix a typo in 2.28's relnotes
Message-ID: <e78abce653d4bf13b9fb464db3d8ecf6b7d137b2.1595449743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---

Just a small typo that I noticed while reading the release notes for
GitHub's blog post about it.

 Documentation/RelNotes/2.28.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.28.0.txt b/Documentation/RelNotes/2.28.0.txt
index 5f1413a699..6baf781380 100644
--- a/Documentation/RelNotes/2.28.0.txt
+++ b/Documentation/RelNotes/2.28.0.txt
@@ -116,7 +116,7 @@ Performance, Internal Implementation, Development Support etc.
    configuration variables in extensions.* namespace were supposed to
    have special meaning in repositories whose version numbers are 1 or
    higher), but this was a bit too big a change.  The behaviour in
-   recent versions of Git where certaion extensions.* were honored by
+   recent versions of Git where certain extensions.* were honored by
    mistake even in version 0 repositories has been restored.


--
2.28.0.rc1.13.ge78abce653
