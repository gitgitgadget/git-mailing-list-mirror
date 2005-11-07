From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix empty line processing in git-shortlog.perl
Date: Mon, 7 Nov 2005 21:46:59 +0100
Message-ID: <20051107204659.GT1431@pasky.or.cz>
References: <20051106224218.22797.97260.stgit@machine.or.cz> <7v3bm9upx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bunk@stusta.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 21:48:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZDtU-0000oU-Qw
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 21:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVKGUrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 15:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKGUrF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 15:47:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44164 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932288AbVKGUrB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 15:47:01 -0500
Received: (qmail 18414 invoked by uid 2001); 7 Nov 2005 21:46:59 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bm9upx4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11279>

Dear diary, on Mon, Nov 07, 2005 at 03:56:07AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I think the problem is deeper than that.  Shortlog summarizes to
> only one line per commit, so I suspect what you would be feeding
> it would say something like this for the above example:
> 
>         commit f1b2646c7f2713c3ea4bce120e1d0d8091808be4
>         Author: Adrian Bunk <bunk@r063144.stusta.swh.mhn.de>
> 
>             From: Michal Wronski <wrona@mat.uni.torun.pl>
> 
> That is, the commit you quoted is done by 'git log --pretty',
> but a typical shortlog invocation would be:
> 
> 	git log --pretty=short rev1..rev2 | git shortlog
> 
> With or without your fix, the command barfs.
> 
> Of course, that "From: " line should have been used as the
> commit author by the tool that created the commit out of e-mail
> Adrian received, but that is a separate issue.

Well, on a second though, I don't think we should probably handle this
at all, then. The whole logic for this in git-shortlog.perl seems to be
dubious, so would be a requirement that we require the input to be from
--pretty=short ok?

Simpler code, no bugs, everyone happy, errors during applying (like
stale From) immediately noticeable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
