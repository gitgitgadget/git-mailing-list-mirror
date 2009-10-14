From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 5/6] This assertion is valid for both loose and packed objects
Date: Wed, 14 Oct 2009 12:37:48 +0200
Message-ID: <1255516669-26745-5-git-send-email-herve@itaapy.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com>
 <1255516669-26745-2-git-send-email-herve@itaapy.com>
 <1255516669-26745-3-git-send-email-herve@itaapy.com>
 <1255516669-26745-4-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qg-0004AO-56
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbZJNKpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 06:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756178AbZJNKpm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:45:42 -0400
Received: from mailhost-p4-p2.nerim.net ([195.5.209.61]:52411 "EHLO
	smtp-delay1.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755168AbZJNKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:45:41 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 06:45:41 EDT
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by smtp-delay1.nerim.net (Postfix) with ESMTP id A97C8B3B31C
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:36:54 +0200 (CEST)
Received: from localhost.localdomain (itaapy-35-170.cnt.nerim.net [213.215.35.170])
	by mallaury.nerim.net (Postfix) with ESMTP id 5A3C7A1083
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:35:53 +0200 (CEST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1255516669-26745-4-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130281>

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index c71948b..a612299 100644
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
1.6.5
