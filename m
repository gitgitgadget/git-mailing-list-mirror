From: Jeff King <peff@peff.net>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 2 Oct 2007 23:23:31 -0400
Message-ID: <20071003032331.GA11638@coredump.intra.peff.net>
References: <47029414.3080100@gmail.com> <7vbqbhl44h.fsf@gitster.siamese.dyndns.org> <470309D5.702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 05:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icupp-0005Ig-Qm
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 05:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbXJCDXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 23:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXJCDXe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 23:23:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4423 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbXJCDXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 23:23:33 -0400
Received: (qmail 11188 invoked by uid 111); 3 Oct 2007 03:23:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 23:23:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 23:23:31 -0400
Content-Disposition: inline
In-Reply-To: <470309D5.702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59774>

On Tue, Oct 02, 2007 at 10:17:41PM -0500, Dan Zwell wrote:

> e88ee2915493213ea0d0be64c542c090fefd4b33 is first bad commit
> commit e88ee2915493213ea0d0be64c542c090fefd4b33
> Author: Martin Waitz <tali@admingilde.org>
> Date:   Tue Oct 10 21:16:25 2006 +0200
>
>     paginate git-diff by default

The only thing this patch does is run the pager, so presumably git-diff
_is_ generating output, but calling the pager is broken for some reason.
What is the value of $GIT_PAGER and $PAGER on the broken and working
machines? Can you confirm that the pager works on both machines?

> I discovered this problem on my 64 bit machine, but the problem does not 
> occur on my 32 bit machine. That is not the only difference between the two 
> computers, but it seems the most obvious culprit. The 64 bit machine may 
> have different libraries than the other, as they are running different 
> distros.

I couldn't reproduce on my 32-bit or 64-bit machine (the former running
Debian unstable, the latter Debian stable). But given the patch you
bisected to, I think it is more likely that your pager is broken on the
64-bit machine.

-Peff
