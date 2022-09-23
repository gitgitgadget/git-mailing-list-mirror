Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED0C54EE9
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 02:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiIWCIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiIWCIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 22:08:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD57119180
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 19:08:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so13097504ljq.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 19:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LgmJS4t9h89J56mFwCiuaemYr6POpO+PuRomzqRiJBc=;
        b=Zd1eUTHhT7QOGSjaUSHNaUIoZf3qvvWWbP8rRvAViZUzzhUQD691fMZnjfKkpPaTvu
         ZmIBBj070rW6SMRNf2E3FZphGpnoWG0XRrdflRx56spRb/wUPzA6RfsMiTGGNhO4ViEI
         4uKG5SjMYViQAyAYPO473K/BsxCi90GqATW707Nas/UE9081yRrHrnMTv6NDDA3Lil2n
         6CsjcDY9GnrysEU35nOJVP69k6X3EG0Df08icdVlCtWDHskC88r3uCboreqJ+t9zAi95
         jC5mVsQEFldHfAuaDuU5htHozlD3+SNnl+UiHufEDxuqOSY3tDbksbNNr3TJXDI2smPq
         GLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LgmJS4t9h89J56mFwCiuaemYr6POpO+PuRomzqRiJBc=;
        b=4/W+xPmXNpHGoMeeQvl/MZnzBsRg/s2+Cdpd2hKT5LFy0ND9skvcL9359KDRyPKkql
         D1jdWtEdIFDiMdj057danftDz+rLOVCmQvSfb5ziWnCZu5BEsie1V3jrF4JaU8J2nBhs
         zA9hmPyb2dmbq7AvuBW/8xoUqERP0V7gSUrf7W0nkymqs1X0TvgV0jxe5HmiKyBMPB6o
         AbTr76mZRoi/if2zzNcUttbv3yVPeuL1u4uMktGL5HFpjQsEC04LEE+c3L2wfTT3PFAf
         3X51oWHT6ICJWh3gmmF+CWErbOTibyswiVVm25LpU+fH3ZnkFeXueuL1bRpUiy5Wx6v7
         BJgQ==
X-Gm-Message-State: ACrzQf0i6IWzabg/k7AjhdXueYlteRRH+hDs5H9ZUfthyy6hA1jsp/ED
        rPesaoD3KyR0obWnX6gu6Fv+NRfTIRGhnWKNCdM=
X-Google-Smtp-Source: AMsMyM5B3U9BWg43eQV25BDX1v7VxRGwz7KWJ5SIv5/fDXPYWO5wA5MidJcNxH8dZoBonDHlO1jFxowFzPsXuzc4WfI=
X-Received: by 2002:a05:651c:903:b0:26c:2f7f:c037 with SMTP id
 e3-20020a05651c090300b0026c2f7fc037mr2233057ljq.325.1663898912939; Thu, 22
 Sep 2022 19:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
 <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
 <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
 <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com> <CAJoAoZ=yc+UA7G0MBpJYVCQ6symMQwPnpfK8Wd=sf6ebB1XOhA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=yc+UA7G0MBpJYVCQ6symMQwPnpfK8Wd=sf6ebB1XOhA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Sep 2022 19:08:21 -0700
Message-ID: <CABPp-BGspmm7FTdGcMwX+PwfEs+XeqDWG09Tfju-p6Ea9tneFA@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 8:21 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Thu, Sep 22, 2022 at 7:24 AM Derrick Stolee <derrickstolee@github.com> wrote:
> >
> > On 9/21/2022 7:36 PM, Elijah Newren wrote:
> > > On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote:
[...]
> > > If you add --no-stat to your merge command (or set merge.stat to
> > > false), the extra blob will not be downloaded.
> >
> > This is an interesting find! I wonder how many people are hitting this
> > in the wild. Perhaps merge.stat should be added to the optional, but
> > recommended config options in scalar.c.
>
> Yeah, that's a weird one. I wonder whether the partial clone filter
> setting should also imply a config shutting off diffstats?

Yeah, ZheNing hit on an interesting case here, and their very careful
problem description with full testcases helped immensely in finding
the issue.  I didn't spot it at first from the output, but being able
to run his examples made it relatively easy to track down -- and then
I noticed I could have figured out the same information from his
output if I had known to look.  Even if I didn't notice the output the
first time around, having the problem be discoverable from his program
output certainly made it easier to describe and explain the issue.
:-)
