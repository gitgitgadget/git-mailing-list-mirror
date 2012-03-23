From: Jeff King <peff@peff.net>
Subject: Re: howto handle name clashes
Date: Fri, 23 Mar 2012 13:12:19 -0400
Message-ID: <20120323171219.GB12881@sigill.intra.peff.net>
References: <4F6C7539.3080607@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB82N-0008M4-W0
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759006Ab2CWRMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:12:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57565
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757105Ab2CWRMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:12:22 -0400
Received: (qmail 16299 invoked by uid 107); 23 Mar 2012 17:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 13:12:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 13:12:19 -0400
Content-Disposition: inline
In-Reply-To: <4F6C7539.3080607@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193772>

On Fri, Mar 23, 2012 at 02:06:01PM +0100, Sven Strickroth wrote:

> how to handle name clashes for branches and tags? Is there anything I
> can add to the refspec to make the name unique?

You can always use a more fully-qualified name to disambiguate (e.g.,
"tags/foo", or "refs/tags/foo").

> - for merging "git merge --no-ff refs/branches/test" works, but
> generates a not so nice default merge message. ("merged  commit
> refs/branches/test" instead of "merged branch test")

Did you mean "refs/heads/test"?

I would have thought we would full-qualify the refname first, and then
use that to determine the message. Doing a simple test, it looks like
"git merge foo" gets you "Merge branch 'foo'", but "git merge heads/foo"
will get you "Merge branch 'heads/foo'". We should be able to do better
in the latter case.

> - how to drop a remote tag/branch ("git push origin :test" does not work)

Does "git push origin :heads/foo" (or :tags/foo) not work?

-Peff
