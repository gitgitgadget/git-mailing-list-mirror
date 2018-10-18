Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63E41F453
	for <e@80x24.org>; Thu, 18 Oct 2018 14:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJRWU4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 18:20:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38511 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeJRWU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 18:20:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id 204-v6so18834929qkd.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 07:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX2Mm5oGANtu4za9gx+sZs+3rr1onLH8Xz8wZXDqZAc=;
        b=iu4BpAly1wmgBGiFfwxkCahDtqf6QEEjOCylSGu9B2Nuf/qpNTzuf2MjU7k50v9C1m
         g71KPmUlpdT8ehpEGb4Ui0ewZzccOchfHdR/JiO6KTk4a6R144ZvNR7SKu1gZ0K5Ho3i
         eBei2GBPaSHaFdRDhx78UFozZoAkVA+MH9z3a4lYp5bTXDV3YiZQloj4DykR/QlOgw75
         mcRDLSfbgnVAbwMZjGYSzcPtx1JbOwreMZYj5IHwwljdo/IdA2NBmZ+hhCHR6qmhb0/8
         XBZWbjPjeN3TbdIuHNoUiIdJ98ZaNsyZwjTeT1yxVn7fDi8B0z8qijAWSYAZRXNf6rbs
         i+ag==
X-Gm-Message-State: ABuFfogzd1KM/RcyWAWCQEdSJvXVrtxOCukVMebVI63u1uBxpBwhxpQc
        iEzacUokxVamq9CBmOZX/sQx0zRLdMUaoPYcyJH3zx4W
X-Google-Smtp-Source: ACcGV61Vp3YgMATcAogxfvMVfE/wf2rZIYgwh8FAIBfxsgLscN04Yje2zHRCTjCZ7oo+UGSV+TqAlq5g10ECQ4uca+E=
X-Received: by 2002:a37:ef08:: with SMTP id j8-v6mr29834040qkk.26.1539872381945;
 Thu, 18 Oct 2018 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com> <20181012133321.20580-1-daniels@umanovskis.se>
 <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com>
 <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com> <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810171211440.4546@tvgsbejvaqbjf.bet> <20181017103902.GA12137@flurp.local>
 <nycvar.QRO.7.76.6.1810181146250.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810181146250.4546@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Oct 2018 10:19:30 -0400
Message-ID: <CAPig+cRbH0xQDg-acGnHs5cAQKueaAfPFF+AXUF2Gq75KqNupg@mail.gmail.com>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 5:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 17 Oct 2018, Eric Sunshine wrote:
> > On Wed, Oct 17, 2018 at 6:18 AM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > My suspicion: it is essentially the `(exit 117)` that adds about 100ms to
> > > every of those 67 test cases.
> >
> > The subshell chain-linter adds a 'sed' and 'grep' invocation to each test which doesn't help. (v1 of the subshell chain-linter only added a 'sed', but that changed with v2.)
> > You could disable the subshell chain-linter like this if you want test the (exit 117) goop in isolation:
>
> You're right! This is actually responsible for about five of those seven
> seconds. The subshell still hurts a little, as it means that every single
> of the almost 20,000 test cases we have gets slowed down by ~0.03s, which
> amounts to almost 10 minutes.
>
> This is "only" for the Windows phase of our Continuous Testing, of course.
> Yet I think we can do better than this.
>
> How difficult/involved, do you think, would it be to add a t/helper/
> command for chain linting?

Probably more effort than it's worth, and it would only save one
process invocation.

Since the  subshell portion of the chain-linting is done by pure
textual inspection, an alternative I had considered was to just
perform it as a preprocess over the entire test suite, much like the
other t/Makefile "test-lint" targets. In other words, the entire test
suite might be tested in one go with something like this:

    sed -f chainlint.sed t*.sh | grep -q '?![A-Z][A-Z]*?!' &&
        echo "BROKEN &&-chain"

That won't work today since chainlint.sed isn't written to understand
everything which we might see outside of a test_expect_*, but doing it
that way is within the realm of possibility. There were two reasons
why I didn't pursue that approach.

First, although I was expecting Windows folks to complain (or at least
speak up) about the extra 'sed' and 'grep', nobody did, so my
impression was that those two extra commands were likely lost in the
noise of the rest of the boilerplate commands invoked by
test_expect_success(), test_run_(), test_eval_(), etc., and by
whatever expensive commands are invoked by each test itself. Second,
the top-level &&-chain "(exit 117)" linting kicks in even when you run
a single test script manually, say after editing a test, which is
exactly when you want to discover that you botched a &&-chain, so it
seemed a good idea for the subshell &&-chain linter to follow suit.
The t/Makefile "test-lint" targets, on the other hand, don't kick in
when running test scripts in isolation.

However, a pragmatic way to gain back those 10 minutes might be simply
to disable the chain-linter for continuous integration testing on
Windows, but leave it enabled on other platforms. This way, we'd still
catch broken &&-chains, with the exception of tests which are specific
to Windows, of which I think there are very few.
