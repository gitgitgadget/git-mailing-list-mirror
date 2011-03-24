From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Thu, 24 Mar 2011 13:45:56 -0400
Message-ID: <20110324174556.GA30661@sigill.intra.peff.net>
References: <20110323181756.GA17415@sigill.intra.peff.net>
 <20110323181915.GC17533@sigill.intra.peff.net>
 <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
 <20110324145047.GB16484@sigill.intra.peff.net>
 <7v39mca7hl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2obq-0006wg-O5
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab1CXRqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:46:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37275
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1CXRqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:46:01 -0400
Received: (qmail 4077 invoked by uid 107); 24 Mar 2011 17:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Mar 2011 13:46:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2011 13:45:56 -0400
Content-Disposition: inline
In-Reply-To: <7v39mca7hl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169929>

On Thu, Mar 24, 2011 at 08:00:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 23, 2011 at 02:25:02PM -0700, Junio C Hamano wrote:
> >
> > We could also turn it on for "git log" in that case, though it is only
> > useful if the first commit happens to be the one that is slow.
> >
> > I should also turn it on for "git diff". I'll prepare a cleaner series
> > with that in it, too.
> 
> Sounds good, thanks.

Here it is:

  [1/4]: pager: save the original stderr when redirecting to pager
  [2/4]: progress: use pager's original_stderr if available
  [3/4]: show: turn on rename detection progress reporting
  [4/4]: diff: turn on rename detection progress reporting

> > What about the degrade-cc-to-c warnings? Are you working on another
> > revision, or should I re-roll your changes on top of my series, handling
> > the "one-warning-per-commit" behavior I suggested when stdout and stderr
> > are combined?
> 
> Also sounds good, thanks.  No, I am spending far more time on ushering
> stalled topics than looking at my weatherbaloons and no time left for the
> latter.

I thought this would be simple on top of 1/4 above, but it's not. In
some cases we want to insert the warning before the diff output, and in
some cases we want to know afterwards what happened. Which means we
probably need to carry a new "show the warning" flag in diffopt and
respect it in the rename, but also fill out the needed_rename_limit.

-Peff
