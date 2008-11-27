From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn clone behaves non-deterministic
Date: Thu, 27 Nov 2008 10:55:12 +0100
Message-ID: <492E6E80.7010209@drmicha.warpmail.net>
References: <20081127075351.GA12716@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 10:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5dc0-0001dJ-1G
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbYK0JzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbYK0JzS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:55:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43186 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbYK0JzR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2008 04:55:17 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4323D188133;
	Thu, 27 Nov 2008 04:55:15 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 27 Nov 2008 04:55:15 -0500
X-Sasl-enc: +V+9wQHxp9YhHI9rbMTJtPSmLmY7WfS0lmUpW57p4xjx 1227779714
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9154817A9D;
	Thu, 27 Nov 2008 04:55:14 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <20081127075351.GA12716@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101806>

Josef Wolf venit, vidit, dixit 27.11.2008 08:53:
> Hello,
> 
> I am new to git and decided to get my feet wet by first cloning and
> playing with my existing svn repositories.  Thus, I've done this:
> 
>  cd /my/test/repos
>  for i in repo1 repo2 repo3; do
>    repos=https://my.repos.server/repos/$i/trunk
>    svn co        $repos svn/$i
>    git-svn clone $repos git/$i
>  done
> 
>  for i in `cd svn; echo *`; do diff --exclude /.svn -Nruw */$i; done
> 
> With this, I see that four of the repositories are cloned as expected,
> but the fifth has only the .git directory in it.  It appears that
> the clone command stopped cloning at r2008, while the repository is
> currently at r3761.  So almost the half of the history was not
> cloned at all.  I've investigated the offending revision and the
> revisions around it, but I can't see anything special about them.
> The effect is perfectly reproducible and it stops always on the very
> same revision.  I get no error message at all.  I've attached the
> last lines of the clone operation at the end of this mail.

First of all: What does git --version say? Is it self-compiled git or
git as it comes with U 8.10?

Then: I assume the above is not quite what you did, otherwise I would be
surprised you see a 4th and 5th clone...

Your repo is probably one giant svn repo. In any case, the fact that the
repo is at $rev does not imply that the last commit on trunk is at $rev.
 What is the last commit on trunk?

Other than that: There are so many sins you can commit (!) in an svn
repo that it it is hard to tell which one threw git-svn off. Can you
share the repo?

> Then I go to another machine and enter exactly the same commands as
> above.  Both machines are fresh ubuntu-8.10 default installs.
> 
> To my surprise, on this other machine the clone operation seems to
> have worked for all the repositories.  But the diff command shows
> me that arbitrary files are missing in _all_ of the repositories.

I don't think computers behave deterministically, at least not according
to my experience. After all they rely on quantum mechanics, and who has
ever understood the measurement process, the collapsing of the wave
function?

OK: Whenever I got 2 different results after doing the same twice I
found that indeed some hidden/forgotten variable was not the same... Any
chance you find one?

Michael
