From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 2/3] entry.c: checkout available submodules
Date: Sat, 26 May 2007 00:19:14 +0200
Message-ID: <20070525221913.GB8361@admingilde.org>
References: <1180127233729-git-send-email-skimo@liacs.nl> <1180127233893-git-send-email-skimo@liacs.nl> <20070525213103.GA8361@admingilde.org> <20070525214205.GJ942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 26 00:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hri85-0004e8-1r
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbXEYWTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbXEYWTR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:19:17 -0400
Received: from mail.admingilde.org ([213.95.32.147]:60713 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbXEYWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:19:17 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hri7u-0003IM-Vr; Sat, 26 May 2007 00:19:15 +0200
Content-Disposition: inline
In-Reply-To: <20070525214205.GJ942MdfPADPa@greensroom.kotnet.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48426>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, May 25, 2007 at 11:42:05PM +0200, Sven Verdoolaege wrote:
> On Fri, May 25, 2007 at 11:31:03PM +0200, Martin Waitz wrote:
> > I think the list tends to prefer subproject over submodule.
>=20
> Does it?  It seems that everyone writing code is use submodule
> instead of subproject.  Either way, I don't really care.

I got that impression from my small poll.

> > > @@ -193,9 +220,8 @@ int checkout_entry(struct cache_entry *ce, const =
struct checkout *state, char *t
> > >  		 */
> > >  		unlink(path);
> > >  		if (S_ISDIR(st.st_mode)) {
> > > -			/* If it is a gitlink, leave it alone! */
> > >  			if (S_ISGITLINK(ntohl(ce->ce_mode)))
> > > -				return 0;
> > > +				return checkout_submodule(ce, path, state);
> > >  			if (!state->force)
> > >  				return error("%s is a directory", path);
> > >  			remove_subtree(path);
> >=20
> > I think the call to checkout_submodule should be moved to write_entry,
> > to keep it in line with the other mode types.
>=20
> Well, like your patch, this only deals with cases where the submodule
> is already available.  In write_entry you could potentially clone
> submodules based on some criteria, but I'm not doing this just yet
> since some people apparently prefer to get these things in pieces.

yes, first we need checkout and then can add more building blocks on
top.

Up to now the quoted code block above only handles cleaning the
tree from conflicting / old entries and write_entry creates the
real content.

For subprojects we first have to remove any non-subproject content
in that location and then later call write_subproject or similiar
in write_entry to update the subproject (or create some empty dummy
directory).

But we can also leave those details for later when we are clear about
the complete semantics.  At the moment it is important to reach a
common base everybody agrees on and which is enough to experiment with
all the high level tools.

--=20
Martin Waitz

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGV2Dhj/Eaxd/oD7IRAl75AJ9/NpgjI3i4XCFhXTgXMhAnkqqObACfZ8SE
eVRWD+f7CC2qEAkBbC663OU=
=sfoJ
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
