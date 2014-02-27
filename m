From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] GSoC2014 microprojects #6 Change bundle.c:add_to_ref_list() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 00:18:14 +0800
Message-ID: <1393517894-670-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 17:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ3gZ-0004rs-5r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 17:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbaB0QTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 11:19:42 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35326 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaB0QTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 11:19:42 -0500
Received: by mail-pd0-f178.google.com with SMTP id x10so2629862pdj.9
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y0XahDuTLuUifeS9N54TA8lLQSTQ2d+64+XAqNxnIlk=;
        b=bHBSsNDwFztYKrFE5x59cKaHeGw7LIvR7paH9BvPUJmhl1BRvjoHzS31BNwu1153Xx
         0TokKDz3cku1D8B2Ife2CJ+4UrnfM7WcLZqs3GavEEShI0kN9WrTt4LK8/je9OWhiKqB
         BgzAsT6a5Tla1ZIutOBYf0T+d/YLU/8wmxvujF13ogJuyTtygstlXZAHMDPZ2LzZvgpk
         xdFI3MyuGZcIzelKdrQtZAibTM7ZT07949O1v3BWcdykT7I7RXj9X6MgLO4CLZYnU9er
         UbpUBW3pdHSVHWlkJr0bIbYDFTq0+qJwMlekaaBbP7QTtkUKazNhYM2e5lrd+XFndzHY
         Kz4Q==
X-Received: by 10.66.139.100 with SMTP id qx4mr16090332pab.141.1393517981541;
        Thu, 27 Feb 2014 08:19:41 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id ug9sm11841240pbc.11.2014.02.27.08.19.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 08:19:40 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242830>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 bundle.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index 7809fbb..1a7b7eb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
 static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		struct ref_list *list)
 {
-	if (list->nr + 1 >= list->alloc) {
-		list->alloc = alloc_nr(list->nr + 1);
-		list->list = xrealloc(list->list,
-				list->alloc * sizeof(list->list[0]));
-	}
+    ALLOC_GROW(list->list,list->nr,list->alloc);
 	hashcpy(list->list[list->nr].sha1, sha1);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
-- 
1.7.1
