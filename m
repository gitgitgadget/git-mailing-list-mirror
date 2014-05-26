From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 07/15] hash.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:48 +0900
Message-ID: <1401118436-66090-8-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowvU-0004kf-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbaEZPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:58 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52645 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbaEZPez (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:55 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so7784290pad.11
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KXMVYqSNMxQqTIQRRlwUosN4T52s6dV/yPAXbWQaFOU=;
        b=QENdfrtAaMsH566qVk6kFda9GC3lILek8XAc2z6nPpDjuDEG8G7/Vj3UB/d3GqTD+c
         WxbfIBFDxDLwF/BQP2S5/90N1VyxGRN41jvGhtK0Kx0j0p+E0R28/mdSmAP5RLhDA25Y
         OwEb9FiaTKpcAnniCTGcGye3/cIgHTpMIYY3gYJFPBrSga3Qt/usoUhhxNrBcQZkl+8t
         3A9Zaw/OYB34tgLo9lZjYJr6vxHF8QgVkPfihqjAjwh/6Bubrg2oTUwMDRkKlfaG+Ze8
         ux1Qt0KbFSlj0IB5a2aPKwakDcpM1QFWyD4wSSJB7pyWRDfXTKabGVnPomunOM8L3aZg
         tixQ==
X-Received: by 10.66.171.138 with SMTP id au10mr29520901pac.102.1401118495569;
        Mon, 26 May 2014 08:34:55 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250096>

xcalloc takes two arguments: the number of elements and their size.
grow_hash_table passes the arguments in reverse order, passing the
size of a hash table entry, followed by the number of entries.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hash.c b/hash.c
index 749ecfe..2067be9 100644
--- a/hash.c
+++ b/hash.c
@@ -53,7 +53,7 @@ static void grow_hash_table(struct hash_table *table)
 	struct hash_table_entry *old_array = table->array, *new_array;
 
 	new_size = alloc_nr(old_size);
-	new_array = xcalloc(sizeof(struct hash_table_entry), new_size);
+	new_array = xcalloc(new_size, sizeof(struct hash_table_entry));
 	table->size = new_size;
 	table->array = new_array;
 	table->nr = 0;
-- 
2.0.0.rc1.543.gc8042da
