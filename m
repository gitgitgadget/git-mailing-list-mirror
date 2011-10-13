From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 16:46:34 +0200
Message-ID: <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
References: <loom.20111013T094053-111@post.gmane.org>
	 <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	 <20111013145924.2113c142@ashu.dyn.rarus.ru>
	 <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	 <loom.20111013T152144-60@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-qx5KFgZ/OK/EPF0WBKxT"
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 16:46:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REMYS-0002eu-RD
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 16:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab1JMOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 10:46:36 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38969 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab1JMOqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 10:46:35 -0400
Received: from [192.168.1.17] (brln-4dbc7ca2.pool.mediaWays.net [77.188.124.162])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id E4B6B460FE;
	Thu, 13 Oct 2011 16:46:07 +0200 (CEST)
In-Reply-To: <loom.20111013T152144-60@post.gmane.org>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183489>


--=-qx5KFgZ/OK/EPF0WBKxT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-10-13 at 13:58 +0000, arQon wrote:
> Andreas Ericsson <ae <at> op5.se> writes:
> > there's no reason to refuse the branch change.
> > Partly because nothing will be lost
>=20
> Actually, this isn't true either, because of the second bug: doing a reve=
rt
> in branchA causes the changes in branchB to be lost. This can't possibly =
be
> the intended behavior: again, it completely violates the integrity of bra=
nches
> by allowing changes on one branch to impact a different branch.

I have not seen a revert command in any of your messages. If a revert on
one branch changes another one, that would be a bug, but you haven't
shown this to happen.

>=20
> Your interpretation of the manpage doubtless matches the actual behavior =
of git,
> but I find it staggering if that truly is what was intended. It basically=
 means
> that if you have local modifications, git will Break Your Entire Tree. Th=
at
> makes changing while you *do* have local mods more than a little undesira=
ble,
> to put it mildly, which is something that a literal reading of the manpag=
e would
> suggest is exactly what the "refuse to switch" is for. I guess only Linus=
 knows
> what he actually meant.  :)

Do not confuse a branch with a worktree. If you haven't committed yet,
those changes aren't in the branch (just like they wouldn't be in svn)

>=20
> Anyway, I guess it's all moot: call it a feature or call it a bug, this c=
ross-
> branch destruction is a deal-breaker for me, especially given the bug abo=
ve that
> actually loses data outright, rather than "only" putting multiple branche=
s into
> an incorrect state.

I've just asked some subversion developers to confirm this, and then
tried it out myself: Subversion (my locally-installed version is 1.6.17,
latest stable) behaves the same way. Local modifications are carried
over across branches.

$ svn copy ^/trunk ^/branches/somebranch # Create a new branch
$ $EDITOR somefile # which exists in trunk and somebranch
$ svn switch ^/branches/somebranch
$ svn diff # My local changes are there!

The reason this happens both in svn and git is that the most likely
cause for someone to change a branch mid-edit is that they decide
they're doing the changes on the wrong branch. What I did notice is that
svn doesn't tell you about the modifications being carried over
(presumably you're meant to use status and diff to figure out what's
going on). Therefore, the same workflow (with the only difference being
how to create and switch branches) works for svn and git in this case.

   cmn



--=-qx5KFgZ/OK/EPF0WBKxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOlvnKAAoJEHKRP1jG7ZzTt94H/judg812UtGCozema1A6VwoR
yBjLoO2xH5LbO690kdPOfV7X+4UQRh3XrXTg/zppm1QexqHMDL6x4HGkKfcgaf1Y
bK0/xM7AA9zx4sU08cnZLqLxN1X8d0vg0fF5uWuElyyPbFbW+ejPhay5uyHntgLD
YU5H2D2HdDHAYYb74bSr21i2+0HSYBVlgVJ7xcXak4w/CKz5Txy2t+C+e2hBcaEc
my2b51RD7pjEFU8DPZLAU5jkZGzNos+JubCCT1KEk5NOJWIdFz9hDhKU8IU7QpHo
6UOIBkaiMj1Ke5rONHhcuyJdDmcITyY/9Oua7n+FAXAWz5mTpGSLijq0F4Qqt2k=
=Ius+
-----END PGP SIGNATURE-----

--=-qx5KFgZ/OK/EPF0WBKxT--
