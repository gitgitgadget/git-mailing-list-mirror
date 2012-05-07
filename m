From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] correct git-status Porcelain Format documentation
Date: Mon, 7 May 2012 14:13:48 -0400
Message-ID: <20120507181348.GA26977@sigill.intra.peff.net>
References: <20120506132959.GA28214@sigill.intra.peff.net>
 <20120506135141.GA17176@sigill.intra.peff.net>
 <7vobpz6ewg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSRa-0007Om-GT
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082Ab2EGSNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:13:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33087
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756982Ab2EGSNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:13:50 -0400
Received: (qmail 25064 invoked by uid 107); 7 May 2012 18:14:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 14:14:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 14:13:48 -0400
Content-Disposition: inline
In-Reply-To: <7vobpz6ewg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197291>

On Mon, May 07, 2012 at 11:10:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What should "git status --porcelain -z -b" look like? With my patch, it
> > prints the branch-line with only a newline, not respecting the NUL
> > termination. Which sounds like a bug, except that's what happens _now_
> > with "git status --short -z -b".  Which seems like a bug to me, but
> > maybe somebody is relying on that. It seems kind of broken to me.
> 
> It is broken; and it is not a problem if somebody relied on a broken
> output without giving --porcelain in a script and such a script needs to
> be updated.  If we are updating the code to give "## <branch>" in the
> output under the "--porcelain", let's do that right from the beginning.

OK, that matches my feelings.

> > Should this be simplified to just "this implies porcelain"?
> >
> > That would technically break somebody who wanted their
> > status.relativePaths config option respected. But it kind of seems crazy
> > to me.
> 
> I do not think it is worth changing it.  It is not too much touble to
> spell "status --porcelain -z <whatever else>" in a Porcelain script only
> once and forget about it.

OK. I think it makes it conceptually simpler, but of the problems I
listed, that is the least bug-like.

I'll prepare a series to fix "-b -z" and "-b --porcelain".

-Peff
