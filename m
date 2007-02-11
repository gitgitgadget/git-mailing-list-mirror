From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 18:46:49 -0500
Message-ID: <20070211234649.GG31488@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702120041.27419.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOPL-0008JI-AU
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbXBKXqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbXBKXqz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:46:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53195 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbXBKXqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:46:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGOP3-0007Cv-8Y; Sun, 11 Feb 2007 18:46:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 758EE20FBAE; Sun, 11 Feb 2007 18:46:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702120041.27419.bruno@clisp.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39334>

Bruno Haible <bruno@clisp.org> wrote:
> Is there some other concept or command that git offers? I'm in the situation
> where I know that 'tr' in coreutils version 5.2.1 had a certain bug and
> version 6.4 does not have the bug, and I want to review all commits that
> are relevant to this. I know that the only changes in tr.c are relevant
> for this, and I'm interested in a display of the minimum amount of relevant
> commit messages. If "git log" is not the right command for this question,
> which command is it?

Two options come to mind:

  `git log v5.2.1..v6.4 -- tr.c`
  `git bisect`

The former has a few different flavors, e.g. you can run the
same arguments to `gitk` to view the changes in a graphical form.
The latter will help you do a binary search through the commits
which affected tr.c between the known good and known bad revisions,
allowing you to test the possible candidates for the defect.
 
> > > 2) Why so much system CPU time, but only on MacOS X?
> > 
> > Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?
> 
> No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
> this command:
>   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
>   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)

That's not so good... This is `git log -- tr.c >/dev/null` ?

-- 
Shawn.
