From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The 10th copy of the msysGit Herald
Date: Mon, 27 Jul 2009 19:23:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907271922310.6883@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 19:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVTv7-0002ph-Ha
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 19:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbZG0RXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 13:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZG0RXT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 13:23:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:43378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbZG0RXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 13:23:18 -0400
Received: (qmail invoked by alias); 27 Jul 2009 17:23:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 27 Jul 2009 19:23:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//c8066Pv/EzxLtgUi+Qcww8lzyjw6jJR40XugIy
	IS8Xxclda7LS3q
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124172>

Good morning git land!

A warm and sunny Monday afternoon is as good an occasion as any to 
offer to you the 10th copy of the msysGit Herald, the quite irregular 
news letter to keep you informed about msysGit, the effort to bring 
one of the most powerful Source Code Management systems to the 
Operating System known as Windows. 

These are the covered topics:

	Upcoming branch layout of 4msysgit

	Using pthreads

	OpenSSL & cURL

	Subversion 1.6.3

	Moving Perl to MinGW32

	Fixes to the "full installer"

	Interview with Erik Faye-Lund



If things had continued as this developer expected, this issue would 
not be due for another year. As things turned out, though, there 
appeared some very interested and capable developers out of the blue, 
and msysGit is moving again! 


Upcoming branch layout of 4msysgit
==================================

Since the last Herald, there have been quite a few infrastructure 
changes in msysGit, such as making it detectable if your Git runs in 
msysGit or in an installed Git for Windows, or improvements in the 
installer-making procedure (see also the story "Fixes to the 'full 
installer'" in this Herald). 

But there has been also quite some work, primarily by Johannes Sixt 
and Steffen Prohaska, to minimize the differences between git.git and 
4msysgit.git. Soon, we will be able to follow git.git much more 
closely than now. 

So the plan is to follow git.git's 'maint', 'master' and 'next' 
branches, and rebase to git.git's branches whenever a new Git version 
comes out. 

The temporary branches will still be called 'work/<branch>' for 
branches that are rebased often, and '<nick>/<branch>' for branches 
that a certain developer wants to work on alone. 

Whenever something was merged into 'next', the corresponding work 
branch will be removed. 


Using pthreads
==============

As more and more Windows machines have multiple cores or even CPUs, we 
now have our own pthreads library, to make use of the machine's 
capabilities when compressing the database. 


OpenSSL & cURL
==============

Many people think our issue tracker is something like a list for Santa 
Clause or something. Many even just dump their (sometimtes 
unreasonable) ideas there and never come back. I made it a habit of 
being joyful when clicking on the "Invalid" link to move such issues 
out of the list of open issues. 

One of these wishes was not too unreasonable, but I knew that it would 
not happen: in my experience, Windows users are very happy to ask for 
things, but they almost feel insulted when you ask them for help. 

But I was wrong: the wish was to have an SSL-aware version of cURL, to 
be able to clone repositories from https:// URLs. And one guy, an 
honest-to-God Windows lover even, volunteered to work on this issue 
(see also the interview at the end). 

It was not smooth sailing, but Erik continued to work on the issue, 
and with a little cooperation, we got something to compile. 

The result is not only the addition of two new, shiny .dll files, but 
two shell scripts ("recipes") that can download, compile, install and 
commit the files. This helps not only with upgrading to newer 
versions, but also with upgrading our Subversion (see next story). 


Subversion 1.6.3
================

Similarly to OpenSSL & cURL, there was a wish on the issue tracker 
that we should upgrade our Subversion, which is quite old by now. 

However, I vividly remember how difficult it was to get the initial 
git-svn support working (albeit very slowly), and how many people and 
their enthusiastic effort it took (and I also remember how some people 
just complained about the slowness of the result, which really took 
almost all the fun out of msysGit for me, shame on them). 

To my pleasant surprise, again someone came along and worked on the 
issue: Laurent Boulard. 

As I feared, upgrading Subversion was not a simple task: its neon 
library now depends on OpenSSL. Unlike the OpenSSL we compiled 
successfully for MinGW, our Subversion is an MSys program, and 
therefore we needed an MSys version of OpenSSL. 

Remember: MinGW is really a very thin compile-time layer over the 
Microsoft Runtime; MinGW programs are therefore real Windows programs, 
with no concept of Unix-style paths or POSIX niceties such as a fork() 
call. 

MSys, in contrast, is a slimmed-down version of Cygwin (an old version 
at that), whose only purpose is to provide enough of a POSIX layer to 
run a bash. 

It appeared easier to us to get something like git-svn, which really 
expects a POSIX environment, going in the MSys environment. 

Here, the efforts not only to make OpenSSL compile in msysGit, but to 
make the result a script which can do it, really came in handy. 

So now we are closing in on having a functional Subversion 1.6.3 in 
msysGit. 


Moving Perl to MinGW32
======================

Just when I thought that I was surprised enough by the arrival of new 
msysGit contributors, another guy names Bosko Ivanisevic came along 
and asked how to fix his Subversion build. It became quite apparent 
that he tried to compile it as a MinGW program. 

I thought it might make sense to try to get git-svn to run in a MinGW 
setting (i.e. OpenSSL, Perl and Subversion all as MinGW programs), and 
Bosko agreed. I fully expect the performance issues of git-svn to be 
helped by that move (although I think that some of those who will 
benefit from it do not deserve it at all). 

This project is in full action right as we speak. 


Fixes to the "full installer"
=============================

According to our download site, the msysGit "full" installer is more 
than three times more popular than the "net" installer. 

Just a quick reminder: "msysGit" is the build environment for working 
on "Git for Windows". The "msysGit" installer comes in two flavors: 
"net" and "full". 

The "net" installer is really just a stripped-down "Git for Windows" 
that just clones our Git repositories, builds and installs Git. 

The "full" installer is a stand-alone self-extracting 7z archive that 
brings everything needed to compile a particular Git for Windows 
version. It has no connection to our Git repositories, though. 

To make a "full" installed msysGit environment updatable (by setting 
up Git remotes and fetching the branches), we provide the script 
/share/msysGit/initialize.sh. 

Now, this would be all well and fine, if that script was not broken. 
As it happens after some rather obvious fixes, the script is no longer 
broken! 


Interview with Erik Faye-Lund
=============================

I think Erik is the first msysGit contributor I "met" via an issue 
tracker. He was relatively active answering questions, also on the 
msysGit mailing list, before he dived into the adventure of compiling 
OpenSSL and cURL (see the corresponding story of this Herald issue). 

He agreed to answer my Terrible Ten, as long as I was fine with his 
sometimes not-too-serious style of answering ;) -- which of course I 
am. 

