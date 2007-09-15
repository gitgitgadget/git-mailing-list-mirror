From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Track /etc directory using Git
Date: Sat, 15 Sep 2007 16:29:32 +0200
Message-ID: <20070915142932.GB27494@artemis.corp>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com> <20070913123137.GA31735@piper.oerlikon.madduck.net> <38b2ab8a0709140108v2a9c3569i93b39f351f1d4ec3@mail.gmail.com> <20070914091545.GA26432@piper.oerlikon.madduck.net> <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com> <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Yylu36WmvOXNoKYn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Thomas Harning Jr." <harningt@gmail.com>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Francis Moreau <francis.moro@gmail.com>
To: Nicolas Vilz <niv@iaglans.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYeQ-00055Z-Bf
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbXIOO3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXIOO3e
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:29:34 -0400
Received: from pan.madism.org ([88.191.52.104]:42181 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbXIOO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:29:34 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F2E2878B;
	Sat, 15 Sep 2007 16:29:32 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7140B4C151; Sat, 15 Sep 2007 16:29:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Vilz <niv@iaglans.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Francis Moreau <francis.moro@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58250>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2007 at 09:26:43PM +0000, Nicolas Vilz wrote:
> On Fri, Sep 14, 2007 at 01:31:06PM -0400, Thomas Harning Jr. wrote:
> > On 9/14/07, martin f krafft <madduck@madduck.net> wrote:
> > > also sprach Francis Moreau <francis.moro@gmail.com> [2007.09.14.1008 =
+0200]:
> > > > Did you find an alternative to git in this case ?
> > >
> > > No, and I did not look anywhere, but I know of no other VCS that can
> > > adequatly track permissions.
> > Has anyone checked out metastore?  http://repo.or.cz/w/metastore.git
> > ... there's an XML error in there somewhere, so its not loading the
> > 'main' page, but http://repo.or.cz/w/metastore.git?a=3Dshortlog should
> > work.
> >=20
> > It looks like it could work.... any thoughts on this?
>=20
> I use that tool. If you just have one branch, it works. With the
> commit-hook, which also updates the metadata, you have current
> permission tracking.=20
>=20
> There is a lack of a checkout-hook, which sets the permissions, so you
> have to remeber todo a metastore -a after you checked out a revision.

  Note that having metastore run by a hook makes it unsuitable for /etc
versioning, because you may have short period of times during which
s3kr3t files are readable by more people that what it should be.

  The sole sane way to do that would be to track permissions, acls,
whatever _in_ git. Though, I'm still not convinced that it is such a
good idea at all. I mean for source code you absolutely _don't_ want git
to track permissions (outside from the +x bit). You don't want git to
try to chown your files to "madcoder:madcoder" because I was the last
one committing. So that would mean that you want sometimes to track
permissions, sometimes not. So you need a bunch of tools to list files
whose permissions have to be tracked, and whose permissions don't need
to be.

  I fear that you'll end up with quite a big bloat of git, for a use
case that is fairly limited.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6+xMvGr7W6HudhwRAt0+AJ4m4O0xWyOeWSV6W4bXe1rO30cfqACeJq5y
d9yMMOUx1rkFkYC7UpKQZAg=
=WvlS
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
