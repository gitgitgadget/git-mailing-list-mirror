From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:40:01 -0400
Message-ID: <20060920214001.GD24415@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920212101.GA24415@spearce.org> <Pine.LNX.4.63.0609202325510.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:40:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9nf-0002EX-VM
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWITVkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWITVkH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:40:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44247 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932148AbWITVkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:40:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ9nO-0007IF-J2; Wed, 20 Sep 2006 17:39:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B7B2C20E48E; Wed, 20 Sep 2006 17:40:01 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609202325510.19042@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27412>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 20 Sep 2006, Shawn Pearce wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Another, even more serious problems with rebasing: You can introduce a bug 
> > > by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
> > > but the sum of your patches, and the patches you are rebasing on, is 
> > > buggy. And there is _no_ way to bisect this, since the "good" version can 
> > > be gone for good.
> > 
> > True, however one would hope that you tested the commit before you
> > rebased it and found it to working.  And bisect should point at the
> > new version of that commit as the break.  And then you can debug
> > it there.
> 
> You misunderstood me. You can _introduce_ a bug by rebasing. _After_ 
> testing that everything is fine. You can even test the rebased branch and 
> miss the bug, since your original tests were more thorough.

Why were your original tests more thorough and your rebased testing
was less so?  Hmm?  Perhaps the test suite needs to be extended as
part of the rebased commit(s).

Of course a rebase-introduced bug could also be in the test suite,
such that you miss the true bug.  I've had bugs in the test suite
mask real bug, but never a bug both in the feature and in the test
due to a rebase or mad merge.  I guess I've just been lucky there.


When rebasing and even when doing a non-fast forward merge one
needs to keep in mind that your code is being edited on your behalf.
Not much different then if you open it in your favorite editor and
whack away at a keyboard for a while.  Sure these auto-edits work
most of the time, on their own and without user intervention, but
every once in while things get messed up.  Heck, I've seen editors
mess up source files such that they won't compile anymore.

So moral of the story is you probably should be testing even after
rebasing or cherry picking, and the testing shouldn't be any less
extensive than before you did the rebase/cherry-pick.  Which is one
reason why automated test suites can be useful, despite the risks
they also bring...

-- 
Shawn.
