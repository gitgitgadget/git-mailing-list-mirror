Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2AFC207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 04:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbcI0EyC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 00:54:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbcI0EyB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 00:54:01 -0400
Received: (qmail 14801 invoked by uid 109); 27 Sep 2016 04:54:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 04:54:01 +0000
Received: (qmail 11533 invoked by uid 111); 27 Sep 2016 04:54:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 00:54:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 00:53:58 -0400
Date:   Tue, 27 Sep 2016 00:53:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] tree-walk: be more specific about corrupt tree errors
Message-ID: <20160927045358.wledqitv4qaqmacl@sigill.intra.peff.net>
References: <1474935093-26757-1-git-send-email-dturner@twosigma.com>
 <xmqqtwd2ng8k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwd2ng8k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 09:01:15PM -0700, Junio C Hamano wrote:

> >  5 files changed, 21 insertions(+), 7 deletions(-)
> >  create mode 100644 t/t1007/.gitattributes
> >  create mode 100644 t/t1007/tree-with-empty-filename
> >  create mode 100644 t/t1007/tree-with-malformed-mode
> 
> I hate to report this, but this alone, or together with 2/2, when
> merged to 'pu', I cannot get them to pass the tests in my automated
> integration tests, even though they seem to pass when the problematic
> tests are run manually.  I do not see offhand anything suspicious
> (like something that may be racy) in these two patches but I haven't
> figured out where it goes wrong.
> 
> If somebody manages to find breakages in today's 'pu', please (1) do
> not be too alarmed, and (2) help figure out where things are broken.

I think the problem is just that they refer to t/t1450 (and t1007) from
the trash directory as "../t1450". That breaks when the test is run with
"--root" (and I imagine that like me, you have --root as part of your
automated tests but do not bother with it when doing a one-off run).

-Peff
