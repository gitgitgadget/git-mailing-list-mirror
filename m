From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Fourth incarnation of the msysGit herald
Date: Sat, 20 Oct 2007 00:25:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710200024460.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 01:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij1Ep-0003c2-DK
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 01:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbXJSX0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 19:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbXJSX0I
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 19:26:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:38019 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754479AbXJSX0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 19:26:07 -0400
Received: (qmail invoked by alias); 19 Oct 2007 23:26:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 20 Oct 2007 01:26:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Pk6t9pmQPw0RK8FrgM2mcp46NSEoX2vzUPib8Z3
	ZyqNgD3EshuvKG
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61773>

Good morning git land!

20 years after the black monday, which happens to be exactly three days
after the 164th (official) birthday of the quaternions, is as good an
occasion as any to bring to you the fourth incarnation of the msysGit
Herald, the not-quite-biweekly news letter to keep you informed about
msysGit, the effort to bring one of the most powerful Source Code
Management systems to the poor souls stuck with Windows.

These are the covered topics:

	Spanking new Inno installer

	New naming scheme & new release

	git gui

	Interview with Steffen Prohaska

	Calling git from cmd.exe

	Historic notes


Spanking new Inno installer
===========================

As mentioned in the last Herald, Sebastian Schuberth (with some help
of Steffen Prohaska) started to replace the 7-Zip installer that I
built with my heart and soul.  I even came so far as to work around
Windows' refusal to delete the uninstaller while that is running
(which would usually be its last action on other platforms).

Incidentally, this uninstaller was also a nice small example how to
write an elegant Win32 program without bloat.  My opinion _might_ be
biased because I wrote it.

But I have to admit that the installer based on Inno looks sleeker,
more professional, and is easier to extend.

It uses the same LZMA compressor that 7-Zip used, so there is (almost)
no downside regarding the size of the installer.

The usual options, such as adding a Start Menu, a Quick Launch item,
a Desktop item, a simple Explorer extension, and an uninstaller,
come basically for free with Inno.  Well, not exactly for free, but
Sebastian did all the hard work, so that we all could benefit.

>From what I hear, this installer is also able to run on DOS based
Windows such as Windows 95.  Yeah!

The downsides of using Inno that I have encountered so far are not
important in comparison:

You can no longer just unzip the installer with 7-Zip.  But if that
should turn out to be a major problem for many people (which I doubt),
we can still just add one line to automatically generate a .7z file
at the same time as the installer.  I came upon a little project
named "innounp" (on sourceforge.net), though, which purportedly unpacks
installers made with Inno Setup.  Maybe at some stage there is also
a 7-Zip plugin ;-)

The installer was easily built using Linux, by making a 7-Zip archive
and prepending the self-extracting module and the config file.  Well,
Wine is not there yet, but hopefully it will soon.

The installer does not run under Wine.  But then, neither did the
7-Zip based installer.


New naming scheme & new release
===============================

There was a bit of a stir when we realised that not everybody
understands the differences between GitMe, msysGit and WinGit.

So we sat down on the msysgit list and thought about it a bit.

There are basically two different projects: msysGit, which is the
development environment which is needed to compile git and friends.

And there is the installer which delivers the compiled programs to
those who do not want to work _on_, but _with_, git.  We used to
call this WinGit (I liked it very much because of the connotation
of "to wing it").

But Steffen Prohaska pointed out, rightfully so, that it should be
Git-<version-and-stuff>.exe.

Since our current versions are not as smooth-running as git on
POSIX platforms, we decided to go with the "preview" postfix, until
we are reasonably comfortable to declare it "beta".  Note: in the
good tradition of Open Source, our "preview" versions are probably
more usable than some XP^WGolden versions of commercial software.

The version number will be that of the git release we are basing
our installer on, and we plan to have indicators "rc<n>" once our
project is stable enough that we are reasonably certain that it
does not have fatal flaws.  Also, the timestamp of its build will be
part of the file name, and we will tag the exact state in msysgit.git
which this build was based on.

So we now have the first official preview of Git on MSys.  By the old
naming scheme, this would have been "WinGit 0.3 alpha".

It was created with Inno (see previous story), and we expect the user
experience to be much smoother than with previous releases.  There is
one known issue, though: pull/fetch does not work in git gui (also see
next story).


git gui
=======

git gui is a really nice program, and as I often said, I consider it
more porcelain than a gui, since it uses the git core directly, instead
of wrapping around porcelain commands.

The user experience I had with git gui made me think that this should
be the primary interface Windows users should be confronted with, not
the command line.

The major problem we had in msysGit is that git-gui was to be launched
from the Start Menu, or a QuickLaunch icon.  This is in contrast to
the shell, where you usually start git gui in a working directory.

So we needed some method to choose a working directory.  Mike Pape
put some work into that, but got too much work to do with the day
job.  While he was busy with non-gittish things, Shawn Pearce went
busy writing a wizard to select an existing directory, create a new
one, or clone a repository.

One issue we did not yet properly resolve is that fetch/pull does not
work from within git gui.  For the moment, you have to use the Git bash.
I suspect that this issue will disappear automagically when we merge
with newer git which have the builtin fetch.

Steffen Prohaska contributed the "open recent" feature, so there is
nothing left preventing our taking over the (Windows-)world!


