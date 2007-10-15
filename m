From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 20:27:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710152026260.25221@racer.site>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> 
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> 
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> 
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> 
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
  <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
  <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Eli Zaretskii <eliz@gnu.org>,
	ae@op5.se, tsuna@lrde.epita.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 22:25:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVbu-0004AC-2t
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759668AbXJOT1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759533AbXJOT1r
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 15:27:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:38087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759200AbXJOT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 15:27:45 -0400
Received: (qmail invoked by alias); 15 Oct 2007 19:27:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 15 Oct 2007 21:27:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T1iZQGthTQrRBAj4kmxBc3dYNfCy+bXq8SAciwP
	OA8XFxBxpYHoPV
X-X-Sender: gene099@racer.site
In-Reply-To: <4713BA89.633B86F2@dessent.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61031>

Hi,

On Mon, 15 Oct 2007, Brian Dessent wrote:

> Johannes Schindelin wrote:
> 
> > My bigger concerns are the performance and stability.  For example, I 
> > had a very annoying problem on one of the machines I am testing 
> > msysGit on. The problem was _only_ fixable by deactivating component 
> > of Logitech's WebCam driver!  Now, if a user-installable 3rd party 
> > program can make my regular git crash, I am scared what more it can 
> > do.
> 
> That is because the MSYS runtime is based on an old version of Cygwin, 
> and it uses the same dirty tricks to emulate fork.  These tricks rely on 
> having a repeatably consistent memory layout for a process each time it 
> is started, and when third party tools add hooks that affect the load 
> order or otherwise screw with the layout, the fork emulation fails. This 
> is also why it is sometimes necessary to assign unique base addresses to 
> all libraries (rebaseall) in order to get fork emulation working again.

Ah, thanks for the explanation!  (I knew that this thread still had 
something useful in it ;-)

> So yes, it is unfortunate that some system tools can drastically affect 
> the ability of Cygwin and MSYS to function, but it's what we live with 
> to have fork/exec emulation.  I see that there is work afoot to abstract 
> process creation so that hopefully this won't be as much a concern in 
> the near future.

We never had the problem in git itself, since we never used fork() on 
Windows.  The problem lies in our usage of bash and perl.

Bash we can fix in the long run (this goes under the keyword 
"builtinification" on the git list), but I do not see our reliance on Perl 
going away, not for git {send-email,cvsimport,cvsexportcommit,svn}.  
These are not too common operations, so common users will be able to do 
without them.

However, if you rely on the CVS/SVN connectors, or send-email, and in any 
case in the short run, you better run Git on Windows only when that funny 
Logitech driver is disabled ;-)

Ciao,
Dscho
