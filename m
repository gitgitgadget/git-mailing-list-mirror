From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 20:50:50 +0100
Message-ID: <43DFBF9A.2020409@gorzow.mm.pl>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl> <20060129181240.GA11721@kroah.com> <43DFAD91.4080105@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9C678B07CE8BB6377A81760"
Cc: Keith Packard <keithp@keithp.com>, Junio C Hamano <junkio@cox.net>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:51:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F41Wp-0002V9-K6
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWAaTvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWAaTvA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:51:00 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:65504 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751412AbWAaTu7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 14:50:59 -0500
Received: (qmail 16504 invoked from network); 31 Jan 2006 19:50:56 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 31 Jan 2006 19:50:56 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id D6B2417912D;
	Tue, 31 Jan 2006 20:50:55 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Greg KH <greg@kroah.com>
In-Reply-To: <43DFAD91.4080105@gorzow.mm.pl>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15338>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9C678B07CE8BB6377A81760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Radoslaw Szkodzinski wrote:
> Cloning without -l option is much slower - some minutes vs below a minu=
te.
> I could have time(8)d it, but it's no use.
>=20

Make that time(1)d.

Results for the kernel follow. Disc cache has been preheated with find.

git version: 5b2bcc7b2d546c636f79490655b3347acc91d17f
Filesystem: ext3 data=3Dwriteback
Kernel: 2.6.16-rc1-astorm2 (mostly -ck patchset with "hotfix")
Elevator: CFQ

time git clone linux-2.6.git linux-2.6.git.new
Packing 180025 objects

real    8m31.637s
user    3m19.571s
sys     0m42.211s

Extremely bad. The task is mostly cpu-bound.
Made some background applications swap out late in the process.
(that's the cause of the sys time)

time git clone -l linux-2.6.git linux-2.6.git.local
0 blocks

real    0m42.339s
user    0m2.818s
sys     0m4.040s

Good enough for me. Possibly cp -rl of objects and then a checkout.

time cp -rl linux-2.6.git linux-2.6.git.rl

real    0m18.333s
user    0m0.103s
sys     0m1.732s

Really fast, but requires additional file modification.
(namely .git/remotes/origin, removal of gitrc)
Also incompatible with apps having problems with hardlinks.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigA9C678B07CE8BB6377A81760
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD37+flUMEU9HxC6IRAmM2AJ9l6awMJZhumtYdY/tXdEmFKx+XvgCff/UD
Pz8YFDOi3GhOmpWz/YHtqU8=
=4Sdp
-----END PGP SIGNATURE-----

--------------enigA9C678B07CE8BB6377A81760--
