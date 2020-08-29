Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB73C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BC520774
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjVi4wCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgH2Su0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:50:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714BFC061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 11:50:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 109so2086032otv.3
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Z7XHIRLlP+CFfm4HNP1tXQDjIMos3p9a7qqkQdWH+0=;
        b=VjVi4wCU9YsxyQx/FjdVgHulgUKSLLGoja7F/OvLLDpTW50dKdMBO2Q4vN9Ap5eqWs
         yxyatqE2tVmo8N4jIHg16zIcS9KXTxZn3+Ij4PYyh0ODEtGZDLWiH0+qxh0yy9rL++/4
         n4mg3XvlxmDXUp4AkEuunYfW3GTAKcqzPrWD3C68YjUwseY/A+DJkGXr4YcuqhVMoAGv
         JsphuwkFuWXLn2pDtbEF1Rv6YVQg6cEyt2Yi2pGZUm2m+M4VP8MTt7vXepGElmEvh6CZ
         RaunpXpEU80TR+yew1M4cbDi80CiL2Ug3O3SUEFagpUJ5V9SfITRZ6NYzJ6omZER40Qm
         9yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Z7XHIRLlP+CFfm4HNP1tXQDjIMos3p9a7qqkQdWH+0=;
        b=B2asHJfZ63GirOaRba4xwmt6qf2pHDvCyx7T3wi0sjxT6Em7ucOWSqoWTl89e7JsNW
         Cq5uVupLifFoIM5s8GerO/FEZpjCtIxFrTd/m2ctbZ8LYWN+kmqU+S8Oer174d0QvLRI
         WkXwKqtLngDYiTQ5d2gMPOje5pmfVzeO+HWm4sbO4CRRW+mLceyGcrKICy5Nbwhh1AMz
         LTn/WnCnWFFjG17ftmmiqu1/+I6mtxnZ6ysCaPORtddBAvxsY0sCHfnJYmhSG1b8o1k5
         rCw95vil5ATC2c9R2OhrV4g1GjG/Tiwy6FVcTtPMJXp3Bqtgyfaemou3ERPQFavbnOVq
         tPZg==
X-Gm-Message-State: AOAM533yfyFIAWBcF2EEaYbJGNdg0W2aSJeZ9s903scwHXPz4ZPkpfrT
        IT9RlyeptqHsGO2+jnYken5WeqHvi3f3XlVKw6QxN70bnqU=
X-Google-Smtp-Source: ABdhPJw6tiUP8NKKbKK5zrqPzBz7gsdMEgmT+2kNQXGu8pZWQ735w5F4dq6RpabwDF4cQT5043wAyXWBV5YlEnFQtUY=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr2796974ota.241.1598727021826;
 Sat, 29 Aug 2020 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com> <CA+CkUQ-SsxrJk+7e-ygm8FfCto6XZt2Ts9UcTMpgkmAQWZkLhA@mail.gmail.com>
 <xmqq1rjpjohy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rjpjohy.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 29 Aug 2020 18:50:10 +0530
Message-ID: <CA+CkUQ_3jvkwNvakGxCvDk-C2RMCfAd7pAxy8OmjwVvJT2S_Cw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Aug 29, 2020 at 11:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hariom verma <hariom18599@gmail.com> writes:
>
> > On Fri, Aug 28, 2020 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> [Cooking]
> >>
> >> * hv/ref-filter-trailers-atom-parsing-fix (2020-08-21) 2 commits
> >>   (merged to 'next' on 2020-08-24 at 79b27f3263)
> >>  + ref-filter: 'contents:trailers' show error if `:` is missing
> >>  + t6300: unify %(trailers) and %(contents:trailers) tests
> >> ...
> >
> > After a discussion, we agreed on keeping the helper function instead
> > on duplicating code in "ref-filter: 'contents:trailers' show error if
> > `:` is missing"
> > There is a high possibility we might want to reuse helper in other places too.
> > Especially in the case of newly added "%(subject:sanitize)", if we
> > also want "%(contents:subject:sanitize)" to work.
> >
> > Full discussion:
> > https://public-inbox.org/git/CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com/
> >
> > I'm about to send the updated patch series soon.
>
> IIRC, the code in question is good for the purpose of what already
> exists and is easier to follow without helper.  When we need to make
> the code more elaborabed and/or when we actually have the second
> callsite would be the ideal time to introduce such a helper as a
> preliminay clean-up patch early in such a follow-on series that
> would happen after the "fix" in question graduates, I would think.
>
> To be honest, I am not sure if we even need an incremental on top
> right now, unless we want to delay the two patches to fix real
> breakage above and make them wait for patches that adds features
> that require to call the same helper from elsewhere.
>

Yeah, I agree with you.
Let's not delay these 2 patches. Sorry for the noise though.

Thanks,
Hariom
