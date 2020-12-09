Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F6AC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE16238E9
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 07:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgLIHRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 02:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLIHRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 02:17:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639EC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 23:16:26 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so531739wrx.9
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 23:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4JCzbZiZpxNmX23eEoldA266rbpYbdA+knLJNGbGyw=;
        b=utHwvqazZ+MvyXnrE3Bxyg6T7TM6Ns4aslASdDDM5/GQ1pfChnoShbQORsH19X//VK
         tDqgQscI8Dfh90fxrlokPVP8lzJsZPeXIVHBFfN6BYzrkQTlRmtaebaGzUdC5ox7bH7u
         5leJ6oJvjadkndOwVr82AkN3OaojdvRvhWgnnSm4PGzH58UCU7McSDsoM3OjHZuifCJr
         WCHCccb9CQyOGSbtQzb1HrHsa8IttI7Doixy7GPlkaEWM2cVS1juFHScOj0+ytI+EjLr
         CL66hXhuzGMJZ3QO0yYLuJIX1cCVG6xchcZ+VgkdoY8xXS+5nafpwSqSOIXGe2rR6X5d
         yK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4JCzbZiZpxNmX23eEoldA266rbpYbdA+knLJNGbGyw=;
        b=YH4Dyl+ASth3nYxUru/I3gQmADB7G68dqReXlqGDyqNCoEea/ZtW4hrzEf/47w3UAT
         dFdJ11CrleuRw0yavQ+dtRVl44zDWeGcwyjpf+rdOtBIdloVwRguWCpZEez20QS9c5pz
         WZ8pN715mK6AA+YvRiafgN2qZfvayWplXYyS5JLXu5hloMEV1THa4IbSxAk7arlrORF0
         pH6LPYZhP1ahEfluFot1TT1WI2BO+IbvFIrGO8cIRIRhTvpTxHleXvMrLFXpM3hiY/eW
         fX90wXLWzLFQEOf5maSvBrPGlYarCgTavDAUMJViVGc47QP8guVNIZDxUiErUbA9Gsrv
         YfFQ==
X-Gm-Message-State: AOAM530aIQAqkDdBVkANnAP02FEMcL49EP8kTQSfn6CdXNOm0esd7wSG
        S1Shfa7nm66hHIIQTcfI85Q7pQCLns9E9DJgQ7o=
X-Google-Smtp-Source: ABdhPJwLpzdzKI7wrapZSWKk464sneNEOae3UWTySfZijUtKtwGDCfASNBMRgn5yee8L2jcbbC/RtwaVcrxB8IBzjeg=
X-Received: by 2002:adf:e788:: with SMTP id n8mr1036817wrm.84.1607498185062;
 Tue, 08 Dec 2020 23:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
 <X9A1On3v35nEjL7i@camp.crustytoothpaste.net> <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
 <xmqqlfe731vh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfe731vh.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 01:16:14 -0600
Message-ID: <CAMP44s2xo=n4z6m7FhuPiZ66yPWvmdQuAodvh2XNpdVAfo6R8g@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 12:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> We have an .editorconfig file[0], which is a cross-editor file that can be
> >> used to specify these settings.  It is supported by many editors out of
> > ...
> > Also, we don't have to support configurations for every editor under
> > the sun, that's a slippery slope fallacy.
> >
> > We can stop at 1 editor: the most widely used editor by developers by far [1].
> >
> > Cheers.
> >
> > [1] https://pkgstats.archlinux.de/packages#query=vim
>
> It shows 71% (for vim-runtime), that is a lot higher than ~20% for
> emacs.
>
> Amusingly, https://pkgstats.archlinux.de/packages#query=nano tells
> us that nano clicks at 80%, which makes it the editor with the
> largest number with your yardstick ;-) [*2*].

Right. But I doubt there's many git developers using nano.

Anyway, that's not my yardstick, I just recall I've seen multiple
surveys of the editors that developers use, and vim always comes at
the top, by far. I just quickly searched for some evidence to sustain
my notion.

> In any case, I think it is a worthy goal to ship a sample set of
> "vimrc" entries that people can readily accept for their use.  It
> also is a reasonable "feature request" to consider doing something
> similar to "editorconfig" to give other editors similar convenience.

Indeed. Editors are kind of a touchy subject, but I don't think
anybody can deny that vim and emacs are the two most popular. My only
point is that we don't have to support "every editor under the sun".

Cheers.

> [Footnote]
>
> *2* In other words, I doubt these graphs are depicting "how widely
> is an editor used by developers".  It is just showing how often it
> is installed, and I know the primary workstation I use daily has vim
> and nano installed without me choosing to have them, as opposed to
> emacs I had to manually install, and I only use vim once every month
> and nano once every quarter.

Yes, but in Arch Linux at least no editor is installed by default.

-- 
Felipe Contreras
