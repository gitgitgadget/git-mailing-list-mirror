Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88795C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D44922D75
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgLEB0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEB0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:26:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDBC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:26:06 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so7013722wrv.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHtaLekH48Fw9F8XblFe3popLtxv8EOCrcHOPNO+0lA=;
        b=dFlrRb5AcgvhXq/zsebPfhuBs+ms/8JlVjeW3Qb6rmhqSdrIBWmnjM46+Tl1BxyvXU
         alB4UNFAtivhTLEB6rmsYxZz+yog+fhWTIFUhsDMLiUhQWEYhSWgvWXaH+94yqH3f2bb
         vc7O+VB4h7e6cvvCWf/PszfdGwDePzlU1lysNmiTrEFggeWeA/k4/X3V1UmONO/xjfDZ
         8lpT3mEv44ezXiDWRsfvwBIGl+0nQbmcZmDhb+xCFOngj+qtAfMPvrbAW42fPMUlyP/B
         90Y/yvnZPLLDAcFe1+5zvBdm4Rv6BvtMlsGnM1kofpJ6nbrSQRWwXyLQ1NGurLj4GkDb
         lWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHtaLekH48Fw9F8XblFe3popLtxv8EOCrcHOPNO+0lA=;
        b=Gu1v6QW3lAK6gsjqSsfsMnQp9lwviSVj9FD5QSse0n4Wp2Z/WvcS8yztYx8MGbMO59
         GMVcGlxsTRxJaTgVQU44/ufBGzneZ2+66WxDk7z4lp/kp+miEWnJekXpr6cPfeN3cVQ/
         SfXQ7JFyZ8/fRGQdU9s+G1BbT8iZz4+TTcoVm0lJhhxqC2PcV/AL0M6McQOOpB6fwgaz
         ilK6ZVFpOW8GFHMy49TcaWjeIgL08rf0UzhzNB9S5yktQbUH0p9fyiIFogBdfhc1z0gi
         6NXuxX2CJcRgaW6avrExumVn4UjXahuqh1RT1NYNseLzph+r6Cu2HQPj9dqWVG5mVumK
         L26Q==
X-Gm-Message-State: AOAM533zReR6PIOH5CyoZOqQGN+NItSJ5Wecoh0Am/Q+fry7m4YoY4Yc
        8hDVDS/QaJ6mE3fzLgsylemwqGxUhHA4e2leBNk=
X-Google-Smtp-Source: ABdhPJzT9CFfFs4on9h6fv87A/bLmrFmQxJxQSI7X+Y+mV9sURovMJoRwMBinCh6puPBdLIt4lViXztf+biHmHt/VkI=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr7959904wrs.100.1607131565416;
 Fri, 04 Dec 2020 17:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-13-felipe.contreras@gmail.com> <CABPp-BE5zvCAmfHE_1_D3boMg5rMcU0iyJJp+yiLwSu2DsySLg@mail.gmail.com>
In-Reply-To: <CABPp-BE5zvCAmfHE_1_D3boMg5rMcU0iyJJp+yiLwSu2DsySLg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:25:54 -0600
Message-ID: <CAMP44s2dRQRZDOooDKQSyEobaDD_z7Q0zmqmVMYSK5G7t0p5SQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] pull: show warning with --ff
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:41 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > It's unclear why --ff should remove the warning, since:
> >
> >   git pull --ff
> >
> > Is implicitly the same as:
> >
> >   git pull
> >
> > Unless of course pull.ff is specified otherwise.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/pull.c               | 2 +-
> >  t/t7601-merge-pull-config.sh | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index ebf2ac687b..e389ffcdc3 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1020,7 +1020,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >                         die(_("The pull was not fast-forward, please either merge or rebase.\n"
> >                                 "If unsure, run \"git pull --merge\"."));
> >                 }
> > -               if (opt_verbosity >= 0 && !opt_ff) {
> > +               if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
> >                         advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> >                                 "discouraged; you need to specify if you want a merge, or a rebase.\n"
> >                                 "You can squelch this message by running one of the following commands:\n"
> > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > index 1de64e6cc5..d709799f8b 100755
> > --- a/t/t7601-merge-pull-config.sh
> > +++ b/t/t7601-merge-pull-config.sh
> > @@ -46,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
> >         git reset --hard c2 &&
> >         test_config pull.ff true &&
> >         git pull . c1 2>err &&
> > -       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> > +       test_i18ngrep "Pulling without specifying how to reconcile" err
> >  '
> >
> >  test_expect_success 'pull.rebase not set and pull.ff=false' '
> > @@ -78,7 +78,7 @@ test_expect_success 'pull.rebase not set and --merge given' '
> >  test_expect_success 'pull.rebase not set and --ff given' '
> >         git reset --hard c2 &&
> >         git pull --ff . c1 2>err &&
> > -       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> > +       test_i18ngrep "Pulling without specifying how to reconcile" err
> >  '
> >
> >  test_expect_success 'pull.rebase not set and --no-ff given' '
> > --
> > 2.29.2
>
> Ah, this answers one of my earlier questions.  I'd be tempted to move
> this earlier in the series; it seems like an obvious cleanup and helps
> explain the "opt_ff" flag that keeps coming up for readers of the
> series.

I tend to put more controversial and less useful patches later in the
series, and this is the one I was least sure of getting consensus nor
does it solve any current issues.

I just found it inconsistent.

-- 
Felipe Contreras
