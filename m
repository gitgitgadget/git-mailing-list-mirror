From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Thu, 12 Apr 2012 17:05:42 -0400
Message-ID: <20120412210542.GD21018@sigill.intra.peff.net>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com>
 <20120412055216.GC27369@sigill.intra.peff.net>
 <4F8737C8.1020501@web.de>
 <4F873CD0.4050204@xiplink.com>
 <4F873E2C.6080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRDD-0007Pl-0p
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762795Ab2DLVFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:05:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60371
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab2DLVFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:05:44 -0400
Received: (qmail 31174 invoked by uid 107); 12 Apr 2012 21:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 17:05:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 17:05:42 -0400
Content-Disposition: inline
In-Reply-To: <4F873E2C.6080808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195371>

On Thu, Apr 12, 2012 at 10:42:20PM +0200, Jens Lehmann wrote:

> Am 12.04.2012 22:36, schrieb Marc Branchaud:
> > I assumed it was an optimization of some sort -- that since tags are normally
> > only fetched when they're part of a requested branch's history (right?),
> > there was no point in doing submodule recursion on the fetched tags since
> > those tagged tree-ishes had already been submodule-recursed.
> 
> If that is the case the patch I just sent is pointless, but adding a comment
> there explaining that would be a good thing ;-)

That is often the case, but not always (I might explicitly fetch a tag,
or have refs/tags/ in my refspec). So I think you want to handle both to
cover all cases. I haven't looked at the submodule recursion code, but I
would hope that it would eliminate duplicates (so if I get a branch and
a tag that is on the branch, we would look at the commit in question
only once).

-Peff
