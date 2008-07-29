From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 00:38:39 -0400
Message-ID: <20080729043839.GC26997@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 06:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNgzt-0004VY-LC
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 06:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYG2Eil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYG2Eil
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 00:38:41 -0400
Received: from peff.net ([208.65.91.99]:4533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYG2Eik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 00:38:40 -0400
Received: (qmail 5682 invoked by uid 111); 29 Jul 2008 04:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 00:38:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 00:38:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90562>

On Tue, Jul 29, 2008 at 01:27:44AM +0200, Johannes Schindelin wrote:

> > So the logical sequence was:
> > 
> >   git checkout production
> >   git merge -s theirs master
> 
> To me, this suggests that they were too married to 'production' being the 
> "dominant" branch.

Perhaps. But I see this as an operation on the production branch: "pull
in master's changes, forgetting ours". In your workflow (git checkout
master && git merge -s ours production && git push origin
master:production) we perform an operation on master, which doesn't seem
as intuitive to me.

Not to mention that we might not _control_ master. What about (and I
think Sverre mentioned something like this previously):

 I forked the kernel and made some changes. Some of my changes got
 applied upstream. The others are now obsolete. Now I want to bring
 myself in sync with Linus, but I want to keep my history (either
 because the history is interesting to me, or because others are basing
 their work on it).

Then your workflow, while still possible within the local repository,
means you are munging the "linus" branch, which seems wrong. That branch
is probably even just a tracking branch, which you would not want to
build on, anyway.

-Peff
