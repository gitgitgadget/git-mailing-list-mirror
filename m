From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 16:00:00 -0500
Message-ID: <20120222210000.GE6781@sigill.intra.peff.net>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
 <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
 <7vlinuaaab.fsf@alter.siamese.dyndns.org>
 <87hayivcmm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 22 22:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0JIJ-0005f4-Db
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 22:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab2BVVAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 16:00:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47377
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2BVVAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 16:00:02 -0500
Received: (qmail 31864 invoked by uid 107); 22 Feb 2012 21:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 16:00:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 16:00:00 -0500
Content-Disposition: inline
In-Reply-To: <87hayivcmm.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191289>

On Wed, Feb 22, 2012 at 09:25:53PM +0100, Thomas Rast wrote:

> > Thanks for diagnosing this, but I wonder if it even needs --pretty=oneline
> > to begin with, except for debugging purposes.
> >
> > Do we ever use the subject string read from the rev-list output in any
> > way?
> >
> > In other words, I am wondering if the right patch to minimally fix the
> > issue starting from older releases is something along this line instead:
> 
> Not sure.  The only use I could think of would be to google for the
> subjects, in the hope of finding some repository that has the commit you
> are looking for.  Other than that...

Or because the bundle creator (which may even be you on a different day)
did not correctly guess at the negative refs when specifying a cutoff.
Assuming you no longer have access to the original repo (not
unreasonable, since you are using a bundle), the messages could help you
understand where the error occurred.

Of course, once you figure out "aha! I expected the bundle to include
foo, but it is actually a cutoff point. I should have said XYZ^ as the
cutoff", I'm not sure what you do then. It's not like there is an easy
way to salvage the data that is in the bundle.

So I think it is a debugging aid, but one that ultimately doesn't help
you that much.

-Peff
