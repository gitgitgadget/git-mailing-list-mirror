Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B112AC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353401AbiCXU10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiCXU1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:27:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3880B823E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:25:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r22so7730018ljd.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0J4Jk8Hx4mu2k3ooFyDKxy8VPTqyoZBP7+wp2rhHXqI=;
        b=Bp9mlOVUVF6AtFO5F7EebsIAFu4JD/XdV4ol0wLRi7sww3wDPcd8dpTdA5jXt0CkLY
         ufqcecjE4nv/wQeeGJ/WpP8XGKgrTSEL4u/lK8PoKJEHmOo2oJGnGg3lLKKz2sQOS0vM
         GBVKPdMaRcx4yDhCH0F4WkmI2zvaXzhM/L27iAZz3yHOq1G4zemBzM+1j+nG9Gv1B8BB
         CfPMqLm6jD2wwgcl7QarY91gIYsktPV3nU3SIcLAX5Ihd1wZdvj21rJJ41mzOYPOuVt5
         ZfIxpXEpKdsAVnWvlAxmqpNoB5EcTLK35c2uUbB07O3eSNR/LCntILV7hrGGgnwn/rnL
         dsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0J4Jk8Hx4mu2k3ooFyDKxy8VPTqyoZBP7+wp2rhHXqI=;
        b=u0fGJQuhEiHa2T5xSGLHGX3oO18zHB2sIzQzjE80fg519yb4jwG+B83uZtAoE+TeW0
         /kn3gaCaYS96lCmpTCYqKOQ/yFC5zo8m4QwMTvq5sLYGQNb4XbakUUV7sWVqXGWq9r4v
         36ZtRv46AZ42YWA0pEAXHs2glAeM7wB8GjEXXQqGnJIf5WjCi6sa2rZFaBHNBq1vVvtN
         KWA0Ja8o1pw+vy4w+QQTc7BVsx0Pfad6ArnLkWif5vcwQs/IO8BzJnjksYgBizUesSUE
         W5i5dbT99bp2T01ziaAMRpaAHRwqED1GeNoscst3liFvDnAwSvoYNZwpnbCtFT/i3mcU
         YYxg==
X-Gm-Message-State: AOAM5325Zs/ZbMw6KXqkwVLffqRy/U2UZEMraws7njr8KgAVlWKUYyQU
        eyJzTGkvfX0VcofuUBZYUFLGyNBMDbhChjO7yto=
X-Google-Smtp-Source: ABdhPJySmO6xAxXViiOjUvKWRH72MRuy7Dat0TuhrIx34TWtQH1x+o1jRDbEWFgaonIqCx9mI3Rn17mrJmgjK2wwRAg=
X-Received: by 2002:a2e:9b96:0:b0:249:8705:8f50 with SMTP id
 z22-20020a2e9b96000000b0024987058f50mr5617656lji.73.1648153550103; Thu, 24
 Mar 2022 13:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
 <xmqqfsn7i594.fsf@gitster.g>
In-Reply-To: <xmqqfsn7i594.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 24 Mar 2022 13:25:38 -0700
Message-ID: <CANQDOdcuBRvWx7iMYBvLYEEb6A_=SURLAGumk026ZyDODpfAsQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] update-index: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static void end_odb_transaction_if_active(void)
> > +{
> > +     if (!odb_transaction_active)
> > +             return;
> > +
> > +     end_odb_transaction();
> > +     odb_transaction_active = 0;
> > +}
>
> >  __attribute__((format (printf, 1, 2)))
> >  static void report(const char *fmt, ...)
> >  {
> > @@ -57,6 +68,16 @@ static void report(const char *fmt, ...)
> >       if (!verbose)
> >               return;
> >
> > +     /*
> > +      * It is possible, though unlikely, that a caller
> > +      * could use the verbose output to synchronize with
> > +      * addition of objects to the object database, so
> > +      * unplug bulk checkin to make sure that future objects
> > +      * are immediately visible.
> > +      */
> > +
> > +     end_odb_transaction_if_active();
> > +
> >       va_start(vp, fmt);
> >       vprintf(fmt, vp);
> >       putchar('\n');
> > @@ -1116,6 +1137,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >        */
> >       parse_options_start(&ctx, argc, argv, prefix,
> >                           options, PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +     /*
> > +      * Allow the object layer to optimize adding multiple objects in
> > +      * a batch.
> > +      */
> > +     begin_odb_transaction();
> > +     odb_transaction_active = 1;
>
> This looks strange.  Shouldn't begin/end pair be responsible for
> knowing if there is a transaction active already?  For that matter,
> didn't the original unplug in plug/unplug pair automatically turned
> into no-op when it is already unplugged?
>
> IOW, I am not sure end_if_active() should exist in the first place.
> Shouldn't end_transaction() do that instead?
>

Today there's an "assert(bulk_checkin_plugged)" in
end_odb_transaction. In principle we could just drop the assert and
allow a transaction to be ended multiple times.  But maybe in the long
run for composability we'd like to have nested callers to begin/end
transaction (e.g. we could have a nested transaction around writing
the cache tree to the ODB to minimize fsyncs there).  In that world,
having a subsystem not maintain a balanced pairing could be a problem.
An alternative API here could be to have an "flush_odb_transaction"
call to make the objects visible at this point.  Lastly, I could take
your original suggested approach of adding a new flag to update-index.
I preferred the unplug-on-verbose approach since it would
automatically optimize most callers to update-index that might exist
in the wild, without users having to change anything.

Thanks,
Neeraj
