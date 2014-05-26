From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 08/15] hash.h: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:49 +0900
Message-ID: <1401118436-66090-9-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowwB-00069G-Db
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbaEZPfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:37 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48970 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbaEZPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:57 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so7886189pbb.27
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/esKKVLMZreZ3z/5DXr0fZQwuVpbZYDKnw7nrmffuGg=;
        b=AjDT7R+kaTnzD2KUtBMDgQgcjphU7FDw6FJ3TbccsNvXkRZo3XsAP/40aYcX7rjkHP
         xeNVNnBoZqoB2nmQ9Z02z0UOrVfsogQZz+Lc9Ct6JJeaHEGMPFJDrua7gBG9k7b03aYI
         4EN6p7UHSF6lCW93zUMxfNSXtlxtHFAEiPvOsYNH+T8Di4qr4c2ETKE8wNhVyqPPGM61
         3zr9ZlaVioNtLzMvpB/A+nnBU9ZMyIZl5jlYBKA8mtfjnUmph/xIoU96MliLXd8HqGmB
         32nL0McouuWeP2q/W4c4i8XNluhJBeC7/SPeP7R/9w92srBjWEGyWJkSOaqN3+DnzQ4r
         rcrg==
X-Received: by 10.66.141.109 with SMTP id rn13mr29494085pab.117.1401118496935;
        Mon, 26 May 2014 08:34:56 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250105>

xcalloc takes two arguments: the number of elements and their size.
prellocate_hash passes the arguments in reverse order, passing the
size of a hash table entry, followed by the number of entries.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 1d43ac0..3b5d9e7 100644
--- a/hash.h
+++ b/hash.h
@@ -44,7 +44,7 @@ static inline void preallocate_hash(struct hash_table *table, unsigned int elts)
 {
 	assert(table->size == 0 && table->nr == 0 && table->array == NULL);
 	table->size = elts * 2;
-	table->array = xcalloc(sizeof(struct hash_table_entry), table->size);
+	table->array = xcalloc(table->size, sizeof(struct hash_table_entry));
 }
 
 #endif
-- 
2.0.0.rc1.543.gc8042da
