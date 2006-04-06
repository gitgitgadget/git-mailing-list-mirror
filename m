From: Keith Packard <keithp@keithp.com>
Subject: Re: Fixes to parsecvs
Date: Thu, 06 Apr 2006 07:48:16 -0700
Message-ID: <1144334896.2303.259.camel@neko.keithp.com>
References: <1144305392.2303.240.camel@neko.keithp.com>
	 <20060406120812.GO13324@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YsFbJ1Pv2/hqrdY4fqVt"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 16:49:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRVnG-0002rn-LF
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 16:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDFOsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 10:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWDFOsv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 10:48:51 -0400
Received: from home.keithp.com ([63.227.221.253]:10763 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932158AbWDFOsu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 10:48:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 9DD93130020;
	Thu,  6 Apr 2006 07:48:44 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09781-03; Thu, 6 Apr 2006 07:48:44 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id D224D13001F; Thu,  6 Apr 2006 07:48:43 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B357214002;
	Thu,  6 Apr 2006 07:48:43 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 63DF4543DB; Thu,  6 Apr 2006 07:48:17 -0700 (PDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060406120812.GO13324@lug-owl.de>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18471>


--=-YsFbJ1Pv2/hqrdY4fqVt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 at 14:08 +0200, Jan-Benedict Glaw wrote:
> On Wed, 2006-04-05 23:36:32 -0700, Keith Packard <keithp@keithp.com> wrot=
e:
> > note, parsecvs remains available from:
> >=20
> > 	git://git.freedesktop.org/~keithp/parsecvs
>=20
> It now compiles out-of-the-box for me, nice work.

cool

>=20
> However, it would be nice if you'd add a short description about how
> to use it. Something like this:

I'd rather just fix the usage to be more sane; that shouldn't take but a
few minutes...

> I just ran it against a locally rsync'ed copy of the Binutils ,v
> files. Looging at the progress bar, it is bascally ready:
>=20
>=20
> Load:               winsup/configure.in,v ....................* 27704 of =
27704

Now all of the ,v files have been parsed and each revision placed in
the .git repository as a blob.

> But it seems it now starts to really consume memory:

Yeah, it's doing the change set computation, which is not very space
efficient; it computes the entire set of files at each commit which can
take 'a bit' of space with a large number of files over a long period of
time. Obviously computing revision deltas and saving those would make it
use a lot less memory.

> jbglaw@bixie:~/bin$ ps axflwww|egrep '(VSZ|parsecvs)'|grep -v grep
> F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMM=
AND
> 0  1000 15564 22879  18   0 2805084 549996 finish T  pts/10    30:51 |   =
    \_ parsecvs

I'd run a large repository on a large machine; I managed to get
postgresql to run on my laptop (615M CVS with 6000 files), but anything
larger I'd probably want to get it onto a big enough machine. The
question is whether it needs to be more efficient so that people can
constantly convert repositories or whether moving the repository to a
sufficiently large machine for the one-time conversion is 'good enough'.

> How well does this work with even larger repositories?

postgresql is the largest I've run; starting with a 615M CVS repository,
it built a 1.7G .git tree, which packed down to 125M.

--=20
keith.packard@intel.com

--=-YsFbJ1Pv2/hqrdY4fqVt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENSowQp8BWwlsTdMRAu/eAKDEKdaNJzKomZipId8H0S99KjZsKwCfQzrL
CEglsSvX54zr2AyvyWl4DT0=
=qcoa
-----END PGP SIGNATURE-----

--=-YsFbJ1Pv2/hqrdY4fqVt--
