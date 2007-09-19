From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/5] sq_quote_argv and add_to_string rework with strbuf's.
Date: Wed, 19 Sep 2007 10:23:13 +0200
Message-ID: <20070919082313.GD28205@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224120.1DC44344AB3@madism.org> <7v3axbqdnw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="76DTJ5CE0DCVQemd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:23:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuq7-0001AL-Ns
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbXISIXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbXISIXP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:23:15 -0400
Received: from pan.madism.org ([88.191.52.104]:47066 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbXISIXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:23:14 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AC57A57F;
	Wed, 19 Sep 2007 10:23:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5F92E4CA59; Wed, 19 Sep 2007 10:23:13 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3axbqdnw.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58693>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:09:55AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > * sq_quote_buf is made public, and works on a strbuf.
> > * sq_quote_argv also works on a strbuf.
> > * make sq_quote_argv take a "maxlen" argument to check the buffer won't=
 grow
> >   too big.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  connect.c |   21 ++++++--------
> >  git.c     |   16 +++-------
> >  quote.c   |   91 ++++++++++++++++-------------------------------------=
--------
> >  quote.h   |    9 ++----
> >  rsh.c     |   33 ++++++----------------
> >  trace.c   |   35 +++++++-----------------
> >  6 files changed, 60 insertions(+), 145 deletions(-)
> > ...
> > diff --git a/quote.c b/quote.c
> > index d88bf75..4df3262 100644
> > --- a/quote.c
> > +++ b/quote.c
> > @@ -20,29 +20,26 @@ static inline int need_bs_quote(char c)
> >  	return (c =3D=3D '\'' || c =3D=3D '!');
> >  }
> > =20
> > -static size_t sq_quote_buf(char *dst, size_t n, const char *src)
> > +void sq_quote_buf(struct strbuf *dst, const char *src)
> >  {
>=20
> You got rid of use of EMIT() macro which is local to this
> function, so you need to remove the #undef/#define in front of
> the function as well.

  Isn't it used by the function before ? hmm I'll check then.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8NxxvGr7W6HudhwRAq6KAKCpZRULDIgPxrrsm4R5Qv4A2emcNACeN6Zm
2aVByvynhSb+aszu59HWbIA=
=q1C5
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
