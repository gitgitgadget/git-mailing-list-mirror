From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix dependencies of parse-options test program
Date: Wed, 14 Nov 2007 09:48:19 +0100
Message-ID: <20071114084819.GA18926@artemis.corp>
References: <20071113231636.GJ3268@steel.home> <Pine.LNX.4.64.0711132345310.4362@racer.site> <20071114000833.GC22836@artemis.corp> <Pine.LNX.4.64.0711140012210.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="FCuugMFkClbJLl1L";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsDvL-0008J2-RI
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXKNIsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbXKNIsX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:48:23 -0500
Received: from pan.madism.org ([88.191.52.104]:59413 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbXKNIsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:48:22 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BE5C228AE2;
	Wed, 14 Nov 2007 09:48:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6647FD24B; Wed, 14 Nov 2007 09:48:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711140012210.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64962>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2007 at 12:12:49AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 14 Nov 2007, Pierre Habouzit wrote:
>=20
> > On Tue, Nov 13, 2007 at 11:46:20PM +0000, Johannes Schindelin wrote:
> >=20
> > > apparently I forgot to send this patch, which I thought was only=20
> > > relevant in the builtin-commit branch of mine:
> >=20
> >   Btw is there a reason why git doesn't use the gcc -M* options to have
> > proper dependency informations ?
>=20
> I suspect the reason is that we do not want to depend on gcc...

  right, but like said, other compilers can generate them, only with a
different CLI switch, and non withstanding this problem, there are tools
to generate such kind of information easily.

  Though for those who care about this issue, this is hackable easily
using config.mak, here is how:

    CFLAGS +=3D -MMD -MF $(@D)/.$(@F:.o=3D.dep)
    -include $(wildcard .*.dep */.*.dep) GIT-VERSION-FILE

It's a quick hack, but allow gcc + gnu make (I believe $(@D) is GNU)
users not to be bitten hard by those dependency issues.

The reason why I include GIT-VERSION-FILE again is that many make
complain if -include gets an empty like as an argument, and passing
/dev/null on certains occasions triggers warnings about /dev/null having
a date in the future on some machines for a reason I never found.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOrZTvGr7W6HudhwRAqgUAJ9Hjk3y/ko97uj88y6/FGuE4YlaSwCgo3hd
/K/TzNqbeMqFodqZ6r6U7Rk=
=o5Ql
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
