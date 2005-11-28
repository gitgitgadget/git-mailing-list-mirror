From: Petr Baudis <pasky@suse.cz>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 14:41:11 +0100
Message-ID: <20051128134111.GP22159@pasky.or.cz>
References: <861x118r9t.fsf@blue.stonehenge.com> <20051128104831.GN22159@pasky.or.cz> <86d5kk7wbv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgjG2-0004uy-OF
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVK1Nk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVK1Nk5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:40:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23246 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932097AbVK1Nk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 08:40:56 -0500
Received: (qmail 2851 invoked by uid 2001); 28 Nov 2005 14:41:11 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86d5kk7wbv.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12877>

Dear diary, on Mon, Nov 28, 2005 at 02:09:40PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> >>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:
> 
> Petr> Dear diary, on Mon, Nov 28, 2005 at 03:01:18AM CET, I got a letter
> Petr> where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> >> localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"
> 
> Petr> BTW, it should be fine to just say ../remote.git#master.
> 
> Maybe this is why yours worked.
> 
> Ahh, yes, it did.
> 
> So, cg-push treats '../..' differently from '/foo/bar/...'.
> 
> This is bad.  That's the bug.

Nope, the relative path is resolved at the time of adding the branch.
Check for yourself:

xpasky@machine[0:0]~/git-devel/x/local.git$ cg-branch-add origin "$(cd ..; pwd)/remote.git#master"
xpasky@machine[0:0]~/git-devel/x/local.git$ cg-branch-add origin2 ../remote.git#master
xpasky@machine[0:0]~/git-devel/x/local.git$ cg-branch-ls
origin  /home/xpasky/git-devel/x/remote.git#master
origin2 /home/xpasky/git-devel/x/remote.git#master

Pushing to both works fine.

> cg-push treats "../" as a local filesystem, and "/..." as git-ssh.
> This is a change from before.
> 
> Please make it recognize "/..." as a local file again.

It would sure be bad if this was the case. However I'm really sorry, but
I still can't reproduce it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
