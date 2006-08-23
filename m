From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix a comparison bug in diff-delta.c
Date: Wed, 23 Aug 2006 04:38:02 +0200
Organization: Polytechnique.org
Message-ID: <200608230438.06053.madcoder@debian.org>
References: <1156300368160-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2089568.lWsS9NSVXn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 23 04:38:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFidB-00079I-EP
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 04:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWHWCiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 22:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWHWCiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 22:38:09 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:13485 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S932292AbWHWCiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 22:38:08 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 6676D331DD
	for <git@vger.kernel.org>; Wed, 23 Aug 2006 04:38:07 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <1156300368160-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Wed Aug 23 04:38:07 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000000, queueID=7F9A63337E
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25889>

--nextPart2089568.lWsS9NSVXn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mer 23 ao=C3=BBt 2006 04:32, Pierre Habouzit a =C3=A9crit :
> =C2=A0 I'm currently trying to make git compile with more strict gcc flags
> (-g -O2 -Wall -Wextra -Wno-unused -Werror to be precise) and I've
> spotted a first bug due to a signed/unsigned comparison.

still in the same kind of "problems" sha1_name.c:512 has:

		if (active_nr < 0)
			return -1;

but active_nr is defined as an unsigned (in cache.h/cache-read.c).

Also note that there is a *lot* of signed/unsigned comparisons due to=20
the fact that it's unsigned, and that it's often compared to positions=20
that are ints (I assume pos need the negative values to mean "error").

so either those two lines are too much, or active_nr has to be a plain=20
signed int. I'm not used to git sources enough yet to be able to make=20
the right decision.
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart2089568.lWsS9NSVXn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE67+OvGr7W6HudhwRAtbYAJ9yRRalV9Usxw5mQlpvhMQDtpCXFACgi/IG
TYwsc9zELjHPU60DxNN8B4I=
=SahY
-----END PGP SIGNATURE-----

--nextPart2089568.lWsS9NSVXn--
