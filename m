From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Invert numbers and names in the git-shortlog summary mode.
Date: Tue, 11 Dec 2007 15:43:51 +0100
Message-ID: <20071211144351.GA15448@artemis.madism.org>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="opJtzjQTFsWo+cga";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Dec 11 15:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26LJ-000139-Jw
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXLKOnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 09:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXLKOnz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:43:55 -0500
Received: from pan.madism.org ([88.191.52.104]:35132 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbXLKOny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 09:43:54 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4C7E9285E2;
	Tue, 11 Dec 2007 15:43:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 309EB49EC23; Tue, 11 Dec 2007 15:43:51 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071211140508.GA12204@elte.hu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67861>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also make it `cut` friendly using a tab to separate the numbers and names.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    On Tue, Dec 11, 2007 at 02:05:08PM +0000, Ingo Molnar wrote:
    > please switch around the column too so that the commit count comes=20
    > first, this is way too ugly:
    >=20
    >  Junio C Hamano: 4826
    >  Shawn O. Pearce: 1146
    >  Linus Torvalds: 950
    [...]

    Agreed, here is the patch that does that, and a sample output is:

        $ git shortlog -n -s -e HEAD -- builtin-commit.c
            11	Junio C Hamano <gitster@pobox.com>
             6	Johannes Schindelin <Johannes.Schindelin@gmx.de>
             6	Kristian H=C3=B8gsberg <krh@redhat.com>
             2	Jeff King <peff@peff.net>
             1	Alex Riesen <raa.lkml@gmail.com>
             1	Pierre Habouzit <madcoder@debian.org>
             1	Shawn Bohrer <shawn.bohrer@gmail.com>
             1	Wincent Colaiuta <win@wincent.com>


 builtin-shortlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 13df0c6..90666cb 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -265,7 +265,7 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		struct path_list *onelines =3D list.items[i].util;
=20
 		if (summary) {
-			printf("%s: %d\n", list.items[i].path, onelines->nr);
+			printf("%6d\t%s\n", onelines->nr, list.items[i].path);
 		} else {
 			printf("%s (%d):\n", list.items[i].path, onelines->nr);
 			for (j =3D onelines->nr - 1; j >=3D 0; j--) {
--=20
1.5.3.7.2226.g8312-dirty


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXqInvGr7W6HudhwRArRZAJ4xVK4nIpwtYDR5XzekwIW1JwTXqwCfTp/a
1CelFUXOyIKbHwzyMwBYZCY=
=GYfy
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
