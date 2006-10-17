From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 14:03:21 +0200
Message-ID: <vpqbqob5euu.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:08:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZnkF-00074z-Lb
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWJQMI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWJQMI3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:08:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:15571 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750702AbWJQMI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 08:08:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HC4GCD020450
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 14:04:17 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZnfF-000769-RF; Tue, 17 Oct 2006 14:03:21 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZnfF-00021Y-Nx; Tue, 17 Oct 2006 14:03:21 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> (Sean's message of "Tue\, 17 Oct 2006 07\:38\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 14:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29064>

Sean <seanlkml@sympatico.ca> writes:

> On Tue, 17 Oct 2006 13:19:08 +0200
> Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
>> 1) a working tree without any history information, pointing to some
>>    other location for the history itself (a la svn/CVS/...).
>>    (this is "light checkout")
>
> Git can do this from a local repository, it just can't do it from
> a remote repo (at least over the git native protocol).  However,
> over gitweb you can grab and unpack a tarball from a remote repo.
> In practice this is probably enough support for such a feature.

Anyway, given the price of disk space today, this only makes sense if
you have a fast access to the repository (otherwise, you consider your
local repository as a cache, and you're ready to pay the disk space
price to save your bandwidth). In this case, it's often in your
filesystem (local or NFS).

>> 2) a bound branch. It's not _very_ different from a normal branch, but
>>    mostly "commit" behaves differently:
>>    - it commits both on the local and the remote branch (equivalent to
>>      "commit" + "push", but in a transactional way).
>>    - it refuses to commit if you're out of date with the branch you're
>>      bound to.
>>    (this is "heavy checkout")
>
> This doesn't sound right, at least in the spirit of git.  Git really
> wants to have a local commit which you may or may not push to a
> remote repo at a later time.  There is no upside to forcing it all to
> happen in one step, and a lot of downsides.  Gits focus is to support
> distributed offline development, not requiring a remote repo to be
> available at commit time.

I lied in my above description ;-).

I should have said "by default" ... but you have "commit --local" if
you want to have a local commit on a bound branch (at this point, I
should remind that not all branches are "bound branches". "bzr branch"
creates branches similar to git ones).

>> In both cases, this has the side effect that you can't commit if the
>> "upstream" branch is read-only. That's not fundamental, but handy.
>
> Again this seems really anti-git.  There is no reason for your local
> branch to be marked read only just because some upstream branch is
> so marked.

Will, take the example of my bzr setup.

I have one repository, say, $repo.

In it, I have one branch "$repo/bzr.dev" which is an exact mirror of
http://bazaar-vcs.org's branch.

I also have branches for patches (occasional in my case) that I'll
send to upstream. Say $repo/feature1, $repo/feature2, ...

If, by mistake, I start hacking on bzr.dev itself, I'll be warned at
commit time, create a branch, and commit in this new branch. I believe
git manages this in a different way, allowing you to commit in this
branch, and creating the branch next time you pull. But you know this
better than I ;-), I never got time to give a real try to git.

>> I use it for example to have several "checkouts" of the same branch on
>> different machines. When I commit, bzr tells me "hey, boss, you're out
>> of date, why don't you update first" if I'm out of date. And if commit
>> succeeds, I'm sure it is already commited to the main branch. I'm sure
>> I won't pollute my history with merges which would only be the result
>> of forgetting to update.
>
> This is exactly the same in Git.  You really only ever push upstream
> when your local changes fast forward the remote, (ie. you're up to date).
> Git will warn you if your changes don't fast forward the remote.

Yes, but you will have to do a merge at some point, right ? While I'm
keeping a purely linear history (not that it is good in the general
case, but for "projects" on which I'm the only developper, I find it
good. For example, my ${HOME}/etc/).

But don't get me wrong, I also prefer the decentralized way in most
case. And I'm happy that bzr and git work like this by default. Just
that at least *I* have cases where a centralized approach suits me
better, and then I'm happy with that particular feature of bzr.

-- 
Matthieu
