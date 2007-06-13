From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Wed, 13 Jun 2007 13:25:08 -0700
Message-ID: <467052A4.6080706@freedesktop.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org> <466ED9CE.3000800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D2B70EB43A1DB173134E42A"
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZQ5-0003nw-9z
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbXFMUZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbXFMUZc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:25:32 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:34410 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbXFMUZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:25:30 -0400
Received: (qmail 12966 invoked from network); 13 Jun 2007 20:25:27 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <ramsay@ramsay1.demon.co.uk>; 13 Jun 2007 20:25:27 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <466ED9CE.3000800@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50126>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D2B70EB43A1DB173134E42A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
> Josh Triplett wrote:
>> Ramsay Jones wrote:
>>> fix most of those problems. (the output from "make check" was about 1=
6k
>>> lines at one point!). Git also tickled a bug in sparse 0.2, which res=
ulted
>>> in some 120+ lines of bogus warnings; that was fixed in version 0.3 (=
commit
>>> 0.2-15-gef25961).  As a result, sparse version 0.3 + my patches, elic=
its 106
>>> lines of output from "make check".
>> One note about using Sparse with Git: you almost certainly don't want =
to pass
>> -Wall to sparse, and current Git passes CFLAGS to Sparse which will do=
 exactly
>> that.  -Wall turns on all possible Sparse warnings, including nitpicky=

>> warnings and warnings with a high false positive rate.
>=20
> I have to say that, my initial reaction, was to disagree; I certainly w=
ant to
> pass -Wall to sparse! Why not? Did you have any particular warnings in =
mind?
> (I haven't noticed any that were nitpicky or had a high false positive =
rate!)

If you don't mind the set of warnings you get, then sure, use -Wall.

Some of the ones I had in mind:
* -Wshadow.  Not everyone cares.
* -Wptr-subtraction-blows.  This warns any time you do ptr2 - ptr1.
* -Wundefined-preprocessor.  This warns if you ever do
  #if SYMBOL
  when SYMBOL might not actually have a definition.  Many projects do exa=
ctly
  that, and the C standard allows it.
* -Wtypesign.  Off by default for the same reason that GCC doesn't give s=
ign
   mismatches by default: too many codebases with too many sloppy signedn=
ess
   issues that drown out other issues.

> ...  You should start from
>> the default set of Sparse warnings, and add additional warnings as des=
ired, or
>> turn off those you absolutely can't live with. =20
>=20
> Why not "-Wall -Wno-nitpicky -Wno-false-positive" ;-)

If you don't mind that, then sure.  You might have to adjust the warning =
list
to taste from time to time.  But please do use -Wall if you feel comforta=
ble
with the warnings it produces.

> ... Current Sparse from Git (post
>> 0.3, after commit e18c1014449adf42520daa9d3e53f78a3d98da34) has a chan=
ge to
>> cgcc to filter out -Wall, so you can pass -Wall to GCC but not Sparse.=
 =20
>=20
> Yes, I noticed that. Again, I'm not sure I agree.
> I didn't comment on that patch, because my exposure to sparse is very l=
imited.
> So far I've only run it on git, so I can hardly claim any great experie=
nce with
> the output from sparse. However, 105 lines of output (which represents =
71 warnings)
> for 72,974 lines of C (in 179 .c files) did not seem at all unreasonabl=
e.

True; for a project the size of Git, you can reasonably handle all the
warnings as you did.

If you want to use -Wall with sparse, you can always pass -Wall to sparse=

directly, or use CHECK=3D"sparse -Wall" cgcc. =20

- Josh Triplett


--------------enig4D2B70EB43A1DB173134E42A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGcFKsGJuZRtD+evsRAmhaAKCfXDkvd6zi4wsN7SCCG/3x4g1MKACfWqg+
HOlA2CRxUp/GUcxPPLR5e0c=
=fiQ/
-----END PGP SIGNATURE-----

--------------enig4D2B70EB43A1DB173134E42A--
