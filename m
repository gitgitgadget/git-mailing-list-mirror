From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Initializing svn repo from git
Date: Sat, 24 Mar 2007 15:35:17 -0700
Message-ID: <20070324223517.GA26593@muzzle>
References: <6efbd9b70703161440h762bd340x787f3258bc8dfcdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Riddoch <riddochc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 23:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVEpX-00016Y-Oy
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 23:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbXCXWfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 18:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXCXWfV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 18:35:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44369 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932873AbXCXWfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 18:35:19 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id ACA6A2DC01A;
	Sat, 24 Mar 2007 15:35:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Mar 2007 15:35:17 -0700
Content-Disposition: inline
In-Reply-To: <6efbd9b70703161440h762bd340x787f3258bc8dfcdc@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43021>

Chris Riddoch <riddochc@gmail.com> wrote:
> Hi, folks.  This is probably targeted at Eric Wong, but any assistance

In that case, feel free to Cc: me so I see it sooner :)

> is welcome.  I asked on #git, and decideded that a larger audience
> might be interested in this question, and whatever its answer turns
> out to be.
> 
> I've been working on a project, and tracking its history in git.  Due
> to lack of windows support, and windows-only developers joining my
> project, my higher-ups decided that we needed to use SVN.  I expect
> I'll probably use git-svn, myself, but I'm faced with a task:
> 
> I need to use the contents of my git repository, which is *very*
> linear with only one branch, to fill in some history for a new, empty
> svn repository.
> 
> My current steps, which isn't complete (identifiers cleaned out to
> protect... well, me.)
> 
> $ git svn init  svn://server/project project
> $ cd project
> project$ git svn fetch
> Fetching git-svn
> r0 = df2d1a798e85c75b9abbfd22fe06ff651a8fa9dd

With completely linear history, you can probably use grafts and add
df2d1a798e85c75b9abbfd22fe06ff651a8fa9dd as a parent of your original,
initial commit.   Afterwards, running dcommit should just work.  (I've
never tried this, though).

> project$ git pull /git/project
> warning: no common commits
> remote: Generating pack...
> remote: Done counting 850 objects.
> remote: Deltifying 850 objects.
> ...
> 
> project$ git log
> commit <sha>
> Merge: <sha>... <sha>...
> Author: Chris Riddoch
> Date: Fri Mar 16 15:13:58 2007 -0600
> 
>    Merge /git/project/
> 
> commit <sha>
> Author: (no author) <(no author)@641bd306-a92b-0410-b27c-7dcbb122c54d>
> Date:   Wed Mar 14 20:41:10 2007 +0000
> 
>    git-svn-id: svn://server/project@0 641bd306-a92b-0410-b27c-7dcbb122c54d
> 
> commit <sha>
> Author: Chris Riddoch
> Date:   Tue Mar 13 13:54:21 2007 -0600
> 
>    Most recent commit
> 
> <skipping a bunch>
> 
> commit <sha>
> Author: Chris Riddoch
> Date:   Thu Feb 1 10:55:42 2007 -0700
> 
>    Initial commit of project
> 
> 
> 
> Um... now what?  Can someone walk me through this?

That will probably force you to discard your git-only history
in SVN or have you duplicate history, neither is what you want.
If it's not too late; I recommend you start over with the
above instructions.

-- 
Eric Wong
