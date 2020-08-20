Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F4C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BC5206B5
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4k3glXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgHTRTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHTRTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 13:19:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B4C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:19:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v13so2494169oiv.13
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mYmYeahBiGRt80AOP/dMV3yrGoJATeb46xLJTFthZ0=;
        b=o4k3glXJ2knjfB2050pKwM81Q1ECFGbUK9iDIzh381+D+GzLZKKUHaeq2EzZjjyl3O
         IfeEvVfs4PZuWy5cqTxgqOFHnFWnt4uS81/RCjjD6HaeoJRKPiReyAdGJ8+rLCHq/rl3
         qvBpkBs35c8Qmb5HSENzAPNM4N1P7N5fn5HU4QoqE7ApMqXA4VPTLKTvwy5+ejuDiJ74
         2tctN+HvXmeAYyhyk0qc7gCRar49HVXjtTtQYSG7TL0UDjpwyeTJa7YyKo1Ckvad7CUg
         IquWV36oi+krD8p3o/sIvTNWzPFsf643plBaGO00cO2dHKL8JM9xNSMDdXQqzqXy5xqD
         pH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mYmYeahBiGRt80AOP/dMV3yrGoJATeb46xLJTFthZ0=;
        b=qv9g+PN3I+kqXCq5fLPr4KME2NG2/psxsUPq51uCn5nhTRun9J2OwAE8fZHOBOp8DN
         6DHMlmNNy4iFdcXyzW3/XOZfqPSnQGD6QIIkqTQmaTDySYgUZUdW3YviYvyRrtlOBpqD
         tz7ZN7+LLCvenv3COCwNlSyekAtg5i8GP6OcTmqHK1Iun6S6kbTmG2fgqYQT4PLxEC5K
         HCyTx/c7L0V+fumIXeAFG3vYuvoYWBHXth5hndclLklKRGG7OG3o5OQpmXDJkiyWgT4K
         DgdhqBjdzmmxvJlpvk6u8V+TpXkeAuv7ylOJexHoqgcx45zDgRW8qiu/YVtu+bDDhZeq
         NLXg==
X-Gm-Message-State: AOAM533hiJJgCDA3aCx1lCenWtkok2K2pX4rYsh/Lh/riUHofV2htnpj
        GN9N4Qk7S9uZF+Jt15m04lZilI7FOsuyfHGX59k=
X-Google-Smtp-Source: ABdhPJyXcm2CwQlIfAYfh8D53TDoHrl9qC21U5lKlVT/TFPOjPSHtIO//Srmfldr/50+SF6UY9OydluKB3ESDu5yS2Q=
X-Received: by 2002:aca:6082:: with SMTP id u124mr2434875oib.155.1597943964071;
 Thu, 20 Aug 2020 10:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
 <xmqqv9hettag.fsf@gitster.c.googlers.com> <xmqqmu2qtpxp.fsf@gitster.c.googlers.com>
 <CAPig+cS398dm4W5Q2DnK+bGvw0mOG3916dHPbZ=y1JNrqz1G-w@mail.gmail.com> <xmqqsgcis2zc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgcis2zc.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 20 Aug 2020 22:49:13 +0530
Message-ID: <CA+CkUQ9qz1=xvpdtTy49W5Uru3ONJ5R1zUCSdi7OXJCnZxTdzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Aug 20, 2020 at 3:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Aug 19, 2020 at 3:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> > "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> >> +static int check_format_field(const char *arg, const char *field, const char **option)
> >> >> +{
> >> >> +            else if (*opt == ':') {
> >> >> +                    *option = ++opt;
> >> >> +                    return 1;
> >> >> +            }
> >>
> >> And the helper does not have such a breakage.  It looks good.
> >
> > One minor comment (not worth a re-roll): I personally found:
> >
> >     *option = ++opt;
> >
> > more confusing than:
> >
> >     *option = opt + 1;
> >
> > The `++opt` places a higher cognitive load on the reader. As a
> > reviewer, I had to go back and carefully reread the function to see if
> > the side-effect of `++opt` had some impact which I didn't notice on
> > the first readthrough. The simpler `opt + 1` does not have a
> > side-effect, thus is easier to reason about (and doesn't require me to
> > re-study the function when I encounter it).
>
> That makes the two of us ... thanks.

It seems like the score is 2-0.
I guess I'm going with winning side.

Will be improved in next version.

Thanks,
Hariom
