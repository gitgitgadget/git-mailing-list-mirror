From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 15:20:31 +0200
Message-ID: <20080723132031.GC20614@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet> <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet> <alpine.DEB.1.00.0807231407040.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qlTNgmc+xy1dBmNv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLeHg-0004Fw-L5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYGWNUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYGWNUf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:20:35 -0400
Received: from pan.madism.org ([88.191.52.104]:35048 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbYGWNUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:20:34 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 55A7432058;
	Wed, 23 Jul 2008 15:20:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 076691F1E73; Wed, 23 Jul 2008 15:20:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231407040.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89649>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 01:09:40PM +0000, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
> > The patch itself should be fine.
>=20
> No, since it opens the whole issue of memory explosion again, the same=20
> issue Shawn's original patch tried to fix.

  No it won't. Indeed the issue is with fix_unresolved_deltas that
sometimes put at the root of the chain (in base_cache) something that
comes from our store, not the pack we are writing. Then starts a delta
chain resolution.

  It won't explode in memory at all, we just keep the first data of a
delta chain in memory, that's all. It indeed consumes more memory, but
we talk about *one* single object per delta chain because we're too lazy
to memorize where it comes from. It's probably not much of an explosion.

  We also waste that object even when it's from our own pack. Well, I'd
say "too bad".

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHMB8ACgkQvGr7W6Hudhw6hgCfXxHsid+Y2SpG9nO9Y/EpxZLJ
UEAAn11/E1+JR0EW2Pf/QruDxUEklPLX
=d2Oq
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
