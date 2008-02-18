From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 04/12] add_one_tree: handle NULL from lookup_tree
Date: Mon, 18 Feb 2008 21:47:55 +0100
Message-ID: <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:48:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCuo-0000Mg-Ru
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760476AbYBRUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbYBRUsI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:08 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40270 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760782AbYBRUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2D957680C0A5;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3Czg7Pyyguf; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B3E0D680CD42; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74341>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 reachable.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/reachable.c b/reachable.c
index 823e324..937af57 100644
--- a/reachable.c
+++ b/reachable.c
@@ -150,7 +150,8 @@ static int add_one_reflog(const char *path, const unsigned char *sha1, int flag,
 static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
 {
 	struct tree *tree = lookup_tree(sha1);
-	add_pending_object(revs, &tree->object, "");
+	if (tree)
+		add_pending_object(revs, &tree->object, "");
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
-- 
1.5.4.1.g96b77
