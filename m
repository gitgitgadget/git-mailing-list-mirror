Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E3C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C7320866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeXcNwMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgHNHOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHNHOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 03:14:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B880C061757
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 00:14:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id df16so6083668edb.9
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuvppKVAPQlExDO0FfexCkDIrgVM+ErgsajPRZfU+xE=;
        b=aeXcNwMSllEBk2L38dCo9SgqPemrbyE0f+Rk54CNySozgrxdgYV4GsqV7svaFHDfQu
         6S4MMz8odYOA2Jz1FdozR5x0tSRJBi4L19/3yjX3+qSBUdbbRPf/xyC6pKSEytPS2b1t
         EQy9I50zNaDWb+j+RRAOzrFflSzM7Dm5b46eLiLU84zbpAP6YVppBM7cFY3jxc3z3dEI
         1QRlVY1ZvZzh0aPGhU1Fyax2FZbo5E7Crs3WGhTUbrwWTuCpjckus6DbKppD98vjjmRG
         i9X8yoObqyRp/qPAIz3oeRdp5O1hc/uU+wqPK0WSUnN+YuGwWgA69DyCMHAnM0g/L4CL
         rjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuvppKVAPQlExDO0FfexCkDIrgVM+ErgsajPRZfU+xE=;
        b=kshduvYru+zRuyZdPrdEwFZum/Dt5VwwjtshW+u4ZMReuArwYn4XB5vmWxJBOJ8pR6
         7LGYBopz7NqQRTTUOB/LpcWUPKx30FspsUZaMSv/PA0SUUpoWIaaBvbMD2fM5IvMnW39
         w5Bt5aU2bA3y3BhBFs8I+q1MTkDYuHyaRYPd2yl4cXuuPtKKvO9p+V9IjPQfXYguxRUB
         +HB9fRDomH1ASTa/DrxEyHG2/mOhT9BKNZGJlc3T6Wtspj0AVcBarLba5XuA1UA9LH+z
         0Ni8wFK2qG2mkZ3fTcujuspeygbL2L83DOW0Tzfv0Q4tPmiyg3wRmhYHAVqPSeSwlxEU
         kr1Q==
X-Gm-Message-State: AOAM531hTVwCFQ57GChqhzbDTMWZaClQtocC9i2iSkJkVFVfwp7+Kx8I
        iBF+MnTyjwksiKxMDU+XcAQLyJsJQG2rUxSHWsU=
X-Google-Smtp-Source: ABdhPJzEGVsHxT6uSUYSpbjZsKk1huG8O+nSuoEwMtOJ1Gk+/3Ym58kyAJMrYUWPfjwXO2fYBE7SyZNPnNkvR83w9MM=
X-Received: by 2002:aa7:d3d9:: with SMTP id o25mr1016109edr.362.1597389252422;
 Fri, 14 Aug 2020 00:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6+3T3AG7RRk8u9fQ_3Sj_P7=hthCKdMD-NLo=hSriu+DdPnQ@mail.gmail.com>
In-Reply-To: <CAP6+3T3AG7RRk8u9fQ_3Sj_P7=hthCKdMD-NLo=hSriu+DdPnQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 14 Aug 2020 09:14:01 +0200
Message-ID: <CAP8UFD2h7M1fzg0YsT4u6F1_+TgsAS87viTFo3NoFMYv+cbq1Q@mail.gmail.com>
Subject: Re: [GSoC] Shourya's Blog
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Wed, Aug 5, 2020 at 7:46 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> This is the thirteenth installation of my weekly blog covering what I have
> learned in GSoC and other like stuff.
> https://shouryashukla.blogspot.com/2020/08/gsoc-week-13.html

Are you planning another blog post soon?

Best,
Christian.
