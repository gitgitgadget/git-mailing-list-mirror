From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libxdiff and patience diff
Date: Tue, 04 Nov 2008 09:33:03 +0100
Message-ID: <20081104083303.GC3788@artemis.corp>
References: <20081104004001.GB29458@artemis.corp> <Pine.LNX.4.64.0811031904130.9116@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iFRdW5/EC4oqxDHL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:34:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHMs-0006zh-VX
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYKDIdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbYKDIdN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:33:13 -0500
Received: from pan.madism.org ([88.191.52.104]:34221 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbYKDIdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:33:12 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id F0EEF3BEA8;
	Tue,  4 Nov 2008 09:33:07 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A663F110A3F; Tue,  4 Nov 2008 09:33:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0811031904130.9116@alien.or.mcafeemobile.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100056>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 03:17:37AM +0000, Davide Libenzi wrote:
> On Tue, 4 Nov 2008, Pierre Habouzit wrote:
>=20
> > Hi Davide,
> >=20
> > I've been working tonight, trying to make libxdiff support the patience
> > diff algorithm, but I've totally failed, because I _thought_ I
> > understood what xdl_split was doing, but it appears I don't.
> >=20
> >=20
> > [ For the readers playing at home, the patience diff algorithm is
> >   explained after my sig. ]
> >=20
> >=20
> > What I did is to:
> > (1) add a flag to the xenv in xdl_split that says that I want a
> >     patience "split".
> > (2) Then in xdl_split, if that bit is set, I compute the longest common
> >     subsequence from the patience diff.
> > (3) for each split it computes I call xdl_recs_cmp on that interval.
> >=20
> >=20
> > What I thought it would achieve is that I force some boundaries at which
> > libxdiff _must_ resync. Though, it seems that for some reason it doesn't
> > work, probably because the "ha" stuff and the boundaries absolutely
> > don't work the way I thought it did.
> >=20
> > So where is the place I should do that ? I suspect it should be
> > partly in xprepare.c but I'm a bit stuck right now.
> >=20
> >=20
> > Any pointer on how the stuff in xprepare.c and xdiffi.c work would help
> > greatly, it's really not self-evident to me :)
>=20
> What makes you think it'd self-evident to me? :)
> Seriously, I forgot stuff I wrote the last month, this is way beyond my=
=20
> memory limits.
> You definitely need to look at xprepare.c, especially at xdl_trim_ends()=
=20
> and xdl_cleanup_records(). Lines are re-arranged in indexes, and this=20
> might screw up your logic if you're not prepared for it.
> What xdl_split() does, is find the start of an LCS and return the=20
> coordinate. Then xdl_recs_cmp() does the box reducing (first two "for"=20
> loops) and different-lines marking (first and second "if").

Well it's what I thought it did indeed, that's why before recursing into
that bit, I tried to extract a full LCS from the patience diff algorithm
and recurse into that for each interval it gives, which _should_ work,
but doesn't at all :/

Okay maybe I should re-read my algorithm slowly and check that I've not
made something silly (like chaining the list in the reverse order or god
knows what), but my debug functions let me believe that I did that fine.

I'll look into it tonight.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkQCL8ACgkQvGr7W6HudhytlQCgqPfUtDl0K2Vk3njMzyrJKVD1
EDYAni9fooQzAj0TYKjVi0QKqokJDoTh
=SttJ
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
