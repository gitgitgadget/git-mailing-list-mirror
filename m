From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: help with git usage
Date: Tue, 29 Apr 2008 14:07:14 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804291354070.19665@iabervon.org>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Quinlan <danq@brtt.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:08:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JquFL-0002yK-Hv
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbYD2SHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYD2SHR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:07:17 -0400
Received: from iabervon.org ([66.92.72.58]:47502 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbYD2SHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:07:16 -0400
Received: (qmail 7087 invoked by uid 1000); 29 Apr 2008 18:07:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2008 18:07:14 -0000
In-Reply-To: <200804291738.m3THc2hC030601@rs40.luxsci.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80714>

On Tue, 29 Apr 2008, Daniel Quinlan wrote:

> I've been trying to use git for awhile now, (and I've read a lot of
> documentation, though maybe my
> comprehension has not been high enough) but there are several operations which
> I
> can't figure out:
> 
> 1) After cloning a repository from work at home, making some changes and
> committing them,
> I use "git push" to push them back to the work repository.  The changes seem
> to make it to the
> work repository (I see the commit message in git log), but I can't figure out
> how to get the
> changes into the working set at work.  (evidently not merge, checkout or reset
> -- seems like it
> should be merge, but)

You shouldn't push to a non-bare repository. You should, instead, set up a 
bare repository for publishing your changes, and have all of the 
repositories you work in be clones of that. The issue is that git doesn't 
expect something outside of the repository to change the current branch 
(much like CVS doesn't expect something else to update CVS/Entries in your 
working directory). Another alternative is, from home, to do:

$ git push origin refs/heads/*:refs/remotes/home/*

Then, at work, you can do:

$ git merge home/master

> 2) I can't figure out how to get back the latest (or any other) version of a
> file I've modified (or deleted)
> in the working set.  (Well, I suppose I could checkout the whole tree
> somewhere else and copy the
> relevant file, but I'm hoping there's something simpler).

$ git checkout HEAD -- <filename>

(And you can use any commit instead of HEAD to get other versions)

> 3) Similarly, I can't use the little context diffs I can see in git-gui  -- I
> need to see side by side comparisons;
> I've become accustomed to tkdiff.  It seems like git mergetool knows how to do
> that in some restricted
> circumstances, but I want to do it outside the context of a merge.

This I don't know, but you can get particular files from particular 
commits output with "git show <commit>:<path>", and you can likely wire 
something up.

	-Daniel
*This .sig left intentionally blank*
