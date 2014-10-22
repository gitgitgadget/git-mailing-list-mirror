From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] Documentation/technical: document push certificate format
Date: Wed, 22 Oct 2014 17:16:54 +0200
Message-ID: <31c4690b88947ff146f4e207a5ee159fd3010465.1413990838.git.git@drmicha.warpmail.net>
References: <cover.1413990838.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 17:17:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgxev-0006u3-3L
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 17:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbaJVPRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 11:17:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33851 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752197AbaJVPQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 11:16:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway2.nyi.internal (Postfix) with ESMTP id 676AF20A2F
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 11:16:58 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 22 Oct 2014 11:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=F04HI+9+XpZxyQ
	GaWY7aeFQIkLY=; b=juanr32a3yvJO/xw5wRSa9sagxQLYIHA/12uIGdAK7rwg9
	jz9pC9FWic7NzBSINM6nX6WDoEO9AkW1ij+vBzVAgcA+XFjGeJl7PqtL1qgFbG/E
	OK6UghJqmpytNBIdw2LdihyGR0KBA6vy3S9QgztrroWL+AMAX1loweVjZ+XO8=
X-Sasl-enc: 59QpDAWauyUBbSzlz7Xbhp+ffkb9Zu3/mV3doaE/Mc0I 1413991018
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1516B68016E;
	Wed, 22 Oct 2014 11:16:57 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
In-Reply-To: <cover.1413990838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/signature-format.txt | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 80f0a47..49c2c82 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -124,3 +124,38 @@ tagmess
 Conflicts:
 	...
 ----
+
+== Push certificate
+
+- created by: `git push --signed`
+- payload: a push certificate header followed by the push transcript
+  (see pack-protocol.txt)
+- embedding: append the signature to the push transcript
+- example: push of commit `21723` updating `master` on `localhost`
+  from `45cfe`
+
+----
+certificate version 0.1
+pusher Michael J Gruber <drmicha@warpmail.net> 1413979846 +0200
+pushee localhost:/tmp/t/a
+nonce 1413979846-48813c0bc9d3b598d71d
+
+45cfec8735b7842a32dcc092a14850aa6220ef33 217230e5793407fc7c099117011ed13143fece63 refs/heads/master
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1
+
+iQIcBAABCgAGBQJUR57GAAoJELR76rQkz552EWMP/3yHaFYuG3T/FcshgXQubsml
+t4TvkegjQFtVK31oedqaAQGJYusXX2/yUFviXpRq611Aj7rooBnpZYZKT5lUm/ol
+m9KjDvFpOiY7rA/y6BBetSX6s6uhmO4WcgJ4hSsMZ4z+001y2zawxWm0cedurIcO
+hpKbAmQ/EiMmQiA4D9vKmLJUXpzF63NzMElZfWzHLa0IU1ZN6EvH1l+N7ulBNsuv
+lTh3UxjabJr4vpu6kwMquCGqRB60+rdG7itiHwRQynnmDhvXoQxtU9gtLymXKJIS
+SGQ5v3B5hsGA2LkCCkvNj+QRLH9LF8iAZqezqGA5U/Cg7xckOPlMwFllTv8goDBW
+IB7Mk5lpQqaUCZf33uIppiEtHipLpGI90NLCm+JvzrNnnseSS6jARVRMx6cWp+dB
+9QTCq80mRI/zzcvDyPhNvj0tP3mUTFmR4+KRh+4zRq9iOGp5KpJrpFjndCQELwAW
+402hXEEjB4Kq7KSU4jEoaYGrJR9KJmPmgWHvz2GaJZ5eCJIXuoLGZo3TtxXRHB9p
+EqWp3iZOZotxZmUVHgohFhqxZgcAefdfzZUqQ8jY3hHvu5Zwd2muToc8Nh/vIHoB
+us0NHUiI8TOccAHd8AIrqgoXj2gChr3cQxWNcfBfx+ALT8sEtNrVkkrovmRiMEa4
+MxEdQTwhooEE8PWD5Yj5
+=6MAR
+-----END PGP SIGNATURE-----
+----
-- 
2.1.2.756.gfa53a0a
