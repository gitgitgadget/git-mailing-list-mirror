From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 23:17:03 +0200
Message-ID: <1114118223.29271.5.camel@nosferatu.lan>
References: <1114100518.17551.31.camel@nosferatu.lan>
	 <20050421202928.GH7443@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DKmGUNNrHOHSyk3fw2J4"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:10:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiv1-00058Z-WB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVDUVNW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDUVNW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:13:22 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:35549 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261881AbVDUVNJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 17:13:09 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id D846C6C9C;
	Thu, 21 Apr 2005 23:13:05 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 235E73A2430;
	Thu, 21 Apr 2005 23:19:25 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03969-13; Thu, 21 Apr 2005 23:19:19 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id AD3FD3A241A;
	Thu, 21 Apr 2005 23:19:19 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421202928.GH7443@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-DKmGUNNrHOHSyk3fw2J4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-21 at 22:29 +0200, Petr Baudis wrote:
> Dear diary, on Thu, Apr 21, 2005 at 06:21:58PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Hi,
>=20
> Hi,
>=20
> > Just pulled linux-2.6.git, and got this:
> >=20
> > ----
> > New branch: 3a6fd752a50af92765853879f4a11cc0cfcd0320
> > Tracked branch, applying changes...
> > Merging 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9 -> 3a6fd752a50af927658=
53879f4a11cc0cfcd0320
> >         to a2755a80f40e5794ddc20e00f781af9d6320fafb...
> >=20
> > Enter commit message, terminated by ctrl-D on a separate line:
> > Merge with 3a6fd752a50af92765853879f4a11cc0cfcd0320
> > ----
> >=20
> > Weird thing was that I made no changes.
>=20
> did you compensate for the renamed hashes? Didn't you before update from
> some very old git-pasky version?
>=20
> Actually, did you do that git init _after_ the unsuccessful pull, or
> before?
>=20

I re-pulled it from scratch after the sha1 changes, so not that.  Just
the next pull that went wonky.

> > Digging a bit deeper, I saw that .git/HEAD was a symlink
> > to .git/heads/master, and the tracked branch was 'origin'.  Due to the
> > fact that Linus only have a .git/heads/master on his rsync, and this
> > thus updated to the new sha1, but the 'origin' (and tracked) head is
> > still pointing to an older sha1 caused this confusion.
>=20
> Duh. The remote branch always grabs the HEAD over there; you don't need
> to care about the various branches over there, and you really do not
> *want* to care. Actually I might add some ^branchname to the rsync URL,
> to be able to refer to particular branches inside of the repository.
>=20

Well, I just did a quick peek.  I thought it just changed the local head
to the sha1 of the remote, and then updated the local files - haven't
yet looked at gitmerge.sh.

> > I replicated the linux tree via:
> >=20
> > ----
> > git init URL
> > ----
> >=20
> > So I had a look at gitinit.sh, which first creates the .git/heads/maste=
r
> > and symlinks HEAD to it, then on seeing a URL was supplied, creates
> > a .git/heads/origin, track it, but do *not* change the .git/HEAD
> > symlink ... Is this intended?  I see also that gittrack.sh do not updat=
e
> > the HEAD symlink ...  Is this also intended?
>=20
> Yes.
>=20
> You never work directly on the remote branch. Ever. That's what this
> tracking stuff is for; you set up a local branch which follows the
> remote one.
>=20

Ok, but for some weird reason it wanted to commit the merge between
remote and local.

> Otherwise, you fork to two trees, one is remote branch, second is local
> branch, and you do git pull remotebranch in the second. You are in
> trouble now. Also, if you do some local commit on the remote branch,
> what would happen? This kind of stuff is why I decided that you just
> cannot work on remote branches directly.
>=20
> > The last option however brings a problem or two.  First, how do you do
> > the multi-head thing?  Maybe add a command 'git lsheads' (and while at
> > it, also add 'git lstags'?)?  Secondly, if there was more than one head=
,
>=20
> Perhaps it would be useful to have some "command classes" (with at least
> cg-*-(add|ls|rm)), like:
>=20
> 	cg-branch-ls
> 	cg-remote-rm
> 	cg-tag-add
>=20

Might make things more sane.

> > the local copy needs to be checked out ... don't know if 'git cancel' i=
s
> > the logical thing the user will think to do ('git clone' perhaps?) ...
>=20
> I don't know what do you mean here.
>=20

Don't worry, no biggy.

--=20
Martin Schlemmer


--=-DKmGUNNrHOHSyk3fw2J4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaBhPqburzKaJYLYRAseNAJwL8wsjBcgGiVNTQDiImLkUjtK3JQCfdyhc
JjcAjTlEcbrgRarhCFFsD4c=
=TGaG
-----END PGP SIGNATURE-----

--=-DKmGUNNrHOHSyk3fw2J4--

