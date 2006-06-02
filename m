From: Keith Packard <keithp@keithp.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 01 Jun 2006 19:07:55 -0700
Message-ID: <1149214075.5521.31.camel@neko.keithp.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SQ2P4ccl99vCOcocrTOM"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 04:08:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flz5F-0003TY-EZ
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 04:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFBCIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 22:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFBCIK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 22:08:10 -0400
Received: from home.keithp.com ([63.227.221.253]:30220 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751117AbWFBCIJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 22:08:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DF9C5130023;
	Thu,  1 Jun 2006 19:08:05 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 23176-03; Thu, 1 Jun 2006 19:08:05 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 8326D130020; Thu,  1 Jun 2006 19:08:05 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 79AB514001;
	Thu,  1 Jun 2006 19:08:05 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id A5E696AC1B1; Thu,  1 Jun 2006 19:07:55 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21134>


--=-SQ2P4ccl99vCOcocrTOM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-01 at 20:55 -0400, Jon Smirl wrote:
> With the attached patch you can parse the entire Mozilla tree. The
> tree has over 100,000 files in it and about 300 branches.

that's good news.

> I ran this overnight and it failed with out of memory on a 1GB machine
> with 1GB swap. If failed in the branch processing, the parse phase
> succeeded.

yeah, parsecvs has some internal storage inefficiencies which need to be
addressed. In particular, every commit has a pointer to the related
revision of every file in the commit. Much like git used to store every
filename in the commit object and was changed to share common directory
contents, parsecvs should be fixed to do the same.

> How much memory does something like this need?

It's basically 4 * nrev * nfile bytes on a 32-bit machine, multiply by 2
for a 64-bit machine.

> If you want to quickly check out the branch processing problems use
> rsync to pull down just a copy of repository files.
>=20
> I am getting 1000s of warnings like these and I haven't figured out why y=
et.
>=20
> Warning: ../mozilla/mozilla/build/mac/build_scripts/Attic/MozillaCheckout=
List.txt,v:
> unnamed branch from master
> Warning: ../mozilla/mozilla/build/unix/run-mozilla.sh,v: unnamed
> branch from master
> Warning: ../mozilla/mozilla/Makefile.in,v: unnamed branch from master of =
99855
> Warning: ../mozilla/mozilla/Makefile.in,v: unnamed branch from master
> Warning: ../mozilla/mozilla/allmakefiles.sh,v: unnamed branch from master=
99855
> Warning: ../mozilla/mozilla/allmakefiles.sh,v: unnamed branch from master
> Warning: ../mozilla/mozilla/cmd/macfe/MailNews/AddressBook/Attic/UAddress=
BookUtilities.cp,v:
> unnamed branch from master
> Warning: ../mozilla/mozilla/cmd/macfe/MailNews/AddressBook/Attic/UAddress=
BookUtilities.h,v:
> unnamed branch from master
> Warning: ../mozilla/mozilla/cmd/macfe/central/Attic/msv2dsk.cp,v:
> unnamed branch from master

yeah, these happen when vendor branches go awry. I'll pull the
repository and take a look. X.org had similar 'issues' as the current
CVS repo was built by merging mesa, XFree86 and X.org together in a
rather haphazard fashion.

--=20
keith.packard@intel.com

--=-SQ2P4ccl99vCOcocrTOM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEf517Qp8BWwlsTdMRAk4/AJ0cF7OpEdz1zEFs0fFeYX8At7aHwACg5tZO
2AMeRJ6KMAG39xFDJmkUgv4=
=vbUZ
-----END PGP SIGNATURE-----

--=-SQ2P4ccl99vCOcocrTOM--
