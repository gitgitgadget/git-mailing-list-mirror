Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89253C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5935023998
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgLGWa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 17:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLGWa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 17:30:27 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE84C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 14:29:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so4702169wrx.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9PaCR9bPotSN/dYd76Atgs0g+dRQ1+plix/bUHrjyM=;
        b=Y7MTiNMcQSSmflUNBIM4JclwemGcq3xn4y5mWdciilmTpE1he4X0K3i7BEbLBpdoSY
         PpFVqPcKQsrLki0Ga23B4wqcq23CstFogEzTSOFyC8/ou3ESvikuGFkrd6SEy444CRuV
         KWDHctbOyYhP7xebl5Cc2RW2i+45D2mdqnSlDNxsVKCRpvh8mbvKA4EowdyoiTH5jyma
         ss7TW3IgyGTv64SrtyeNOhO3PbWLFK+gkuI7XtDz7DVYzx8QwuriSC6BKSzROpU0EXot
         2v/fpoxUrav9GfrnCIIkbi+cjQ0+azKmV9AWqCe6QcMHZzLD6XxPXv313Rh6ckKAMKll
         7QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9PaCR9bPotSN/dYd76Atgs0g+dRQ1+plix/bUHrjyM=;
        b=OGmpq5i9lJijaiA9Vo36kePSRBEeLvdu6/IBX+eeWz+S2JBuwIfY98fD2rgcwMFv/E
         IbieLv8xVm3+ZWXOs2eig+gXzTDGfrUiMJU0TYUcdRQq/WUH0atPWOTiQv4pg9wItga5
         cgEIMEXHZhifkxKvbxrfo6zqGSGf0WfUxny91jvCzyWDE6biw5kmTJzjd68XktKjMHM5
         d/tbVSs+HjGStCt0PWWMLEBesDtsv8WBhTrorf4AOVq2ZO08Ynm7U5Vn1uya3Snmep1F
         Bmwc0deZhzDGthCltzT1vY1odB3yLZ5bjrS0HKdnyDLxiw6lLPBW3LrNoKDwL5uuVuhT
         LFbQ==
X-Gm-Message-State: AOAM530TRpfwYT3+fFgL07cHnOcY4jyl06dZyZbWaZw+uaFCxUAhpIkP
        syvJznDhAtXuz6codctuPbhhqPa/K6ARQKyC1/gV0R7AHslTGg==
X-Google-Smtp-Source: ABdhPJyi6kP9hob9bGoLTXm2at3JCTV6HwAhdFATCExH6Ke1Mz3wB/8sbNSTjQjVAF53Guo1fz2DNU4HVYQAkpxoDmU=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr22143052wrv.255.1607380185597;
 Mon, 07 Dec 2020 14:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-3-felipe.contreras@gmail.com> <xmqq4kkx9vzx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kkx9vzx.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 16:29:34 -0600
Message-ID: <CAMP44s1aYqzCVvELH8zULaTkOdgLSSAQ0LE8WfgQKLPfU2MHfg@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 2:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > We want to:
> >
> > 1. Be clear about what "specifying" means; merge, rebase, or
> >    fast-forward.
> > 2. Mention a direct shortcut for people that just want to get on with
> >    their lives: git pull --no-rebase.
> > 3. Have a quick reference for users to understand what this
> >    "fast-forward" business means.
> >
> > This patch does all three.
> >
> > Thanks to the previous patch now "git pull --help" explains what a
> > fast-forward is, and a further patch changes --no-rebase to --merge so
> > it's actually user friendly.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/pull.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 1034372f8b..d71344fe28 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -345,18 +345,19 @@ static enum rebase_type config_get_rebase(void)
> >               return parse_config_rebase("pull.rebase", value, 1);
> >
> >       if (opt_verbosity >= 0 && !opt_ff) {
> > -             advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > -                      "discouraged. You can squelch this message by running one of the following\n"
> > -                      "commands sometime before your next pull:\n"
> > -                      "\n"
> > -                      "  git config pull.rebase false  # merge (the default strategy)\n"
> > -                      "  git config pull.rebase true   # rebase\n"
> > -                      "  git config pull.ff only       # fast-forward only\n"
> > -                      "\n"
> > -                      "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > -                      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > -                      "or --ff-only on the command line to override the configured default per\n"
> > -                      "invocation.\n"));
>
>
> > +             advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
> > +                     "you need to specify if you want a merge, a rebase, or a fast-forward.\n"
> > +                     "You can squelch this message by running one of the following commands:\n"
> > +                     "\n"
> > +                     "  git config pull.rebase false  # merge (the default strategy)\n"
> > +                     "  git config pull.rebase true   # rebase\n"
> > +                     "  git config pull.ff only       # fast-forward only\n"
> > +                     "\n"
> > +                     "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > +                     "preference for all repositories.\n"
> > +                     "If unsure, run \"git pull --no-rebase\".\n"
> > +                     "Read \"git pull --help\" for more information."
> > +                     ));
> >       }
>
> It is an improvement to say what they can do from the command line
> in order to get out of the current situation, before giving them a
> configuration advice.
>
> But the exact instruction for the command line in the original seems
> to have been lost during the rewrite, which I think makes the "what
> to do now" advice less valuable than it could be.

In my opinion we should not dump the entire contents of the manpage in
a warning. The warning should be as brief as possible while giving
these:

1. A description of what's going on
2. A suggested way to move forward
3. A quick way to opt-out
4. A way to find more information

That's it.

Of course when it comes to succinctness other developers tend to
disagree with me, but that's my opinion.

> I personally think it is backwards to update this message before
> fixing the condition under which it triggers (I think by now
> everybody involved in the thread understands that we do not want to
> give this advise that does not stop to behave as-is---it should be
> made not to trigger if we know the history would fast-forward, and
> when it triggers it should stop the operation).  It may appear OK as
> long as we get the right end-state, but because this message must be
> rewritten when the triggering condition changes (i.e. when we stop
> giving this message when the history fast-forwards, there is no
> point in offering the fast-forward-only as a viable option), it
> seems to me a needless detour.

Except it's not necessary to rewrite it further, not in step 1.

Maybe it will be clearer when I send all the patches.

-- 
Felipe Contreras
