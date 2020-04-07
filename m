Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8DAC2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57920692
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oet5IH/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDGPSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:18:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40981 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgDGPSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:18:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so3470284otf.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EDqoRPpuQ36JIqw4D6qbr6esLVBRbTxVpumRK85/Yk=;
        b=Oet5IH/195ertiNa/P1RTWbhPeNAMmb2R2z9C2bWnohKPW9m8G9sr3w2uqNPAOXs7q
         nH645VczDOeYlG9hR22b4N54MTc1unGN0H/HP3z4NcMxLVBEx8tRxdjGl9gOOwaTM/eV
         KzYhePTz8js4rvl775vdLT1hZysYn1qyHu6my+xk51tg9mKlC94h6Jml8v9ob3vNYLac
         gGjMVaLgn+GlDiFfVJKUNkyUBhoht759YP6jbanrAo4XvUq9HMWcL57VnEwk9yO5eTqy
         m8J9tW3bKwwbz/ZISzFgRGkdZovCLW0l50yEXuBcdoAXmNqfljPqDSAMtJ1WVzFLqgo2
         LE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EDqoRPpuQ36JIqw4D6qbr6esLVBRbTxVpumRK85/Yk=;
        b=FPAbsYPXZ3Z+jJvdcJ9KuySpEvj5xvb0zQVGS+u9sG0IBS0QYWNSWT3CSNYl0mRBdH
         14w1YpGMrjgAX4NyNNF1hmQ7Dg2K3nA/riVAZTsuXW5hQNtcm0jfgpcrhKU2CJ1yGHPJ
         tR5ZtR1yWfk0QJP30UEcANugA1d+t7qfxwZ0LHuJieZmhaarPKWtIsNciFxy9bdj2eZ5
         Yqn2GvzTFNqKG1tI3CtZj3qlcXxscAZBNRdwTXb8hdDiw/Zc2UBUbesWnNUWSL83piR0
         fEg7DqKlikyoHfmY77Pq3EyRgjNWyFzTUJEJGtkFLamHFyn/dVX3CIz1SW9UkQNyJWzi
         s5FA==
X-Gm-Message-State: AGi0PuZXC8i/UBLMcq0hcA/111of3Wnt35BXjwaDaaQR2/+Tbtfwms+f
        by3ZQZ/LS8coSfP++hTwmj4AJW4LeuJ94Dgjfs4=
X-Google-Smtp-Source: APiQypLKT2Tctheyz+bgsUjMHqoPfIOqa1f5CWvdRrgMDkN6aXGmA98OqBYt+xbDKf8pe5fS9/wyNDXfx5TPi8xdQ0o=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr2064602oti.162.1586272724351;
 Tue, 07 Apr 2020 08:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
 <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com> <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com>
 <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com> <nycvar.QRO.7.76.6.2004071649190.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004071649190.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 08:18:33 -0700
Message-ID: <CABPp-BFXT1QkTLUFSAju2TwzVdSRjKSyLQYp2KaoW2+S2U8KJw@mail.gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 7:50 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 2 Apr 2020, Phillip Wood wrote:
>
> > On 02/04/2020 18:01, Elijah Newren wrote:
> > >
> > > On Thu, Apr 2, 2020 at 2:25 AM Phillip Wood <phillip.wood123@gmail.com>
> > > wrote:
> > > >
> > > > On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
> > > >
> > > > >        va_start(ap, fmt);
> > > > >        strbuf_reset(&buf);
> > > > > -     strbuf_addstr(&buf, action_name(opts));
> > > > > +     strbuf_addstr(&buf, reflog_action ? reflog_action :
> > > > > action_name(opts));
> > > > >        if (sub_action)
> > > > >                strbuf_addf(&buf, " (%s)", sub_action);
> > > > >        if (fmt) {
> > > > > @@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *r,
> > > > >                        struct replay_opts *opts)
> > > > >    {
> > > > >        int res = 0, reschedule = 0;
> > > > > +     char *prev_reflog_action;
> > > > >
> > > > >        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > > > > +     prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
> > > >
> > > > I'm confused as to why saving the environment variable immediately after
> > > > setting it works but the test shows it does - why doesn't this clobber
> > > > the value of GIT_REFLOG_ACTION set by the user?
> > >
> > > The third parameter, 0, means only set the environment variable if
> > > it's not already set.
> >
> > Ah thanks, I thought I must be missing something fairly obvious but couldn't
> > see what it was
>
> FWIW I was also about to comment on that. Maybe that warrants even a code
> comment above the `prev_reflog_action`?

Yeah, if it tripped you both up, I'll add such a comment to the code
to help explain it.
