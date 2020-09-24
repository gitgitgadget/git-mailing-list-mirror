Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98805C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2737F206B8
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNwS+VjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIXGKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIXGKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:10:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09FC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 23:10:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so2103232eds.13
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpl6YzywIzPfzaL2g5MGmngpIgHr7OXRKhMgCN+gOMM=;
        b=tNwS+VjLSdOSyPc2Yyu0l6unEh1waZnLKFZYlxbdER/YIbD6NRLKwVgKPGurj/u3OW
         434LlZxlIxPpQGhu2xhtzPF44IWppYfWt4aFPYMfzBnFsjq2A2vEB77EvtcKC4aJ6+BP
         reeCq25i/3768uDPo9DXIuD6bXOVWPI/ptFFTGQVWV0m4va/1yshdBj1Hhz2TWnSASQa
         zZuaVulhJ+cR3l7Q9sxMEbx4AjVeiwxaHa7g78TUV+Y6p/EXPM7VO0+/PTU+/lHjyCsa
         4STMiCcJGQzgsjLcOoYYKXN7GFp7E4R279P0UkMxZe3NqKHtVDImYjwCOwigFBm5v1FF
         cHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpl6YzywIzPfzaL2g5MGmngpIgHr7OXRKhMgCN+gOMM=;
        b=CsfJq17uJiI6dAcdkFd2ppepIM0naSD7nGind4Q0ybEThp2gSbk9hjlUfpAQNQ8Myr
         Xe4EFjzeWjGirOxsnTnUFdnsBAWosjCgOJUJOaXKZFtahgPK+756nKIOwGEvbd0F2x0V
         A0G6yrQsAwVyICLnEYzXFWNH8T7F36EPJg6+Q31OWKjAFT0AHDUcv0Tn+biMCGWbZAKW
         ts/Nc+AhCzPkQqt79405yRxSx5ea4Zp3EiV9I6kQi7xgVN/GZKLAnYWQN3buv3uqIDuU
         qPgBthWu1YAwbZ6hka1cjkvPCMWc49lqGoGbFLWQStc0OYmHtikYsDr++12JW3TmEmrL
         hzAA==
X-Gm-Message-State: AOAM530BpA+Xa062uyBZ/X177i3vPmzhPPm4EjZHQiUEYiXUdR9csDV5
        fBln953ObCoLZBnI97f1AqI3HlSlFTeakwaxX4A=
X-Google-Smtp-Source: ABdhPJySIMnj1P/vV8d4EbrE+qf0JrPqdJCf76VPj9QB0K7T+jrRpWM0EhrFLGVL9OPVzcLo5BhSC9rTGx/JiE0aAQo=
X-Received: by 2002:aa7:d750:: with SMTP id a16mr3003332eds.362.1600927842199;
 Wed, 23 Sep 2020 23:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
 <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
 <xmqqa6xgi363.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6xgi363.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Sep 2020 08:10:31 +0200
Message-ID: <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 11:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > From f673cea53e046774847be918f4023430e56bf6cb Mon Sep 17 00:00:00 2001
> > From: Christian Couder <christian.couder@gmail.com>
> > Date: Wed, 23 Sep 2020 19:09:15 +0200
> > Subject: [PATCH] bisect: don't use invalid oid as rev when starting
> > ...
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 93e855271b9..d11d4c9bbb5 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
>
> Unfortunately this does not apply to the broken commit or 'master'
> or anywhere else, it seems (no such blob as 93e855271b9 found at the
> path).
>
> It is better to make it applicable at least to 'master'.  Making it
> also apply to 'maint' is optional, I would say, as the bug it fixes
> is not so critical.

Sorry, I don't know what happened. It seemed to me that my branch was
based on master, but maybe I did something wrong.

Hopefully the V2 I just sent will be better anyway.
