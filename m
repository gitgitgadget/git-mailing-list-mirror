Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFAFC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbiC3TL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350636AbiC3TLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:11:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D23135D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:09:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bt26so37486653lfb.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVqFGRkG75zJd7Tcc3fpNlGm0DroU4S5w1Nswx3jq+o=;
        b=gRTWHDh4i3LUlvWpArMsFZbFT4jGy35K8KAjojNmb2RDn9YGNRIulY0rV2rmArYe2s
         jR3ceczqBxf1hzfjWMeOdIWJplippZDC8YGfS5Rx+sU8kGwcptGlIbaTgXraKPU6ez5j
         vXq0OR21f4CoFpq54KGIshvdq6NuKqwDbJ24fUoLDvn+ngAt2bmGQeaZxj01ZQphYA2J
         M3vrdZagirQt4SV9SdpTNRiGjFyfhFlyuE3f/5Te7xrsa4lmdQs78ztjPNGCeptYJr0+
         UyjzRr2apy9x6I01ihdQuAnqV5vhvmncJmx4fp8gP2CTznn6CGyQynLnhAiLi+aoVjuR
         P4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVqFGRkG75zJd7Tcc3fpNlGm0DroU4S5w1Nswx3jq+o=;
        b=v9KttqryJ6H7KgwNR8u6TilLf5cnBJ/1xVhAQHDc9Mlf1eldGRMpQyFyBOcIT6JXd1
         U/cB/vKGOdz8Pk6H73f6f6oOLVeREcKl9HuT0Np58BfbV5m+W2Xg60uAwb6mkZCz12wA
         YzNgL+HTtJCzgaG3na3dB1K4na9WimcEtQ0lN4cDGzlGPkH2KdIOfvUHfhhB0dbtfur5
         bjpvNBshMfyzGn0Rov33cJZh+FjRcChqHyrs4/yZrAe1oLvxKHNKVq9zHDDIMYlg2iWZ
         gHuUXF43+WiWvRm4oxu8SpyRR7cSoW45/7oYnLWxqUeUgMLDUt348l9wGe4R+ElV905M
         1m1g==
X-Gm-Message-State: AOAM533BHAfYntoRl3AlSaIrB1weMyb5Vvxsyi+QNV3TdRbmIYOKH6zP
        COQDsfPSwfIW/MW42Veqs1z4ub5j62u71m2cgXY=
X-Google-Smtp-Source: ABdhPJx0yzOQS0U0gy9WsW7WJhqRPXetvH4P8MjQgsSnwZQmdY6kKAWd8AZVsH90a3kFL6+lmLNH0Qw1h19/C1vnD8g=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr8241593lfe.74.1648667356343; Wed, 30
 Mar 2022 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <8cac94598a58704d9b625a9d8a593779f7adc30f.1648616734.git.gitgitgadget@gmail.com>
 <xmqqpmm38h01.fsf@gitster.g>
In-Reply-To: <xmqqpmm38h01.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 12:09:04 -0700
Message-ID: <CANQDOdf5T9iexGryVfZ1epgEdkiBU5WBCX9rBtpr_JuSvvxjmA@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] update-index: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     /*
> > +      * Allow the object layer to optimize adding multiple objects in
> > +      * a batch.
> > +      */
> > +     begin_odb_transaction();
> >       while (ctx.argc) {
> >               if (parseopt_state != PARSE_OPT_DONE)
> >                       parseopt_state = parse_options_step(&ctx, options,
> > @@ -1167,6 +1174,17 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >               the_index.version = preferred_index_format;
> >       }
> >
> > +     /*
> > +      * It is possible, though unlikely, that a caller could use the verbose
> > +      * output to synchronize with addition of objects to the object
> > +      * database. The current implementation of ODB transactions leaves
> > +      * objects invisible while a transaction is active, so end the
> > +      * transaction here if verbose output is enabled.
> > +      */
> > +
> > +     if (verbose)
> > +             end_odb_transaction();
> > +
> >       if (read_from_stdin) {
> >               struct strbuf buf = STRBUF_INIT;
> >               struct strbuf unquoted = STRBUF_INIT;
> > @@ -1190,6 +1208,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >               strbuf_release(&buf);
> >       }
> >
> > +     /*
> > +      * By now we have added all of the new objects
> > +      */
> > +     if (!verbose)
> > +             end_odb_transaction();
>
> If we had "flush" in addition to "begin" and "end", then we could,
> instead of the above
>
>     begin_transaction
>         do things
>     if condition:
>         end_transaction
>     loop:
>         do thing
>     if !condition:
>         end_transaction
>
>
> which is somewhat hard to follow and maintain, consider using a
> different flow, which is
>
>     begin_transaction
>         do things
>     loop:
>         do thing
>         if condition:
>             flush
>     end_transaction
>
> and that might make it easier to follow and maintain.  I am not 100%
> sure if it is worth it, but I am leaning to say it would be.
>
> Thanks.

I thought about this, but I was somewhat worried about the extra cost
of "flushing" versus just making things visible immediately if the
top-level update-index command knows it's going to need objects to be
visible.  I'll go ahead and implement flush in the next iteration.
