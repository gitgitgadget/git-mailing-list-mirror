From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 10/14] dir.c: use ALLOC_GROW() in create_simplify()
Date: Tue,  4 Mar 2014 02:31:58 +0400
Message-ID: <1393885922-21616-11-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ0-0002Y2-DM
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbaCCWcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:45 -0500
Received: from forward1l.mail.yandex.net ([84.201.143.144]:58956 "EHLO
	forward1l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbaCCWco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:44 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward1l.mail.yandex.net (Yandex) with ESMTP id 1B6B31520E2C;
	Tue,  4 Mar 2014 02:32:43 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id D03EC1E1112;
	Tue,  4 Mar 2014 02:32:42 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WgvCfRWb;
	Tue,  4 Mar 2014 02:32:42 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 2c0d6727-3b53-44c0-89a8-a5ea609d8dfe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885962;
	bh=0o/XqBnm+wn40GkP6GuZWYqXsjURCcXw5DXWfQM3wDo=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=O8CGhGw7j2rPuJOMu8mQm+0TTWM/kjFQvQpezTGUpCWW3+QsBTgOY2Pfj1qkcJvMf
	 p9CY3xn6HsbGGIqhRvQbl6B6HUCyWE59OwBwkBNqs4RAU5pZKJB/U9k48F7/TveaPh
	 mMutTkCxDoQqr/zLRpA3QB/bFcCducGbd+O8ctbI=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243284>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 98bb50f..4ae38e4 100644
--- a/dir.c
+++ b/dir.c
@@ -1341,10 +1341,7 @@ static struct path_simplify *create_simplify(const char **pathspec)
 
 	for (nr = 0 ; ; nr++) {
 		const char *match;
-		if (nr >= alloc) {
-			alloc = alloc_nr(alloc);
-			simplify = xrealloc(simplify, alloc * sizeof(*simplify));
-		}
+		ALLOC_GROW(simplify, nr + 1, alloc);
 		match = *pathspec++;
 		if (!match)
 			break;
-- 
1.8.3.2
