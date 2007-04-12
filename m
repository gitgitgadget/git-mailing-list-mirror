From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: One more shallow tree weirdness - tag not pulled?
Date: Wed, 11 Apr 2007 18:16:16 -0700
Message-ID: <20070412011616.GB18378@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 03:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbnv6-0001iC-OH
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 03:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbXDLBQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 21:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbXDLBQN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 21:16:13 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:43177 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161434AbXDLBQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 21:16:13 -0400
Received: (qmail 28648 invoked from network); 12 Apr 2007 01:16:12 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 12 Apr 2007 01:16:12 +0000
Received: (qmail 25921 invoked by uid 10000); 11 Apr 2007 18:16:16 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44301>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One other bit of weirdness I ran into.  On a shallow clone that is extended=
 to
full depth, there is a tag missing (that was in the non-shallow clone).

Testcase
> git clone git://git.kernel.org/pub/scm/git/git.git git-0
> git clone --depth 1 git://git.kernel.org/pub/scm/git/git.git git-1
> cd git-1 && git pull --depth 10000000

Now the content of git-0 and git-1 should be functionally identical, but
it's not.

I created 'git-$N.list' with:
find git-$N ! -type d  | sort |egrep -v '\.git/(objects/pack/|index$|logs/)=
' \
 | tr '\n' '\0' | xargs -0 md5sum | sed 's,git-$N/,,g' >git-$N.list

--- git-0.list	2007-04-11 18:12:25.000000000 -0700
+++ git-1.list	2007-04-11 18:12:32.000000000 -0700
@@ -28,7 +28,6 @@
 bc94cbd02df32d07b7fd230d7aba42e8  .git/refs/tags/gitgui-0.6.3
 91521cca8d3f177e2f0cb4a586dac6be  .git/refs/tags/gitgui-0.6.4
 c56d1ac72d959f87ba0dd92721de36de  .git/refs/tags/gitgui-0.6.5
-b9c7a4533d41dfedd0a0d23bbfb3fed8  .git/refs/tags/junio-gpg-pub
 43ceb81bf4c131a8a882025a676aa22e  .git/refs/tags/v0.99
 072e3055bf33ff1ba5aa4697f2b539fb  .git/refs/tags/v0.99.1
 85916310d7d0a86818033ac95f32b234  .git/refs/tags/v0.99.2

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGHYhgPpIsIjIzwiwRAtFKAJ46ecU5E+lNkGYUGkvwR3AVLCzLgQCeIq8X
0LBdeYWrac/vQixjVQpQKVI=
=4/Uz
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
