From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 05/12] process_tree/blob: check for NULL
Date: Mon, 18 Feb 2008 21:47:56 +0100
Message-ID: <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvc-0000iE-VX
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbYBRUsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760550AbYBRUsO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:14 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40271 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760204AbYBRUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3B82F6CF006B;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6EkvtrOzhCo5; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id C6E016A63A78; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74344>

As these functions are directly called with the result
from lookup_tree/blob, they must handle NULL.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 list-objects.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 4ef58e7..c8b8375 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -18,6 +18,8 @@ static void process_blob(struct rev_info *revs,
 
 	if (!revs->blob_objects)
 		return;
+	if (!obj)
+		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
@@ -69,6 +71,8 @@ static void process_tree(struct rev_info *revs,
 
 	if (!revs->tree_objects)
 		return;
+	if (!obj)
+		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	if (parse_tree(tree) < 0)
-- 
1.5.4.1.g96b77
