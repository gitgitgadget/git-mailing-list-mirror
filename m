From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 00:12:11 -0500
Message-ID: <20061223051210.GA29814@segfault.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:12:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzBB-0002zd-Ny
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWLWFMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWLWFMO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:12:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1067 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbWLWFMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:12:12 -0500
Received: (qmail 1159 invoked by uid 1000); 23 Dec 2006 00:12:11 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35265>

On Thu, Dec 21, 2006 at 03:01:21PM -0800, Junio C Hamano wrote:

> > $ git checkout -b local_next origin/next
> 
> "git checkout -b next origin/next" should work just fine, I
> think.
> 
> There was a talk about allowing "checkout -b <new> <track>" to
> add branch.<new>.merge and branch.<new>.remote if <track> can be
> proven to corresond uniquely to one remote and one branch from
> that remote; I think that would match the expectation most of
> the time but that "most" would not be 100% nor even 80%, so I
> think that should be an optional feature.  In any case, there
> was a talk but there is no code yet.

BTW, is there some explanation why branch.*.merge specifies a _remote_
head? The following would make much more sense to me:

[branch "master"]
remote = origin
merge = refs/remotes/origin/master

Because I don't _care_ that the other guy calls it refs/heads/master. I
care that I'm pulling from refs/remotes/origin/master on my end (and
however I get stuff into that branch is defined by the remote).

It also means that even without a remote, the merge option makes sense
(e.g., if I do repeated merges from one local branch to another). And it
means that it's _always_ correct for "checkout -b <new> <track>" to set
branch.<new>.merge to <track>, without having to worry about finding an
appropriate remote.

-Peff
