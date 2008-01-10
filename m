From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 18:13:41 +0100
Message-ID: <200801101813.45938.devurandom@gmx.net>
References: <200801081738.56624.devurandom@gmx.net> <20080110083846.GA15047@soma> <200801101204.58300.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5011567.XQAekOMtTt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 18:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD13M-0003u1-5q
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 18:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbYAJRSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 12:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbYAJRSX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 12:18:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:49481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753648AbYAJRSV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 12:18:21 -0500
Received: (qmail invoked by alias); 10 Jan 2008 17:18:17 -0000
Received: from hnvr-4dbbd1d5.pool.einsundeins.de (EHLO ernie.local) [77.187.209.213]
  by mail.gmx.net (mp003) with SMTP; 10 Jan 2008 18:18:17 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1+npMEWzHGnECFKyyU9oCddua4K7WvVYSHc5xAP4z
	U5pnVdNrH01Fln
User-Agent: KMail/1.9.7
In-Reply-To: <200801101204.58300.devurandom@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70076>

--nextPart5011567.XQAekOMtTt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 10. Januar 2008 12:04:54 schrieb Dennis Schridde:
> Am Donnerstag, 10. Januar 2008 09:38:46 schrieb Eric Wong:
> > Dennis Schridde <devurandom@gmx.net> wrote:
> > > Am Dienstag, 8. Januar 2008 18:21:55 schrieb Junio C Hamano:
> > > > Dennis Schridde <devurandom@gmx.net> writes:
> > > > > I am getting "Odd number of elements in anonymous hash at
> > > > > /usr/bin/git-svn line 1760." (normal output, no warning/error)
> > > > > during git-svn-clone. I am using git version 1.5.4.rc2.
> >
> > Can you look in .git/svn/.metadata for the svnsync-* values?  Thanks.
> >
> > I downloaded your repository and couldn't reproduce it locally.
>
> This is the file left after the segfault from the other mail:
> ---
> [svn-remote "svn"]
>     reposRoot =3D file:///var/svn/warzone2100
>     uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
>     branches-maxRev =3D 14
>     tags-maxRev =3D 14
>     svnsync-uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084\n
>     svnsync-url =3D http://svn.gna.org/svn/warzone
> [svn-remote "tags/1.10a.12"]
>     reposRoot =3D file:///var/svn/warzone2100
>     uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
> ---
The rest of the file is rather boring. The "svn" remote is not changed=20
(besides having higher revisions) and the other remotes look exactly like=20
the "tags/1.10a.12" one.

Somehow I think that the \n at the end of the svnsync-uuid shouldn't be=20
there... It could be that this is the same linebreak which prevents people=
=20
from relocating (svn switch --relocate) from svn://svn.gna.org/svn/warzone =
to=20
http://svn.gna.org/svn/warzone, so that would be a Gna bug.
However git-svn shouldn't throw any warnings (or even (make perl) crash?) o=
n=20
such occasions, either...

I now got it to run through without a segfault, by compiling an unstriped p=
erl=20
binary with debug symbols (Gentoo: FEATURES=3Dnostrip CFLAGS=3D"... -g").
Maybe this is a bug in GCC or something...

The "Odd number of elements in anonymous hash" still stays, though.

=2D-Dennis

svn, version 1.4.6 (r28521)
git version 1.5.4.rc2
This is perl, v5.8.8 built for i686-linux

--nextPart5011567.XQAekOMtTt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkeGUkkACgkQjqfyF1DtJW7UfQCePGnGNQolan6SSBuUuHHiOv/G
JZYAnjW1m30rlrfpEG1NKJnV2+4h5Czc
=S7UZ
-----END PGP SIGNATURE-----

--nextPart5011567.XQAekOMtTt--
