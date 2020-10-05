Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF21C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEBF206B5
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="ow75tcI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgJEXda (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgJEXd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:33:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D82C0613A7
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:33:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l8so11059080ioh.11
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXiPJPLBllyPob1halc69SSReCoTJuEufqY7SNQHS/Y=;
        b=ow75tcI7vKFZs8MD3KEMgfhvCUJuvTHMI7uixbRoqUq5xuTqA1qizEAH6GBqdnx3bD
         8B113ybKzWntlgvS4Fu+Ri7qWDTEfhqIjRfaVogVb8SwV13nh4JI98uoXCrJneYLhPOb
         d3pGVGuiKcr8i0mBMi65bMxJqhD0hGXdUbC66iI265HzqIAA8RfHbgIn3KoK89kruDVx
         yTELX+iDXhuFb+WBf4ZZMNXJ7Pe1LylXnG+R1YvJyQBRv3YSJfSvYOsY4aWgItlUELbg
         bRkWxeIk08UutKDJ+sdDO4+ut1giRmXRKAl7SfpZLOgKgYIST90bDu89lmiwN5WnbRFI
         TZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXiPJPLBllyPob1halc69SSReCoTJuEufqY7SNQHS/Y=;
        b=lR7U9oEiIKTlZfs499jk7amnh/t2QqeqeOiG+oeuK0mAYM1IVGUGeY9pY8OAKKYV/p
         ULXhwqlkbZoA8Ux4AJgxMCru9RIsBQLb8S0ss/Xk5QJ4xK4htt7d7FuG3Jjt9r70tqEo
         zevBfzEt8pgKUDh4S6m5LpxQj0WbLf4N8732IS4cF91K/bce5zNXLTGWJIRTFlLgS6M6
         UEMwtNGLhiX0MXNKRB/n18WB7/HfMZfqGZldDeWBlVaAOvfcMlRWNuJJ/5rHoH0GVoPC
         7g27h+tyFA4vfJ325cRHn4oLny4TaJevxj/kA8jSwAx5D/7j8dxAb1OFgTRDbPbKlfkM
         B2UA==
X-Gm-Message-State: AOAM5309dq9tjR1BlC+dU2NL3DWR8gXUNlaIyZGuDFJUhUsOYEs8DW9C
        bSHBJ4FDuxdYU/LVLmHnLs6ol2jueJ6tAziMylgAHA==
X-Google-Smtp-Source: ABdhPJwBLlubx4vdoL+pwkH4nDaNYihiO8vD2QEqabU9I3UsaGxI1l23hunR2FvxQhKXi/6Uig9V4Ysxe57Lz/eGLwI=
X-Received: by 2002:a6b:5c06:: with SMTP id z6mr1813090ioh.49.1601940808820;
 Mon, 05 Oct 2020 16:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 5 Oct 2020 16:33:17 -0700
Message-ID: <CAGyf7-Hbs8nTUWzF+bo96x-HNR-pR16MzVjK2Pn-+=bs3Ki7Ww@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 5, 2020 at 3:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> An early preview release Git v2.29.0-rc0 is now available for
> testing at the usual places.

I've run Bitbucket Server's test matrix over the release candidate. No
failures to report.

Thanks again for these early milestones! I really appreciate the
testing opportunity.

Bryan
