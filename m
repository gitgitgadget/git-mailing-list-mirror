From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 08/12] process_tag: handle tag->tagged == NULL
Date: Mon, 18 Feb 2008 21:47:59 +0100
Message-ID: <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvh-0000iE-PJ
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbYBRUs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbYBRUs2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:28 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40286 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760633AbYBRUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 942096CF0060;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUYxS4uTxJVU; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 04DEF6CF0063; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74345>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 reachable.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/reachable.c b/reachable.c
index 937af57..339be7f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -79,7 +79,8 @@ static void process_tag(struct tag *tag, struct object_array *p, const char *nam
 
 	if (parse_tag(tag) < 0)
 		die("bad tag object %s", sha1_to_hex(obj->sha1));
-	add_object(tag->tagged, p, NULL, name);
+	if (tag->tagged)
+		add_object(tag->tagged, p, NULL, name);
 }
 
 static void walk_commit_list(struct rev_info *revs)
-- 
1.5.4.1.g96b77
