From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:47:43 +0200
Message-ID: <20070613144743.GF5311@artemis.intersec.eu>
References: <18031.64456.948230.375333@lisa.zopyra.com> <20070613143845.GD5311@artemis.intersec.eu> <20070613144311.GE5311@artemis.intersec.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4Epv4kl9IRBfg3rk";
	protocol="application/pgp-signature"; micalg=SHA1
To: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 16:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyU8Q-0002jc-9y
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915AbXFMOrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757764AbXFMOrp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:47:45 -0400
Received: from pan.madism.org ([88.191.52.104]:46072 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456AbXFMOro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:47:44 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 70B04D61E;
	Wed, 13 Jun 2007 16:47:43 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1F4BE1AF1A; Wed, 13 Jun 2007 16:47:43 +0200 (CEST)
Mail-Followup-To: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070613144311.GE5311@artemis.intersec.eu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50066>


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 04:43:11PM +0200, Pierre Habouzit wrote:
> On Wed, Jun 13, 2007 at 04:38:45PM +0200, Pierre Habouzit wrote:

> >   I suppose the following way would work:
> >=20
> >   $ git commit -a -m "temporary commit"  # save current work
> >   $ git branch -f dirty                  # ..in a separate branch
> >   $ git reset --hard HEAD~1              # unwind this commit
> >   $ git pull                             # perform a clean pull
> >   $ git rebase master dirty              # rewrite the work
> >   <you may have to fix some conficts here>
>=20
> >   $ git reset master                     # "undo" the commit
>=20
>   okay this is wrong because you would then "live" in the `dirty`
> branch. So you'd have to do sth like:
>=20
>    git checkout master
>    git diff master..dirty | git apply

  Alternatively and definitely shorter:

  $ git commit -a -m "temporary commit"        # save the current work
  $ git checkout -f -b dirty HEAD~1            # have a dirty branch for th=
e pull
  $ git pull                                   # perform the pull
  $ git rebase dirty master                    # rewrite the work
  <you may have to fix some conficts here>
  $ git reset HEAD~1                           # then unwind the commit

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcAOPvGr7W6HudhwRArEOAJ4kvNNBp5Aetk/tEJDlig97GFzR/ACdGDPr
Ns+0RRVPo6grIf6J4ZqT83g=
=KU0r
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
