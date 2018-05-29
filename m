Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961DC1F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967296AbeE2Vcr (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:32:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967149AbeE2Vcr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:32:47 -0400
Received: (qmail 3973 invoked by uid 109); 29 May 2018 21:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:32:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31186 invoked by uid 111); 29 May 2018 21:32:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:32:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:32:45 -0400
Date:   Tue, 29 May 2018 17:32:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not
 just the first
Message-ID: <20180529213244.GD7964@sigill.intra.peff.net>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
 <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 06:25:18PM +0900, Junio C Hamano wrote:

> Martin Ågren <martin.agren@gmail.com> writes:
> 
> > diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
> > index 0c6f48f302..31b0702e6c 100755
> > --- a/t/t1011-read-tree-sparse-checkout.sh
> > +++ b/t/t1011-read-tree-sparse-checkout.sh
> > @@ -243,9 +243,9 @@ test_expect_success 'print errors when failed to update worktree' '
> >  	test_must_fail git checkout top 2>actual &&
> >  	cat >expected <<\EOF &&
> >  error: The following untracked working tree files would be overwritten by checkout:
> > -	sub/added
> > -	sub/addedtoo
> > -Please move or remove them before you switch branches.
> > +error: 	sub/added
> > +error: 	sub/addedtoo
> > +error: Please move or remove them before you switch branches.
> >  Aborting
> >  EOF
> 
> This shows the typical effect of this series, which (I subjectively
> think) gives us a more pleasant end-user experience.

Heh, that is one of the cases that I found most ugly when I looked into
this earlier (and in particular, because I think it makes cut-and-paste
a little harder).

More discussion in:

  https://public-inbox.org/git/20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net/

and down-thread.

-Peff
