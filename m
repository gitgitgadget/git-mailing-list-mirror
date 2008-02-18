From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 09/12] process_tree/blob: check for NULL
Date: Mon, 18 Feb 2008 21:48:00 +0100
Message-ID: <12033676842301-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvg-0000iE-Dy
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYBRUsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbYBRUsY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:24 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40287 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761454AbYBRUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id AAFBE6CF0061;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UBIWj2rqwtT; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 12A3A680BF93; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74346>

As these functions are directly called with the result
from lookup_tree/blob, they must handle NULL.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 reachable.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/reachable.c b/reachable.c
index 339be7f..3b1c18f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -15,6 +15,8 @@ static void process_blob(struct blob *blob,
 {
 	struct object *obj = &blob->object;
 
+	if (!blob)
+		die("bad blob object");
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
@@ -39,6 +41,8 @@ static void process_tree(struct tree *tree,
 	struct name_entry entry;
 	struct name_path me;
 
+	if (!tree)
+		die("bad tree object");
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
-- 
1.5.4.1.g96b77
