From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-apply: use strbuf's instead of buffer_desc's.
Date: Sun, 16 Sep 2007 10:15:19 +0200
Message-ID: <20070916081519.GB21810@artemis.corp>
References: <20070915141210.GA27494@artemis.corp> <20070915141340.334CA4C152@madism.org> <7v4phv8m26.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="DKU6Jbt7q3WqK7+M";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWpHr-0002pf-HO
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXIPIPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXIPIPW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:15:22 -0400
Received: from pan.madism.org ([88.191.52.104]:45792 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbXIPIPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:15:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 73B1E78B;
	Sun, 16 Sep 2007 10:15:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 197F14CA97; Sun, 16 Sep 2007 10:15:19 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4phv8m26.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2007 at 12:56:49AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >  1 files changed, 73 insertions(+), 130 deletions(-)
>=20
> Nice reduction.
>=20
> > -		}
> > -		return got !=3D size;
> > +
> > +		nsize =3D buf->len;
> > +		nbuf =3D convert_to_git(path, buf->buf, &nsize);
> > +		if (nbuf)
> > +			strbuf_embed(buf, nbuf, nsize, nsize);
> > +		return 0;
>=20
>=20
> I suspect that changing the convert_to_git() interface to work
> on strbuf instead of (char*, size_t *) pair might make things
> simpler and easier.

  Well, yes, maybe it could use:
  (const char *, char *, size_t, struct strbuf *out);

  But this function is used elsewhere where there isn't strbuf's (yet ?)
so I wasn't willing to do such a big change. But as you seem to think it
would help, I'll evaluate where it's going.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7OYXvGr7W6HudhwRAiXzAJ49i59QD/sow5mFaTh19dOwM5QutgCfdR90
V4xv7/f7v8DPjT60BRaufZk=
=JWWt
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
