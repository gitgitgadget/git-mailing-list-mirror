From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Clean master, version tags
Date: Sun, 18 May 2008 22:31:35 -0400
Message-ID: <20080519023135.GW29038@spearce.org>
References: <8345bd80805181921l36451957s2063395c65a42aea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Mon May 19 04:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxvAr-0008HT-WE
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 04:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbYESCbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 22:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbYESCbk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 22:31:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57610 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbYESCbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 22:31:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jxv9p-0001li-Bx; Sun, 18 May 2008 22:31:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E389A20FBAE; Sun, 18 May 2008 22:31:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8345bd80805181921l36451957s2063395c65a42aea@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82405>

Marcus <prima@wordit.com> wrote:
> I created a lot of test files in the master, branch before Iearning
> how to use branches. How do I safely remove all entries in master. The
> branch should can be completely cleaned and leave no traces, so we
> have a fresh start.

A couple of ways.

You can checkout the branch, then forcibly reset both the branch
and your working directory to some other revision, like say
origin's master.  Note this will overwrite any modified but not
committed files!

  git checkout master
  git reset --hard origin/master

or delete the branch and recreate it:

  git branch -D master
  git branch --track master origin/master

or just delete the branch and don't even have a master:

  git branch -D master

 
> 2) Is there a tutorial on how to tag versions and use the version name
> as reference?

Read git-tag's manpage.  Creating a tag is as easy as:

  git tag -a tagname

then you can later go back to that version with:

  git checkout tagname

if you have that version checked out you can find out what the
tag name was:

  git describe

you can also export that version as a tarball, even if you don't
have it checked out:

  git archive --format=tar tagname | gzip >tagname.tar.gz

Does that help any?  Tag names are treated almost like any other
revision identifier (commit SHA-1, branch name, etc.) in git.

-- 
Shawn.
