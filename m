From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 03:11:47 +0200
Message-ID: <20061018011147.GN20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:12:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzyQ-0001VH-6K
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWJRBLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWJRBLt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:11:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57296 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750965AbWJRBLt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 21:11:49 -0400
Received: (qmail 18940 invoked by uid 2001); 18 Oct 2006 03:11:47 +0200
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Disposition: inline
In-Reply-To: <vpqbqob5euu.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29140>

Dear diary, on Tue, Oct 17, 2006 at 02:03:21PM CEST, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> I have one repository, say, $repo.
> 
> In it, I have one branch "$repo/bzr.dev" which is an exact mirror of
> http://bazaar-vcs.org's branch.
> 
> I also have branches for patches (occasional in my case) that I'll
> send to upstream. Say $repo/feature1, $repo/feature2, ...
> 
> If, by mistake, I start hacking on bzr.dev itself, I'll be warned at
> commit time, create a branch, and commit in this new branch. I believe
> git manages this in a different way, allowing you to commit in this
> branch, and creating the branch next time you pull. But you know this
> better than I ;-), I never got time to give a real try to git.

In fact, in Git the branch is actually created at the moment you clone.

For simplicity sake, let's say you cloned just a single branch, not the
whole repository (or imagine a repository with a single branch). Then,
in your local repository, two branches will be created: 'origin' and
'master'. The origin branch is considered readonly (though Git does
not enforce it) and only mirrors the branch in the remote repository.
The master branch is the branch you do your work on, and it corresponds
to the contents of your working tree.

Thus, when you are "updating" your repository (we also call that
"pull"), what happens is that new commits are _fetched_ from the remote
repository to your 'origin' branch and then the 'origin' branch is
_merged_ to the 'master' branch. (You can even separate those two steps
and do them manually. So you can e.g. periodically fetch but just check
diffs with your master branch and never actually merge, or whatever.)

If you never do any local commits on the repository, every time you
merge the 'master' branch is ancestor of the 'origin' branch and only
so-called fast-forward merge happens - the 'master' branch is updated to
point at the same commit as the 'origin' branch.

If you _did_ do some local commits, a real merge of the two branches
happens and a new merge commit tying the current master and origin
history together is recorded on the merge branch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
