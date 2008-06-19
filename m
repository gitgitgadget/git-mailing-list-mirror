From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 12:06:37 +0200
Message-ID: <20080619100637.GO29404@genesis.frugalware.org>
References: <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk> <7v7iclx4nw.fsf@gitster.siamese.dyndns.org> <20080619082156.GB12727@diana.vm.bytemark.co.uk> <20080619083356.GN29404@genesis.frugalware.org> <20080619091903.GA14415@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E+d41Xxi+aYmIyHQ"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9H3T-00052h-FO
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 12:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbYFSKGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 06:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756063AbYFSKGk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 06:06:40 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36086 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659AbYFSKGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 06:06:40 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 995BE1B24FD;
	Thu, 19 Jun 2008 12:06:38 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B328D4465E;
	Thu, 19 Jun 2008 11:44:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 01C4B1190A3E; Thu, 19 Jun 2008 12:06:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080619091903.GA14415@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85465>


--E+d41Xxi+aYmIyHQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 11:19:03AM +0200, Karl Hasselstr=F6m <kha@treskal.c=
om> wrote:
> What you're describing is pretty much what we're thinking about doing
> -- have a log branch where each commit contains enough metadata to
> recreate the complete patch stack state at that point in time, and has
> all the parents it needs to be safe from gc.
>=20
> The particular problem I'm asking about here is that due to StGit's
> concept of "unapplied" patches that are per definition not reachable
> from the current branch head, a given log entry might have to keep an
> unbounded number of commits from being gc'ed. Thus my question about
> what would blow up if we were to make a commit with 50 parents. Or
> 100. Or 1000, if our users are crazy enough. (The alternative being,
> of course, to make a tree of octopuses with a fixed maximum fan-out.)

I may miss something, but you have (at least) two options to store
"patches".

You can store them as a blob, make a tree of them and make a commit in
the log branch point to the tree. This one has the advantage of being
able to do a 'git log' on a particular patch of the patch set.

The other one is to create n+1 trees (and commits, where the first
commit has no parent) for n patches, and point to the last commit from
the log branch.

--E+d41Xxi+aYmIyHQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhaL60ACgkQe81tAgORUJZZqQCeJodjJWl7z7v14kqIW/92FQHK
/eYAniKjYLiVZyqzHA0jJLHJg4Bk3BVt
=x+yP
-----END PGP SIGNATURE-----

--E+d41Xxi+aYmIyHQ--
