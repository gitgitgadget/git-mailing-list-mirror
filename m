From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 10:33:56 +0200
Message-ID: <20080619083356.GN29404@genesis.frugalware.org>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk> <7v7iclx4nw.fsf@gitster.siamese.dyndns.org> <20080619082156.GB12727@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fvotiRPmxuu5ONx4"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Fc8-0007AU-R3
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 10:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYFSIeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 04:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYFSIeC
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 04:34:02 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35904 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYFSIeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 04:34:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 232321B2586;
	Thu, 19 Jun 2008 10:33:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8FE6A4465E;
	Thu, 19 Jun 2008 10:11:59 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AC6E21778015; Thu, 19 Jun 2008 10:33:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080619082156.GB12727@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85459>


--fvotiRPmxuu5ONx4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 10:21:56AM +0200, Karl Hasselstr=F6m <kha@treskal.c=
om> wrote:
> Catalin and I are tossing ideas around for how to represent the
> history of an StGit patch stack (using a git commit for each log
> entry). One complication is that we have to keep references to all
> unapplied patches so that gc will leave them alone (and so that they
> will get carried along during a pull, in the future). And the number
> of unapplied patches is potentially large, so I thought we'd be going
> to have to make a tree of "merge" commits to connect them all up.
>=20
> (What we'd really like, of course, is a way to refer to a set of
> commits such that they are guaranteed to be reachable (in the gc and
> pull sense), but not considered "parents".)

I had a similar problem in git/vmiklos.git on repo.or.cz, while working
on builtin-rebase: I squash several patches using rebase -i before
sending a series, but it's nice to have the old long list of small
patches in case I would need them later.

What I did is to have a rebase-history branch: each commit in it is an
octopus merge:

- The first parent is the previous rebase-history ref

- The second is the old HEAD

- The third is the new HEAD

This way I can use git rebase -i without worrying about loosing history,
even if reflogs are not shared among machines.

(It may or may not be a good idea to do something like this in StGit, I
just though I share this idea here.)

--fvotiRPmxuu5ONx4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhaGfQACgkQe81tAgORUJbmZgCglcyX8Pv2E7MJJa878wA8WTOY
ZUcAniTCbVYNHI6hJW5Px4yR+F1L5sbe
=3xhc
-----END PGP SIGNATURE-----

--fvotiRPmxuu5ONx4--
