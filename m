From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] refs.c: Remove unused get_ref_sha1()
Date: Thu, 15 Nov 2007 17:33:44 +0100
Message-ID: <1195144424-2991-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshfP-00009u-4U
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764806AbXKOQdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760194AbXKOQdv
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:33:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29191 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101AbXKOQdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:33:50 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IsheR-0003TN-Rq; Thu, 15 Nov 2007 17:33:12 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E91AD6C4; Thu, 15 Nov 2007 17:33:44 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id BFB63FA45; Thu, 15 Nov 2007 17:33:44 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.578.g1f8ec
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65134>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 refs.c |   12 ------------
 refs.h |    3 ---
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index aff02cd..ae53254 100644
--- a/refs.c
+++ b/refs.c
@@ -580,18 +580,6 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
 }
 
-/* NEEDSWORK: This is only used by ssh-upload and it should go; the
- * caller should do resolve_ref or read_ref like everybody else.  Or
- * maybe everybody else should use get_ref_sha1() instead of doing
- * read_ref().
- */
-int get_ref_sha1(const char *ref, unsigned char *sha1)
-{
-	if (check_ref_format(ref))
-		return -1;
-	return read_ref(mkpath("refs/%s", ref), sha1);
-}
-
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
diff --git a/refs.h b/refs.h
index 6eb98a4..9dc8aa0 100644
--- a/refs.h
+++ b/refs.h
@@ -26,9 +26,6 @@ extern int for_each_remote_ref(each_ref_fn, void *);
 
 extern int peel_ref(const char *, unsigned char *);
 
-/** Reads the refs file specified into sha1 **/
-extern int get_ref_sha1(const char *ref, unsigned char *sha1);
-
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
 extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
 
-- 
1.5.3.5.578.g1f8ec
