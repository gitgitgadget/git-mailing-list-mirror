From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-sh-setup: fix parseopt `eval`.
Date: Thu, 08 Nov 2007 10:14:02 +0100
Message-ID: <20071108091402.GA7391@artemis.corp>
References: <7vr6j15i3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="sdtB3X0nJg68CQEu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3Sw-0006De-CS
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbXKHJOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXKHJOG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:14:06 -0500
Received: from pan.madism.org ([88.191.52.104]:55858 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbXKHJOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:14:05 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 33A4D28BBD;
	Thu,  8 Nov 2007 10:14:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 63450F9B9; Thu,  8 Nov 2007 10:14:02 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6j15i3a.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63971>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 07:09:29AM +0000, Junio C Hamano wrote:
> The 'automagic parseopt' support corrupted non option parameters
> that had IFS characters in them.  The worst case can be seen
> when it has a non option parameter like this:
>=20
> 	$1=3D" * some string   blech"
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

> -	parseopt_extra=3D
> -	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
> -		parseopt_extra=3D"$parseopt_extra --keep-dashdash"
> +	[ -n "$OPTIONS_KEEPDASHDASH" ] && parseopt_extra=3D"--keep-dashdash"

  oh and this part is wrong because you're affected by $parseopt_extra
environment poisonning. And you have to fix git-clone.sh that uses
git-rev-parse --parsopt directly with the same call too (as it doesn't
use git-sh-setup).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMtNavGr7W6HudhwRAjKnAJ9PeTGxw/ML+DiHHFVyqXNs1VjJsACeIWxn
KHMAHprjT/cowN8wqlbvVuQ=
=4HGM
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
