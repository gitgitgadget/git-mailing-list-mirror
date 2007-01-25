From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Thu, 25 Jan 2007 17:24:49 +0100
Message-ID: <45B8D9D1.2000802@fs.ei.tum.de>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org> <45B8C032.7020004@fs.ei.tum.de> <20070125150536.GA8314@cepheus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E8E7FA0280D2C610B3B0E64"
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 17:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7Pt-00011W-Az
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbXAYQY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbXAYQY7
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:24:59 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:36430 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030304AbXAYQY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:24:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 15BAE281D0;
	Thu, 25 Jan 2007 17:24:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QvBknMp8ohre; Thu, 25 Jan 2007 17:24:55 +0100 (CET)
Received: from [62.216.203.191] (ppp-62-216-203-191.dynamic.mnet-online.de [62.216.203.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 4A25A281CE;
	Thu, 25 Jan 2007 17:24:55 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070125150536.GA8314@cepheus>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37736>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E8E7FA0280D2C610B3B0E64
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig wrote:
> I don't know ruby nor hg, but I managed to clone your repo.  Now I'm
> stuck with:
>=20
> 	zeisberg@cepheus:~/hsrc/fromcvs$ ruby1.8 fromcvs.rb=20
> 	fromcvs.rb:1:in `require': no such file to load -- rcsfile (LoadError)=

> 	        from fromcvs.rb:1

yes, you need the rcsparse module, available from the same address.

> Is there some documentation how to get that to work?

I've written it a million times to different people on irc, but somehow I=
 never got around to making a README out of it.  I'll write it up very co=
ndensed here and add this as a base for a README to the the repo.

=46rom CVS to * in little time
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Prerequisites:
  - ruby (1.8.5 known working)
  - fromcvs, <http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs>
  - rcsparse, <http://ww2.fs.ei.tum.de/~corecode/hg/rcsparse> (ruby modul=
e)
  - Ruby/RBTree, <http://raa.ruby-lang.org/project/ruby-rbtree/>
  - for git: git-fast-import, <git://repo.or.cz/git/fastimport.git/>
  - for hg: ruby-python, <http://ww2.fs.ei.tum.de/~corecode/hg/ruby-pytho=
n>


How to convert a CVS repo:

There is still a nice frontend missing, so you have to invoke the scripts=
 by hand.

% mkdir gitdest && (cd gitdest && git init)
% ruby togit.rb /path/to/cvsroot modulename gitdest
% cd gitdest && git-repack -a -f -d      # optional, saves 20% or so

If you want to get nice author names, create setup the file authormap:

cat > /path/to/cvsroot/CVSROOT/authormap
corecode	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
jdoe		Jon H. Doe <hannidoe@example.net>
branch-fixup	CVS repo conversion <flames@example.net>

that's about for the quickstart.  be sure to report conversion errors or =
runtime issues (possibly due to obscure CVS repo activity) to me.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig8E8E7FA0280D2C610B3B0E64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuNnTr5S+dk6z85oRAoF8AJ4xZ5Hxtk05x4Nrzye09Rnej2P8iwCeJCoF
KdQ1EBAa4GT4Fq+8QLiM/tA=
=sSAd
-----END PGP SIGNATURE-----

--------------enig8E8E7FA0280D2C610B3B0E64--
