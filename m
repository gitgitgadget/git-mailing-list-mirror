Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3586E1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdJXTqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:46:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750908AbdJXTqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:46:36 -0400
Received: (qmail 29946 invoked by uid 109); 24 Oct 2017 19:46:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 19:46:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14940 invoked by uid 111); 24 Oct 2017 19:46:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 15:46:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 12:46:34 -0700
Date:   Tue, 24 Oct 2017 12:46:34 -0700
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
Message-ID: <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 12:19:26PM -0400, Eric Sunshine wrote:

> On Tue, Oct 24, 2017 at 11:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> > @@ -34,6 +34,86 @@ test_update_rejected () {
> > +# Test adding and deleting D/F-conflicting references in a single
> > +# transaction.
> > +df_test() {
> > +       local prefix="$1"
> > +       shift
> > +       local pack=:
> 
> Isn't "local" a Bash-ism we want to keep out of the test scripts?

Yeah. It's supported by dash and many other shells, but we do try to
avoid it[1]. I think in this case we could just drop it (but keep
setting the "local foo" ones to empty with "foo=".

-Peff

[1] There's some more discussion in the thread at:

  https://public-inbox.org/git/20160601163747.GA10721@sigill.intra.peff.net/
