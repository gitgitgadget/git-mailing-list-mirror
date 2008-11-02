From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sun, 02 Nov 2008 10:25:55 +0100
Message-ID: <20081102092555.GC4066@artemis>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <20081102015611.GH15463@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OBd5C1Lgu00Gd/Tn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:27:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZEo-0003oG-0m
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYKBJZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbYKBJZ7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:25:59 -0500
Received: from pan.madism.org ([88.191.52.104]:43089 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbYKBJZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:25:58 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7E2CD3B830;
	Sun,  2 Nov 2008 10:25:56 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 60C83373C2; Sun,  2 Nov 2008 10:25:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081102015611.GH15463@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99829>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 01:56:11AM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > For types that _will_ be in the tight loops, we must make the types
> > explicit or it'll bite us hard performance-wise. I'm thinking what is
> > "struct object" or "struct commit" in git.git. It's likely that we will
> > loose a *lot* of those types are opaque.
>=20
> Yes, but I'm arguing they should be opaque to the application, and
> visible to the library.  Today the application is suffering from
> massive fork+exec overhead.  I really don't give a damn if the
> application's compiler has to deal with a function call to read
> from a private member of an opaque type.  Its still thousands of
> CPU instructions less per operation.

The problem is not the function call, it's really cheap on modern CPUs.
The problem is that across a function call the compiler cannot make
some kind of optimizations and _that_ isn't cheap.

For example, pointers whose value have been loaded from the store into a
register have to be loaded again. A function call trashes all the
registers, etc...


> Come back to me a year after libgit2 has been widely deployed on
> Linux distros and we have multiple applications linking to it.
> Lets talk then about the harmful performance problems caused by
> making these types opaque to the application.  About that time
> we'll also be talking about how great pack v4 is and why its a good
> thing those types were opaque, as we didn't have to break the ABI
> to introduce it.

Well I fear it'll be more than a few percent harm, and I can already see
Linus argue against the switch to libgit2 for git-core because it lost
2% performances ;P

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNciMACgkQvGr7W6HudhxoMQCgkJujL0+4Sjk8LsbRWBDKSFTy
KFMAn001v24oZhUn2ZL59kWGuTZphcww
=SXT2
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
