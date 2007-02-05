From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 14:45:08 -0500
Message-ID: <20070205194508.GD8409@spearce.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org> <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 20:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9mA-0005LQ-K6
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbXBETpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933420AbXBETpN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:45:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33536 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbXBETpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:45:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE9lu-0003dO-8A; Mon, 05 Feb 2007 14:45:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60B7720FBAE; Mon,  5 Feb 2007 14:45:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38773>

Alex Riesen <raa.lkml@gmail.com> wrote:
> I have reflog off by default (and never missed it yet), so leave it
> at least as option to git-fsck, please. Besides, how do you find
> lost objects which were not mentioned in any reflog? (because
> of a bug someone made in reflog code, for example)

Learn to love reflog.  :-)

I use it daily.  Mainly `git log origin/master@{1}..origin/master`
to see what has come in from Junio since my last fetch.  The @{n}
syntax has (for me) been one of its best features.  (Thanks Junio!)

Repeat after me:

  There aren't any bugs in the reflog code.
  They have not been any bugs in the reflog code.
  There will never be any bugs in the reflog code.

I don't think we've had a case where a commit wasn't recorded in
a reflog when it should have been.  Perhaps *very* early in reflog
development a couple of commands bypassed the reflog code, but that
has certainly since been fixed.  The last one was git-receive-pack,
which we finished in early December.

If the reflog code did fail to record something, and you needed it,
and you hadn't git-prune'd yet, git-fsck would list the dangling
commit.  And a copy-n-paste session with `git-log -p D --not --all`
in another xterm would help you navigate what the dangling commits
were.

-- 
Shawn.
