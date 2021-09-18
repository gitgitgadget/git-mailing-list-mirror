Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A310FC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8960FC0
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhIRNqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhIRNqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 09:46:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D7AC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:45:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i4so45552166lfv.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JznDBzivlNu2+lfSYwm1/mNAvUdBRDsBdox4YtC/4JM=;
        b=AKSHVn1YpeDWGNoZKQdojLvkPPOee+EaR/BUYZT6gRPXqafodjFv7j6g+Qi2vFicEo
         rTNiytJ0RfQJ5MVc1wdKA1LbkByom7cfzFs7u0dO8cc6+MZNOA1wwS3u/M+V8Ogx7gwI
         F8x0bXEdiOD/W/LcjkiAOjer6B5G6zwLT26TIQXqVdAKcllgttXVDrnh5zCLWyteaUPE
         JJ81Yja2G0re9vG0CXoxpxhhNTEK1lmAwAgV5AS7L0URX9MVWgkxjNr+I87CIs3oi9TZ
         0H3iuVnG1RPxw5gsV74JYsUbt5UVk2iqTvFddBMvVcltmSyhlS5URUYfdCiO+CJiQ0Xf
         WgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JznDBzivlNu2+lfSYwm1/mNAvUdBRDsBdox4YtC/4JM=;
        b=B2LFKwkEAlkmfdQCC6FhBioW6YGDkfDZNP7i9jtPp6Ll8wEzoGsPlZ/8bwIEaAt/tn
         JkXxE4zO9mFs53A0ZH7gIwIxJ3egfIbSq4bLaOb+qgLhjHHY7jGDFBTZQ0gmZBsAIvnX
         d7BtAZoV7WvrNfilWSet9uGSiWGe26N8rJWvczqxNJmkyd1z+KTlPuzNMb3yDJHBPt7D
         vwBX0Sghfc+92gfOgdJxR3qpQY4tC2bAQg4KZFmvmvQ8Nr9H4gPifWVSEjlRUUNbOEgH
         p7vbNF1iuFPTzWdBvUkt/ztyCsCtZCJg0/6JvMRfq7VNY/Ra2Rd7VccLb6dOI41rV+54
         M2Lw==
X-Gm-Message-State: AOAM531G4ixPeIZZglfQ0ivDav9JKteyWrypYZWsHijN9PxXbUZMFav0
        iCPNt5phiWQ4ksec6NXAWwm/3Nfft3JodQZ3K98=
X-Google-Smtp-Source: ABdhPJzK2sCVgoiqvZv5mHDZu6oN9xRTmYweRXaTfBcgCMEjesCdFzUfwwG8A9coPnkCb34SC+lTG5Y6T8ZWsbJZ7uM=
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr14114239ljc.30.1631972717310;
 Sat, 18 Sep 2021 06:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net> <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
 <xmqq4kaihqjj.fsf@gitster.g>
In-Reply-To: <xmqq4kaihqjj.fsf@gitster.g>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 18 Sep 2021 06:45:05 -0700
Message-ID: <CAPx1GvdL4gNQhLwaF0useXXWzXXFRxZekuFEcSkyOOTniueFTg@mail.gmail.com>
Subject: Re: Should `@` be really a valid git tag name?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, gitmailinglist.bentolor@xoxy.net,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was in fact the commenter, and I wasn't saying
that it is a bug in check-ref-format, but rather that
since `@` by itself is forbidden, perhaps the creation
of a tag or branch named `@` should be forbidden.
Maybe it should even be forbidden as any component
part, in new names, although obviously we would
have to allow deleting existing names!

I knew this would be a bit of a hornet's nest though,

Chris

On Fri, Sep 17, 2021 at 9:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Fri, Sep 17, 2021 at 7:12 AM <gitmailinglist.bentolor@xoxy.net> wrote:
> >>
> >> A SO commenter pointed out, that git-check-ref-format forbids @ and
> >> maybe I should report this as a potential bug. Is it?
> >
> > a reference that is named "@" only is invalid, but refs/tags/@ is not.
>
> ;-)
>
> "git check-ref-format master ; echo $?" would show that any single
> level name is "forbidden", so probably the SO commenter (whatever
> that is) was confused---it is not about @ at all.
>
> In any case, a tag whose name is @ may be another source of
> confusion in the modern world, after we added @ as a synonym to
> HEAD.  I do not know, for example, offhand which between the HEAD or
> that tag "git show @" would choose.  It makes sense to avoid it.
