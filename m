From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 07 Jan 2009 23:45:04 +0100
Message-ID: <20090107224504.GA29537@artemis.corp>
References: <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan> <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302> <7v63kqall2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901072213570.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="azLHFNyN32YCQGCU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:46:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKhAa-0001ji-Cp
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbZAGWpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757332AbZAGWpK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 17:45:10 -0500
Received: from pan.madism.org ([88.191.52.104]:47129 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbZAGWpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 17:45:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6C3EA3BF30;
	Wed,  7 Jan 2009 23:45:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 270482B100; Wed,  7 Jan 2009 23:45:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901072213570.7496@intel-tinevez-2-302>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104842>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2009 at 10:00:07PM +0000, Johannes Schindelin wrote:
> Therefore I counted the lines between conflict markers (actually, a perl=
=20
> script did).  Of these 66 merges, on average patience merge produced=20
> 4.46774193548387 _fewer_ lines between conflict markers.
>=20
> Take that with a grain of salt, though: the standard deviation of this=20
> difference is a hefty 121.163046639509 lines.
>=20
> The worst case for patience diff was the merge=20
> 4698ef555a1706fe322a68a02a21fb1087940ac3, where the --cc diff line counts=
=20
> are 1300 (without) vs 1301 (with patience merge), but the lines between=
=20
> conflict markers are 197 vs a ridiculous 826 lines!
>=20
> But you should take that also with a grain of salt: this merge is a=20
> _subtree_ merge, and my test redid it as a _non-subtree_ merge.
>=20
> So I restricted the analysis to the non-subtree merges, and now=20
> non-patience merge comes out 6.97297297297297 conflict lines fewer than=
=20
> patience merge, with a standard deviation of 58.941106657867 (with a tota=
l=20
> count of 37 merges).
>=20
> Note that ~7 lines difference with a standard deviation of ~59 lines is=
=20
> pretty close to ~0 lines difference.
>=20
> In the end, the additional expense of patience merge might just not be=20
> worth it.

Depends, if it can help generating nicer merges, it's good to have.

We could have an option to git-merge that tries hard to generate the
smallest conflict possible. _that_ would really really be worth it. I
mean, I've had really really tricky conflicts to work with where
git-merge genrated ridiculously big conflicts, and where I hard to
resort using UI tools to perform the merge (meld IIRC to name it), and
given how slow and crappy those tools are, I would gladly restart a
merge with a --generate-smallest-conflicts-as-possible if it can save me
=66rom those merge tools.

YMMV though.

PS: I never thought the patience diff is a silver bullet, it's just yet
    another tool in the toolbox.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkllMG4ACgkQvGr7W6HudhwqogCfTLKyvjq56G/EzOIh3A2bB1lH
WbYAn1pu3rlpjNnyK+UyHirBgAAOMJrX
=KPg7
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
