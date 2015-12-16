From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] credential-store: don't pass strerror to die_errno()
Date: Wed, 16 Dec 2015 12:22:55 +0100
Message-ID: <1450264975-9760-1-git-send-email-szeder@ira.uka.de>
References: <1449138687-23675-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 12:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9ABN-0007rs-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 12:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbbLPLXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2015 06:23:41 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44730 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752679AbbLPLXl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 06:23:41 -0500
Received: from x4db0f3a3.dyn.telefonica.de ([77.176.243.163] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a9ABD-0003Pn-67; Wed, 16 Dec 2015 12:23:36 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
In-Reply-To: <1449138687-23675-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1450265016.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282548>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

v2 fixed this, but it fell on the floor, I suppose because of the
maintainer switch.  Anyway, I should have noticed it while the patch
was still cooking, sorry.

 credential-store.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index fc67d16c1088..54c4e0473737 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -64,8 +64,7 @@ static void rewrite_credential_file(const char *fn, s=
truct credential *c,
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
-		die_errno("unable to write credential store: %s",
-			  strerror(errno));
+		die_errno("unable to write credential store");
 }
=20
 static void store_credential_file(const char *fn, struct credential *c=
)
--=20
2.7.0.rc0.37.g77d69b9
