From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: StGIT: "ghost" branch (unable to either create or delete)
Date: Mon, 15 Feb 2010 22:22:55 +0300
Message-ID: <201002152223.00871.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5467690.RNSZUvnzxc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 20:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh6nU-0001b7-VU
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 20:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab0BOTjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 14:39:51 -0500
Received: from fallback1.mail.ru ([94.100.176.18]:33362 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab0BOTjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 14:39:51 -0500
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2010 14:39:50 EST
Received: from mx71.mail.ru (mx71.mail.ru [94.100.176.85])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id 13A1519773E
	for <git@vger.kernel.org>; Mon, 15 Feb 2010 22:23:40 +0300 (MSK)
Received: from [91.77.253.190] (port=49357 helo=cooker.localnet)
	by mx71.mail.ru with asmtp 
	id 1Nh6XD-0006H1-00; Mon, 15 Feb 2010 22:23:08 +0300
User-Agent: KMail/1.13.0 (Linux/2.6.33-desktop-0.rc8.1mnb; KDE/4.4.0; x86_64; ; )
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140025>

--nextPart5467690.RNSZUvnzxc
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

{pts/1}% stg branch --delete --force tmp
Deleting branch "tmp" ... stg branch: Branch "tmp" not initialised
{pts/1}% stg branch --clone tmp
Checking for changes in the working directory ... done
Cloning current branch to "tmp" ... stg branch: tmp already initialized


I am not sure exactly how it happened. Using 0.14.3 and up-to-date GIY=20
recently I started to get "git failed with code 128" for large number of=20
operations. Apparently this resulted in sort of "ghost" branch that=20
cannot be deleted but cannot be worked with either

{pts/1}% stg branch -c tmp
Checking for changes in the working directory ... done
Recording as a local branch                          =20
Branch "tmp" created                                 =20
{pts/1}% stg branch -l
Available branches:  =20
  s     initscripts  |=20
  s     local-mdv    |=20
        master       |=20
        mdv          |=20
> s     tmp          |=20
{pts/1}% stg branch local-mdv
Checking for changes in the working directory ... done
Switching to branch "local-mdv" ... done             =20
{pts/1}% stg branch --delete tmp
Deleting branch "tmp" ...      =20
  stg branch: git failed with code 128
{pts/1}% stg branch -l         =20
Available branches:            =20
  s     initscripts  |         =20
> s     local-mdv    |         =20
        master       |         =20
        mdv          |         =20
{pts/1}% stg branch --clone tmp
Checking for changes in the working directory ... done
Cloning current branch to "tmp" ...                  =20
  stg branch: tmp already initialized                =20

And now I have

{pts/1}% cat .git/config
[core]                 =20
        repositoryformatversion =3D 0
        filemode =3D true           =20
        bare =3D false              =20
        logallrefupdates =3D true   =20
[remote "origin"]                 =20
        fetch =3D +refs/heads/*:refs/remotes/origin/*
        url =3D ssh://git.mandriva.com/projects/networkmanager.git
[branch "master"]                                              =20
        remote =3D origin                                        =20
        merge =3D refs/heads/master                              =20
[branch "initscripts.stgit"]                                   =20
        parentbranch =3D mdv                                     =20
        stackformatversion =3D 2                                 =20
[branch "local-mdv.stgit"]                                     =20
        parentbranch =3D mdv                                     =20
        stackformatversion =3D 2                                 =20
[remote "upstream"]                                            =20
        url =3D=20
git://anongit.freedesktop.org/NetworkManager/NetworkManager.git
        fetch =3D +refs/heads/*:refs/remotes/upstream/*                    =
   =20
[branch "tmp.stgit"]                                                       =
 =20
        parentbranch =3D local-mdv                                         =
   =20
        stackformatversion =3D 2                                           =
   =20

I would expect, stgit branch --delete --force to allow cleanups from=20
such cases.

--nextPart5467690.RNSZUvnzxc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkt5nxAACgkQR6LMutpd94yWgACfUEin3EUFf5yShx+V1a2QkEJq
7KIAniKmNJG/pngugbPnLgbrRw6wOti6
=ROgS
-----END PGP SIGNATURE-----

--nextPart5467690.RNSZUvnzxc--
