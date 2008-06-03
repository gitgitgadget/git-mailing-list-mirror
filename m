From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase --interactive: Compute upstream SHA1 before
 switching branches
Date: Tue, 3 Jun 2008 14:55:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806031454350.13507@racer.site.net>
References: <4843FD44.90905@viscovery.net> <alpine.DEB.1.00.0806021628260.13507@racer.site.net> <7vbq2j5k0u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 15:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3X15-0007JW-UA
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778AbYFCN4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757720AbYFCN43
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:56:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:46677 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757671AbYFCN42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:56:28 -0400
Received: (qmail invoked by alias); 03 Jun 2008 13:56:27 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp038) with SMTP; 03 Jun 2008 15:56:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VkUN6Jg/VAYybEUUs1KgZao/mt/5cB7j994SzCj
	dJgItk8mPwayJt
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vbq2j5k0u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83660>

Hi,

On Mon, 2 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> BTW, methinks, this checkout is unnecessary, since before the rebase 
> >> begins, there is a 'git checkout $ONTO', and the branch switching is 
> >> certainly not needed to compute the todo list...
> >
> > It is needed to determine which branch to update after finish.
> 
> I'll apply Hannes's patch for now as I do not want to leave an obvious fix
> out of -rc1.
> 
> I think Hannes is referring to the same issue as the one dealt with with
> 0cb0664 (rebase [--onto O] A B: omit needless checkout, 2008-03-15) for
> the non-interactive codepath.
> 
> You certainly "need to determine which branch to update after finish", 
> and you do need to remember what branch you were on (if you were not 
> called with the <branch> parameter), or what branch were given from the 
> command line (if you got one as <branch> parameter) in order to do so, 
> but the way to remember these values does not have to involve an extra 
> checkout.
> 
> By doing an extra checkout of "the original HEAD", before switching to a 
> detached HEAD state at the $ONTO commit to "clean the slate" to apply 
> the sequence on top, more work tree entries will be smudged, forcinging 
> more recompilations than necessary if the tracked contents are "source" 
> files.

Right.  I failed to follow the given hint to the other commit, but it 
makes perfect sense now.

Thanks,
Dscho
