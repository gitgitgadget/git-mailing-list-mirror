From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 05/12] Replace instanceof in WalkFetchConnection with getType()
Date: Mon,  2 Jun 2008 23:24:36 +0200
Message-ID: <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXq-0006g0-23
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYFBVZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYFBVZG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:06 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYFBVZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:02 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aeWN/ANTVXq0H89qnxRGp7Toxt/cmiCEfZWG3GagZHI=;
        b=HzvLwt6nD4GG97k8hyqHyN98DfGdfgWSKwXIgG5F53xttVSFAEON7keIcgTH7KqMHzjxzOV6lNXSn/3Xzutu527+YaZh/nrG7pC6khbNhrbxlqASOWPwRHXg3AlEmW07Ybq3QGOCce/xaA3SkVLW7evxwTpp+TXcSHYOi3Lmeew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NVRpPK+hDrWr6IbBryKq8I2ufj8rwkZYM6vHA7MVbRPHIiqXDmdnJ/r1DUHzVJKVWaAzhOL8Ib5TQnEYn2PM6PhYiNdZ6taIJoFxGNqwGjvIeGxIH8LicPDZFPmKUDJLXwLviFzBO/r6rCBUCYSy33PQX94aeoh3ozQUONsFjmo=
Received: by 10.103.24.11 with SMTP id b11mr5782673muj.98.1212441901944;
        Mon, 02 Jun 2008 14:25:01 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id g1sm21232934muf.7.2008.06.02.14.25.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83571>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../jgit/transport/WalkFetchConnection.java        |   36 +++++++++++--------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 4edeb93..45c2ded 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -66,7 +66,6 @@ import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.UnpackedObjectLoader;
 import org.spearce.jgit.revwalk.DateRevQueue;
-import org.spearce.jgit.revwalk.RevBlob;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
@@ -251,20 +250,22 @@ class WalkFetchConnection extends FetchConnection {
 		//
 		obj.dispose();
 
-		if (obj instanceof RevBlob)
-			processBlob(obj);
-
-		else if (obj instanceof RevTree)
+		switch (obj.getType()) {
+		case Constants.OBJ_BLOB:
+			processBlob(obj);	
+			break;
+		case Constants.OBJ_TREE:
 			processTree(obj);
-
-		else if (obj instanceof RevCommit)
+			break;
+		case Constants.OBJ_COMMIT:
 			processCommit(obj);
-
-		else if (obj instanceof RevTag)
+			break;
+		case Constants.OBJ_TAG:
 			processTag(obj);
-
-		else
+			break;
+		default:
 			throw new TransportException("Unknown object type " + obj.getId());
+		}
 
 		// If we had any prior errors fetching this object they are
 		// now resolved, as the object was parsed successfully.
@@ -632,19 +633,24 @@ class WalkFetchConnection extends FetchConnection {
 	}
 
 	private void markLocalObjComplete(RevObject obj) throws IOException {
-		while (obj instanceof RevTag) {
+		while (obj.getType() == Constants.OBJ_TAG) {
 			obj.add(COMPLETE);
 			obj.dispose();
 			obj = ((RevTag) obj).getObject();
 			revWalk.parse(obj);
 		}
 
-		if (obj instanceof RevBlob)
+		switch (obj.getType()) {
+		case Constants.OBJ_BLOB:
 			obj.add(COMPLETE);
-		else if (obj instanceof RevCommit)
+			break;
+		case Constants.OBJ_COMMIT:			
 			pushLocalCommit((RevCommit) obj);
-		else if (obj instanceof RevTree)
+			break;
+		case Constants.OBJ_TREE:
 			markTreeComplete((RevTree) obj);
+			break;
+		}
 	}
 
 	private void markLocalCommitsComplete(final int until)
-- 
1.5.5.1