Interview with Steffen Prohaska
===============================

> 1) How did you get involved with Git?

I was looking for a simple version control system to handle my personal
Mac OS X documents. Mac OS X applications save data as directories
containing related files that together form a document. A version
control system must not store data in such a directory.

I worked with CVS, which I am still using on a daily basis, and tried
svn. But both need to store data in every subdirectory they manage.

I stumbled over a couple of other systems, like monotone, arch, darcs,
and finally git. Git was quite easy to install and did what I needed;
well, after I found out about

    git-ls-files -z --others SomeBundle | \
		git-update-index --add -z --stdin
    git-commit -a	

I created my first git repository around April 2006 and have these two
lines in a script there. And I still use them to handle nearly all of
my documents.


> 2) What were the reasons that you started working on Git?

Git did always a great job managing my own documents. But two
deficiencies kept me for a long time from advertising it as a
replacement for our CVS: Git didn't work on Windows and git didn't
provide a mechanism that is today known as sub-modules.

When it turned out that sub-modules will become available and Windows
support (autocrlf) was introduced, I started to evaluate a migration
of our development team from CVS to git. The need for a new system
intensified after it became clear that we'll have to handle three
sub-groups in the future with different release schedules.

I was pretty convinced that git would be the right system. But Windows
support was just not good enough. So I started to work on this.
A bit earlier I needed to debug CVS import. If I remember correctly
the first patch I sent was on git-cvsexportcommit.


> 3) What do you like most in Git?

When I started I liked most the lightweight installation and easy
setup of fresh repositories.

Today, I like most the great support for automatic merging, rerere,
and git-mergetool.


> 4) What do you hate most in Git?

Git asks me two times for my password during 'git fetch' when I
forgot to unlock my ssh-key. And I can't reasonably explain this
fact to newbies.

I often need to find small workarounds for minor deficiencies in
the user interface. Especially getting started with git is not as
easy as it could be. git-* matches approximately 150 commands.
That's overwhelming.


> 5) What was the most surprising moment when working with Git?

When I learnt about rerere. It's magic.


> 6) What was the most frustrating moment when working with Git?

When I understood that git-cvsimport messes up CVS history and
cannot be used for importing from CVS. It was really hard to find a
working alternative. The documentation didn't help much.

I was also quite desperate when I understood that git will never
run in Cygwin's textmode.


> 7) In what environment do you work?

Mac OS X, Linux (x86_64, i386, ia64), XP, XP64, Vista.


> 8) What other hobbies do you have?

besides git? ... hmm ... maybe jogging counts as a hobby.


> 9) What is your favourite movie?

Pulp Fiction.


> 10) What are your visions for Git? (I.e. where do you want it to go?)

I wish to see all core features with same quality on Windows as on Unix.
In addition, everything which is needed to support cross-platform  
projects that look on Windows as if they were pure Windows projects and
on  Unix as if they were pure Unix projects.

A leaner user interface would be nice that is more focused on the  
essential workflows and makes it easier to explain git. The average
developer shouldn't need to know too many details about git before he
is able to participate in a shared repository workflow.

	Steffen


Calling git from cmd.exe
========================

As mentioned in the story "The war between cmd and bash" in the first
issue of this little tabloid, some people prefer to avoid bash.

The simplest solution to allow this would be to add msysGit's bin/
to the PATH.  Alas, it is not as easy as that.

Windows has its own versions of "sort" and "find", and regular Windows
users' scripts might rely on finding those, while git relies on finding
more POSIXy versions of those programs.

Therefore we have a cmd/ directory containing wrappers for git and gitk,
and the new installer adds this directory to the PATH.  (Actually you
can choose between a few different options...)

That should make everybody happy.


Historic notes
==============

Reading Jakub's results of the git survey instigated me to investigate
when msysGit was born (under a different name...).  We had a tremendous
progress since, and it almost felt as two years had gone by since I
started this thing.

Alas, the first commit I ever made on my mingw branch was on
Tue Jun 20 19:13:02 2006 +0200

A long time nevertheless.  From the commit messages I found that the
first time I fixed a test -- which is my best indicator that I got
something running; I did not manifest a "Hooray, first time it
_does_ something" in any commit message -- was on
Tue Sep 19 15:11:29 2006 +0200

So it took me two months, on and off, to get it to run.  Of course, this
version was so lousy that it was only barely self-hosting.  Since I could
not get vi to run on my MinGW setup, I did the commits using -m.

I also had not found out yet that bash in an Rxvt was not able to call
"less" properly, and I had to pipe "git log | less" to stop the output
from whizzing by as fast as Douglas Adams' deadlines.

Reading further in my logs, I stopped working on my mingw branch on
Wed Sep 20 17:38:35 2006 +0200, certainly because I did not feel the
need, and the major obstacles had been tackled, and I got bored with it.
Or my boss made me work for a change.  Something along those lines.

All the better for the many eager Windows users that Hannes Sixt took
up the ball, and committed his first version on Fri Dec 22 11:43:50
2006 +0100, although you can see in the logs that it was recommitted
(for the last time, I guess) on Fri Jan 19 16:21:41 2007 +0100.

Since then, he made steady progress, with a few helpers helping out
from time to time.

The next big turn was the kick off of the msysGit project... the rest
is history.
