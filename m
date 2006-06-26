From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A series file for git?
Date: Sun, 25 Jun 2006 20:44:26 -0400
Message-ID: <20060626004426.GA7193@spearce.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org> <7virno79a7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605291739430.5623@g5.osdl.org> <7vmzd05i25.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605292112530.5623@g5.osdl.org> <7vpshtyffk.fsf@assigned-by-dhcp.cox.net> <m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com> <7vac83ylk6.fsf@assigned-by-dhcp.cox.net> <m1r71exww5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 26 02:44:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FufDS-0003jP-Ae
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 02:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWFZAof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 20:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWFZAof
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 20:44:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42118 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932448AbWFZAoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 20:44:34 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FufD8-0001Pk-Oj; Sun, 25 Jun 2006 20:44:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 914EA20FB16; Sun, 25 Jun 2006 20:44:27 -0400 (EDT)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1r71exww5.fsf@ebiederm.dsl.xmission.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22652>

"Eric W. Biederman" <ebiederm@xmission.com> wrote:
> Junio C Hamano <junkio@cox.net> writes:
[snip]
> > I am not sure about that.  What does the series file contain,
> > and what other things the meta data branch contain?  If you are
> > listing commit SHA1 in the series file, you _do_ have the risk
> > of losing things -- git-fsck-objects needs to look at such blob
> > object and consider that as the root of reachability chain; to
> > me that seems too specialized hack.
> 
> When described that way I agree.   The best I can imagine
> is to list those commits as ancestors of the current commit.
> Hmm.  Or possibly I could collect up tag objects and work
> with them.  In any case representing this in a non-hackish
> way is my goal.

I did this in pg.  It didn't work out very well as the GIT diff
tools (e.g. the diff in gitk) show the diff in a very odd way.
It did not work out as well as I had hoped.

> > I have a feeling that I really should study how well StGIT does
> > things before talking about this further.  It may suit your
> > needs perfectly.  What do you feel is lacking in StGIT that you
> > need?
> 
> What I want and what I see lacking in the git and StGit is
> the ability to record the history of editing the history
> of a branch. 
> 
> A mundane example.  It would be nice if I rebased a branch if
> I could record in some fashion what that branch was before
> I rebased it.

Use the new reflog code.  Its in 1.4.  Check the documentation for
git-update-ref for some details.  git-commit, git-rebase and git-am
should track history on a ref in the reflog.  However a reflog
won't anchor a commit into your repository and thus a prune may
remove it if no other commit/ref/tag mentions it.

-- 
Shawn.
