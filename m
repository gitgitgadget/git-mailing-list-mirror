From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 16:02:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703271547040.6485@iabervon.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271338210.6485@iabervon.org> <4609643C.9050803@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHrw-0002Oj-T1
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXC0UCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 16:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbXC0UCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 16:02:09 -0400
Received: from iabervon.org ([66.92.72.58]:1044 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964934AbXC0UCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 16:02:08 -0400
Received: (qmail 3621 invoked by uid 1000); 27 Mar 2007 16:02:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2007 16:02:07 -0400
In-Reply-To: <4609643C.9050803@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43303>

On Tue, 27 Mar 2007, Steven Grimm wrote:

> The obvious use case for "I want the superproject and just one submodule" is
> when the superproject has build tools, header files, or other pieces of data
> that are shared by some/all of the submodules. Maybe not the case in BSD per
> se, but having a top-level file full of settings, paths to tools, etc. that
> gets included by the individual Makefiles in subdirectories isn't all that
> uncommon in complex multi-part projects.

This is actually the case I'm personally interested in. But in that case, 
you want to reverse the superproject/subproject organization, because that 
way each project part can use the desired version of the common stuff, and 
people can modify the common stuff without then testing the whole 
universe.

I.e., at some point, you'll want to change the behavior of the build 
system in such a way that all of the per-part configuration information 
sets needs to be updated to work with it. If the build system is in the 
superproject, you need to do everything at once. If the build system is in 
a subsubproject, you can make the change without affecting anything, and, 
as subprojects pull the build system change, they update the subsubproject 
entry and the configuration files as a single subproject commit. For 
sanity, you want to reach the point where all of the projects are using 
the same subsubproject version, but that doesn't have to happen overnight, 
and you don't have a single commit which touches every subproject.

	-Daniel
*This .sig left intentionally blank*
