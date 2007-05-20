From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 01:36:51 +0200
Message-ID: <20070520233651.GS5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520221455.GN5412@admingilde.org> <20070520225810.GH25462@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 01:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuxT-0007Sy-AI
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033AbXETXgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbXETXgy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:36:54 -0400
Received: from mail.admingilde.org ([213.95.32.147]:51838 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbXETXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:36:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpuxI-0007Jj-5r; Mon, 21 May 2007 01:36:52 +0200
Content-Disposition: inline
In-Reply-To: <20070520225810.GH25462@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47953>


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 12:58:10AM +0200, Alex Riesen wrote:
> Martin Waitz, Mon, May 21, 2007 00:14:55 +0200:
> > >  - Do we detach HEAD if the commit named by the superproject
> > >    tree is not at the tip of the current branch of subproject?
> > >    do we detach always even if the commit is at the tip?
> >=20
> > We must not mess with random upstream branches of the submodule
> > just because they happen to reference the same tip.
> > That would be too confusing.
>=20
> Strange. The very same reason I heard when I tried to explain why
> branches are good. The people found them confusing, just like you now.
> They preach Perforce, too.

Sorry, you lost me.

I didn't say that branches are bad but that guessing branch names based on
their tip is bad.


> > Either use one special branch or detach.
>=20
> Why not just detach always?

Which is just another name for "unnamed special branch" ;-)
When you give it a name you can actually use it even after you switched
to another one.

> > >  - What would we do when the subproject working tree is not
> > >    clean?
> >=20
> > The same as with normal files:
> > error out if something is changed which conflicts with the requested
> > update.
>=20
> This is called tree-level merge. Done by -m option (it does more than
> that, yes, but this one too). While at it we can do file-level merge
> as well, why not?

It's not that easy, for submodules we have different levels of dirty:
 * submodule HEAD matches supermodule index, but submodule working
   directory is dirty.
   If the submodule update would touch any modified file then it should
   fail.
   If used with -m (or perhaps another option? after all this merge
   is in a submodule) then it could do the file-level merge for dirty
   files.
 * submodule HEAD does not match supermodule index
   normal checkout should error out if it would touch the submodule.
   checkout -m has to merge submodule HEAD
And of course:
 * index entry of submodule does not match the entry in supermodule HEAD.
   Same as for files.


> > When we have a special managed-by-supermodule branch and the submodule
> > has another branch currently checked out we can entirely ignore this
> > issue.
>=20
> Detached head isn't special enough?

it's too special ;-)

--=20
Martin Waitz

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUNuTj/Eaxd/oD7IRAtDnAJ4twGxeSbNv1vKGmGDM9I3haB6dxACdES/h
6Kd7U/KuEYqhyIjRMSDeR5I=
=x+Kf
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
