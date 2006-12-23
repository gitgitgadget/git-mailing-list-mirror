From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Fri, 22 Dec 2006 21:56:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612222141470.20138@iabervon.org>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
 <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org>
 <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org>
 <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org>
 <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx> <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net>
 <87d56cirs8.wl%cworth@cworth.org> <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 03:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxx3w-0006z3-Fg
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 03:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWLWC4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWLWC4Z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 21:56:25 -0500
Received: from iabervon.org ([66.92.72.58]:4241 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbWLWC4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 21:56:24 -0500
Received: (qmail 29382 invoked by uid 1000); 22 Dec 2006 21:56:23 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Dec 2006 21:56:23 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35254>

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> Sure, what you want is "git add --no-add newfile", and I can
> understand that mode of operation if you are always going to
> commit with "git commit -a".  Maybe we can have a config
> variable that makes "commit -a" and "add --no-add" the default
> for these two commands, and we do not have to change anything
> else.

I think there's value to a command to add an empty space with a given name 
to the staging area. If you commit without -a, I don't see any reason to 
think that you couldn't want the sequence "add-empty-space <new-file>", 
"modify <old-file>", "update-index <old-file>", "commit", "update-index 
<new-file>", "commit". It can be useful to make sure the file isn't going 
to be forgotten, but also not get it into the next commit.

> One minor detail I wonder about is what mode bits would you give
> to that placeholder entry.

I looked into this at one point. It should probably use 000000 for the 
mode, because it shouldn't read the working directory at all (you might 
actually want to add the space before creating a file at all, for 
instance, and then make a symlink when you provide anything, surprising 
any reasonable guess at a mode). Also, this is going to show up in the 
diff listing, and all-zero SHA1 with a mode is used there for "read the 
working directory".

	-Daniel
*This .sig left intentionally blank*
