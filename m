From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] git gui and =?iso-8859-1?Q?my_?=
	=?iso-8859-1?Q?=F6?=
Date: Tue, 24 Apr 2007 02:16:52 -0400
Message-ID: <20070424061652.GP17480@spearce.org>
References: <20070423113225.GA5427@lala> <20070424053935.GO17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgEL1-00062v-HV
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 08:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXDXGQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 02:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161652AbXDXGQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 02:16:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59766 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXDXGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 02:16:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgEKO-0005Zv-NC; Tue, 24 Apr 2007 02:16:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 510A420FBAE; Tue, 24 Apr 2007 02:16:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070424053935.GO17480@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45416>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> > 	commit-tree failed:
> > 	Warning: commit message does not conform to UTF-8.

This was starting to bug me, so I went off and found it.  OK, well
the encoding error anyway.  git-gui incorrectly claimed commit-tree
failed when it didn't.  But besides the point, this is the bad line:

>    1294     fconfigure $msg_wt -encoding $enc -translation binary

I have had trouble in the past with trying to use that magic
-encoding flag on fconfigure to get Tcl's file channels to perform
encoding work for me.  Seems it doesn't work right or something...
so other parts of git-gui (e.g. the filename handling parts)
perform the convertfrom/convertto logic on their own... but the
commit message handling parts didn't.

They do now (git gui 0.6.5-11-gf20db5f).

Can you please test my current master branch and see if that fixes
things for you?  repo.or.cz, git-gui.git...

If it does, I'm probably going to tag that as 0.6.6 and let Junio
cut 1.5.2 with that release.

-- 
Shawn.
