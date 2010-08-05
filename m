From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 15:27:23 -0400
Message-ID: <20100805192723.GA10435@sigill>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org>
 <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
 <20100805173635.GA15760@sigill>
 <7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
 <20100805190653.GA2942@sigill>
 <AANLkTimzn05tvwY=uG6VP6PXDHwA=wS9ECuK_9eWKtSx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Ted Ts'o <tytso@mit.edu>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh66G-0002VX-GP
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab0HET12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:27:28 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab0HET10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 15:27:26 -0400
Received: (qmail 30288 invoked by uid 111); 5 Aug 2010 19:27:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 05 Aug 2010 19:27:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Aug 2010 15:27:23 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimzn05tvwY=uG6VP6PXDHwA=wS9ECuK_9eWKtSx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152706>

On Thu, Aug 05, 2010 at 03:18:15PM -0400, Jay Soffian wrote:

> On Thu, Aug 5, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:
> > I agree it's a pretty generic name. I was trying to make this as generic
> > as possible, at least within the domain of commits, so it could be a
> > faster replacement for calls to is_descendant_of. Maybe commit_contains?
> 
> I'm going to side-track this slightly. I wonder why branch and tag
> have --contains, but it is not more generically available via
> rev-list?  I needed it the other day and spent 5 minutes looking at
> what it would take before I ended up just calling merge-base in a loop
> for the commits I wanted to check.

I'm not sure rev-list makes the most sense. We already have "show
commits in X, but not in Y". But I gather you wanted "from a list
(U,V,W,X), print each that contains Y". Which is not really a rev-list
function anymore, as it is not about listing revisions, but rather about
grepping a list you've given it.

Something like "git for-each-ref --contains" seems more sensible to me,
though it is not as generic as we could make it (I cannot use an
arbitrary list of commits to the "haystack", but only ones that have
refs pointing to them).

-Peff
