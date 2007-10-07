From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Sun, 07 Oct 2007 16:39:12 +0200
Message-ID: <20071007143912.GB10024@artemis.corp>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NDin8bjvE/0mNLFQ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 16:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeXI7-0003XK-QI
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXJGOjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXJGOjQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:39:16 -0400
Received: from pan.madism.org ([88.191.52.104]:38913 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804AbXJGOjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:39:14 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8208B15E;
	Sun,  7 Oct 2007 16:39:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 03FF81513EB; Sun,  7 Oct 2007 16:39:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20071007172425.bb691da9.tihirvon@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60181>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 02:24:25PM +0000, Timo Hirvonen wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>=20
> > +static inline int strbuf_cmp(const struct strbuf *a, const struct strb=
uf *b)
> > +{
> > +	int len =3D a->len < b->len ? a->len: b->len;
> > +	int cmp =3D memcmp(a->buf, b->buf, len);
> > +	if (cmp)
> > +		return cmp;
> > +	return a->len < b->len ? -1: a->len !=3D b->len;
> > +}
>=20
> strbuf->buf is always non-NULL and NUL-terminated so you could just do
>=20
> static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf =
*b)
> {
> 	int len =3D a->len < b->len ? a->len : b->len;
> 	return memcmp(a->buf, b->buf, len + 1);
> }

  doesn't work, because a buffer can have (in some very specific cases)
an embeded NUL.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCO+QvGr7W6HudhwRAm3jAJ95fUDIsxAsV3sYEhpc3CAvmcJJDACeOw3H
Z8JZWmciOmE+L/VCzyJGuK4=
=IKDv
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
