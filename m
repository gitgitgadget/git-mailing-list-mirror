From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Thu, 16 Oct 2008 10:23:40 +0200
Message-ID: <20081016082340.GB15266@artemis.corp>
References: <1224111343-17433-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8GpibOaaTibBMecb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 10:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqOAG-0001g7-76
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 10:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYJPIXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 04:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYJPIXp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 04:23:45 -0400
Received: from pan.madism.org ([88.191.52.104]:41670 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbYJPIXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 04:23:44 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A28FA3E6C2;
	Thu, 16 Oct 2008 10:23:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 15AC82A36A; Thu, 16 Oct 2008 10:23:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224111343-17433-1-git-send-email-vmiklos@frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98351>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2008 at 10:55:43PM +0000, Miklos Vajna wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>=20
> NOTE: I introduced the force/quiet/not_new helper variables because they
> are originally bitfields, so passing their address is not possible. One
> could say that introducing helper functions for those as well would be
> nicer, but I think that would just make the code even longer with no
> good reason.

Well the alternative is to replace the bitfields with an enum, but it's
not always that nice as a result. C bit-fields sucks when it comes to
address them, it's silly not to be able to have the same as offsetof in
"bits" for a structure, but oh well.

> diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
> index 4ba2702..e241cd1 100644
> --- a/builtin-checkout-index.c
> +++ b/builtin-checkout-index.c
> @@ -40,6 +40,7 @@
>  #include "cache.h"
>  #include "quote.h"
>  #include "cache-tree.h"
> +#include "parse-options.h"
> =20
>  #define CHECKOUT_ALL 4
>  static int line_termination =3D '\n';
> @@ -153,11 +154,55 @@ static void checkout_all(const char *prefix, int pr=
efix_length)
>  		exit(128);
>  }
> =20
> -static const char checkout_cache_usage[] =3D
> -"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=3D[123]|all] [--pr=
efix=3D<string>] [--temp] [--] <file>...";
> +static const char * const builtin_checkout_index_usage[] =3D {
> +	"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=3D[123]|all] [--p=
refix=3D<string>] [--temp] [--] <file>...",
> +	NULL
> +};

Since git checkout-index -h will show you all the options, I usually
prefer to use "[options] [--] <file>...", it's 10x as readable, and the
user will have the [options] detail just below.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj2+gwACgkQvGr7W6HudhyZlgCdGDLe1FwbjrW+THlsNu1E3I5g
X0oAoIhkkgOv1SGjfRA7wQ0dwGQqP0SM
=rMml
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
