From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix an infinite loop in sq_quote_buf().
Date: Sun, 04 Nov 2007 22:37:59 +0100
Message-ID: <20071104213759.GD4207@artemis.corp>
References: <200711042126.22512.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iVCmgExH7+hIHJ1A";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IonAg-0008B5-0T
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbXKDViE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbXKDViC
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:38:02 -0500
Received: from pan.madism.org ([88.191.52.104]:47333 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbXKDViA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:38:00 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C0D8825E02;
	Sun,  4 Nov 2007 22:37:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 566123F6A1; Sun,  4 Nov 2007 22:37:59 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200711042126.22512.johannes.sixt@telecom.at>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63447>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 08:26:22PM +0000, Johannes Sixt wrote:
> sq_quote_buf() treats single-quotes and exclamation marks specially, but
> it incorrectly parsed the input for single-quotes and backslashes.
>=20
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  quote.c          |    2 +-
>  t/t5510-fetch.sh |    7 +++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/quote.c b/quote.c
> index 482be05..919d092 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -26,7 +26,7 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
> =20
>  	strbuf_addch(dst, '\'');
>  	while (*src) {
> -		size_t len =3D strcspn(src, "'\\");
> +		size_t len =3D strcspn(src, "'!");
>  		strbuf_add(dst, src, len);
>  		src +=3D len;
>  		while (need_bs_quote(*src)) {

  Ouch, good catch :/ sorry about that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLju3vGr7W6HudhwRAiQtAJ4m6z5gRDzfaMNw3AnzhVL7m/Z52wCdH1eF
8/0dOlilOb549Zhr4nfMdyM=
=a5i2
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
