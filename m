From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 04/24] read-cache: clear version in discard_index()
Date: Sun, 18 Aug 2013 21:41:53 +0200
Message-ID: <1376854933-31241-5-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xd-0003i3-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3HRTsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:18 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:56676 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:16 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so2838884wgh.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhxLWGttCFS8j4sOSQHteX+aH0Z0tE7P8pz3N663ZcI=;
        b=q9Wl5ufgR3FbYi7Txm31GaLwx6M/OX6xUbVH+MeZePbwxunYWVWjaptXVrWw1GXFyK
         +eiwM7TT5+EvmFqvnO2eHa+n6bEA4rX0Gice26qfBB3LpQsoqHs6idNhzUTYs/aj65oq
         yqsgluOeHQCjzzzN69VgZgOOGowJpVvgfyBRPMXmB/Sf6KsD/+mh/e7UmfeVlWjjhdRf
         6Xhrdkd1E9O83XgD1CPt7Pq9+AJcDbVBzksZWU6fZXzJDZAvt2PlOElTm7lJDwyyeKSO
         miXwVrs4mblU2CZLx3viT/OIIqPTeE12e2W0IXE0Hg6/FhqmIHKJrDicHAUs5jtPhuXk
         Ykag==
X-Received: by 10.180.36.50 with SMTP id n18mr5407797wij.8.1376855295435;
        Sun, 18 Aug 2013 12:48:15 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id ee5sm12123481wib.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232492>

All fields except index_state->version are reset in discard_index.
Reset the version too.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index de0bbcd..1e22f6f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1558,6 +1558,7 @@ int discard_index(struct index_state *istate)
 	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
 	resolve_undo_clear_index(istate);
+	istate->version = 0;
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
 	istate->timestamp.sec = 0;
-- 
1.8.3.4.1231.g9fbf354.dirty
