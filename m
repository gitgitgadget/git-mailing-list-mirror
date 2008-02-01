From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: simple cvs-like git wrapper
Date: Fri, 1 Feb 2008 13:25:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802011318590.7372@racer.site>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus> <1201871157.D6625E4@ea26.dngr.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Ed S. Peschko" <esp5@pge.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Kate Rhodes <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 14:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKvuO-0003pQ-HV
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 14:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359AbYBANZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 08:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757019AbYBANZm
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 08:25:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:60755 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756217AbYBANZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 08:25:40 -0500
Received: (qmail invoked by alias); 01 Feb 2008 13:25:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 01 Feb 2008 14:25:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IXlJfWXXIpsp2bjM3ylACjlZP5wOVNEr4L8KIJG
	ja0dQhMCspMpdZ
X-X-Sender: gene099@racer.site
In-Reply-To: <1201871157.D6625E4@ea26.dngr.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72173>

Hi,

On Fri, 1 Feb 2008, Kate Rhodes wrote:

> I'm leaning towards agreement with Shawn that you're a little confused 
> as to how syncing works or you're not adequately expressing what you're 
> really hoping for and why git isn't doing it and we're misunderstanding 
> you.

Well, the thing is: git (plumbing) does not really care about syncing and 
how that works.  The core of git is "just" a very clever object database, 
geared towards revision control.

So in theory, Ed could just go and write a porcelain for git, which does 
_exactly_ what he wants, yet would be mostly interoperable with other git 
porcelains.

I imagine that the "cvsish update" would boil down to fetching upstream, 
updating the index with what the user has in the working directory 
(something like "git add -u"), then write out a tree from that, and call 
merge-recursive on that tree and the upstream's current tree.  Force fast 
forward master, but keep the index, keeping the error output of 
merge-recursive.  Done.

However, you need to understand the internals of git enough to do that.  
Especially the conflict management, and its relation with the index.

And I cannot see how that understanding would not lead to abandoning that 
work-flow as suboptimal.  But hey, that's just my private opinion.

Ciao,
Dscho
