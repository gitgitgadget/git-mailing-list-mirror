From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 15:58:43 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801041555220.2649@xanadu.home>
References: <20080104185926.GA11912@redhat.com>
 <alpine.LFD.1.00.0801041437190.2649@xanadu.home> <477E9536.6050401@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtdH-000218-Oe
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbYADU6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbYADU6o
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:58:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14437 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYADU6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:58:44 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JU500DOA0XVPTA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 Jan 2008 15:58:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <477E9536.6050401@redhat.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69605>

On Fri, 4 Jan 2008, Michael Stefaniuc wrote:

> Nicolas Pitre wrote:
> > On Fri, 4 Jan 2008, Michael Stefaniuc wrote:
> > 
> >> With "too many unreachable loose objects" git gc --auto will always
> >> trigger. This clutters the output of git am and thus git rebase.
> >>
> >> The work flow of the Wine project doesn't include git merge. git rebase
> >> is therefor used to track the origin. This will produce soon too many
> >> loose objects for git gc --auto's taste. Pruning the repository would
> >> "fix" it. But we tell Wine developers new to git to NOT prune as long as
> >> they aren't confident enough with git; just as a safety net in case they
> >> have thrown away month of work.
> > 
> > The safety is the reflog.  What it refers to doesn't get pruned.
> Then git gc --auto should just prune too and not spam, right?

Pruning might be dangerous if some other operation is happening 
concurrently, which is why it is not done by default.

> But the reflog is only there for branches that still exist; the rest is
> gone. A git stash clear will also remove the reflog for the stash.

But the reflog for HEAD remains nevertheless, and it contains everything 
that happened to be the current branch.

> Regardless of the safety of git prune i don't see a reason why git gc
> --auto needs to be called for every patch in a git-am run and not once
> at the end.

Indeed.


Nicolas
