From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Sat, 3 Sep 2011 08:49:47 +0000
Message-ID: <20110903084947.GA16711@dcvr.yhbt.net>
References: <20110902140702.066a4668@robyn.woti.com>
 <4E612319.7030006@vilain.net>
 <20110902144922.383ed0f1@robyn.woti.com>
 <4E6127F5.5070009@vilain.net>
 <20110902154206.331b80e9@robyn.woti.com>
 <4E614AE7.7090706@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Jacobs <bjacobs@woti.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Sep 03 10:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzlvG-0008EY-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 10:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1ICItt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 04:49:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52799 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab1ICIts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 04:49:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07ABE1F84D;
	Sat,  3 Sep 2011 08:49:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4E614AE7.7090706@vilain.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180647>

Sam Vilain <sam@vilain.net> wrote:
> On 9/2/11 12:42 PM, Bryan Jacobs wrote:
> >On Fri, 02 Sep 2011 12:01:09 -0700
> >Sam Vilain<sam@vilain.net>  wrote:
> >
> >>That's one way to do it; in fact, if the trees match you don't need
> >>to do anything complicated like cherry-pick.
> >>
> >>ie, say you're committing
> >>
> >>     r1---A---B---C---D
> >>
> >>and it blows up at
> >>
> >>     r1--r2--r3--C---D
> >>
> >>So long as the tree from the fetched r3 == the tree from B, then you
> >>can just go ahead and write out new commits for C and D without doing
> >>any merging (ie cherry-pick or rebase).  You could also put merge
> >>commits back the way they were, too.
> >When you say "write out new commits" you mean create a commit object
> >with the same contents, but a different parent? Does git-svn do this
> >somewhere already?
> 
> I guess it doesn't, but if it did it would certainly make this
> easier.  I'm not sure why it would need to modify the WC at all.
> Eric, is this just historical or is there a better reason for that?

dcommit needs to continually rebase because it's possible somebody else
may make a commit to the SVN repo while a git-svn user is dcommiting
and cause a conflict the user would need to resolve in the working tree.

At least I think that was the reason...  There is also the "commit-diff"
command in git-svn.  It was the precursor to dcommit which requires no
changes to the working tree.

-- 
Eric Wong
