From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 11:53:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
 <86d4xmxbjf.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:53:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM6x9-0007vQ-UG
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 20:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759947AbXHQSxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 14:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759892AbXHQSxm
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 14:53:42 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57777 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759650AbXHQSxl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 14:53:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HIrCRT030457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 17 Aug 2007 11:53:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HIr6IK024482;
	Fri, 17 Aug 2007 11:53:06 -0700
In-Reply-To: <86d4xmxbjf.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00,TW_SV
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56081>



On Fri, 17 Aug 2007, David Kastrup wrote:
> 
> But it isn't an independent git project: the superproject has its
> _own_ copy of dsp, with its _own_ specific commits and fixes that are
> not supposed to ever end up in the dsp "mothership". 

Sure. And that's different from any git "branch" exactly how?

So you'd have different branches in the superproject - the way you always 
have when you have two copies of a git project. And then you merge between 
the two at will.

> With Subversion, I can actually merge files in different projects of
> the repository even when they are in different directory levels.  Of
> course, since Subversion does not track any merge info, that is not an
> accomplishment.

Right. Git can do that too. It's called "patches".

> And that is the problem here: in this case it does not make sense to
> see it as a separate project, and in particular, it needs to be in
> synch with the tags/branches of the superproject, and particularly
> while I am using git-svn.

I do agree that the "git svn" interaction may end up making it unworkable, 
if only because git-svn simply doesn't know/understand about submodules. 
But the submodule *would* be well-specified by the tags and branches in 
the superproject, so that shouldn't be a problem in itself.

> > Another alternative is to do what git has long done with "gitk": you
> > can maintain a separate project and just merge it directly into
> > another git project, and it works fine that way, but it gets
> > impossible to merge back and forth between the two projects (you can
> > only merge one way: make all the major changes in the "dsp" project,
> > and then you can just merge it into the project that uses it (but if
> > you fix things in the bigger project, you can't merge the fixes
> > back, you'll have to export the fixes as patches and do them in the
> > "dsp" tree).
> 
> Well, that would be at least quite handy for propagating upstream dsp
> fixes into project/great.  How do I merge one project into a
> _subdirectory_ of another one?

There's a special "subtree" merge that does exactly that: it basically is 
the normal recursive merge, except it merges into a subtree. I think 
that's how Junio does the "git-gui" merges. Junio?

			Linus
