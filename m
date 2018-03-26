Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9101F404
	for <e@80x24.org>; Mon, 26 Mar 2018 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeCZUzK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 16:55:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35676 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 16:55:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id r82so18001666wme.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEEWCdi8QxbM6L/iqcDChMAjZLnffTHk4zztC5KaRxs=;
        b=XSGmjHC5no5zQJ5wxw7Sy+6iNvlPaIrDt/LDWPjrzGFXgc0zrZ5BdZZf/9yuNARAmm
         QYTHVRX2Xyw8kRKYtny9WDMuI6Ks2F2vrMOggW63ysbaUlfDiSwlG9apnHge1HS+lsRU
         zDxLOAizRLV99kZdVTdrtasP1NTNtwNSefwDm60UiLYbns3tGKQAUi/Eb7j8fWFMobZC
         reOmcxS5/JLPGBm1lIQatAgkZXZNNlcNgQNF7rvZd931snB0mG/HRyenDGuvuRoxDtKk
         UM/P30/1vBoNT5nkuCobZ1LMAX3y1I1WtU9ep/0Lysx1nwAMFtPWIJ04+Ts2S0pZ7Og6
         +R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEEWCdi8QxbM6L/iqcDChMAjZLnffTHk4zztC5KaRxs=;
        b=gZaZ9//FLPtbAWD8vdt3UIhKk4WkF69FUJuSBrUZtCOPlDmBjQWHUrEY3bg8IEDg0r
         7ox5UvHS95DEVdb55+0sdO/OYPjSn+9T18NuZp+aOBYIyDaRGnyUUFAXBtfHs3ZLEZMW
         AoIDztDM3mHUkTKQuduVnANYV5NziKGbNZseqYM4oLglOi2dkTkGqHOGitzlfukFbTuM
         o4EL/5jqGEuEl23DbjjD0cOPvSD9GnconFN/GM4zwWBRwsoxfrjk++XjBrvGCIme097E
         QIv+BdDZNXtmNUB3DmxI5Ckb6RTuUARrHz+xnaoDq13Gp6kIjz1g3Ctnl26MoQGMdBMK
         evNQ==
X-Gm-Message-State: AElRT7GejctikbVyg3nbqUd780Iz7FUIqV+OxcEdHufFJI3CRYrXrp8l
        Xd9qz9iE+mb+Qw69VWbqAcThFkXr
X-Google-Smtp-Source: AIpwx48GkWYjzkoq5f6J3OtPo+FImcNRvb+lO4xU7sIONhItyuRD31YosDAdz9Dv+WfwchzPd+673Q==
X-Received: by 10.28.241.6 with SMTP id p6mr619216wmh.107.1522097708256;
        Mon, 26 Mar 2018 13:55:08 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y9sm8434429wrg.34.2018.03.26.13.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 13:55:07 -0700 (PDT)
Date:   Mon, 26 Mar 2018 21:58:31 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
Message-ID: <20180326205831.GG10909@hank>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
 <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803262058490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803262058490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26, Johannes Schindelin wrote:
> Hi Eric,
> 
> On Sun, 25 Mar 2018, Eric Sunshine wrote:
> 
> > On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
> > <ungureanupaulsebastian@gmail.com> wrote:
> > > Currently, because git stash is not fully converted to C, I
> > > introduced a new helper that will hold the converted commands.
> > > ---
> > > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> > > @@ -0,0 +1,52 @@
> > > +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> > > +{
> > > +       int cmdmode = 0;
> > > +
> > > +       struct option options[] = {
> > > +               OPT_CMDMODE(0, "list", &cmdmode,
> > > +                        N_("list stash entries"), LIST_STASH),
> > > +               OPT_END()
> > > +       };
> > 
> > Is the intention that once git-stash--helper implements all 'stash'
> > functionality, you will simply rename git-stash--helper to git-stash?
> > If so, then I'd think that you'd want it to accept subcommand
> > arguments as bare words ("apply", "drop") in order to be consistent
> > with the existing git-stash command set, not in dashed form
> 
> Why not start with cmdmode, and then add a single patch that *also*
> accepts argv[1] as a bare-word cmdmode?

I don't think we should accept the dashed form of the commands for
'git stash'.  The main reason being that we also have 'git stash'
without any arguments, which acts as 'git stash push'.  So if we would
ever come up with an argument to 'git stash push', that matches one of
the current verbs, or if we come up with a new verb that matches one
of the options to 'git stash push', that would not work.

In that case we could obviously go for a different word, but I think
the rules when 'git stash' is going to be 'git stash push' and when it
is not are already complicated enough, and allowing the verbs as
dashed options would only make the interface more complicated.

> This could even potentially be a patch to parse-options.[ch] that
> introduces, say, PARSE_OPT_ALLOW_BARE_CMDMODE.

Now if we'd take that one step further and make it
PARSE_OPT_BARE_CMDMODE, which would only allow the non-dashed options,
I think we could use that in other places in git as well (for example
in 'git worktree').

> Ciao,
> Dscho
