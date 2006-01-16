From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 15:20:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601161414080.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> 
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> 
 <43C537C9.4090206@hogyros.de>  <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
  <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
  <43C951B6.5030607@gmail.com>  <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
  <43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
 <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
 <Pine.LNX.4.64.0601152248030.25300@iabervon.org> <43CBEF47.7050607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:19:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyaoV-0006GE-DK
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 21:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWAPUSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAPUSs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 15:18:48 -0500
Received: from iabervon.org ([66.92.72.58]:59915 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751175AbWAPUSs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 15:18:48 -0500
Received: (qmail 13063 invoked by uid 1000); 16 Jan 2006 15:20:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2006 15:20:39 -0500
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <43CBEF47.7050607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14758>

On Mon, 16 Jan 2006, A Large Angry SCM wrote:

> Daniel Barkalow wrote:
> [...]
> > 
> > So the problem with handling subprojects with the build system is that it is
> > too tempting to use the revision control system directly on the subproject,
> > at which point the thing you're developing and testing isn't at all what
> > other people will get if they check out your commit. You want "git status"
> > to report it as an uncommitted change if you have a different revision of
> > the subproject than your previous commit had, and it can't tell if this
> > information is buried in the build system.
> 
> Using "git-status" is the wrong tool to use there. What you should be using is
> "make project_status". Claiming "that it is too tempting to use the revision
> control system on the subproject" is wrong; you should use the SCM (of the
> subproject) to manage the subproject. You use the build system to manage the
> _entire_ project.

I'm talking about using "git status" on the main project, in case you're 
misunderstanding me. If you can manage the entire project with the build 
system, then you don't need git or any version control at all, aside from 
your build system. But you'd also lose the ability to use webgit, bisect, 
gitk, git log, and so forth on the project as a whole.

> > The tricky question is whether we should permit the "subproject" objects to
> > specify a revision that isn't a hash, for use in identifying revisions of
> > subprojects in other systems.
> 
> Why would you want to limit how required versions of subprojects are
> specified? Your project policies and procedures may require that subprojects
> be specified by a subproject SCM specific immutable revision but the policies
> and procedures of other projects may not be so restrictive and could accept a
> tag identifying the latest "stable" (or something) revision.

If you accept a tag identifying the latest stable revision, then you might 
as well not bother. The point of revision controlling a project is to be 
able to reconstruct previous states. If you allow any event, especially 
outside, unrelated, events to change the reconstructed state for a 
revision, then this is not the case. Your normal debugging situation will 
be "It's broken, and I didn't change anything." because someone somewhere 
else changed something, and you have no record of what last worked. And 
you can obviously forget any hope of "git bisect" working.

	-Daniel
*This .sig left intentionally blank*
