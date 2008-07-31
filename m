From: Jeff King <peff@peff.net>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 15:02:09 -0400
Message-ID: <20080731190209.GA8372@sigill.intra.peff.net>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 21:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdQe-0004FB-NF
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbYGaTCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbYGaTCM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:02:12 -0400
Received: from peff.net ([208.65.91.99]:1566 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbYGaTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 15:02:11 -0400
Received: (qmail 28847 invoked by uid 111); 31 Jul 2008 19:02:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 15:02:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 15:02:09 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90965>

On Thu, Jul 31, 2008 at 08:13:59PM +0200, Sverre Rabbelier wrote:

> If I clone the git mirror of our monotone repository, I find a
> checkout size of 148 MB after git-repack--running git-gc also
> increased the size by 2 MB, but I'll stick with the initial checkout
> size for fairness. If I multiply this by my 11 checkouts, I will have
> 1628 MB. This is even more compelling for me, as I now save 728 MB of
> disk space with monotone."

Yikes. This is not even remotely a fair comparison to monotone, which is
keeping a central db.

> I'm in the process of cloning the repo myself, and will check if doing
> a more aggressive (high --window and --depth values) repack will get
> us below that 148, but I'm thinking it's just that big a repo. Anyway,

It's much better than that. I just cloned

  git://github.com/felipec/pidgin-clone.git

and the _whole thing_ is 148M, including the working tree. His object db
is only 88M. So he can do his 11 trees in 61 * 11 + 88 = 759M, saving
141M over monotone.

And I am repacking with insane depth and window right now to see if we
can get it smaller (though really, it is not that big a deal, since the
size is dominated by his 11 working trees).

-Peff
