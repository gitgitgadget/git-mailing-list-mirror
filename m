Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A069C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 16:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6430464DED
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBSQbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBSQbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 11:31:25 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDEBC061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 08:30:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b21so4828407pgk.7
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 08:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FB97CWNRPQ49XdH1Ge8BjqJkjLL99NdkOI5XKk1qDvg=;
        b=F22zO5RBVJfZ01RE9l+2tAO1InsiM4J0OrYXP9m7h1Y1R89qG/bWNv5BJ9sTiNEdhr
         CP9emVULN7a+AFn6W/3EuC0T3DOJHgId4gz7/zHqz+WrGsPRjFqZVSozXl5RTCa2SWy6
         LWl2DdcfaThvrAz6llz/xmtaiggyd2TtZlYYzkH/PYcPEUarPu/n9jDkYPUPVVtezhyM
         BiwidEzFOg6o93VEHYDrch30EWTMIeAcPp3GIraTgjswf3gGz1fYKxzmHjcQ63ikJzCk
         XB6Y/rtH1DDqgKtjkyQjzyYXuzzaHhnfq3olppBYjAaBpyM5iwe1UgYxYKBL6QqfidKu
         Ao6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FB97CWNRPQ49XdH1Ge8BjqJkjLL99NdkOI5XKk1qDvg=;
        b=Gjrp6K2CWhPi98VZC4zY+s6OnPw3NW3yNoECYHyAFCokQ1OhqRyQk2ohJgmS0rZMlJ
         qt4yC5PvZ7fuaI2fBxWdDItI60qVjze8xx7R1uI75lqJj6ggQt0H5kHlHTvLfQQUkflb
         rr0zLv6JZtUOpwY94JhaHSW7qXkNbTa+Fe9twXBfEiO800G9BeCon9PssGVi0s452ZYg
         KURMaP+LXJm+Qr0faKsRh93qolg9TTQMxEIpQps33rZF7ZvVymZ2fI9OmknTnNmfdnea
         yWaKmspkmvmSrszScPVVXEKRPW5OUUa2+HLa62841om/7295Di/lpQmtchCis2WSe4LN
         WdnQ==
X-Gm-Message-State: AOAM530FiW0MNYnFyzDpJQbXgy9AKwxdexR8sMOuOSpQ09q1zCRZ3ZF8
        LjF364X4rTKC0oPwQ+PhaWB1U2eWEZMtG6TD6Qc=
X-Google-Smtp-Source: ABdhPJzjN+rqI776Hm1BQMExP3p9kVpqHlL/1MlIRa84XybWuNuW/okVyyvN0/5577/dg47k5pyBFyc3K7AA9cxmveo=
X-Received: by 2002:a05:6a00:9d:b029:1df:c229:1b95 with SMTP id
 c29-20020a056a00009db02901dfc2291b95mr10236299pfj.80.1613752243080; Fri, 19
 Feb 2021 08:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com> <CAP8UFD3vDfrQnxSUcUoZHx3TqdxyrUeviT2zfjCcZHF-t-uK9A@mail.gmail.com>
In-Reply-To: <CAP8UFD3vDfrQnxSUcUoZHx3TqdxyrUeviT2zfjCcZHF-t-uK9A@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Fri, 19 Feb 2021 22:00:31 +0530
Message-ID: <CA+ARAtrSM3VT-j8n-c26r5eKpyfKjon=Du6H9-WfwNW2ve38XQ@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, Feb 19, 2021 at 8:26 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Feb 19, 2021 at 12:52 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Tue, Feb 16, 2021 at 7:12 PM Kaartic Sivaraam
> > <kaartic.sivaraam@gmail.com> wrote:
> >
> > > So, I was curious to know if we've already applied to participate
> > > in GSoC 2021 (or) if we're planning to participate?
> >
> > I don't think we have applied yet, but I would be ok to apply. I think
> > I will do it soon unless people objects.
>
> So I just filled up the forms to apply. The information I used is in:
>
> https://git.github.io/SoC-2021-Org-Application/
>
> I also registered myself as an org admin. The only issue left is that
> we need another org admin, so I invited Peff and Kaartic. (You should
> have received an email.) I hope at least one of you will accept,
> otherwise please tell us soon.
>

Thanks for the opportunity! I just accepted the invite.

--
Sivaraam
