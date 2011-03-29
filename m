From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Minor cosmetic defect in git-pack-objects output
Date: Tue, 29 Mar 2011 12:10:40 +0200
Message-ID: <20110329121040.de22bd56.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__29_Mar_2011_12_10_40_+0200_CUK/rVbxrzcju+9w"
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 12:16:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Vy6-00015K-NN
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 12:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1C2KQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 06:16:03 -0400
Received: from smtp209.alice.it ([82.57.200.105]:51098 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab1C2KQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 06:16:02 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Mar 2011 06:16:02 EDT
Received: from jcn (82.55.137.85) by smtp209.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4D498EF304A813A8; Tue, 29 Mar 2011 12:10:52 +0200
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.24.3; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170253>

--Signature=_Tue__29_Mar_2011_12_10_40_+0200_CUK/rVbxrzcju+9w
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in some cases, on git-pack-objects failure, there is a small defect in
the output, see:

# git gc --aggressive
Counting objects: 1954118, done.
Delta compression using up to 2 threads.
warning: suboptimal pack - out of memory02)  =20
Compressing objects: 100% (1936802/1936802), done.
Writing objects: 100% (1954118/1954118), done.
Total 1954118 (delta 1618716), reused 0 (delta 0)

The defect is here:
warning: suboptimal pack - out of memory02)
                                        ^^^
the trailing chars are from the replaced line which was ending in
1936802)

AFAICS this is basically what is happening:
#include "git-compat-util.h"
fprintf(stderr, "Compressing objects:  15% (296661/1936802)\r");
                 warning("suboptimal pack - out of memory");

I can think to a dumb workaround for this particular path but maybe
there are other places when this can happen as well.

Anyway it is not a big deal, but since I noticed it I wanted to report
that.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__29_Mar_2011_12_10_40_+0200_CUK/rVbxrzcju+9w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2RsCAACgkQ5xr2akVTsAGYIwCgiaV2KSjPgNRotnTTtEuYSC3W
agQAoJI7pnNJ3Gx8LOa8NnexOZjE8zfO
=vr7o
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Mar_2011_12_10_40_+0200_CUK/rVbxrzcju+9w--
