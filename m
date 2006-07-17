From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-repack not removing files from $GIT_DIR/objects/[00-ff]
Date: Sun, 16 Jul 2006 21:51:49 -0400
Message-ID: <20060717015149.GB27389@spearce.org>
References: <20060717012154.GA27389@spearce.org> <5A14AF34CFF8AD44A44891F7C9FF410507E43006@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 03:52:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2IHG-000307-5C
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 03:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWGQBvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 21:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWGQBvz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 21:51:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:25006 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751289AbWGQBvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 21:51:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G2IGq-0005iZ-LE; Sun, 16 Jul 2006 21:51:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 098FF20E462; Sun, 16 Jul 2006 21:51:49 -0400 (EDT)
To: "Post, Mark K" <mark.post@eds.com>
Content-Disposition: inline
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF410507E43006@usahm236.amer.corp.eds.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23961>

So try:

  GIT_DIR=/home/git/pub/scm/linux-2.6.git git-prune-packed

On a bare repository you should always set the GIT_DIR environment
variable to the directory of the repository before running the
command.

"Post, Mark K" <mark.post@eds.com> wrote:
> Thanks for the suggestion, but it didn't help.  One reason is that this
> is a bare repository.  When I ran the command, it aborted with "fatal:
> Not a git repository."  Most likely because bare repositories don't have
> a .git directory in them.
> 
> 
> Mark Post 
> 
> -----Original Message-----
> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> Sent: Sunday, July 16, 2006 9:22 PM
> To: Post, Mark K
> Cc: git@vger.kernel.org
> Subject: Re: git-repack not removing files from $GIT_DIR/objects/[00-ff]
> 
> "Post, Mark K" <mark.post@eds.com> wrote:
> > I'm having a problem that just started occurring with git-repack not
> > removing the files from $GIT_DIR/objects/*, and therefore not removing
> > the directories, since they're not empty.  The command I'm using (as
> the
> > git user) is this:
> > GIT_DIR=/home/git/pub/scm/linux-2.6.git git-repack -a -d -l
> > 
> > This used to work, but then suddenly stopped working.  I ran an strace
> > -f -F with this same command, and I don't see any attempt being made
> to
> > unlink the files in $GIT_DIR/objects/*/, but I do see the rmdir
> commands
> > failing because the directories are not empty.  All of the files in
> > those directories are owned by git:git.
> 
> Try running `git-prune-packed` after git-repack.  git-repack doesn't
> delete the loose objects.
> 
> I don't remember git-repack ever doing it either.

-- 
Shawn.
