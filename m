From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Speedup scanning for excluded files.
Date: Mon, 29 Oct 2007 09:02:34 +0100
Message-ID: <20071029080234.GA22826@artemis.corp>
References: <200710290845.26727.lars@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+QahgC5+KEYLbs62";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Lars Knoll <lars@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 09:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImPaH-00035T-F4
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 09:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbXJ2ICi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbXJ2ICh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 04:02:37 -0400
Received: from pan.madism.org ([88.191.52.104]:42463 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbXJ2ICg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 04:02:36 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 38B53274A5;
	Mon, 29 Oct 2007 09:02:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 27E651A691; Mon, 29 Oct 2007 09:02:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Lars Knoll <lars@trolltech.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200710290845.26727.lars@trolltech.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62609>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2007 at 07:45:26AM +0000, Lars Knoll wrote:
> +static int no_wildcard(const char *string)
> +{
> +    return !strchr(string, '*') && !strchr(string, '?')=20
> && !strchr(string, '[') && !strchr(string, '{');

       return string[strcspn(string, "*?[{")] =3D=3D '\0';

is faster as it doesn't scan the string 4 time in the case where there
is no wildcard.

> +}
> +
>  void add_exclude(const char *string, const char *base,
>  		 int baselen, struct exclude_list *which)
>  {
>  	struct exclude *x =3D xmalloc(sizeof (*x));
> =20
> +        x->to_exclude =3D 1;

  You used spaces in here, and in many places of your patch.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJZOavGr7W6HudhwRAkEKAKCCfy7TOylF4HOLVtNuE379ZEjeyQCfSK9v
5LB5LIXtO0FtS77xQTVtH20=
=d5Ly
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
