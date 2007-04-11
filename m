From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 12:03:29 +0200
Message-ID: <20070411100328.GK21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com> <20070411083642.GH21701@admingilde.org> <7virc3p8zr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZfr-0004a8-2U
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 12:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbXDKKDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 06:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbXDKKDb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 06:03:31 -0400
Received: from mail.admingilde.org ([213.95.32.147]:38229 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbXDKKDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 06:03:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbZfl-0000E0-1Y; Wed, 11 Apr 2007 12:03:29 +0200
Content-Disposition: inline
In-Reply-To: <7virc3p8zr.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44232>


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 02:15:36AM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
>=20
> > Your working tree now contains a complete git repository which has
> > features which are not available for normal files.  Notable, you
> > have the possibility to create branches in the submodule.
> > If you insist in using HEAD you throw away those submodule capabilities.
>=20
> Why?  If you are working in the parent module (e.g integration)
> and notice breakage due to a bug in a submodule, it is very
> plausible that you would want to cd into the directory you have
> the submodule checked out, which has its own .git/ as its
> repository, and perform a fix-up there, with the goal of coming
> up with a commit usable by the parent project pointed at by the
> HEAD of the submodule repository.  And while working toward that
> goal, you will use branches, rebase, rewind or use StGIT there
> in that submodule repository.  It does not forbid you from using
> any of these things -- as long as you end up with a good commit
> at HEAD that the supermodule can use.

that's perfectly fine.
I only require one more thing: make sure that your commit is on
one dedicated branch (simply by merging your working/rebased/whatever
branch into the dedicated one) and not on some random one.

Again: for your above example this is not neccessary and using HEAD
would indeed be perfectly fine.

But you also have to update the submodule when you do a checkout in
the supermodule.  So what do you update?  Updating 'HEAD' is not
very concrete, please have a look at my initial mail to Linus.

What is stored in the supermodule?  It stores a reference to a specific
point in the history of the submodule.  As such I am convinced that
the right counterpart inside the submodule is a refs/heads/whatever,
and not the branch selector HEAD.
You can have other branches next to the one which is tracked by the
supermodule.  If you always update HEAD you don't have a clear
distinction between the branch which is tracked and other branches.

> Once you come up with a suitable commit sitting at HEAD of the
> submodule repository, you cd up to the parent module.  Top-level
> git-diff would notice that the commit recorded at the submodule
> path has been updated (because you now have a good commit at
> HEAD of the submodule repository, while earlier the one in your
> index was a dud).
>=20
> So it is not clear to me what your argument about throwing away
> capabilities is.

If the supermodule just updates some random submodule branch I happen to
use at the time of a supermodule pull then submodule branches are
of much lower value.
Suddenly you have to make sure for yourself that the correct branch
gets updated.
For me, different branches should be independent and I want git to
always update the correct one.

--=20
Martin Waitz

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHLJwj/Eaxd/oD7IRAvO+AJ95xEmxtQyRvPVS6tGKHlWZ5p+4awCfZ1bM
GkSxrwlJRZZrcHc6L1SsiL0=
=NgNH
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
