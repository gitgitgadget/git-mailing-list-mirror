Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B0F1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLA2f (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:28:35 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:35184 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLA2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:28:35 -0500
Received: by mail-il1-f174.google.com with SMTP id z12so13899043ilp.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2J2p39vYWIjK2PHPaVp/kAuU//ZgnpdqvGdxFfLRGuo=;
        b=ys4Y8gm++7DmxdwWXnCLkXYd5KIW1BcQ0j/2ksKlR2zPb9kfMHKPHlApI7oss79TrB
         gw+41Ek2hVA7F+/io+NgUz/l8oVV0bBXBbSY2OVceTcQzlafPjKi56Zpq/bOiaruqg91
         KXCvuK+6JuqIF6Z8xtZgEMVOHB4SOklRRnzgzsevN9DWxY4tBMg6RG8MYqN8hPsIg/BU
         eWnwst5WlsATJAbOvl+sb70wvf5QX5/tm5l2OmN4QWWYEU3DRsDvmQAiCq9VR66fqJTi
         IJ0ymwuzYQojwEqAEFB7fCGTEKMh24TUvWRkLeispZdnwJu8j4RRgPW2g2xjH0KTr9kB
         PqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2J2p39vYWIjK2PHPaVp/kAuU//ZgnpdqvGdxFfLRGuo=;
        b=C0H9uUBY5ZAfVdwbO5xv011E7WeLBScYsBLA0tXVDKRTkKCkiqcM9n715UA9z0ag4t
         PaXJsbdZIJGeL6lLNaAJPbyAne2I6yXzr9QNOujn1T7rWaFT1pK4iZONDNJf3Sq75n6G
         dZTAhb8Gm/KpB6VNzfe0kOn8DpyNa8YsoLexvFbcGZHXxh9liyhM9uEWj+K7TtWmqxdh
         S/0HWzHGS76Q7/m7agLUu3S70AIHMgPh9qYNFEz/090WmOONHq+xxiivaxct1NDuszmh
         jQPvYVA8TGRqTjFj+df/R6LoVsfSQQG+O87hGB8Yyov1p8vl/uyBoelvC4aEHQigE4v0
         +OrQ==
X-Gm-Message-State: APjAAAWS2FsjUnHX3T3ckyCxYjXHgC9he8H+ZLugxzi27azGKLt6823R
        Vub9P6SZLv8Ihj1L82VAafYT3Tp6kn0OPrqoSsEJ6g==
X-Google-Smtp-Source: APXvYqyKn8GnUo8H+BwykiwRsIgS60PP2QhBMHuxu7vPCrWDW2eAFSghqUuAVt3qyOR+YGMu0ypFGGA4Mqe+1SVEBG8=
X-Received: by 2002:a92:db03:: with SMTP id b3mr24286801iln.109.1573518514143;
 Mon, 11 Nov 2019 16:28:34 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
 <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
In-Reply-To: <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 11 Nov 2019 16:28:23 -0800
Message-ID: <CAGyf7-EqQdvg4fQcZJv6BpqZ9hPDx72KBiLp1Xe3Ur7NrSMBeA@mail.gmail.com>
Subject: Re: Split commit graphs and commit-graph read
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 5:19 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> > But git commit-graph read isn't:
> > .../objects$ git commit-graph read
> > fatal: Could not open commit-graph
> > '/path/to/repository/objects/info/commit-graph': No such file or
> > directory
> >
> > Running some tests with commands like git for-each-ref and git
> > rev-list shows that the "split" commit graph is being used (setting
> > core.commitGraph=false makes commands noticeably slower), so
> > functionally all seems well. But should git commit-graph read be
> > handling this better?
>
> Unfortunately, you're running into an issue because I designed the
> "read" subcommand poorly (and also forgot to update it for
> incremental commit-graph files). The biggest issue is that "read"
> is not really meant for end-users. It really should have been built
> as a test-tool. This point was corrected when I got around to writing
> the multi-pack-index since it uses "test-tool read-midx" instead of
> add.
>
> To fix this issue, I would probably go about it by removing the "read"
> subcommand and creating a "test-tool read-commit-graph" for the tests
> that need that output.
>
> If others on-list think that the better thing to do is to update the
> "read" subcommand to provide the same output, but iterate over each
> layer of an incremental commit-graph, then I can do that work instead.

I was only running "git commit-graph read" as another way of verifying
that everything looked good (to Git, that is). I'd already run "git
commit-graph verify" and just found the discrepancy in their behavior
surprising/interesting. For what it's worth, I personally don't see
anything amiss with removing the "read" subcommand if that's simpler
than updating it to handle incremental graphs. (Put differently, it's
not a command I'd ever have Bitbucket Server run, or that I'm likely
to try and run going forward. In this case I just completed some
commit graph-related changes to Bitbucket Server and was looking for
every possible avenue I could pursue to try and ensure what I did was
producing the "correct" output after my changes got deployed to our
internal dogfooding server.)

Thanks for taking the time to look into it and clarify the behavior! I
really appreciate it.

Best regards,
Bryan Turner

>
> Thanks,
> -Stolee
