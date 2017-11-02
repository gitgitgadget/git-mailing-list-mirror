Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587E320281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbdKBSer (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:34:47 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:53856 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdKBSeq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:34:46 -0400
Received: by mail-wr0-f175.google.com with SMTP id u40so429594wrf.10
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y1LsID9wAm+NOdAtgxmLqEcsotN298xFP561A3SPCBQ=;
        b=UKlS7eDkDumB7mg9ydtGY/oF/hdoI7L1pDkiO6B8bB4ljOjiKiigcyho1uTFc+D8Bb
         9/5b8q85xAl6zfVqPqWckqkWaYjn6qD2PRTh8Eqs/uYgtCi3oAcGSoKHlih5mYNSpxm+
         CDfwncF/Py+lWmKM679aLw4swd0coHOahyaWf/5sdJS+d5aIvRtd0JH1ey6xfUwYhX4r
         3rf5MX1mTSPjsIv7v3CcIL2qhFmgmTP67OFjTMnwoEI0Os7mrMOXJ8HdbbGpzkl/1SqN
         JZJaNO0zoqvTJ7oSZvUtgt53gg5hD0NMD5CGBn4aP2bov8azKp/lfZ9p8LnnSpObuasf
         3s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y1LsID9wAm+NOdAtgxmLqEcsotN298xFP561A3SPCBQ=;
        b=XpKUI+0lmjfg2kpDhuPUMvVyS0LMRZ1l+aZOH1b40e3AUor1D+ISGoE/fuJBHdl0TZ
         AJfHDBlPkefsj3Ut18Obfi2JsB5BjRdOo6u1VXLUYsiA8RRTXsX4sf/DSrlL+vp0WjHk
         xVk5HVMS/fE2Hor3mmKSwgArZnZSL4Q8WDxCa1TTN1LudJcrutyGT6GuWBg/ehgJhq1B
         v2x+QF6xGNkVlGcvSkYPtcJCZydbjdLrCiLKp187sf9I/X8ni/04I/KHKvwQllQDijdx
         vxw+SkQtp7MTR/hd+jU7xucgJy71U0TRnfSL7wETLbUKueWX+xzP7zo/uGYOH6qCxHHv
         dKRg==
X-Gm-Message-State: AMCzsaXHgLLbFW/HBl15OMQ0KOLMFQu8ZpYHaWTHfUmN6xcjzWOmIFpD
        KX58QOxAKadbYQsP0kk+5dU8g6KwXKuDU5rFGNB2fA==
X-Google-Smtp-Source: ABhQp+Q5rmQc2GhewmohQaJWQ3y96BczNs/3T5UnRXju2qql8A3i5pS751NnZF3Sb7rTA2bviPiMu/5bxrTq9JDzYKg=
X-Received: by 10.223.134.250 with SMTP id 55mr3934965wry.249.1509647685335;
 Thu, 02 Nov 2017 11:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 11:34:20 -0700 (PDT)
In-Reply-To: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 11:34:20 -0700
Message-ID: <CAGZ79kZaCe6ATXajK_HhzhDcWm9CV3bsJ5EAqE5UYXBc+_b5yA@mail.gmail.com>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
To:     Orgad Shaneh <orgads@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 1:30 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> I can't reproduce this with a minimal example, but it happens in my project.
>
> What I tried to do for reproducing is:
> rm -rf super sub
> mkdir sub; cd sub; git init
> git commit --allow-empty -m 'Initial commit'
> mkdir ../super; cd ../super
> git init
> git submodule add ../sub
> touch foo; git add foo sub
> git commit -m 'Initial commit'
> touch a; git add a; git commit -m 'a'
> touch b; git add b; git commit -m 'b'
> cd sub; git commit --allow-empty -m 'New commit'; cd ..
> git rebase -i HEAD^^
>
> Then drop a.
>
> In my project I get:
> error: cannot rebase: You have unstaged changes.
>
> This works fine with 2.14.3.

  git log --oneline v2.14.3..v2.15.0 -- submodule.c
doesn't give any promising hints (i.e. I don't think one of a
submodule related series introduced this either by chance or
on purpose)

"rebase -i" was rewritten into C in 570676e011, though
that series was extensively tested by DScho, so I wouldn't
want to point fingers here quickly.

Would you be willing to bisect this behavior?