So here it goes: 

1) How did you get involved with Git? > 

I was looking for something better than SVN for a long time. The 
reason was mostly distribution, as I do a lot of work offline. I tried 
SVK, and I hated it. I tried Mercurial, and it was a lot better than 
SVK, but still not quite there. I can't really put my finger on it, 
but it just didn't work for me. 

I still prefered SVN over Mercurial. I doubt I would now, though. I'm 
too much in love with distributed work-flows. 

I already knew about Git, but had early dismissed it because I had 
heard it was difficult to use (read: "ZOMG, Linux zealotry!!"). I 
wanted a VCS that didn't require a lot of time of getting into. 
Luckily, I overcame my skepticism, and gave it a shot. And I must 
admit, I was amazed. Not only was it really really easy to use (as 
opposed to what some people are saying), pretty much everything about 
it felt right. 

I immediately fell in love with the staging concept. In fact, it was 
something I already had kind of "mentally built" myself in SVN (which 
was pain to do), and I loved that it was so accessible. 

2) What were the reasons that you started working on Git? > 

I'm in it for the fame, glory and women... or whatever. 

Actually, I don't have a big reason other than wanting to make the 
world a better place (blah blah). I was bored one day, and I saw an 
issue posted on the mailing list that made me think "hey, I'm a 
programmer, I can solve this". And I did. After that, the ball just 
kinda started rolling. 

3) What do you like most in Git? > 

The development community. I think it's really focused and generally 
working in a constructive manner. 

About git itself I'd go with the "obvious" answers; distribution, 
painless branching, stash, the staging area... Oh, and the 
performance, of course. 

4) What do you hate most in Git? > 

That Windows is still a second class citizen. But let's try to fix 
that one, huh? :) 

5) What was the most surprising moment when working with Git? > 

I guess when I figured out that I could just create a local repo for 
basically any project, and push it out somewhere if it turned into 
something useful. That ad-hoc way of making repos is not something I'm 
used to from SVN. 

6) What was the most frustrating moment when working with Git? > 

GWhenever I fight with line-endings. The fact that core.autocrlf=true 
doesn't work too well in git-svn, combined with visual studio's lack 
of proper newline-support causes me a lot of annoyance at my dayjob. 

That's one thing that actually still SVN is better at, and it makes me 
a bit sad. 

7) In what environment do you work? > 

Windows Vista 64bit. I'm a Windows guy. Sure, go ahead an hate me -- I 
like Windows. 

8) What other hobbies do you have? > 

I murder people who ask too many questions. 

No, seriously, I'm an active demo programmer. You can read more about 
it on http://en.wikipedia.org/wiki/Demoscene if you don't know what 
demos are. 

Back when I was younger and in better shape I did a lot of 
skateboarding. I sometimes still pretend that I'm up to i, but I 
always end up disproving myself. But it's fun :) 

9) What is your favourite movie? > 

Hmm. That's a very tricky question, I don't watch that many movies 
these days. Can I answer with a book? If so, "Shantaram" by Gregory 
David Roberts. I'm sure the movie will be awesome, I heard Johnny Depp 
is playing the lead role. 

10) What are your visions for Git? (I.e. where do you want it to go?) 
> 

I'd like to see the Windows version being as good as the 
*nix-versions. Also, I don't think we should settle for less than 
world domination. Giant lazers on the moon? I can't see why not. 
