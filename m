From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Wed, 27 Aug 2008 08:29:54 -0400
Message-ID: <20080827122954.GA11986@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 14:31:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYKAy-0008JT-4J
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbYH0M35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 08:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbYH0M35
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:29:57 -0400
Received: from peff.net ([208.65.91.99]:3627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbYH0M35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 08:29:57 -0400
Received: (qmail 11947 invoked by uid 111); 27 Aug 2008 12:29:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 27 Aug 2008 08:29:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 08:29:54 -0400
Content-Disposition: inline
In-Reply-To: <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93889>

On Tue, Aug 26, 2008 at 11:13:13PM -0700, Junio C Hamano wrote:

> > It is not just you. I think this version of the patch is much improved,
> > but I am still against user.$key.*. At the very least, it needs its own
> > namespace.
> 
> It's not just that.  Having many of these in .git/config will slow down
> any unrelated thing that needs to read from config.

Sure, it can, but so can putting a lot of branch info in your config. My
thinking was that this covers the "I just want to put in a few entries
easily" use case. If somebody wants to do something _big_, then that is
time for the external format.

But then we have two formats which we must support forever, which is
maybe a bad thing.

> I am not married to the "reuse existing information" idea, but doing it
> the way this sample patch does at least makes only people who uses this
> feature to pay the price and only when they use it.

Actually, I like this quite a bit. Almost by definition, the information
is already here (and if it isn't, it is because it is the first time
this person is an author, so you would have to end up typing it once
_anyway_).

My only complaint is:

> +	strbuf_addf(&buf, "--author=%s", name);
> +	av[++ac] = "--all";
> +	av[++ac] = buf.buf;
> +	av[++ac] = NULL;

I am too lazy to hit "shift", so I would use "-i".

-Peff
