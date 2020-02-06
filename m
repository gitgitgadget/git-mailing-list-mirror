Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B381CC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9E421775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKOm8BIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBFTPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:15:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43767 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:15:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so3210599pgc.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Leo4TRx8vgpdPngHU+/fSwfxZdbpT3FJFr82cPvEtjs=;
        b=lKOm8BIMNEvu4dStxCOq+baYUAS/vggU5nKwcku2qkr4nfDRjHfGVkRm5HJRNVkP9r
         btL08nbejlmtSQydHVtksS5CetiJifGRYuCzQQcof4drMOIzN5urVrUFPemOtHnosJyx
         yAGwuGPlcEMtzVorFjrKSqhMuDR56JYBVLCOvC451y/CyCfIWzYTmrcpflEhP/3Zf3CZ
         TsIMuOAc4+00LMTZbNP9N3iAYXrlHQlNcK7xLQimC97UYGCyyJ1D1x6pQJUuJUSQBDUx
         jKlzcVT0NPWNONB7q2ECxaFT/+MxPrb7Qx30cJdIwCOdzvg0ER43nUTw1iHv6ljQDmtx
         V3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Leo4TRx8vgpdPngHU+/fSwfxZdbpT3FJFr82cPvEtjs=;
        b=PbYdNtCgo/eKUxNrJtxRU5hM/olIGU6520WIYajk7fAnH+Erppsxg+5n5NIAPqCzQR
         q7DtL+ys/Sl2NvLgGxelkyd4hzgWdcTIJovMS11WiAnzvK4jIOnMMAdtgve2iY6vAIDC
         T5KB5uHH9sZcnZTWctI46XDixNI9GSFhc8NWq8VOGCUV1sB7dNcaWPEZxWtHfnxw/KTu
         fibPJVzmnGqzlfs+dgg7AebwPGREIDxIbJMQOe8SP6qVDxfyQEYJxjloQWJ7n9UkBe9a
         FIX8jSh0DlIK2xVz6bzFX1DFSIVLN+38xyvfQxpnRTfsmEPVBdRLMnMPheWkp/rfWitT
         lW/Q==
X-Gm-Message-State: APjAAAXwl8IdJiTXNGgQHF3VaOX4hXJlK+89wkN/54/DaFF8plZ/26VP
        uBvWfsxZBVeD+kvGX9M+fSYst/ue7eIAGDbVOfg=
X-Google-Smtp-Source: APXvYqx/uTyvbSRuXxNa+oWCnUdnXgYh+WqEoA1kx5roD4Dr5c98w0/8viXP6+ViA11r4nUSNZmIMAmM+Y9QG9WXXao=
X-Received: by 2002:a63:4282:: with SMTP id p124mr5113196pga.155.1581016514692;
 Thu, 06 Feb 2020 11:15:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <CAN0heSo29+sf1352EfGv=qFsir-e=Ompja445bh5z3vpOfkaJA@mail.gmail.com> <20200204040628.GE5790@syl.local>
In-Reply-To: <20200204040628.GE5790@syl.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 20:15:03 +0100
Message-ID: <CAN0heSpg6i7m9tT6LM-8C+cOMGOtDYMdpsuGn-weUo23jgJOTQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Feb 2020 at 05:06, Taylor Blau <me@ttaylorr.com> wrote:
>
> > Or can you convince me otherwise? From which angle should I look at
> > this?
>
> Heh. This is all very reminiscent of an off-list discussion that I had
> with Peff and Stolee before sending this upstream. Originally, I had
> implemented this as:
>
>   $ git commit-graph write --split --[no-]merge
>
> but we decided that this '--merge' and '--no-merge' requiring '--split'
> seemed to indicate that this was better off as an argument to '--split'.
> Of course, there's no getting around that it is... odd to say
> '--split=no-merge' for exactly the reason you suggest.
>
> Here's another way of looking at it: the presence of '--split' means
> "work with split graph files" and the '[no-]merge' argument means:
> "always/never condense multiple layers".
>
> For me, this not only makes the new option language jive, but makes it
> clearer to me than the combination of '--split', '--split --no-merge'
> and '--split --merge', where the third one is truly bizarre. At least
> condensing the second '--' and making 'merge' an argument to 'split'
> makes it clear that the two work together somehow.

Yes, "--split --merge" sounds no better. :-)

> If you have a different suggestion, I'd certainly love to hear about it
> and discuss. But, at least as far as our internal discussions have gone,
> this is by far the best option that we have been able to come up with.

I can't come up with anything better, so please feel free to carry on
(as you already have).


> > > -               OPT_BOOL(0, "split", &opts.split,
> > > -                       N_("allow writing an incremental commit-graph file")),
> > > +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> > > +                       N_("allow writing an incremental commit-graph file"),
> >
> > This still sounds very boolean. Cramming in the "strategy" might be hard
> > -- is this an argument in favor of having two separate options? ;-)
>
> Heh. Exactly how we started these patches when I originally wrote
> them...

You left this as-is in v2. I don't have any immediate improvements to
offer. I could see shortening the original to "use the 'split' file
format", in which case maybe one could allude to a strategy here. (I
don't think "allow" is really needed, right? Maybe it tries to cover for
the situation where there's no commit graph yet, so you might say we
wouldn't write an "incremental" one, but the format would still be the
same, AFAIU. Anyway, that's outside the scope of this patch.)

Martin
