From: Jan Hudec <bulb@ucw.cz>
Subject: Re: pushing changes to a remote branch
Date: Sat, 14 Jul 2007 10:38:43 +0200
Message-ID: <20070714083843.GA3678@efreet.light.src>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net> <20070710173401.GB5032@sigill.intra.peff.net> <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com> <20070711193152.GC3069@efreet.light.src> <7v1wfe4op5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 10:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9dDT-0000BZ-Sn
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 10:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbXGNInA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXGNIm7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 04:42:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:34673 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbXGNIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 04:42:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8E38A57399;
	Sat, 14 Jul 2007 10:42:57 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Fl4BTQv8uSM4; Sat, 14 Jul 2007 10:42:53 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id DC8CB57396;
	Sat, 14 Jul 2007 10:42:51 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I9d9H-0001Cg-EH; Sat, 14 Jul 2007 10:38:43 +0200
Content-Disposition: inline
In-Reply-To: <7v1wfe4op5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52457>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2007 at 14:26:14 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> >>   $ git checkout origin/master
> >>   Note: moving to "origin/master" which isn't a local branch
> >>   If you want to create a new branch from this checkout, you may do so
> >>   (now or later) by using -b with the checkout command again. Example:
> >>     git checkout -b <new_branch_name>
> >>   HEAD is now at f4855d4... 1
> >
> > The problem of this warning is, that it does not actually say anything =
about
> > detached and that potential commit won't update the ref being checked o=
ut.
>=20
> "Being detached" is a rather geekish synonym to "which isn't a
> local branch", isn't it?

In a sense, no, it is not. "Being detached" is a synonym of "HEAD is not
symbolic ref". The current warning does not really convey the information,
that the ref being checked out will not be updated. Maybe it could be
extended along the lines of following patch.

Hm, it will say the same when checking out with commit name, which does not
make sense much, though.

-->8--
Extend the detached head warning in checkout.

The warning when detaching head now explicitely states that ref being check=
ed
out will not be updated.
---
 git-checkout.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 17f4392..502b2be 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -178,7 +178,8 @@ then
 	detached=3D"$new"
 	if test -n "$oldbranch" && test -z "$quiet"
 	then
-		detach_warn=3D"Note: moving to \"$new_name\" which isn't a local branch
+		detach_warn=3D"Note: moving to \"$new_name\" which isn't a local branch,=
 so it will
+_not_ be updated by local commits.
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmIuTRel1vVwhjGURAmj1AKCCsNXt0Df9U6h7XZvZeSz8SvE8SACgo+BW
eRnbEAdIRGiDwmok7yWKg0A=
=LnI9
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
