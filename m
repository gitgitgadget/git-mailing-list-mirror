Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D75C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EC86105A
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbhIXRgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbhIXRgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:36:08 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61CC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:34:32 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id az15so10809264vsb.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/Rt8TKh6XmTf9itvmPxf6du3UC39xeXl2QjaaqOmFo=;
        b=KI8npc3HWEr9vvwjinf2FyY451WOx5AG2kRQfMabDceIuUOJqcV3jRc+z9j39V8oUm
         QagT5cmmwCexSAmrlLa3SsKV+wBYBvHouiNskJOIDutS10Ph4vZStqs3eU7ZE/UNfAkO
         GcaYMB7Zg/3oYffntsB1Ae+j3TDCBqyCzTRsWaY9o3FnhmCrTlykIZXO4NqTxBFWz8yD
         0jRJerpQkiJkFHSGA0Q00oKeWKG0fPl93/GUAvbMxcJXPDVJiPAH1J/RcmCHwFI987nZ
         67hd76jyqgKRlELw3XAcqyw112OZcU2m142xgB88BMb2QQogGM8NosROrlKVIVv9TOSV
         H7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/Rt8TKh6XmTf9itvmPxf6du3UC39xeXl2QjaaqOmFo=;
        b=wqEK4LXd2HeLMz0t5BI/Qq0D9YhJr6htVyvrcuAO0jdLNySZw5Bzpk1HCCg7bqxG9T
         i8GYGz2YxhAGfnAI8UE6qYA5v+s2VbgtnYhyqzFYHnLStDo2yjiOM80uNft68CRb9i2H
         AWqqagofSOnoOjyS5Eq7cTRUwkjtDJTmx91VDtfnCByAaAToAd1QTtxtQUB/yVOS0qzN
         BIm6kgZ57UPb0nblsWSpp1ijYIf4oWUdCwfRQlujQMkAMmfgDqvJi1om84iRUiTN3/Xb
         N3kiiMNF2+HfTA2ratbi4Ye3tU+S6nNrUsB7hFgrTuc2tL1Cn4UyPEqTAbs3E6WVuLZQ
         X7VA==
X-Gm-Message-State: AOAM531QSuzO95ogjh7kSm4TKuwtxZboLkO7YHUn+vzEyw/hJxMCsNgG
        CfOgokFfWxTz2EjcPiyAQJeiYcemWUcICCKHsMk=
X-Google-Smtp-Source: ABdhPJzZ4FtGHz/In7KzFoeDHHGmsHpKMUPAEpGV8Gdt5o8bi9tzIptYxq7Gp/OC3OfoE0HnoIDIO9cUilF32aS5kD8=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr10736498vsq.3.1632504870282;
 Fri, 24 Sep 2021 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <87zgs34ccx.fsf@evledraar.gmail.com> <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com> <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
 <xmqqzgs2vvim.fsf@gitster.g>
In-Reply-To: <xmqqzgs2vvim.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 24 Sep 2021 10:34:19 -0700
Message-ID: <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 8:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Thu, Sep 23, 2021 at 9:36 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >>
> >> On 24/09/21 09.46, Thiago Perrotta wrote:
> >> >   SYNOPSIS
> >> >   --------
> >> >   [verse]
> >> > -'git send-email' [<options>] <file|directory|rev-list options>...
> >> > +'git send-email' [<options>] <file|directory>...
> >> > +'git send-email' [<options>] <format-patch options>
> >> >   'git send-email' --dump-aliases
> >>
> >> Is <format-patch options> optional? If so, we can say [<format-patch
> >> options>].
> >
> > no; as Junio explained [1] this omission is intentional while the
> > rev-list options that
> > got cut to make space are not and are more relevant.
> >
> > IMHO leaving [<options>] to imply ALL options (that also include diff
> > options, for example) is better
>
> Could you claify this idea a bit more?  Do you mean that the second form
> can just be:
>
>         git send-email <format-patch options>
>
> That will exclude the send-email specific ones (like
> "--in-reply-to=<msg>"), so it may not be a great idea.
>
> Or do you mean
>
>         git send-email <options>
>
> and have the <options> placeholder to stand for both send-email
> options and options meant for format-patch?

the later AND including a non optional part that explains that you
need to indicate some sort of revision (which hopefully will also
imply to users that all the related options are also expected),
but also won't be specific, not to promote the use of this type of
mode or the need to update it further to include the whole universe of
options through format-patch (ex: log and diff)

Granted, I could have worded it better, but Bagas' proposal[1] (based
on this discussion) does and clarifies both; why this is not optional
in a way that is less confusing than what Thiago posted and is IMHO[2]
a good candidate for replacing this patch in the series

Carlo

[1] https://lore.kernel.org/git/20210924121352.42138-1-bagasdotme@gmail.com
[2] https://lore.kernel.org/git/CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com/T/#m6f0600b597fbe0b59aa767603a7f1d24d60e8fe9
