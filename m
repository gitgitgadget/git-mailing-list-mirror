Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB13C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8E164E85
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhBRMXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhBRKQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:16:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB486C061788
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:14:25 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id h17so1406361oih.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQo00tEd3kRJMKTLxEvlE0FiCM54+4/Hr33XoSIv/U=;
        b=TW2VDrxU1//CkEj/dO+DSItMoVgTHrNtYl0DDmZpCtXFuXDP6T0FScgoj+BYSCAB7Q
         L733hk2bXcKGlHvh/gn05jbguia7v8j58cO9wi69DRsqUlJpMovdhlNPYoUbmQUL1xaF
         TmzGiHCfcpFrvoaWs3aZKubWV3Hh9a58C6lmzgloBTvYG0RBjVlQPRjKOal9BJfV+6u+
         +WTsyH8/w0jqKFFHkUTUnfn62H1aC1hsT9Caisy0SpSc0wlo2eD1UJxQOLa7jaZzFidy
         Zs0GTgaJi+hQihrd+kvS/oFy1jGZKnl7DXhRDuz0zGnmbHB4JSJkpVzTufQwX7tbRWP3
         MbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQo00tEd3kRJMKTLxEvlE0FiCM54+4/Hr33XoSIv/U=;
        b=QBSB4puV9xx80y12uIj63Y1V5bh5Hn9e2GBFxpHtvG8amLRUjQwZCY/QxkwsGwO0o/
         EcF08Fca4/OtjAvA5V674QLHHfP1+JlrWH9PXAO0gQtNWpRLVUEQumsP50h+mhAJm8Az
         aO5ybN+4l0vV3syU9suLwj2GdkCh8Nlb3PyZj1Ww9oXw1M+LLJshvQJx8KgyV5h/L51v
         yR76Uz88M/18XNGPC8A1RwLFSjjJjJb0tZPP/W9l422JfF+hIyMMa/RJyPf7aYfua9Vd
         08EybAD5++cczidP/NrpyQ683pCLDO9knZTdCNOayvpD0wO/rpwJv8sJVSnN3AZyfM6e
         pQwA==
X-Gm-Message-State: AOAM5315pkjOZsukjGRm62KoXozHg3TRMKFcmhryZ60tdjQ7/73tt8QM
        m2zwv+ICWLZJ1X9n+SvBluqQeIpMiTVm/rvnyxw=
X-Google-Smtp-Source: ABdhPJzXFqihogDS8TUeC9CCZireM6AgGCj/pqu/RAKJLfmSOtel46bWQT+EcB/oXPbB5vU7f0FyfZK50CODsJM1SJ8=
X-Received: by 2002:a05:6808:aa6:: with SMTP id r6mr2076332oij.163.1613643265456;
 Thu, 18 Feb 2021 02:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-3-charvi077@gmail.com> <xmqqwnv6jwmz.fsf@gitster.g>
In-Reply-To: <xmqqwnv6jwmz.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 15:44:14 +0530
Message-ID: <CAPSFM5c0xFwnSh_O_8FRQSidQUMZWZs_f7kV8kXuCRYr0ro6rQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 01:26, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> The same comment applies to the above as an earlier step.
>

Okay, will remove it.

> > +static void check_fixup_reword_options(void) {
> > +     if (whence != FROM_COMMIT) {
> > +             if (whence == FROM_MERGE)
> > +                     die(_("You are in the middle of a merge -- cannot reword."));
> > +             else if (is_from_cherry_pick(whence))
> > +                     die(_("You are in the middle of a cherry-pick -- cannot reword."));
> > +     }
> > +     if (all)
> > +             die(_("cannot combine reword option of --fixup with --all"));
> > +     if (also)
> > +             die(_("cannot combine reword option of --fixup with --include"));
> > +     if (only)
> > +             die(_("cannot combine reword option of --fixup with --only"));
> > +}
>
> Not just these options, wouldn't it be an error to ask to commit
> anything but an empty commit?  E.g. shouldn't this sequence
>
>         edit builtin/commit.c
>         git commit --fixup=reword:HEAD~3 -- builtin/commit.c
>
> trigger an error, as we will *not* be taking any change made to the
> working tree file?
>
> Or is that implicitly covered by some other code?
>

I admit this is a bug here. Thanks for pointing this out and will add the
check for pathspec.
