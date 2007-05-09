From: Jan Hudec <bulb@ucw.cz>
Subject: Re: svn user trying to recover from brain damage
Date: Wed, 9 May 2007 22:16:05 +0200
Message-ID: <20070509201605.GC2982@efreet.light.src>
References: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com> <20070509162259.GY4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Cc: Joshua Ball <sciolizer@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 22:16:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsaQ-0004ld-Gl
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbXEIUQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755519AbXEIUQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:16:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4999 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755926AbXEIUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:16:27 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.118017;
	Wed, 09 May 2007 22:16:05 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HlsZx-00024I-Iw; Wed, 09 May 2007 22:16:05 +0200
Content-Disposition: inline
In-Reply-To: <20070509162259.GY4489@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46779>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2007 at 18:22:59 +0200, Petr Baudis wrote:
> > What is a merge? My understanding of merge comes from the SVN book,
> > where it was described as diff+apply. Diff takes 2 arguments, and
> > apply takes a 1 argument (if the patch is implicit). However, cg-merge
> > only appears to take one branch. (There again a use of the word
> > branch! Wouldn't commit or revision be a more accurate term?) Why does
> > cg-merge only take one argument? Even if I use the -b switch, I'm
> > still only up to two arguments. Where is the hidden argument?
>=20
>   The hidden argument is your current branch. So cg-merge x will merge
> the branch 'x' to your current branch: symbolically, kind of
>=20
> 	base=3D-b argument | base(HEAD, x)
> 	apply(HEAD, diff(base, x))
>=20
>   The word 'branch' is used in an attempt to make it all less confusing
> :-). But in fact, you can give cg-merge just id of a commit, it does not
> have to be branch name.

I believe the important thing to explain here is the BASE, as that is really
the missing argument.

Subversion Book describes merge as diff + apply. Diff takes 2 arguments - O=
LD
and NEW, and apply takes 2 arguments - TARGET and result of diff. That gives
us 3 arguments in total. 2 of them are passed to merge and the third is
current state of working tree.

Now in git (and in any other version control tool), merge is still diff
+ apply[1]. The TARGET is again implied by working tree. The argument to git
merge is the NEW. So where is the OLD missing?

The answer is simple: It is implied by the history! It is the most recent
common ancestor of the NEW and TARGET, or in other words latest revision th=
at
is predecessor of both revisions being merged.

An important distinction between subversion and git here is, that in git BO=
TH
NEW and TARGET are considered parents of the new commit created by merge.
This means that repeated merges just work without need to look in the logs =
or
anywhere for what changes need to be applied.

The OLD, NEW and TARGET argument names are derived from diff/patch
terminology. More common (also in git) is to call them BASE, REMOTE and LOC=
AL
respectively.

It might be interesting to note, that merging is *symetrical* operation.
Swapping the LOCAL and REMOTE will give the same result, except for order in
which parents are recorded in the commit object and the order in which
conflicted sections are written out in case of conflict.

This is property is not in any way special to git. It is fundamental proper=
ty
of patches. Git just cares very little about the order.

[1] The 3-way merge algorithm is not diff+apply internally, but is
    equivalent to diff+apply with full context (whole file is kept), except
    for way it marks conflicts.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQiwFRel1vVwhjGURAlNeAJ4nNptIZes5ZP3FtPOFeCkXfAgoqgCfX9dW
yF4t9H5XZ0c3MCi3/ouFL6s=
=AGK+
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
