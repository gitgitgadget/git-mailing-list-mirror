From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 19:53:38 -0700
Message-ID: <20070418025338.GG31488@curie-int.orbis-terrarum.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org> <20070417235649.GE31488@curie-int.orbis-terrarum.net> <7vps62lfbw.fsf@assigned-by-dhcp.cox.net> <20070418010637.GF31488@curie-int.orbis-terrarum.net> <7vejmilbyt.fsf@assigned-by-dhcp.cox.net> <7vy7kqjw4x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He0IN-0002Bp-9h
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 04:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbXDRCxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 22:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965379AbXDRCxU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 22:53:20 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:39281 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965337AbXDRCxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 22:53:19 -0400
Received: (qmail 15879 invoked from network); 18 Apr 2007 02:53:18 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 18 Apr 2007 02:53:18 +0000
Received: (qmail 2297 invoked by uid 10000); 17 Apr 2007 19:53:38 -0700
Content-Disposition: inline
In-Reply-To: <7vy7kqjw4x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44857>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2007 at 06:42:38PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > I do not have much against an optional "only blob id" expansion
> > myself, as I do not see any more downside than CRLF expansion in
> > it...
> Actually, there is one.  Somebody makes a patch against a file
> with $id$ expanded.  Gives it to somebody else who is git
> challenged and does not have git-apply.  The patch is useless.
So they have diff'd outside of Git, and the recipient is applying outside of
Git:
A - If they are applying the patch on top of the same base revision, it will
    apply fine, because the keywords are identical.=20
B - If they are applying the patch on top of a different revision, the keyw=
ords
    won't apply, and most probably other content in the patch won't apply e=
ither.

Additional with B  the longer your individual files, the more likely that t=
he
diff hunk containing the keyword change does not contain any other changes,=
 and
can be easily discarded. More that the changes are likely to be further away
=66rom the keyword ;-).

Discarding portions of patches is already wide-spread (not just for CVS
keywords, the architecture keywords in Gentoo ebuilds change rapidly as wel=
l),
and if git-apply can discard the keyword, it only serves to accelerate the
usage of git.

Some quick stats I hacked together on lengths of Gentoo ebuilds.
23161 ebuilds total.
51% of the Gentoo ebuilds are less than 36 lines long.
76% are less than 56 lines long.
90% are less than 92 lines long.
(thereafter the tail gets VERY long).
0.21% are more than 500 lines long.

> So it is not without more downsides than CRLF.
A cleaner version of my earlier command to find the changes between revisio=
ns.
diff -Nuar <(git-cat-file blob $SHA1:$FILE) $TMPFILE
where $TMPFILE is a temporary filename for the file from the user.
This saves having to overwrite the local $FILE and restore it afterwards.
It would be nice if git-diff could handle this case directly.

On a tangent, has any work gone into specialized patch mergers for specific
file formats?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGJYgyPpIsIjIzwiwRApjNAJ0bdWnz8KoCxlBD+V4Mq1c5TrhrggCfZdAt
GscungGOXntJMl55dwaaF7E=
=UD9b
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
