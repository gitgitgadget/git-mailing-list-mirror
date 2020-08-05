Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E55C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07DE2075D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFNUY7kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHETUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgHERr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:47:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F19C06179F
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:46:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x24so7390898lfe.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HKFtpw4aqfTf3gwkDhS+pyA+MmY9oI98oJVEXDVCdrI=;
        b=IFNUY7kWSwRiFCQxfQUPr0uMtQPuYxnyY7lzdA+DAxjrhNUyiCLlUTuz2ttg6eryRf
         /v1HKTnIc4BToQDqGAu4RAgr4DQn3LVvApR91TgLOfrsvfesD7HMZMvj6uUS3FKdPJCO
         wsjRaoUCfX6Ny+j1PnCI4mi33DChR6cpP0enNiCcw27r8+ten4mdfBGjoaCO9pum8dyA
         pvbLh6v4gk6U4D2mPT/0QRxq0gUG++qbFfIswpYwrOtDils45w2FNupmLBf78+CzBlDh
         zjQjwaNG8UuoA/FaJKGqO6ApiwTsnJ0Zk2WYUr3B1+RcEPUR8pRU36+5Q3x1FsHT1rFQ
         cf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HKFtpw4aqfTf3gwkDhS+pyA+MmY9oI98oJVEXDVCdrI=;
        b=AgTpqZMV0WI125zqfiBDK4B0M5Njg3tm4E79/YkOQrJZHgBxI8O/FCZxfMOQ0bMWGN
         FJJqXPwDP2z/VTSd2n9RbMELjvQ/AgO+fRwt2oe3RJqJ87aIM8B8nm17ET+fv8nPCCoE
         E8/ZTfu5sW576xrZVfwCebiogHpYWYyeMwh+8OmZWLbripZSuVvFgRqUsMN+w7/2ub0e
         M2scKMjakP5NkrICtcwonwM6iGM6qgK7r9fMIRt1dK/o2+D3ZDsdbhVIwxRiuns8zQ/y
         9TA1TL6NOranv4eFebEQwRUfxB/CkY3UntFV6QTklGtcCfHnK8+L6RIGbb60TreUtZXM
         bWzQ==
X-Gm-Message-State: AOAM533YTIzlhp/RDYavb47ThFrFxVVaFfDjBK9P/ew7rpXASzEq0xxV
        A3yGgLSVE66cgS2EhagYNncOb9QWl7Vi9E2HeYcKyLOUACA=
X-Google-Smtp-Source: ABdhPJx3G7ciy1evUbOIkgSCrJFP14Zp/eg27xbD7roIlhQVpbbue0I6T9E1B04VuIk8jqoR7wOOBtzUSvD7Z/TAyIM=
X-Received: by 2002:a19:d14:: with SMTP id 20mr2067801lfn.27.1596649603942;
 Wed, 05 Aug 2020 10:46:43 -0700 (PDT)
MIME-Version: 1.0
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
Date:   Wed, 5 Aug 2020 23:16:32 +0530
Message-ID: <CAP6+3T3AG7RRk8u9fQ_3Sj_P7=hthCKdMD-NLo=hSriu+DdPnQ@mail.gmail.com>
Subject: [GSoC] Shourya's Blog
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the thirteenth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/08/gsoc-week-13.html

Feel free to comment!

Regards,
Shourya Shukla
