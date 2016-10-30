Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE77D20193
	for <e@80x24.org>; Sun, 30 Oct 2016 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbcJ3MyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 08:54:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:36172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbcJ3MyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 08:54:05 -0400
Received: (qmail 2698 invoked by uid 109); 30 Oct 2016 12:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 12:54:04 +0000
Received: (qmail 10125 invoked by uid 111); 30 Oct 2016 12:54:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 08:54:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Oct 2016 08:54:02 -0400
Date:   Sun, 30 Oct 2016 08:54:02 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Pelly <aaron@pelly.co>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161030125402.y2swumdomymigjxi@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
 <xmqqwpgt2ng2.fsf@gitster.mtv.corp.google.com>
 <cc23eece-d693-9e40-78fe-3bafe6bcad3a@pelly.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc23eece-d693-9e40-78fe-3bafe6bcad3a@pelly.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 10:32:07PM +1300, Aaron Pelly wrote:

> On 28/10/16 15:54, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> >> However, as I said elsewhere, I'm not convinced this feature is all that
> >> helpful for in-repository .gitignore files, and I think it does
> >> introduce compatibility complications. People with older git will not
> >> respect your .gitignore.d files. Whereas $GIT_DIR/info is purely a local
> >> matter.
> > 
> > As I do not see the point of making in-tree .gitignore to a forest
> > of .gitignore.d/ at all, compatibility complications is not worth
> > even thinking about, I would have to say.
> 
> Well; that saves some work. :)
> 
> I do not suggesting making this mandatory. I think it adds value and it
> is a common and understood mechanism. But, if it is abhorrent, consider:
> 
> There is precedent for including files in git-config. This could be
> extended to ignore files. The code is not similar, but the concept is. I
> could live with it.

Yes, but note that we don't have in-tree config files, either (to large
degree because of the security implications).

Perhaps Junio can clarify himself, but I took his statement to mean only
that in-tree .gitignore.d is not worth worrying about, but that
$GIT_DIR/info/exclude.d or similar would be OK (but perhaps I
interpreted that way because that's my own position :) ).

> Or how about a new githook that can intelligently create or return the
> details? This would be my least favourite option unless it was
> configured in an obvious place.

That seems more complicated than is really merited, and probably doesn't
perform great either (it's an extra forked process for almost every git
operation). And obviously would not work for an in-tree solution anyway,
as we do not want to run arbitrary code.

-Peff
