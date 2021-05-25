Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EFC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AFC6135F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhEYR0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhEYR0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 13:26:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C458C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 10:24:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r5so47239083lfr.5
        for <git@vger.kernel.org>; Tue, 25 May 2021 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ihvgpv9KFvdCrH6yPdEyN1mfLCm5YZXFX/fjjksKnk=;
        b=mI2hZ/JIFM31Y6z1lq/wimij+R2QG3hhMRm7OxCRZY4CROVI08dSPY7sY1AE6vgqNC
         CmCARQmtptyLKoppbsVxRfeVNbCEUPlsWTxEOymXHIjJBD/4UWJwFYbrGDtuGpfRkFPH
         d6KKA5UUoxP2dWZ7tIPOcD9rPtj2eTsgnN7qaSGwMIH0FvxXZj6zJk3I9p8/TMwyrtuS
         XHOfIDIQm3pcuQu0Er47vDSyEW1gFqpILlZsfVagHwdX3tTrEFlC9X5U3CtqWVDw4PVP
         VdfnHTyWeaDu+Su8+AyDcy4YUFIyNod57SuXt1jl1lnrJVwvyYcquPlHe/+CeE5gPjtc
         s9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ihvgpv9KFvdCrH6yPdEyN1mfLCm5YZXFX/fjjksKnk=;
        b=JJi7qN+slclEaEullcNF0FCsfABMziQEzV/1v799pRAubkzE9UFznIM/exaGKybrIa
         i1DQIDboAVoHgFyqkrtfjFbUNalLParY0LzhcgwfJvl+uL1boei1m3upuHlSSpC0u7Du
         53B2xH9zMB9I5uyMNZ732vXRTtmjKroxmk0/5cmojgo16jSPoGYOlLvrgmomHDny6O74
         TnOk5gq4+VnI3/C7rQlNo1jzDibUuIAETdwVuZo/8xyCP254Lp5EogvDXATH2kg59tks
         vClk3I///SNxetaSN83JNXmZPMtqwAu4cA1aZJgfFwIXgwzLtTb6TFrbk9cprFyGBLHs
         EH/A==
X-Gm-Message-State: AOAM532iP8ONLkftD7aDBUvqcaEpSxphzjD1jQ2rdHfckvFHlpmQv1C9
        RiYmztPLzRjgxWrwZsUEQpWcLzBBAo/dFD6ilaZ7MBTjABc=
X-Google-Smtp-Source: ABdhPJyCZWqbxvlxEDBQt4zbVJk8s8m9hSI2AAA+ofk+lu3fcLyYQCKaYrBZanm72CLf4xymgxchgMvaTUy4xNGX8hI=
X-Received: by 2002:a05:6512:3990:: with SMTP id j16mr14577815lfu.367.1621963486799;
 Tue, 25 May 2021 10:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <YKWggLGDhTOY+lcy@google.com> <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <7f0c9ab8-c1ca-171b-8247-6d921702f3bc@iee.email> <60a97550287b3_857e9208b8@natae.notmuch>
In-Reply-To: <60a97550287b3_857e9208b8@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 25 May 2021 11:24:35 -0600
Message-ID: <CAMMLpeR5S3Ps4C2V4QuTxrCRB_iRsUKyCNOJ4G7Fy7jGe98ZbA@mail.gmail.com>
Subject: Re: RFC: error codes on exit
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 22, 2021 at 3:19 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Philip Oakley wrote:
> > On 21/05/2021 17:53, Alex Henrie wrote:
> > > On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > >> It's good to not include many initial codes, but I would start with at
> > >> least three:
> > >>
> > >>   OK = 0,
> > >>   UNKNOWN = 1,
> > >>   NORMAL = 2,
> > > If you go that route, could you please pick a word other than "normal"
> > > to describe errors that are not entirely unexpected? I'm worried that
> > > someone will see "normal" and use it instead of "OK" to indicate
> > > success.
> > >
> > > -Alex
> > Typical <== Normal
> >
> > Though abnormal and atypical often have different implications ;-)
> > P.
>
> Or USUAL.

The words "typical" and "usual" have the same problem of making it
sound like there was no error. I would suggest terms like "user
error", "network error", etc. instead.

-Alex
