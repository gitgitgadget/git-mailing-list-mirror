Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB8C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820922070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSo+XHgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgEOSmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgEOSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:42:25 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C234C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:42:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 72so2725629otu.1
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KWbnJeVaypQf8LNmNEzdxGFE9MxKtGFbslkj2wBpp4o=;
        b=OSo+XHggHy1HKywP3hAkzEoAZJ7c4XCSf4gj2fFgW8hnoOENCttoxzQLaqsflsgSgA
         LXgnwY7Wg9JlNr7uuG90OX0XKYmvJw+l55ob44zu1OOsx4pQIQamznKODc6Ov9nBpY4F
         IPNgkY3Hq7Yf7r8xijAGkPlQgBICZzyEWd1UqLGMDfMmLx49c4udCD9fNs4qx9RDxDpk
         8naIB2l+unfHZ5LqLPGV2C/itfoxUuceD2jVEikcYb77mCvJ2NL3MMa4IiFcfXgMq0zX
         8j/8Vlm6ZJKsYQTYA/CLki4h/smHLtKR3JCBSh17G1E5aGQZfVjZKsvscyXpOY8LFkZo
         OMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KWbnJeVaypQf8LNmNEzdxGFE9MxKtGFbslkj2wBpp4o=;
        b=krqM5bERJXlHtYqQRO3dr7g0iClCr2PrkTHwYBVpyKb3rywEjYBW0BrQ02YXqW+/JJ
         j1oO1WjLD0GusCKm/t7AyVXocln4dw69G8meKKru/PXgNDVD1xgVR+KLBuiM/8TKovKv
         3cVhKjSzCxZ62EcXrg6toclyqXCKhztq83LIS2THHi1ed1RqSbDS5D4Y+dFVHAcFPpaa
         lgcX8hiffHYo0zOT2cEw4ULk5Zu8N2Tbb9pihXdp1VXzHvsW/c3kG+0vGdGmqnpkaQWW
         FNuFPhswrfsTghU6/YthZmMFBY1AowBGgFrgjyX24wL5d9azCSO4cZOiRCr1YkgOPbxO
         JezQ==
X-Gm-Message-State: AOAM532ARQoferd6hbVMwpYixb/Ov9G3rYmi1yOKrlbG6mj7V2Rtng0F
        pGd32Fr1Ym2WsyT/tqIGDAbsRwo6SyHE0xE6UzkXkBN0
X-Google-Smtp-Source: ABdhPJzu6I16JF6p3bvGjleHyMIZbtSisJbawugbhJgNPh9qtvTJvBFZm/ILDFb6LDiS62Spg/ihAL7XxyPcEmq/P/U=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr2936112otb.177.1589568142556;
 Fri, 15 May 2020 11:42:22 -0700 (PDT)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 16 May 2020 00:12:11 +0530
Message-ID: <CA+CkUQ-CKCCKFqzXYpGTz=Mmwchd_B+2xm8Dj_s3BB3K=6MC5A@mail.gmail.com>
Subject: [GSoC] Blogging with Git
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just wrote a blog about my this week's progress here:
https://harry-hov.github.io/blogs/posts/week1-the-ten-questions

You can found my all blogs at https://harry-hov.github.io/blogs/posts/

I appreciate any suggestions or feedback.

Just to mention, I'm working on "Unify ref-filter formats with other
--pretty formats"

Thanks,
Hariom
