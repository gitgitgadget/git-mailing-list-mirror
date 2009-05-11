From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn : some feedback and wonder...
Date: Mon, 11 May 2009 18:45:03 +0200
Message-ID: <4A08560F.8030800@drmicha.warpmail.net>
References: <1de9d39c0905110852v65b07bebl47cc9a58046c5288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 18:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3YdB-0005S6-J4
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 18:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbZEKQpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZEKQpN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 12:45:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44661 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752525AbZEKQpM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 12:45:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C9615342614;
	Mon, 11 May 2009 12:45:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 11 May 2009 12:45:11 -0400
X-Sasl-enc: gOIlZp2zhzAwu+TJislr6ASuCcdUTyykUgukEZA50FlI 1242060311
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3E7AD2E62F;
	Mon, 11 May 2009 12:45:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1de9d39c0905110852v65b07bebl47cc9a58046c5288@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118810>

jean-luc malet venit, vidit, dixit 11.05.2009 17:52:
> hi
> I'm just toying with git svn....
> so I have an svn repository and I do a git svn clone -s
> http://path.to/my/repository
> here all is fine it checkout my trunk into master branch
> 
> 1) when I do a git branch -a, it show 2 branches : master and trunk,
> shouldn't it be master and svn/trunk?

No. Not unless you said --prefix=svn during clone.

> 2) when I create a branch using git svn branch it create an empty
> directory and not as expected a branch from the current revision of
> trunk

I get a branch as you expect. Can you repeat the commands which
generated an unexpected result for you?

> 3) the branch appears in git branch -a without a remote
> information.... not easy to track

See 1)

> 4) you can't do git branch --track newbranch (where new branch is the
> svn branch), since the branch name isn't prefixed by svn/ you can't
> reuse the same name

You certainly can create a local branch with the same name. I just did.
I always do. If b is that name, say

git branch --track b remotes/b

unless you have used --prefix, of course.

> 5) why having called dcommit instead of push? it would have been more
> understable (more coherent) git svn push would have pushed current
> branch on corresponding svn branch and git svn push somebranch would
> have do a git svn branch followed by the commits...

The latter would be inconsistent with git push as well.

Dcommit may be for historical reasons, but keep in mind that dcommit is
not simply pushing. It involves rebasing and a whole git-svn-git
roundtrip. It really is "do the commits" on the svn side.

> 6) why having called rebase instead of pull? git svn pull would have
> fetched svn/trackedbranch and merged into current branch, git svn pull
> somebranch would have merged into current branch the svn/somebranch
> (without traking info)

Because pull does not rebase by default, it uses merge!

Let me just add that with some more git experience, which includes
reading man pages and trying things out, there certainly will be more
insight into the why's and why not's of git-svn ;)

Cheers,
Michael
