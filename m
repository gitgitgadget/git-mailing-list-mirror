From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] submodule: remove redundant check for the_index.initialized
Date: Sun,  9 Jun 2013 18:33:45 +0200
Message-ID: <1370795625-10506-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliZ2-0007r3-8b
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab3FIQdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 12:33:52 -0400
Received: from india601.server4you.de ([85.25.151.105]:59080 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3FIQdv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:33:51 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BE82C.dip0.t-ipconnect.de [87.155.232.44])
	by india601.server4you.de (Postfix) with ESMTPSA id 69D68FD;
	Sun,  9 Jun 2013 18:33:49 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226970>

read_cache already performs the same check and returns immediately if
the cache has already been loaded.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 submodule.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index e728025..1821a5b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -603,9 +603,8 @@ int fetch_populated_submodules(const struct argv_ar=
ray *options,
 	if (!work_tree)
 		goto out;
=20
-	if (!the_index.initialized)
-		if (read_cache() < 0)
-			die("index file corrupt");
+	if (read_cache() < 0)
+		die("index file corrupt");
=20
 	argv_array_push(&argv, "fetch");
 	for (i =3D 0; i < options->argc; i++)
--=20
1.8.3
