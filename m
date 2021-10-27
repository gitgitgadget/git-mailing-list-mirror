Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB457C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BCC61039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhJ0TGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:06:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:39779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhJ0TGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635361431;
        bh=yVM4e/8UNBAy37TBdbIHD5SzJHH5gJuFWAOilOmJ9co=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=ctqYSIOfenRNBOE+CyR8dmQqvhHjGDS6dQhT/+VtsmTot570IB1ci1aUV8E9eyrDr
         0nYg4O76BfZ4HUKipGnAc/C1mj/J+EhqRMqxNEP4gob01Y1v8mBRX8+PJLRSOb5vHf
         EVb67DMXiJBzPQjuZPjeqzokebO+ccsj/9LfhjSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.9.46] ([62.202.180.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1mr2T62qGx-00yOr9 for
 <git@vger.kernel.org>; Wed, 27 Oct 2021 21:03:51 +0200
To:     Git Mailinglist <git@vger.kernel.org>
From:   Peter Hunkeler <phunsoft@gmx.net>
Subject: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
Message-ID: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
Date:   Wed, 27 Oct 2021 21:03:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:E4fw98v29D4k5tdWHsxtCalZSZ9Wa80IbaZkxnxwhUHjjqUosn1
 dax9qP8+MMoSmxp88vAnT2/O8UO/WXH3J2+mVcGmknvNCRqexm7lFt/IWY0T3rDmEjY+yF7
 1HmUUZt7B8xYiaAeRSmqEH14RRGjaJoU+8F6BZGYktkA4zPS5oydhoANsakRI3z3lZaWQQ0
 +Akp5Voi0+QwsTrCJUQ4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/cFhET45ZpI=:3NHMoLeYupZfKGTihBo7Z1
 O1zlmC9fkSl1n7MB9joClN7Dq/glrfKjZqhO6yVjGP3lfrD8aTW33qhH7v8Ho0cxct/RkAnJH
 XWKcBM7LOuV7D4I6mykK2N0tBssg9WtXMmsBY7gGHrUCIOB0D14dB/zVRN3DEOj7T/Nk9G0zt
 ITlRatMbhfiJsaaBHgq11JQz6ykh2Q1Cbi9iWXWXunkSfkXhfCLasmQ+huKGjoepeK+qho51T
 rhyH/d1Al77n0t9DbrZLhsPueZWm0hwpw1Q/7oSOmNgNdZS4YgiXKl3s3bMytK878NJwO6E5W
 nPN5o5CFxK05PRQRbzpy+WkPr8aZ8bKvCPL0wn7kVLPMyqyDisransoia94wrM5SFUdDVvXTP
 emAMkpoQr7pgxFWLn45M6o0UMp0q+/Y3CK9a+8G1n162CcRzSLDaMWdJRfpR3A9mjAYdmN7Yk
 or73Wd93x6prc+TWnEucHPi3vEU0maoZIpaVjtMOiNxuqmvBiTek3f1Qc/c50UcKSJPlfXg99
 FBqzMKKFPSftVtN22/a2aSOrm+etRfLyZZP1f9KZRFWh/GkisoZlYoLaKH+QW3Bt8uzV9G7pz
 vwnGa9VV7J5eln4imdD1Sg665ApURPvpJSDSYWE1CA9wmpCiUr0Gybt3IbDnBphyQQg1Lccpu
 CsTUG48KnKT+lMRalFf/fsJxdnI6vO+APWkLnFsBQkzEKYujtXAdAzClWjhsdZQdiiasDnm2K
 YtRoFemrrNNXvSApv+UXYsgXabCt58cAg7Rv0geCGMb4GngYhBBU+XNTSFJdV8BSNarytfCb8
 zfY3iqux0Fr3Nlp/mf9/VrPK0kzgvtgyI5nAjov5ANtlsvo4mqwIp4bY7PnaOXT87kdBee6SL
 S9WaqAylo4G8V2WJlH2O6fErFxIDWlXD/vfXsoCPilJJ1xCbCltD13j93BFXjijr4A9Yrct7Z
 8nBroN2EliWuIN/Yoaez3MZCmdMxAMxj/emagEe0GlJELtKIvF8R3lnHeXozdMDXpuzy0Ik53
 9cBv9CtFQESntiydWI3S+z4bTGs9UW2f5FS0Z5O/13x567/pKArwKvUOFTPBM4RujcVDHMIfa
 JLUN2xL7E/Nibk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Git seems to behave inconsistently when creating and "git add"ing
content (files) from within a pre-commit hook. It claims there is
"nothing to commit", if the stating area was empty before the commit
command. Otherwise, the new content becomes part of the commit. See
details on how to reproduce and a log of the individual steps below.

Regards
Peter


=3D=3D=3D Amended Git bug report
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I'm quite new to using git, so please bear with me should I mix up some
terminology.

I need some new file to be created at each commit. The new file must
become part of the commit.
I thought a git pre-commit hook would be the appropriate place. While
the file is created as desired,
git does *not* include this new file in the commit, when there is
nothing else in the staging area. It
reports the new file as being untracked, and says nothing added to
commit. A git status immediately
thereafter does, however, show the new file in the staging area. If I
run another commit just now, another
new file is created as expected, but this time, git adds them both to
the commit. This can be reliably
reproduced by repeating 'git commit -m "empty"', and every second time,
the commit is done.

Further testing shows that the newly created file *is* added to the
commit, *if* at least one other change
was registered to be commited (git add some time before the git commit).

Same behaviour, if two files are created and added withing the
pre-commit hook. Both files are added to
the commit only every second time, or if some other change does exist in
the staging area before the commit
command.

The git pre-commit hook looks like this (indented for readability, only):
 =C2=A0=C2=A0=C2=A0 #!/bin/bash
 =C2=A0=C2=A0=C2=A0 fn=3D"folder1\folder1_file3_$(date +%Y%m%d_%H%M%S).txt=
"
 =C2=A0=C2=A0=C2=A0 echo "some text" > $fn
 =C2=A0=C2=A0=C2=A0 git add $fn

Note: This testing was done on Windows 10, but initially, I detected
this on a server running Linux.






What did you expect to happen? (Expected behavior)

I expect the file created and added from within the git pre-commit hook
to become part of the commit
no matter whether there are or aren't any other changes in the staging
are, i.e. added beforehand.




What happened instead? (Actual behavior)

File created and 'git added' from within the pre-commit hook shell
script is *not* added to the current
commit, if there are no other changes in the staging area.

The behaviour is inconsistent. If it is allowed to do a "git add" from
within a pre-commit hook (is it allowed?),
then file added must become part of the commit irrespective of whether
or not there are other changes in the
staging area that have been there *before* the commit command was
issued. Else git should reject the "git add"
(and other commands) from within the pre-commit hook.

What's different between what you expected and what actually happened?

see above,






Anything else you want to add:

I'm adding the log from a terminal session where I reproduce the
behaviour below, limited by a line
of '=3D' signs. Individual commands are separated by a line of '-' signs
with a comment what the next step
will be.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


=2D-- content of directory before git init
=2D--------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ ls -lR
.:
total 6
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file1.txt
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file2.txt
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:19 folder1/
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:16 git-hook-saved/

./folder1:
total 2
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:58 folder1_file1.txt
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:58 folder1_file2.txt

./git-hook-saved:
total 1
-rwxr-xr-x 1 Peter 197121 111 Oct 25 14:21 pre-commit*


=2D-- git init
=2D----------------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing
$ git init
Initialized empty Git repository in D:/Temp/git-testing/.git/


=2D-- git initial status
=2D------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master

No commits yet

Untracked files:
 =C2=A0 (use "git add <file>..." to include in what will be committed)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file1.txt
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file2.txt
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folder1/
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git-hook-saved/

nothing added to commit but untracked files present (use "git add" to trac=
k)


=2D-- adding all initial data to the staging area
=2D--------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git add "*"


=2D-- commiting initial data
=2D-----------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "initial commit"
[master (root-commit) 4daefe7] initial commit
 =C2=A05 files changed, 12 insertions(+)
 =C2=A0create mode 100644 file1.txt
 =C2=A0create mode 100644 file2.txt
 =C2=A0create mode 100644 folder1/folder1_file1.txt
 =C2=A0create mode 100644 folder1/folder1_file2.txt
 =C2=A0create mode 100644 git-hook-saved/pre-commit


=2D-- Show status after initial commit
=2D----------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
nothing to commit, working tree clean


=2D-- Install git pre-commit hook, then do an empty commit
=2D------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "empty 1"
warning: LF will be replaced by CRLF in
folder1/folder1_file3_20211025_142454.txt.
The file will have its original line endings in your working directory
On branch master
Untracked files:
 =C2=A0 (use "git add <file>..." to include in what will be committed)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folder1/folder1_file3_20211025=
_142454.txt

nothing added to commit but untracked files present (use "git add" to trac=
k)


=2D-- Show whats in the file system at this point in time
=2D------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ ls -lR
.:
total 6
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file1.txt
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file2.txt
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:24 folder1/
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:16 git-hook-saved/

./folder1:
total 3
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file1.txt
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file2.txt
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:24 folder1_file3_20211025_142454.tx=
t

./git-hook-saved:
total 1
-rwxr-xr-x 1 Peter 197121 111 Oct 25 14:21 pre-commit


=2D-- What is the status of git? The "add" from the hook did
work!------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
Changes to be committed:
 =C2=A0 (use "git restore --staged <file>..." to unstage)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new file:=C2=A0=C2=A0 folder1/=
folder1_file3_20211025_142454.txt


=2D-- Immediately do another (not really empty) git commit
=2D------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "empty 2"
warning: LF will be replaced by CRLF in
folder1/folder1_file3_20211025_142554.txt.
The file will have its original line endings in your working directory
[master e9809aa] empty 2
 =C2=A02 files changed, 2 insertions(+)
 =C2=A0create mode 100644 folder1/folder1_file3_20211025_142454.txt
 =C2=A0create mode 100644 folder1/folder1_file3_20211025_142554.txt


=2D-- Show whats in the file system at this point in time
=2D------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ ls -lR
.:
total 6
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file1.txt
-rw-r--r-- 1 Peter 197121 9 Oct 25 13:55 file2.txt
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:25 folder1/
drwxr-xr-x 1 Peter 197121 0 Oct 25 14:16 git-hook-saved/

./folder1:
total 4
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file1.txt
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file2.txt
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:24 folder1_file3_20211025_142454.tx=
t
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:25 folder1_file3_20211025_142554.tx=
t

./git-hook-saved:
total 1
-rwxr-xr-x 1 Peter 197121 111 Oct 25 14:21 pre-commit


=2D-- Once more, this time really an "empty" commit again.
=2D-----------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "empty 3"
warning: LF will be replaced by CRLF in
folder1/folder1_file3_20211025_142645.txt.
The file will have its original line endings in your working directory
On branch master
Untracked files:
 =C2=A0 (use "git add <file>..." to include in what will be committed)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folder1/folder1_file3_20211025=
_142645.txt

nothing added to commit but untracked files present (use "git add" to trac=
k)


=2D-- Show the status, same behaviour again.
=2D--------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
Changes to be committed:
 =C2=A0 (use "git restore --staged <file>..." to unstage)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new file:=C2=A0=C2=A0 folder1/=
folder1_file3_20211025_142645.txt


=2D-- Yet another commit immediately thereafter
=2D--------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "empty 4"
warning: LF will be replaced by CRLF in
folder1/folder1_file3_20211025_142659.txt.
The file will have its original line endings in your working directory
[master 032a58e] empty 4
 =C2=A02 files changed, 2 insertions(+)
 =C2=A0create mode 100644 folder1/folder1_file3_20211025_142645.txt
 =C2=A0create mode 100644 folder1/folder1_file3_20211025_142659.txt


=2D-- Status?
=2D--------------------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
nothing to commit, working tree clean


=2D-- Content of filesystem
=2D--------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ ls -lR
.:
total 7
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:55 file1.txt
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:55 file2.txt
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:27 file3.txt
drwxr-xr-x 1 Peter 197121=C2=A0 0 Oct 25 14:28 folder1/
drwxr-xr-x 1 Peter 197121=C2=A0 0 Oct 25 14:16 git-hook-saved/

./folder1:
total 7
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file1.txt
-rw-r--r-- 1 Peter 197121=C2=A0 9 Oct 25 13:58 folder1_file2.txt
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:24 folder1_file3_20211025_142454.tx=
t
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:25 folder1_file3_20211025_142554.tx=
t
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:26 folder1_file3_20211025_142645.tx=
t
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:26 folder1_file3_20211025_142659.tx=
t
-rw-r--r-- 1 Peter 197121 10 Oct 25 14:28 folder1_file3_20211025_142815.tx=
t

./git-hook-saved:
total 1
-rwxr-xr-x 1 Peter 197121 111 Oct 25 14:21 pre-commit


=2D-- Creating a new file outside of hook
=2D-------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ echo "some text" > file3.txt


=2D-- Git status?
=2D-----------------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
Untracked files:
 =C2=A0 (use "git add <file>..." to include in what will be committed)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file3.txt

nothing added to commit but untracked files present (use "git add" to trac=
k)


=2D-- Adding the new file to the staging area
=2D-----------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git add *
warning: LF will be replaced by CRLF in file3.txt.
The file will have its original line endings in your working directory


=2D-- Status again
=2D---------------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
Changes to be committed:
 =C2=A0 (use "git restore --staged <file>..." to unstage)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new file:=C2=A0=C2=A0 file3.tx=
t


=2D-- Committing the new file (and the one created by the pre-commit hook)
=2D-------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git commit -m "one new file present"
warning: LF will be replaced by CRLF in
folder1/folder1_file3_20211025_142815.txt.
The file will have its original line endings in your working directory
[master 4ea47ec] one new file present
 =C2=A02 files changed, 2 insertions(+)
 =C2=A0create mode 100644 file3.txt
 =C2=A0create mode 100644 folder1/folder1_file3_20211025_142815.txt


=2D-- Status?
=2D-------------------------------------------------------------------
Peter@MySystem MINGW64 /d/Temp/git-testing (master)
$ git status
On branch master
nothing to commit, working tree clean



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D








Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.32.0.windows.2
cpu: x86_64
built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Programme
Non-UAC\Git\usr\bin\bash.exe


[Enabled Hooks]
pre-commit

