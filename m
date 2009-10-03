From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 5/6] This assertion is valid for both loose and packed objects
Date: Sat,  3 Oct 2009 20:10:00 +0200
Message-ID: <1254593401-18801-6-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
 <1254593401-18801-2-git-send-email-herve@itaapy.com>
 <1254593401-18801-3-git-send-email-herve@itaapy.com>
 <1254593401-18801-4-git-send-email-herve@itaapy.com>
 <1254593401-18801-5-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96e-0004eY-Fe
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773AbZJCSKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbZJCSKE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:10:04 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54312 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZJCSKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:10:02 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id E620E4B005A;
	Sat,  3 Oct 2009 20:08:48 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 016554B0189;
	Sat,  3 Oct 2009 20:08:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-5-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129491>

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index bc26cf7..dd3c142 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -1149,11 +1149,10 @@ void git_odb_close(git_odb *db)
 	free(db);
 }
=20
-int git_odb_read(
-	git_obj *out,
-	git_odb *db,
-	const git_oid *id)
+int git_odb_read(git_obj *out, git_odb *db, const git_oid *id)
 {
+	assert(out && db && id);
+
 attempt:
 	if (!git_odb__read_packed(out, db, id))
 		return GIT_SUCCESS;
@@ -1171,8 +1170,6 @@ int git_odb__read_loose(git_obj *out, git_odb *db=
, const git_oid *id)
 	char file[GIT_PATH_MAX];
 	gitfo_buf obj =3D GITFO_BUF_INIT;
=20
-	assert(out && db && id);
-
 	out->data =3D NULL;
 	out->len  =3D 0;
 	out->type =3D GIT_OBJ_BAD;
--=20
1.6.4.4
