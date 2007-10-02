From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Tue, 02 Oct 2007 23:02:52 +0200
Message-ID: <20071002210252.GB19710@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp> <20071002204748.GA19710@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zx4FCpZtqtKETZ7O";
	protocol="application/pgp-signature"; micalg=SHA1
To: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icote-0005QI-Gg
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbXJBVCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbXJBVCz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:02:55 -0400
Received: from pan.madism.org ([88.191.52.104]:40298 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbXJBVCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:02:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1C0F721906;
	Tue,  2 Oct 2007 23:02:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BFE1128F999; Tue,  2 Oct 2007 23:02:52 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071002204748.GA19710@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59737>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2007 at 08:47:48PM +0000, Pierre Habouzit wrote:
> On mar, oct 02, 2007 at 08:13:18 +0000, Pierre Habouzit wrote:
> >   Ancestor: (aa*, aaa, bbb)
> >   Left child: (aa*, bbb)   <-- remove aaa because aa* covers it
> >   Right child: (aaa, aabcd, bbb, cc*) <-- remove aa* and be explicit
> >=20
> >   The proper result is probably: (aaa, aabcd, bbb, cc*) but is in fact a
> > case of conflict, because the "left" child could have used the fact that
> > aa* was present and hide say a aaXXX that the right child did not had,
> > and the merge would be wrong.
>=20
>   Okay this example blows, I believe this one is better:
>=20
>        (a*)
>       /    \
>   (ab*)    (ac*)
>       \    /
>        ????
>=20
>   gitignore are subsets of the set of words.  if S is the ancestor set,
> S1 and S2 the left and right sets. let =CE=941 and =CE=942 be S1 \ S and =
S2 \ S
   I meant S \ S1 and S \ S2 in fact here ...
> respectively.  I think there is a conflict if
>   =CE=941 n =CE=942 !=3D 0 and (=CE=941 is not a subset of =CE=942) and (=
=CE=942 is not a subset of =CE=941)
>=20
>   If the condition holds, then I believe that the "merged" .gitignore
> would be: (S1 u S2) \ (=CE=941 u =CE=942)

  after some more thoughts, as basically merging the complementary of
the sets I talk about here should yield the same "conflicts" (as it's
the dual problem), I suppose that the same restrictions should be
checked wrt the "added" deltas between S -> S1 (aka S1 \ S for real this
time) and S -> S2 (aka S2 \ S).

  so if =CE=94(0,n) is Sn \ S and =CE=94(n, 0) is S \ Sn, it would mean tha=
t if:

   { =CE=94(0,1) n =CE=94(0,2) =3D=3D 0 || =E2=88=83 i =E2=88=8B (1,2), =CE=
=94(0,i) =E2=8A=86 =CE=94(0, 3 - i) }
&& { =CE=94(1,0) n =CE=94(2,0) =3D=3D 0 || =E2=88=83 i =E2=88=8B (1,2), =CE=
=94(i,0) =E2=8A=86 =CE=94(3 - i, 0) }

  Then the correct merge (without conflicts) would be:

  (S u =CE=94(1,0) u =CE=94(2,0)) \ (=CE=94(0,1) u =CE=94(0,2)) aka S + wha=
t was added -
what was removed.

  in fact, I think that wrt the sets usual operations, there is a
conflict if the expression I just wrote does not commutes wrt the \ or
sth very similar.

  Anyway, I'm going pretty off topic here, so I'll shut up now :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHArH8vGr7W6HudhwRAkZ7AJ0aBVKEJBSLOCXdNoeM1gm9zpMUPgCdE39Z
CdtZ4KzMwj0ksyNGRRQLh0M=
=wcji
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
