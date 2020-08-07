Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA717C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11C62075D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHGQRg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Aug 2020 12:17:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42276 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGQRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 12:17:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so2176580wrx.9
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 09:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NBd/IizNkxTAtPWwmEpwlMM3L+8cRmOOvMhvUVsDUIA=;
        b=RSUhCExAL/FqEhXyfw+ZhyU1x30l/aCsYeoNi8dGPuUte55QOq1G7yuivRGq8fVoO4
         3u1BNGtON83jXqSOlvGKjrVEX3mvBFl5puPrq0LpGRkCG8PPfdHZlKmCg+MkUJxTFwWV
         ezcxuwv0+d969XpbR7gb3eNBGwywtDH591TNl/PQbYliFx41J0vg4ySXrpfI/sY7Zo1W
         fjTeRq3xBnR+XcXuo+PEJNiz5711M8Ws0Ln3zXn2g+CzpCBomtoEG2DLBMWbWFZ/Dohi
         IWkhzfdXks9mCfH4RyUAEVBbrXcf2szAYPe0fmqn7wp8ka2GPikxU83gNhyPuAkicw4F
         qMJw==
X-Gm-Message-State: AOAM530B6E8ZfOWNVvHkbZX7HMjP+GjROiqCiCuM8OJMOQkShrVFa6wB
        6DjFSM7ETNadl3sydEWqtg+su0k6/VSqBpnM/tU=
X-Google-Smtp-Source: ABdhPJxlueTKi0cgd9ePxUbD2ByIEUVttYEvrzB0vv3MITViuB8ti8i7YWhWdSImB2ES8+0f2cIq85mK5fv+oHb6wMc=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr12438932wrv.120.1596817052938;
 Fri, 07 Aug 2020 09:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200802143018.5501-1-martin.agren@gmail.com> <cover.1596742823.git.martin.agren@gmail.com>
 <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
 <CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com> <CAN0heSpjgc0GUHnebeBdtr6Yny3Y_jsjz5hTfJqw15bZiPc8HQ@mail.gmail.com>
In-Reply-To: <CAN0heSpjgc0GUHnebeBdtr6Yny3Y_jsjz5hTfJqw15bZiPc8HQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Aug 2020 12:17:22 -0400
Message-ID: <CAPig+cR+JmQsj9qAALq6oxYQb9E94TAEqXHx+dAt=E0FZH6WwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: don't spuriously close and reopen quotes
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 7, 2020 at 4:45 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Thu, 6 Aug 2020 at 22:26, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Aug 6, 2020 at 4:09 PM Martin Ågren <martin.agren@gmail.com> wrote:
> > > -    echo "$fifth      branch 'fifth' of ." |
> > > +    echo "$fifth      branch fifth of ." |
> >
> > This one is a bit weird. It really seems as if the intent was to quote
> > the word "fifth" in the merge message, so dropping the quotes
> > altogether seems wrong. However, the file 'msg' is never even
> > consulted in this test (or any other test), so is this just "dead
> > code" (including the leading 'fifth=' assignment which also is
> > otherwise unused outside the 'echo')?
>
> Huh, good catch. [...] So I should be able to safely drop this
> "dead code" entirely.

That could be done atop this series if there is no other reason to
re-roll.

> > > -    git tag -a -m 'annotated' anno HEAD &&
> > > +    git tag -a -m "annotated" anno HEAD &&
> >
> > There are a fair number of these quoted single-token arguments
> > containing no special characters which don't actually need to be
> > quoted at all, so an alternative would be simply to drop the quotes
> > altogether, making the commands less syntactically noisy. However,
> > that might be outside the intended scope of this change.
>
> If we say that "don't use quotes if you don't need to" is a reasonable
> thing to strive for, I can drop these in a reroll. I think I'll be
> injecting a patch anyway for the "msg" you pointed out in t4200, so I
> can certainly tweak this patch to be a bit more aggressive in dropping
> unnecessary quotes.

No need. Matching the local convention makes sense, and I don't insist
upon such a change at all. Mine was a non-actionable observation, and
it's entirely subjective anyhow.

I don't feel strongly about whether the series should be re-rolled.
It's true that dropping that dead code (mentioned above) would make more
sense coming before the patch which fixes up the quoting, but it
wouldn't bother me if the dead-code removal was done as a follow-on
patch.
