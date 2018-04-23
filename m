Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC151F424
	for <e@80x24.org>; Mon, 23 Apr 2018 01:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeDWBOf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 21:14:35 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44073 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeDWBOd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 21:14:33 -0400
Received: by mail-pg0-f52.google.com with SMTP id l12so7187364pgp.11
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 18:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWpT81aM3tsrj2VBl/4JGsdv4YNdLp4M5vJUfe9Pb1o=;
        b=WDEoiiD573kusnBVeNZmX8W6MvHA2/OMpUukMK9s2MzwNX3LQuQfIsVJUXAy17ukXq
         h+iirUayfh7AT0u2boTKkchjdSTAn5XZKjM0MMDGAHRFdZI63nsmZ8SZB9BQyGGN/Rfq
         /A3YfburZgIrHQLRDXuunh/LUKOzbaWNP4x4cQyOUGLZywu32jcDFJMHU/dEvtyURQyJ
         l0fIFE7cMjKSF6SkzAFeYc0S4VIaqzzaa/QgzI9whi7dY2PI06PDtZH5244N5mo8qZc7
         QijVsY5wOZ0IVaI5BPyUnb60EO/cNEoVQ2op4T9w3SeYphJpgj+LgpJPgnZ75zwTk3QD
         3D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWpT81aM3tsrj2VBl/4JGsdv4YNdLp4M5vJUfe9Pb1o=;
        b=pWOSNQL7bUdu6+22HIa2laGz1UHz0Rw1FB2n/KXnZ4P6CYzDRrpWjSCvDg6v0D9mHl
         5LLlRLh40W2eeFIY3Kmu+QDElNpKcVPD3LM2DTPtvHtPeDw2udSJTAdxKGSs2X1Gdcmc
         Qv5UoAfHvUR1iOdibZlzxhOMBHgtU8WqGPBzcFh7gvufTgYnzZwo8W4cX1rnjEvdZIHJ
         zIvw0dkcVjPxodDTxdzjM8JFTw9BMyRRRvl58OzCm9F3hfuZh1GYm+3eWJ37tjaNjXlA
         58bpxijUQxSyatM4WQ9DL7RWIAGkD64hL+kU63Q1FJW4cMo9+ZDyVFjb33mEpu33OvMd
         dHsA==
X-Gm-Message-State: ALQs6tD74ixkIYjv4ARgr+lUVPpZuHM75fuoSOfrHy/tneuaLpC22deE
        J4dtRTWCn0bbFxPeXgMqhQPVQw==
X-Google-Smtp-Source: AIpwx4+sXLfGCnvv1QEfqTtJxhvqawrfeBi/NtZazBByqkioL4Iml2bdgke0UpNABQHabjKlzAEuUg==
X-Received: by 10.98.89.89 with SMTP id n86mr18129294pfb.158.1524446072999;
        Sun, 22 Apr 2018 18:14:32 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id m185sm20523133pfm.118.2018.04.22.18.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 18:14:32 -0700 (PDT)
Date:   Sun, 22 Apr 2018 18:14:31 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] builtin/grep.c: show column numbers via
 --column-number
Message-ID: <20180423011431.GC78148@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
 <CAPig+cTozduqSAxh+w4H85m7en72Yo09asdx+1KSTswqbnBr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTozduqSAxh+w4H85m7en72Yo09asdx+1KSTswqbnBr4w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 08:32:28PM -0400, Eric Sunshine wrote:
> On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > This commit teaches 'git-grep(1)' a new option, '--column-number'. This
> > option builds upon previous commits to show the column number of the
> > first match on a non-context line.
>
> Imperative mood (and dropping unnecessary "builds upon previous"):
>
>     Teach 'git-grep(1)' a new option '--column-number' which shows the
>     column number of the first match on a non-context line.

Thanks. I am not used to writing in this mood, but have amended my
patches locally to conform to your proposed layout and have reworded
each to be in the imperative mood.

> > For example:
> >
> >   $ ./git-grep -n --column-number foo | head -n3
> >   .clang-format:51:14:# myFunction(foo, bar, baz);
> >   .clang-format:64:7:# int foo();
> >   .clang-format:75:8:# void foo()
> >
> > Now that configuration variables such as grep.columnNumber and
> > color.grep.columnNumber have a visible effect, we document them in this
> > patch as well.
>
> As mentioned in my review of patch 2, document the configuration
> variables in the patch which introduces them.

Thanks again, I have moved this introduction to the relevant patch.

> > While we're at it, change color.grep.linenumber to color.grep.lineNumber
> > to match the casing of nearby variables.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> > @@ -99,6 +99,28 @@ do
> > +       test_expect_success "grep -w $L" '
> > +               ...
> > +       '
> > +
> > +       test_expect_success "grep -w $L" '
> > +               ...
> > +       '
> > +
> >         test_expect_success "grep -w $L" '
>
> I realize that several existing tests in this script are already
> guilty of this sin, but please give each new test a distinct title
> reflective of what it is actually testing in order to make it easier
> to correlate failed test output with the actual test code.

:-). I have changed this locally to indicate which is which in the hopes
that it will provide more clarity should these tests fail at any point.


Thanks,
Taylor
