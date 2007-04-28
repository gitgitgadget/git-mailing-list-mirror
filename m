From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Added 'find-rev' command
Date: Sat, 28 Apr 2007 03:50:16 -0700
Message-ID: <20070428105016.GA11271@muzzle>
References: <117770027350-git-send-email-aroben@apple.com> <20070427193004.GC12375@untitled> <7vbqh9kov9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 12:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhkVk-0003NM-49
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbXD1KuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 06:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbXD1KuT
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 06:50:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34740 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030192AbXD1KuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 06:50:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D72D07DC0A0;
	Sat, 28 Apr 2007 03:50:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 28 Apr 2007 03:50:16 -0700
Content-Disposition: inline
In-Reply-To: <7vbqh9kov9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45774>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Adam Roben <aroben@apple.com> wrote:
> >> This patch adds a new 'find-rev' command to git-svn that lets you easily
> >> translate between SVN revision numbers and git tree-ish.
> >
> > Looks useful.
> >
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> But looks quite wasteful.  Why not run "rev-list -v" or
> something instead of running cat-file on revision one-by-one?

Didn't know about "rev-list -v", but I just checked and it still has the
limited-size buffer that --pretty=raw has.

"git-svn log" only runs cat-file if it can't find a git-svn-id: line at
the bottom.  (I used log --abbrev-commit --pretty=raw).

Sorry about the premature Ack, I hadn't had my coffee yet at that point
(and now I'm half awake :x)

Adam:

However, since we're not fetching ranges...

You can do $gs->rev_db_get($rev_nr) to easily find a commit given a
revision.  Bonus points if this works independently of the current HEAD
so you can look up revision numbers on different branches.  (git-svn log
should be made to support this, too)


-- 
Eric Wong
