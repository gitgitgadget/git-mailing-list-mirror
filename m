From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and   optimize it a bit
Date: Sun, 07 Oct 2007 18:54:24 +0200
Message-ID: <20071007165424.GF10024@artemis.corp>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <Pine.LNX.4.64.0710071710190.4174@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="XIiC+We3v3zHqZ6Z";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZOm-000868-KE
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXJGQy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbXJGQy1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:54:27 -0400
Received: from pan.madism.org ([88.191.52.104]:34562 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbXJGQy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:54:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EEB5E23956;
	Sun,  7 Oct 2007 18:54:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 945F63837; Sun,  7 Oct 2007 18:54:24 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710071710190.4174@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60201>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 04:11:29PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 7 Oct 2007, Pierre Habouzit wrote:
>=20
> > On Sun, Oct 07, 2007 at 02:24:25PM +0000, Timo Hirvonen wrote:
> >
> > > strbuf->buf is always non-NULL and NUL-terminated so you could just do
> > >=20
> > > static inline int strbuf_cmp(const struct strbuf *a, const struct str=
buf *b)
> > > {
> > > 	int len =3D a->len < b->len ? a->len : b->len;
> > > 	return memcmp(a->buf, b->buf, len + 1);
> > > }
> >=20
> >   doesn't work, because a buffer can have (in some very specific cases)
> > an embeded NUL.
>=20
> But it should work.  The function memcmp() could not care less if there i=
s=20
> a NUL or not, it just compares until it finds a difference.

  not if your one of your strbuf has as prefix, the other followed by
'\0', then anything else (including nothing ;p).

  Your test would yield equality.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCQ9AvGr7W6HudhwRAuD6AJ914AFzKepL2222iuQv/hS4rjBhgQCbBE45
x5lWg/Gscm+i96wH1/nsdOo=
=oxks
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
