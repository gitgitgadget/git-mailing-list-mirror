From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 17:55:05 -0500
Message-ID: <20070205225505.GA9222@spearce.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org> <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com> <20070205194508.GD8409@spearce.org> <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 23:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HECjz-0004X0-5Y
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 23:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbXBEWzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 17:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbXBEWzL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 17:55:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40910 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005AbXBEWzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 17:55:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HECji-00010f-1t; Mon, 05 Feb 2007 17:54:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B48D620FBAE; Mon,  5 Feb 2007 17:55:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38797>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >I use it daily.  Mainly `git log origin/master@{1}..origin/master`
> >to see what has come in from Junio since my last fetch.  The @{n}
> >syntax has (for me) been one of its best features.  (Thanks Junio!)
> 
> It looks and smells like a useful feature. I just haven't found
> any use for it yet. Besides all the good, it's another part of a repo
> needing maintenance (constantly growing thing, like /var/log).

`git gc` is your friend.  It automatically trims the reflogs, keeping
only the last 90 days worth of entries.  You can tune this with the
`gc.reflogexpire` configuration parameter.  Seeing as how `git gc`
also invokes `git repack -a -d`, `git pack-refs --prune`, etc.,
one would have to wonder why use anything else.

So its not a constantly growing thing; you can at least bound it
by time.
 
> >If the reflog code did fail to record something, and you needed it,
> >and you hadn't git-prune'd yet, git-fsck would list the dangling
> >commit.  And a copy-n-paste session with `git-log -p D --not --all`
> >in another xterm would help you navigate what the dangling commits
> >were.
> 
> Yes, of course. I somehow missed it. Shows how often one does
> git-fsck in cygwin, doesn't it?

:-)

Actually I have need for git-fsck too often on Cygwin; one of
my coworkers looses objects all of the time in his repository.
I think his harddrive is failed.  The zlib CRC checking we put into
pack-objects saved his bacon when it failed to repack his repository
with corrupt objects.

-- 
Shawn.
