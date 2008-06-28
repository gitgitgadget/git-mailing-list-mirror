From: Theodore Tso <tytso@mit.edu>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 21:23:06 -0400
Message-ID: <20080628012305.GC15463@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 03:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCPAi-0004wE-R8
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 03:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYF1BXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 21:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbYF1BXJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 21:23:09 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:37887 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753820AbYF1BXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 21:23:08 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KCP9e-000277-OS; Fri, 27 Jun 2008 21:23:06 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KCP9e-0004Cx-9m; Fri, 27 Jun 2008 21:23:06 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86688>

On Fri, Jun 27, 2008 at 08:51:41PM -0000, David Jeske wrote:
> -- Jakub Narebski wrote:
> > git rebase --interactive?
> > Any patch management interface (StGIT, Guilt)?
> 
> Yes, as I said, that set of operations can be performed with git today.
> 
> What git can't do, is let me "supercede" the old DAG-subset, so
> people I shared them with can get my new changes without hurting
> their world. Currently git seems to rely on the idea that "if you
> accept changes into your tree that will be later rebased, it's up to
> you to figure it out". I don't see why that is the case

Because it's fundamentally hard and fraught with danger --- especially
since with git-rebase --interactive you actually can *edit* an
intervening patch, so commits that are based off of a rebased branch
have absolutely no guarantee of correctly applying against the rebased
branch.

If they do apply cleanly, you can use git rebase --onto, but the
possibility of merge conflicts are endless.

The general workflow here is that you simply don't share your git
state until it's been refactored and you're positive that it you've
gotten it right.  Or if you do share, it you do so in a branch where
you tell people --- don't base work off of this!  (i.e., a "pu" branch
like git has.)

As I said earlier, premature sharing is highly over-rated.  And having
people develop against an unstable branch is just extra work for them
anyway.  So commit frequently, and if you want to backup your local
hard drive, push regularly to your own private git repository located
off-machine.  Just don't ask people base any branches off your private
branch until you're ready to publish it in a form after which you
don't do rebase operations.  This works quite well for many projects
and many developers.

						- Ted
