From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The msysGit Herald, issue 2
Date: Sun, 23 Sep 2007 21:54:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709232153230.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 22:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZYUZ-0006ai-CK
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXIWUzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 16:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXIWUzp
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 16:55:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:51692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbXIWUzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 16:55:44 -0400
Received: (qmail invoked by alias); 23 Sep 2007 20:55:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 23 Sep 2007 22:55:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sEGFKhXvsBFyHmPWQVxVZwJrSzg/g94XlNcSuIw
	+WSMTkBiIEvm/N
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58985>

Good morning git land!

This lovely afternoon in St Andrews is as good an occasion as any to issue
a new incarnation of the msysGit Herald, the not-quite-biweekly news letter
to keep you informed about msysGit, the effort to bring one of the most
powerful Source Code Management systems to the poor souls stuck with
Windows.

These are the covered topics:

	WinGit 0.2

	What will be in WinGit 0.3?

	We're getting famous in China

	Compiling Perl from scratch

	Time for a new console?

	Interview with Johannes "Mr mingw.git" Sixt

	Still no concrete mingw/git.git merge plans yet


WinGit 0.2
==========

By mistake, Perl was not properly installed with version 0.1 of WinGit.
This is the most visible part that was fixed in 0.2.

However, in the meantime we got our "Issue" list (see home page) cut
almost in half.  Which means that we are mostly stuck with the hard
problems ;-)

What will be in WinGit 0.3
=========================

What will be in 0.3?  We have a proper uninstaller now.  Yes, that means
that "Git" will be in the "Add/Remove Software" list.

Also, curl, termcap, the completions, sh-add, and git-gui are actually
installed.

Maybe we'll get to the state where a link to git gui is installed in
addition to the "Git Shell", maybe we'll succeed in merging 1.5.3.2?

Who knows... ;-)


We're getting famous in China
=============================

Apparently, there is a blog talking (amongst other things, like the
unfamous language flame war) about "Git on Windows" in China:

http://blog.csdn.net/turingbook/archive/2007/09/07/1775488.aspx

I am dyslexic when it comes to Chinese, but we got some hits from
there...


Compiling Perl from scratch
===========================

We have an open issue called "Install scripts do not install perl modules
for git-svn" (Issue 42).  Unfortunately, it is not really as easy as
that...

The Perl version we have does not come with valid MakeMaker information,
and we are therefore unable to compile modules for Perl (even something
as dirt-simple as Digest::MD5 does not work).

So we tried to compile Perl from scratch -- which opened another can of
worms.  It was not a problem at all to compile Perl for _MinGW_.  Which
means that the resulting binary does not have any clue about the MSys
environment (think Unix style paths, and (worse!) no shell scripts).

An option would be to not care, and decouple Perl from MSys.  Another
option would be to get Perl compiled & linked to msys-1.0.dll.

This issue is not resolved yet.


Time for a new console?
=======================

The first publically available version of msysGit recommended Rxvt, until
I realised that there were strange stderr/stdout issues, which prevented
-- among other things -- the pager and ssh transport from working.

So we reverted back to cmd as the Terminal, which has its own set of
shortcomings (does not do ANSI well, has Control-C issues, and the
multi-line selection being a rectangular box is outright annoying, as
well as the missing Shift+Insert binding to paste the clipboard).

Now, compiling (and possibly fixing) Rxvt seems to be out of reach for the
moment, but Marius Storm-Olsen found the "Console" project:

	http://sourceforge.net/projects/console

Unfortunately, this project does not work on Windows 95/98/ME, and I would
have liked to retain backwards compatibility (some developers, yours
truly included, do not have Windows boxen to develop, so they have to
resort to emulated ones -- and 2k is a real hog there, opposed to 95).

However, since we already rely on the NT based family for our installer,
that reason not to use Console seems to fall on the floor.

We would need to work on it, though: ATM it has problems with selections,
and recompiling is made difficult by the ATL dependency.


Interview with Johannes "Mr mingw.git" Sixt
===========================================

Hannes announced an initial official version of the MinGW port of git on
January 19th, 2007:

	http://article.gmane.org/gmane.comp.version-control.git/37202

For quite some time, he was the only one working on this port.  Most of
the smoothness of the msysGit effort is his fault.

So here, without further ado, the interview:

> 1) How did you get involved with Git?

In our shop, CVS was used for years. I have been working with patch sets 
because it did not allow the workflow that I wanted - namely to construct
a series of changes before making them public.

When the news came out that Linus was working on a new VCS, I was
following its development closely. From the discussions I discovered that
git would be the tool that allowed my desired workflow.

In order to get acquainted with git, I used it on my Linux projects
(KDbg, Cinelerra).

> 2) What were the reasons that you started working on Git?

In our shop, which develops software for Windows, the requirement arouse
to have several different, but related versions of the same product -
which is  a setup that we would not be able to solve with CVS, but it
would be a breeze with git.

But we needed git on Windows. And since I dislike cygwin (for no good
reason actually), I decided to start the native port of git to Windows
using MSYS ang MinGW.

> 3) What do you like most in Git?

- Easy merging with real merge history
- Massage a series of changes into proper shape before making it public

> 4) What do you hate most in Git?

You're kiddin'!

> 5) What was the most surprising moment when working with Git?

It merged a change I made in an old branch in a file that was moved in
the new branch to a new location. IOW, merge across renames. Really, I
was so surprised - I wanted to start the manual merge when I discovered
that git had done all the work for me.

> 6) What was the most frustrating moment when working with Git?

Just the other day, I wanted to fetch a set of changes from a public
repo into my test repo in order to cherry-pick from them - and it
automatically fetched all the tags. But, the heck, I don't want them tags
here, just the commits. I just can't figure out how to avoid the automatic
fetching of tags.

> 7) In what environment do you work?

Linux (SUSE); Windows 2000, XP.

> 8) What other hobbies do you have?

Cuddling the brats and changing nappies - does that count as a hobby?

> 9) What is your favourite movie?

You think I have time to watch movies?

> 10) What are your visions for Git? (I.e. where do you want it to go?)

Seriously, I'm not a visionair.

On *nix, git will be perfect when it is able to seamlessly serve the KDE 
source.

On Windows, git still has too many problems that we don't need a vision, yet.

-- Hannes


Still no concrete mingw/git.git merge plans yet
===============================================

As mentioned in the first issue of this news letter, I sent a rather long
list of relatively small and well contained projects, that in total would
mean a complete merge of the mingw/4msysgit port back into git.git:

	http://article.gmane.org/gmane.comp.version-control.git/57163

Unfortunately, there have not been any takers (just a few "would it not
be better to have this in git.git" sayers).

In related news, it seems to be awfully more common for Windows users than
for other people to have the attitude "I am the user.  You _have_ to help
me."  (Remember that in our case, the users are developers, too, so they
should be able to help themselves.)

Do not let yourself fool into thinking that _all_ Windows users are like
that.  Just enough to annoy.

However, nobody stops changing until eaten by the bugs, so all of those who
think "well, I might be able to do a small thing, just to prove that
bastard wrong": follow the above link, read the mail (you can even just
randomly jump around, and only read parts of it), pick a target, and say so
on the msysGit mailing list (msysgit@googlegroups.com).
