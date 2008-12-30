From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 22:55:38 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D33@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnWK-0007n4-QM
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYL3Wzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYL3Wzm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:55:42 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:29705 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752066AbYL3Wzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 17:55:41 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
thread-index: AclqzFR8U2w7fMx1R52tkeYeSgp6YQAA11tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104220>

Whoa there Stevey, I'm a windows user, don't forget

I mighta had a chance at following this 10-12 years ago when last I did
some scripting, but not now

Its very generous of you to go to all this bother and I'm mighty
grateful. 

However if this is what its gonna take to get what I want, then Im'
outta here.

Getting a snapshot on the filesystem, in terms of a directory tree (not
a reference to, representation of etc etc. but a real life directory
tree, files and folders that you can actually interact with - build,
edit etc.), of a past version is a basic operation in my book.
Even in clearcase this was a cinch.

Is there anyone who can see anyway to do this simply, without a script,
without creating a branch ?

Personally I suspect "$ git checkout <version> ." is what should be
doing this (I have confidence in saying this because it seems to want to
do this, and does it right at least half the time). But no-one wants to
admit to the remotest possibility that it might be off ....

In any case, a bunch of smart guys like you should be able to knock this
functionality together in hours, if you put your mind to it.

I know you guys have put a lot into this project and for many of you it
defines who you are 
- but if you want ppl out there in the user world to take this stuff on,
its gotta work for them 

<END>impassioned plea</>

-----Original Message-----
From: Boyd Stephen Smith Jr. [mailto:bss@iguanasuicide.net] 
Sent: 30 December 2008 22:17
To: Conor Rafferty
Cc: git@vger.kernel.org
Subject: Re: for newbs = little exercise / tutorial / warmup for windows
and other non-sophisticated new Git users :-) [Scanned]

On Tuesday 2008 December 30 15:49:22 Boyd Stephen Smith Jr. wrote:
> On Tuesday 2008 December 30 15:27:33 you wrote:
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ git status # On branch 
> > master nothing to commit (working directory clean)
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ git checkout versionA .
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ ls ABC.txt  AC.txt
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ rm *.*
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ git checkout versionB .
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj $ ls ABC.txt  AC.txt  BC.txt
>
> Not a bug.  git checkout <commit> <paths> does not delete files by
design.
> Try using "git checkout versionB" instead (no paths specified), and it

> will properly remove AC.txt from your working tree as well as warning 
> you that "You're Doing It Wrong" (tm).

This may be what you want:
(commands)
mkdir test && cd test && git init &&

echo 'ABC' > ABC.txt && echo 'AC' > AC.txt && echo 'BC' > BC.txt && echo
'C' > C.txt &&

find -name '*C*' -print0 | xargs -r0 -- git add -- && git commit -m '"C"
files.' && git branch versionC master &&

git checkout -b versionA master &&
find -type f -not -wholename '*.git*' -not -name '*A*' -print0 | \
	xargs -r0 -- git rm -- &&
git commit -m 'Removed non-"A" files.' &&

git checkout -b versionB &&
find -type f -not -wholename '*.git*' -not -name '*B*' -print0 | \
	xargs -r0 -- git rm -- &&
git commit -m 'Removed non-"B" files.' &&

git checkout -b versionD master &&
find -type f -not -wholename '*.git*' -not -name '*D*' -print0 | \
	xargs -r0 -- git rm -- && git commit -m 'Removed non-"D" files.'
&&

git checkout master && git branch -v --abbrev=4 && ls -l && git checkout
versionA && ls -l && git checkout versionB && ls -l && git checkout
versionC && ls -l && git checkout versionD && ls -l

(output)
/home/bss/test
Initialized empty Git repository in /home/bss/test/.git/ Created initial
commit 8dbf3a1: All files.
 4 files changed, 4 insertions(+), 0 deletions(-)  create mode 100644
ABC.txt  create mode 100644 AC.txt  create mode 100644 BC.txt  create
mode 100644 C.txt Switched to a new branch "versionA"
rm 'BC.txt'
rm 'C.txt'
Created commit a06e10c: Removed non-"A" files.
 2 files changed, 0 insertions(+), 2 deletions(-)  delete mode 100644
BC.txt  delete mode 100644 C.txt Switched to a new branch "versionB"
rm 'AC.txt'
Created commit 2029ca2: Removed non-"B" files.
 1 files changed, 0 insertions(+), 1 deletions(-)  delete mode 100644
AC.txt Switched to a new branch "versionD"
rm 'ABC.txt'
rm 'AC.txt'
rm 'BC.txt'
rm 'C.txt'
Created commit 1793ba0: Removed non-"D" files.
 4 files changed, 0 insertions(+), 4 deletions(-)  delete mode 100644
ABC.txt  delete mode 100644 AC.txt  delete mode 100644 BC.txt  delete
mode 100644 C.txt Switched to branch "master"
* master   8dbf "C" files.
  versionA a06e Removed non-"A" files.
  versionB 2029 Removed non-"B" files.
  versionC 8dbf "C" files.
  versionD 1793 Removed non-"D" files.
total 16
-rw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
-rw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt
-rw-r--r-- 1 bss users 3 2008-12-30 16:10 BC.txt
-rw-r--r-- 1 bss users 2 2008-12-30 16:10 C.txt Switched to branch
"versionA"
total 8
-rw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
-rw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt Switched to branch
"versionB"
total 4
-rw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt Switched to branch
"versionC"
total 16
-rw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
-rw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt
-rw-r--r-- 1 bss users 3 2008-12-30 16:10 BC.txt
-rw-r--r-- 1 bss users 2 2008-12-30 16:10 C.txt Switched to branch
"versionD"
total 0
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
