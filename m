From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn feature request: exclude certain subpaths on clone
Date: Fri, 5 Dec 2008 16:13:04 -0800
Message-ID: <20081206001304.GA31770@yp-box.dyndns.org>
References: <bbbeeccd0812040843p3e5547c4tac88b0d01562a37f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wade Berrier <wberrier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8koa-00065K-7a
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 01:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbYLFANJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbYLFANI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 19:13:08 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59204 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbYLFANH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 19:13:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6FBC72DC01A;
	Sat,  6 Dec 2008 00:13:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bbbeeccd0812040843p3e5547c4tac88b0d01562a37f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102424>

Wade Berrier <wberrier@gmail.com> wrote:
> Hi,
> 
> Consider the following example layout:
> 
> trunk/src
> trunk/big_fat_binary_blobs
> trunk/doc
> 
> I think it would be really nice to be able to tell git-svn to ignore
> 'big_fat_binary_blobs' while keeping 'src' and 'doc'.
> 
> I know someone is thinking, "Why did you check in
> 'big_fat_binary_blobs' in the first place?"  In this case, the
> repository is out of my control.  For the svn users, it's not that big
> of a deal since they only get one HEAD version of the binary_blobs.
> But when trying to clone with git-svn, I repeatedly get out of memory
> and packing errors (every 1000 commits) when packing several revisions
> of these binary_blobs.  (Now, that may be a bug in of itself... which
> can reproduced by creating an svn repo with several revisions of
> KNOPPIX at the same path, followed by a git svn clone )
> 
> Anyway, I still think it may be useful to be able to ignore certain
> paths on a clone.  In thinking about the implementation details, I
> figure probably the best approach would be to manually purge the
> unwanted path after it has been fetched, but before it is committed.
> That way, if a commit contains changes in paths that are both wanted
> and unwanted, the commit could be 'pruned'.
> 
> I've looked at the git-svn script a little, but wanted to solicit
> feedback and ideas before continuing further.

Maybe... What about git-filter-branch?

I realize that doing it at the git-svn level can save bandwidth; but it
might not be possible with the way SVN deltas work...

I'll try to get around to splitting git-svn.perl out to separate source
files this weekend so it's easier to navigate.

-- 
Eric Wong
