From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 15:53:59 -0700
Message-ID: <471D2A07.7070201@midwinter.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 00:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6A6-0001Wy-OI
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbXJVWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbXJVWyG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:54:06 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55926 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbXJVWyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:54:05 -0400
Received: (qmail 18037 invoked from network); 22 Oct 2007 22:54:04 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=KhQ1jHMjkvt4KVL1tz48HXRf1JtegfmoanPMqehkR3ffWKUXROilspYp+pr2lNH8  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 22 Oct 2007 22:54:04 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0710212308540.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62051>

Johannes Schindelin wrote:
> I'd really like people to respond not so much with broad and general 
> statements to my mail (those statements tend to be rather useless to find 
> how to make git more suitable to newbies), but rather with concrete top 
> ten lists of what they do daily.
>   

Maybe not top 10 per se, but here are a couple of my common command 
sequences and some comments about how they could maybe be simplified. I 
mostly use git to talk to an svn repo, which in some sense is a corner 
case but which I suspect is both (a) really common already, and (b) 
potentially even *more* common if we can make git an even easier way to 
work with svn repositories.

Pulling updates from svn:

git stash
git svn rebase
git stash apply

A "git svn up" command could do the above automatically (svn users are 
accustomed to doing "svn up" with dirty working copies.)

Committing my work:

git commit -a
(ask someone for a code review, usually involves "git diff" or "git show")
git commit --amend (to indicate in my commit message who did the review)
git svn rebase
git svn dcommit

This isn't too bad as is. I could save myself the "git commit --amend" 
if there were an option to "git svn dcommit" to pop up a commit message 
editor (using the existing text as the default, of course) but it 
doesn't bother me much.

A more extreme possibility which I predict approximately 0 people on 
this list will like: if the working copy is dirty but there is no local 
commit, "git svn dcommit" could pop up an editor for a commit message, 
make a local commit, then send it to svn. That would simplify the 
git-based workflow even further for svn users who don't care about local 
versioning. I'm not sure *I* even like this idea, mind you, but it would 
certainly address the "Why this extra step I don't need in svn?" 
complaint svn users sometimes raise.

Working in a topic branch:

git checkout whateverbranch
git svn rebase
git commit -a   (a bunch of times)
git checkout -b temp trunk
git merge --squash whateverbranch
git commit
(get code review)
git commit --amend
git svn dcommit

This could be shortened a bit with the above idea (edit commit message) 
plus an option to git-svn dcommit to squash everything into one svn commit.

Of course, whether adding more options like that would make things more 
newbie-friendly is a valid question in and of itself; a shorter workflow 
is not necessarily a more discoverable one.

-Steve
