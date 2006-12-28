From: Pavel Roskin <proski@gnu.org>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 16:29:06 -0500
Message-ID: <1167341346.12660.17.camel@dv>
References: <1167251519.2247.10.camel@dv>
	 <7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 22:29:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H02oM-0000Oe-JF
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 22:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbWL1V3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 16:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001AbWL1V3L
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 16:29:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55416 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbWL1V3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 16:29:10 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1H02o4-0007wx-1b
	for git@vger.kernel.org; Thu, 28 Dec 2006 16:28:56 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1H02oE-0003OX-H4; Thu, 28 Dec 2006 16:29:06 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35561>

Hello!

On Wed, 2006-12-27 at 13:14 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > For example, I clone the git repository anew, and I try to update it by
> > git-fetch a few days later.  I get an error:
> >
> > * refs/remotes/origin/pu: not updating to non-fast forward branch 'pu'
> > of git://www.kernel.org/pub/scm/git/git
> 
> Perhaps you would want something like this?
> 
> if you are using separate remote layout:
> 
> [remote "origin"]
> 	fetch = +refs/heads/pu:refs/remotes/origin/pu
> 	fetch = refs/heads/*:refs/remotes/origin/*

That works.

Actually, it's strange that I don't actually have refs/heads/pu
under .git, and it doesn't get created even if I run "git-pull" or
"git-pull origin pu".

I realize that I'm far behind in my understanding of GIT, but it seems
to me that something is wrong in the new layout.

We have a line that says: "pull from pu branch of origin and merge it
into local pu branch even if fast-forward is impossible".  However,
there it no local pu branch.  Yet not having this line blocks updating
of master branch.

It's like saying: I won't update master branch because there is another
branch that you are not tracking locally, but if you were, it would not
fast forward.  Seems quite perverse to me.

My .git/config file is:

[core]
        repositoryformatversion = 0
        filemode = true
        logallrefupdates = true
[remote "origin"]
        url = git://www.kernel.org/pub/scm/git/git.git
        fetch = refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

-- 
Regards,
Pavel Roskin
