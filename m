Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B6EC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D9022314
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgUcOhR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBFT7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:59:03 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39403 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFT7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:59:03 -0500
Received: by mail-pl1-f176.google.com with SMTP id g6so2771264plp.6
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4uy5a2VmKpiROVvw4tGoTCLQaPvJVZDzy6O54iHgfW0=;
        b=sgUcOhR8P5pjq1uTKJAq0TaIC2pljBGB34JP6iBswSD92koMjmAaT/LEOWLqbqaPFx
         ZxOUppEh0UEqxlWlY7KNrTagF5k9dT9ewEfTDHyhmN9a4Ugrtf5oyxLLOmjZkfHjs5Qd
         6shtOGtUGt4v/j443WUXaIpBFGiFyZSN3QIRuSRO/yHBT6FXF4fvoNfHAfRAPeweFJDk
         T9wQs5FEowr71pT9MMFw7ajU0QtpYQNdFS3yIum/kzTnSeMNsJioWDXAe+PR9brU9KbQ
         aTvMlRgBtMy4R6Z379MeHoFLMIH7T2dLpSuzJpd5W7AEmBOzPD9NunTJnCEd4QTrT12/
         ihMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4uy5a2VmKpiROVvw4tGoTCLQaPvJVZDzy6O54iHgfW0=;
        b=a3qO2JrmQZsmpycnSi0HhEhF6Irk4AujcgF/ifQx5xkN4Ufh7np9sUwiP8TtcHkn4X
         qdNyHHPXHINbjm9XWgyMnjapHsJkhP1ZF6WsiVGtuZiTvSHmhD5pK9xtrPPqp3hCftvj
         Eu0qtkOUhpr0kJqKg1pkTTsv8ja0XI2mDBQs1GUmpKxuO+97qcwxjRRV0qlmp95D01nW
         Jd3lnA1IhTXjigt1Hv2GD4xf72ULCWmoTTuG71MZCFnugZjIIgUr8CRI4XB1M/NdUKBJ
         qHu9wB0ZcWOx4ifsZqqaL0hDcWajfGT6BJmL85Hl4bHhFTLdz1V9pZ7OK5v+l69xLkqP
         6hag==
X-Gm-Message-State: APjAAAW38kIEjjmaU9wCL22ZBQO6fh7XowIYMQVwW3t+vwQkSgiLtu6S
        i3Yzm6O8CODtd+w3R3duxYwCSbIt3zXXXcfPdlU=
X-Google-Smtp-Source: APXvYqzpYdNrGuXLHkFSVBKhQGiAVpnZz1kfyd8bi2Hl0UC32h+7hfPPnj5zaql5MgwbNdnMVBH0OTN6X/ISJw2CgD4=
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr5792588pls.197.1581019142512;
 Thu, 06 Feb 2020 11:59:02 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com> <20200206025130.GA22748@syl.local>
 <20200206085747.GA17654@szeder.dev> <20200206174837.GA55561@syl.local>
In-Reply-To: <20200206174837.GA55561@syl.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 20:58:50 +0100
Message-ID: <CAN0heSrcMYwy72oR0HA+ptEutLFqvs14RLF5AVE1ATJTUj=eVw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Feb 2020 at 18:48, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Feb 06, 2020 at 09:57:48AM +0100, SZEDER G=C3=A1bor wrote:
> > On Wed, Feb 05, 2020 at 06:51:30PM -0800, Taylor Blau wrote:
> > > > * tb/commit-graph-split-merge (2020-02-05) 3 commits
> > > >  - builtin/commit-graph.c: support '--input=3Dnone'
> > > >  - builtin/commit-graph.c: introduce '--input=3D<source>'
> > > >  - builtin/commit-graph.c: support '--split[=3D<strategy>]'
> > > >  (this branch uses tb/commit-graph-object-dir.)
> > > >
> > > >  The code to write out the commit-graph has been taught a few
> > > >  options to control if the resulting graph chains should be merged
> > > >  or a single new incremental graph is created.
> > > >
> > > >  Will merge to 'next'?
> > >
> > > I think that this is ready. Martin =C3=85gren and I discussed a littl=
e bit
> > > about the rationale behind why the new options were chosen over
> > > alternatives, but I think we reached consensus (at least, the thread =
has
> > > been quiet for a few days after sending 'v2').
> > >
> > > So, if you're asking whether or not this is ready to merge to 'next',
> > > I'd say that it is, but I'd like to hear from Martin's thoughts, too.
> > > (For what it's worth, we're *also* running this at GitHub, and withou=
t
> > > issue).
> >
> > Please don't rush it, those '--input=3D<source>' options need more
> > consideration.
>
> Of course, and I'm happy to discuss more, if that's what others discuss.
> I thought that things had settled since the thread quieted down after
> sending 'v2'. But, if there's more to discuss, certainly we should do
> that before queuing this up.
>
> Let's wait a little while longer and see what happens there before
> queuing this topic.

I feel there's something awkward about these new options, but it's not
like I have brilliant suggestions to offer. But I don't think it hurts
to wait a little and see if others chime in.

At a minimum, the two comments (patches 1/3 and 3/3) I just left on some
asciidoc hickups should be fixed before this graduates (that should be
easy). I'll be happy to test and give a thumbs-up if needed.

Martin
