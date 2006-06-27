From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 10:31:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271016450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com> 
 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44A06A8D.7080202@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 10:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv8zI-0002X7-5O
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWF0Ib5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWF0Ib4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:31:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:11202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751205AbWF0Ib4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 04:31:56 -0400
Received: (qmail invoked by alias); 27 Jun 2006 08:31:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 Jun 2006 10:31:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44A06A8D.7080202@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22712>

Hi,

I just cloned your repo, and as far as I can tell, the latest commit is on 
June 23rd. So your numbers should be the same as mine. But not all are.

On Tue, 27 Jun 2006, Martin Langhoff (CatalystIT) wrote:

> Ok, I cooked the numbers up a bit, it was 60 total, with 10 merged upstream.
> Here's what I have today:
> 
>   $ git-cherry svnhead..master | grep -c '+'
>   52

Here, it is 51!

The problem I see: from the 53 non-merges in nzvleportfolio (who makes up 
your branch names anyway?), there are two already in upstream: e3f56c and 
7e448c5c. So it really should be 51.

>   $ git-rev-list svnhead..master  | wc -l
>   61

Same on my repo.

>   $ ~/local/git/git-format-patch.sh  -o .patchesold svnhead master
>   ...
>   $ ls .patchesold | wc -l
>   52

I guess this propagates from git-cherry. (Did not test here, since I do 
not have an old git-format-patch.sh handy, and am too lazy to get the last 
version from my git repo.)

>   $ ~/local/git/git format-patch  -o .patchesnewall svnhead..master
>   ...
>   $ ls .patchesnewall/ | wc -l
>   53

Same on my repo. Correct, since
"git rev-list --parents svnhead..master | grep -c \ .*\ "
yields 8, which is exactly 61 - 53.

>   $ ~/local/git/git format-patch --ignore-if-in-upstream -o .patchesnewignore
> svnhead..master
>   ...
>   $ ls .patchesnewignore | wc -l
>   52

Again, I get 51.

I do not know what is happening, but it could be that there was a bug 
fixed lately. I run a slightly modified version of 'next', updated about 
15 minutes ago.

But anyway, looking at your numbers I take it that the new format-patch 
with --ignore-if-in-upstream has the same output as the old format-patch, 
right?

Ciao,
Dscho
