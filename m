From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 16:17:11 -0600
Message-ID: <200812301617.15496.bss@iguanasuicide.net>
References: <gj68a0$u56$3@ger.gmane.org> <gje3ok$gnc$4@ger.gmane.org> <200812301549.26538.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1760929.bbHICcmcIk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmul-0004Db-VW
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYL3WQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYL3WQv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:16:51 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57231 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYL3WQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 17:16:51 -0500
Received: from [206.104.161.8]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHmtO-0005GQ-8T; Tue, 30 Dec 2008 22:16:50 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <200812301549.26538.bss@iguanasuicide.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104215>

--nextPart1760929.bbHICcmcIk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 15:49:22 Boyd Stephen Smith Jr. wrote:
> On Tuesday 2008 December 30 15:27:33 you wrote:
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ git status
> > # On branch master
> > nothing to commit (working directory clean)
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ git checkout versionA .
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ ls
> > ABC.txt  AC.txt
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ rm *.*
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ git checkout versionB .
> >
> > conorr@KINKLADZE /w/GITPLATFORM/swproj
> > $ ls
> > ABC.txt  AC.txt  BC.txt
>
> Not a bug.  git checkout <commit> <paths> does not delete files by design.
> Try using "git checkout versionB" instead (no paths specified), and it wi=
ll
> properly remove AC.txt from your working tree as well as warning you
> that "You're Doing It Wrong" (tm).

This may be what you want:
(commands)
mkdir test && cd test && git init &&

echo 'ABC' > ABC.txt && echo 'AC' > AC.txt &&
echo 'BC' > BC.txt && echo 'C' > C.txt &&

find -name '*C*' -print0 | xargs -r0 -- git add -- &&
git commit -m '"C" files.' && git branch versionC master &&

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
	xargs -r0 -- git rm -- && git commit -m 'Removed non-"D" files.' &&

git checkout master && git branch -v --abbrev=3D4 && ls -l &&
git checkout versionA && ls -l &&
git checkout versionB && ls -l &&
git checkout versionC && ls -l &&
git checkout versionD && ls -l

(output)
/home/bss/test
Initialized empty Git repository in /home/bss/test/.git/
Created initial commit 8dbf3a1: All files.
 4 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 ABC.txt
 create mode 100644 AC.txt
 create mode 100644 BC.txt
 create mode 100644 C.txt
Switched to a new branch "versionA"
rm 'BC.txt'
rm 'C.txt'
Created commit a06e10c: Removed non-"A" files.
 2 files changed, 0 insertions(+), 2 deletions(-)
 delete mode 100644 BC.txt
 delete mode 100644 C.txt
Switched to a new branch "versionB"
rm 'AC.txt'
Created commit 2029ca2: Removed non-"B" files.
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 AC.txt
Switched to a new branch "versionD"
rm 'ABC.txt'
rm 'AC.txt'
rm 'BC.txt'
rm 'C.txt'
Created commit 1793ba0: Removed non-"D" files.
 4 files changed, 0 insertions(+), 4 deletions(-)
 delete mode 100644 ABC.txt
 delete mode 100644 AC.txt
 delete mode 100644 BC.txt
 delete mode 100644 C.txt
Switched to branch "master"
* master   8dbf "C" files.
  versionA a06e Removed non-"A" files.
  versionB 2029 Removed non-"B" files.
  versionC 8dbf "C" files.
  versionD 1793 Removed non-"D" files.
total 16
=2Drw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
=2Drw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt
=2Drw-r--r-- 1 bss users 3 2008-12-30 16:10 BC.txt
=2Drw-r--r-- 1 bss users 2 2008-12-30 16:10 C.txt
Switched to branch "versionA"
total 8
=2Drw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
=2Drw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt
Switched to branch "versionB"
total 4
=2Drw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
Switched to branch "versionC"
total 16
=2Drw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
=2Drw-r--r-- 1 bss users 3 2008-12-30 16:10 AC.txt
=2Drw-r--r-- 1 bss users 3 2008-12-30 16:10 BC.txt
=2Drw-r--r-- 1 bss users 2 2008-12-30 16:10 C.txt
Switched to branch "versionD"
total 0
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1760929.bbHICcmcIk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklanesACgkQdNbfk+86fC3c6ACggP3Y+uZc6S7QXfDFkTr4hS0w
ii8Anig+BB12M8XLZ7wywv6vwnBBxDQY
=c2zY
-----END PGP SIGNATURE-----

--nextPart1760929.bbHICcmcIk--
