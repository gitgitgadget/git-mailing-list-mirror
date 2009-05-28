From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Git, Debian and development against xf86-video-intel
Date: Thu, 28 May 2009 16:39:33 +0200
Message-ID: <1243521573.944.170.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-m7NPdRl+oAZ6N+j933EU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 22:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mYe-00063r-U3
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764839AbZE1UtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764815AbZE1UtS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:49:18 -0400
Received: from b186.blue.fastwebserver.de ([62.141.42.186]:50667 "EHLO
	mail.gw90.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764821AbZE1UtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:49:16 -0400
X-Greylist: delayed 22176 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2009 16:49:16 EDT
Received: from f053034254.adsl.alicedsl.de ([78.53.34.254] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1M9glg-0007cm-7K
	for git@vger.kernel.org; Thu, 28 May 2009 14:39:40 +0000
X-Mailer: Evolution 2.26.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120227>


--=-m7NPdRl+oAZ6N+j933EU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear list readers,


I sent this message to the xorg list but did not get an answer [3]. I
adapted this message a little bit.

I have some patches against xf86-video-intel 2.3.2 [4], which is the
version in Debian Lenny. Ultimately these should be integrated upstream,
so probably in version 2.7.x.

The developer of the patch is using Debian Lenny and therefore it would
be convenient to be able to build always a Debian package to be able to
test the patches.

My question is: =E2=80=9CHow is your repository setup?=E2=80=9D or =E2=80=
=9CHow do you do
this?=E2=80=9D.

The Debian Git repository is available [1] and of course the xorg one
too [2].

*One problem is, that the Debian branch includes some patches in debian/
which do not apply cleanly anymore after changing the Intel sources.
Therefore it is not so easy to just merge to branches!*

1. One suggestion I got from Tobias Grimm was to do the following.

git init
git remote add xorg git://anongit.freedesktop.org/xorg/driver/xf86-video-in=
tel
git remote add debian git://git.debian.org/git/pkg-xorg/driver/xserver-xorg=
-video-intel
git fetch debian ; git fetch --tags debian
git fetch xorg ; git fetch --tags xorg
# there are some minor discrepancies between the tags
git br frc-patch xorg/master
git br frc-debian-lenny debian/debian-lenny
# publish the branches on a server

Then develop against one branch (probably debian-lenny the patches are
based on) and cherry-pick them into master.

2. One other way is to only use the Debian Git repository because it
tracks the xorg branches.

git clone git://git.debian.org/git/pkg-xorg/driver/xserver-xorg-video-intel
git checkout --track origin/upstream-lenny
# apply patches against upstream-lenny
git checkout --track origin/debian-lenny
git merge upstream-lenny # rebase does not work
# adapt a Debian specific patch
# publish the branches on a server

3. Or would it be better to directly develop against debian-lenny?

4. What branches should be published? 4? One for upstream version in
Debian Lenny, one to be ready to build for Debian Lenny, one for latest
upstream and one adapted for Debian?

Sorry for this kind of post. But I am no Git expert, so any advice is
much appreciated. I found this post [5] but because of the
Debian/distribution specific stuff it did not solve all my questions.


Thanks,

Paul


[1] http://git.debian.org/?p=3Dpkg-xorg/driver/xserver-xorg-video-intel.git
[2] http://cgit.freedesktop.org/xorg/driver/xf86-video-intel/
[3] http://lists.freedesktop.org/archives/xorg/2009-April/045279.html
[4] http://projects.vdr-developer.org/git/?p=3Dxf86-video-intel-frc.git;a=
=3Dsummary
[5] http://www.gelato.unsw.edu.au/archives/git/0601/15567.html

--=-m7NPdRl+oAZ6N+j933EU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoeoiUACgkQPX1aK2wOHVhMVgCfaXlupdhUgU0RR/4UOKSmczVS
t28An3mqZ6kQFapD1MiPPXwP2x612vsH
=BoyN
-----END PGP SIGNATURE-----

--=-m7NPdRl+oAZ6N+j933EU--
