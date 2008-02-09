From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "git clone" for git:// protocol
Date: Sat, 9 Feb 2008 18:05:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091805190.11591@racer.site>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site> <alpine.LNX.1.00.0802091205530.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 19:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNu5p-0006JX-2i
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYBISFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 13:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYBISFv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 13:05:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:35460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752106AbYBISFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 13:05:50 -0500
Received: (qmail invoked by alias); 09 Feb 2008 18:05:48 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 09 Feb 2008 19:05:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192SVkLi7Z2CTQ2DfXlupvysIqmHOBnOs+oL5iPWA
	zgQ477J0TcdEtR
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802091205530.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73252>

Hi,

On Sat, 9 Feb 2008, Daniel Barkalow wrote:

> On Sat, 9 Feb 2008, Johannes Schindelin wrote:
> 
> > In the commit "Reduce the number of connects when fetching", we 
> > checked the return value of git_connect() to see if the connection was 
> > successful.
> > 
> > However, for the git:// protocol, there is no need to have another 
> > process, so the return value is NULL.
> > 
> > The thing is: git_connect() does not return at all if it fails, so we 
> > need not check the return value of git_connect().
> 
> Huh. Sure enough. Actually, there's a similar problem in transport.c, 
> where it assumes that the return value of git_connect is non-zero, which 
> makes it not reuse the connection (not that you can really tell). It might 
> be good to roll in a fix for that. Or maybe git_connect should return a 
> pointer to a static struct child_process if it doesn't need a subprocess, 
> just to distinguish "we're doing it ourselves" from "it's not being done"? 

Yeah, I like that.  Will do that tomorrow.

Ciao,
Dscho
