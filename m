From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-options: fix segmentation fault when a required value  is missing
Date: Mon, 21 Jul 2008 21:07:10 +0200
Message-ID: <20080721190709.GD2718@artemis.madism.org>
References: <4884D5CC.2070007@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="veXX9dWIonWZEC6h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0k9-0004G5-KL
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYGUTHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYGUTHR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:07:17 -0400
Received: from pan.madism.org ([88.191.52.104]:46232 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbYGUTHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:07:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A2F9A34D94;
	Mon, 21 Jul 2008 21:07:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2366FE55C8; Mon, 21 Jul 2008 21:07:10 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4884D5CC.2070007@free.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89384>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2008 at 06:30:36PM +0000, Olivier Marin wrote:
> From: Olivier Marin <dkr@freesurf.fr>
>=20
> p->argc represent the number of arguments that have not been parsed yet,
> _including_ the one we are currently parsing. If it is not greater than
> one then there is no more argument.
>=20
> Signed-off-by: Olivier Marin <dkr@freesurf.fr>
Acked-by: Pierre Habouzit <madcoder@debian.org>

> ---
>  I hope this is the right fix.
>=20
>  parse-options.c          |    2 +-
>  t/t0040-parse-options.sh |    7 +++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index 987b015..71a7acf 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -22,7 +22,7 @@ static int get_arg(struct parse_opt_ctx_t *p, const str=
uct option *opt,
>                 p->opt =3D NULL;
>         } else if (p->argc =3D=3D 1 && (opt->flags & PARSE_OPT_LASTARG_DE=
FAULT)) {
>                 *arg =3D (const char *)opt->defval;
> -       } else if (p->argc) {
> +       } else if (p->argc > 1) {
>                 p->argc--;
>                 *arg =3D *++p->argv;
>         } else

  Gasp thanks, Junio pointed it to me already, and for some reason this
hasn't made it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiE3l0ACgkQvGr7W6HudhzjLACgosU0JRvONC6v1Lxbz3VqBv69
Q6oAn2S0XuYw18e3aSNyQb1/QlzC/9cr
=omWs
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
