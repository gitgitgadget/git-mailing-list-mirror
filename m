From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 02/12] get_sha1_oneline: check return value of parse_object
Date: Mon, 18 Feb 2008 21:47:53 +0100
Message-ID: <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvc-0000iE-Aj
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbYBRUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbYBRUsL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:11 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40265 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760880AbYBRUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id DB3BB680BF87;
	Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RUxnqDQUygx; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 994C8680BF93; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74350>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 sha1_name.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index ed3c867..f8506bf 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -620,7 +620,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		unsigned long size;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		parse_object(commit->object.sha1);
+		if (!parse_object(commit->object.sha1))
+			continue;
 		if (temp_commit_buffer)
 			free(temp_commit_buffer);
 		if (commit->buffer)
-- 
1.5.4.1.g96b77
