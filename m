From: martin f krafft <madduck@madduck.net>
Subject: Re: [TopGit] Multiple concurrent sets of patches
Date: Wed, 4 Mar 2009 08:16:17 +0100
Message-ID: <20090304071617.GA23605@piper.oerlikon.madduck.net>
References: <20090303113741.GO12820@jones.dk> <20090303130316.GA17702@piper.oerlikon.madduck.net> <20090303192221.GV12820@jones.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
To: Jonas Smedegaard <dr@jones.dk>, git@vger.kernel.org, pasky@suse.cz,
	u.kleine-koenig@pengutronix.de
X-From: git-owner@vger.kernel.org Wed Mar 04 08:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LelMq-0001fs-EL
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 08:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbZCDHQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 02:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZCDHQo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 02:16:44 -0500
Received: from clegg.madduck.net ([193.242.105.96]:42191 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZCDHQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 02:16:44 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 364981D409B;
	Wed,  4 Mar 2009 08:16:19 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 199409F16B;
	Wed,  4 Mar 2009 08:16:18 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B1ECA446D; Wed,  4 Mar 2009 08:16:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090303192221.GV12820@jones.dk>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9066/Wed Mar  4 07:03:21 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112187>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jonas Smedegaard <dr@jones.dk> [2009.03.03.2022 +0100]:
> I know that I can create all those TopGit branches one by one, but
> I would then need to explicitly declare a list of TopGit branches
> to apply each time I want to (re)generate a quilt patchlist.

There are two ways to achieve what you want with TopGit. Uwe
outlined one way:

- create a new branch depending on all the patch branches you want
  to use. This is what I advocated for packaging in Debian's topgit
  0.3-1 package:
  http://git.debian.org/?p=3Dcollab-maint/topgit.git;a=3Dblob;f=3Ddebian/RE=
ADME.source;hb=3Ddebian/topgit-0.3-1

- declare the list of patches to use, as you suggest. This is what
  the current tg2quilt.mk approach of Debian's topgit 0.5-1 package
  does.

In the context where you have a single debian/rules file to prepare
a quilt series as part of building your package, I think the latter
makes more sense, as it keeps information in debian/rules and
alleviates the user of repetetive steps.

However, in the special context of a security fix, the suggestion
illustrated by Uwe probably makes a lot more sense. One reason for
this is because it is not yet possible to use TopGit patch branches
of the past, meaning that you can only ever use the tip of each, and
that tg-update basically destroys the infrastructure needed to go
back in time. By creating a special depending branch for the
security fix, however, you are preserving the graph at the time,
which is the tag you were alluding to.

This is what I can add to this discussion. I don't think I have
actually fully understood the scope of the problem yet.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"no work of art ever puts forward views.
 views belong to people
 who are not artists."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmuKsEACgkQIgvIgzMMSnU40ACgj/wNXo2BZO1PkqHBI9uFlQzK
yKkAoLZtdgc2xIFgqYiLyoquF9F8aFek
=DmKt
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
