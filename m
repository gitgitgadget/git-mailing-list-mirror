From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] work-trees are allowed inside a git-dir
Date: Sat, 28 Jul 2007 01:38:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280122160.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271957250.14781@racer.site> <7vejity3h8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaKY-0006H4-PM
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938070AbXG1Aii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937894AbXG1Aii
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:38:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:52444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762290AbXG1Aih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:38:37 -0400
Received: (qmail invoked by alias); 28 Jul 2007 00:38:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 28 Jul 2007 02:38:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DtE0gphPDtG+fqvIsJMzOVa7sdwn0Sv/WsaGQ9L
	3/cdcNNz9D8Tes
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejity3h8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53978>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is allowed to call
> >
> > 	$ git --git-dir=../ --work-tree=. bla
> >
> > when you really want to.  In this case, you are both in the git directory
> > and in the working tree.
> >
> > The earlier handling of this situation was seriously bogus.  For regular
> > working tree operations, it checked if inside git dir.  That makes no
> > sense, of course, since the check should be for a work tree, and nothing
> > else.
> >
> > Fix that.
> 
> I do not doubt this patch makes the above command line to work
> better, but I have to wonder how that layout is useful.  Care to
> give a use case or two in the commit log message?

In the commit log message?  Better somewhere else.  Only git developers 
read the commit message.

But yes, I can point to a use case.  AFAIR Martin Krafft brought up the 
issue to track different components of the home directory in different 
repositories.

I have a similar scenario here, which does not involve a home directory, 
but rather a directory where I should not put anything into (I could, but 
if the admin was anything akin to competent, I could not).

There are files in that directory (and all of its subdirectories) of a 
certain type, which are the only ones which are human generated, and 
therefore precious.  I like to add them, and inspect them, with

	git --git-dir=$HOME/x.git add

and

	git --git-dir=$HOME/x.git diff

Another similar scenario is a network drive on Losedows, where the locking 
always fails.  So I do not _want_ a repo there, even if I _could_.

Ciao,
Dscho
