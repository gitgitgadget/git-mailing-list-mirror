Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2840C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 02:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiBQC02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:26:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiBQC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 21:26:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1229B9C3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 18:26:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so7192261edn.0
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 18:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=87Nm6nXTGoU20HOR00Dcm39nx0u/1+qpdyENavRHpZc=;
        b=WS2EJ9sTIzkpjxJzcqlY9QbaVpricdQAB9DojhtB4Z8z/yCwrdYuaRVOkC8fJ5nsCa
         MMhPiJmLM421HbMCk9Jn0hr2VIabbTTwGF2tSPQFaDQK3cJFGKg27qy9ZDd5I6Op2C9r
         8UA+jHt4o5tW6BLPTCrzHILP6oB5WMNNsQ3uUK7uhou53lecXr+HNMhSpAgbHLW8cyjG
         bTTy1DVqoFJWhAzzDDUYxOcUlkJk+1PrTYwPZGRwgc25RrBV3hc/rKex40/xlvCfS0jT
         vmqR789s4ge9hk+bMDtYpeHQ6rVLqVW7dDWd9ziN2UNZ0jaXCOEG7SF4yus/4Q5A4oo3
         Rbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=87Nm6nXTGoU20HOR00Dcm39nx0u/1+qpdyENavRHpZc=;
        b=SJW+61jJxq/72OdWtJtdLeFzCXMA1vrphXz+70tV3R4zom437L4jTPpZOGSIy8SaQT
         0Y5vCEKX8VA6Ag+kcMHCmrzqrXnI0nirZMgn7G1TU6qdlcSBXvN8MDey4svRulaJvoDI
         DaeO9e/hBrlUsRCA0/rJQxqPnLff8jCrXsdGV3aaSWVdt1FYzIOdDVznMCRTmO6U7Cuz
         enazPDryvLDBKlOMK2qqQpvLa4JAeEyblxG3T93ItRCFOpCfHjq2Uf5UUwf4qI6wOct0
         LuIk00wKRoEp5NjKrjGiq0VzdklpJrAyRcnzuHevJJPzXznmm0HeOHaqPANRqb+9zetg
         S7yA==
X-Gm-Message-State: AOAM531i/uvpuSCiCyRrkbB9qexGG3UNbM+cpjyeAKhepyozK4PcdsAH
        mwPS91nu/Gg4N2UUP7qqhtaY2xGujGwuaTOZstI=
X-Google-Smtp-Source: ABdhPJy/aEKcLeKBfqZH4mL0MpNrRI7NHIMbh37UOUeSK9ZrcGmimPokVhr3BhoNtpj0SSZbAvvRMrshGauhy48d+gI=
X-Received: by 2002:aa7:cb0e:0:b0:410:ba25:79ee with SMTP id
 s14-20020aa7cb0e000000b00410ba2579eemr571107edt.380.1645064773043; Wed, 16
 Feb 2022 18:26:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com> <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
 <220216.8635kjuob0.gmgdl@evledraar.gmail.com> <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
In-Reply-To: <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 18:26:01 -0800
Message-ID: <CABPp-BGcX=Ajj2p=KRp9KxJheAwrAZVzd9JqN0gqzhujobScTA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I misspoke...

On Wed, Feb 16, 2022 at 8:54 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Feb 16, 2022 at 1:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Wed, Feb 16 2022, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > In sparse-checkout add/set under cone mode, the arguments passed are
> > > supposed to be directories rather than gitignore-style patterns.
> > > However, given the amount of effort spent in the manual discussing
> > > patterns, it is easy for users to assume they need to pass patterns s=
uch
> > > as
> > >    /foo/*
> > > or
> > >    !/bar/*/
> > > or perhaps they really do ignore the directory rule and specify a
> > > random gitignore-style pattern like
> > >    *.c
> > >
> > > To help catch such mistakes, throw an error if any of the positional
> > > arguments:
> > >   * starts with any of '/!'
> > >   * contains any of '*\?[]'
> >
> > But not "\" itself, we're just escaping the "?" here?...
>
> Nah, I just missed that one.  I should add it below.

I should not have included '\' in the commit message; the code was
correct.  The code treats backslashes specially on Windows (see
t1091.46 -- 'cone mode replaces backslashes with slashes'), and I'd
rather avoid having platform-specific error messages/checks, so I left
backslashes out.  But I do need to fix up the commit message to match
the code.
