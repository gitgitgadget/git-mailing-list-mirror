From: Jeff King <peff@peff.net>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 15:08:56 -0400
Message-ID: <20090422190856.GB13424@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <vpqws9cd06b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhrc-0000qa-Rx
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbZDVTJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbZDVTJB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:09:01 -0400
Received: from peff.net ([208.65.91.99]:52903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756951AbZDVTJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:09:00 -0400
Received: (qmail 17327 invoked by uid 107); 22 Apr 2009 19:09:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 15:09:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 15:08:56 -0400
Content-Disposition: inline
In-Reply-To: <vpqws9cd06b.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117231>

On Wed, Apr 22, 2009 at 08:15:56PM +0200, Matthieu Moy wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Why so?  Having fewer packs is always a good thing.  Having only one 
> > pack is of course the optimal situation. 
> 
> Good and optimal wrt Git, but not wrt an incremental backup system for
> example. I have a "git gc" running daily in a cron job in each of my
> repositories, but to be nice with my sysadmin, I don't want to rewrite
> tens of megabytes of data each night just because I commited a 2 lines
> patch somewhere.

You can mark your "big" pack with a .keep, then do your nightly gc as
usual. You'll have a smaller pack being rewritten each night. When it
gets big enough, drop the .keep, gc, and then .keep the new pack.

Yes, it's a bit more work for you, but having "git gc" optimize by
default for git's performance seems to be the only sensible course.
Your idea of what is "big enough" above is somewhat outside the realm of
git, so you have to pay the price to specify it by tweaking the
keep-files.

-Peff
