From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/3] sha1_file: add function to insert alternate object db
Date: Sun, 18 Jan 2009 11:53:17 +0100
Message-ID: <1232275999-14852-2-git-send-email-hjemli@gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 11:55:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVJ1-0008GS-2f
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 11:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762413AbZARKxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 05:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763000AbZARKx1
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 05:53:27 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:49590 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761896AbZARKxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 05:53:25 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0IArKDb021200;
	Sun, 18 Jan 2009 11:53:21 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106168>

This function will be used when implementing traversal into submodules.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 cache.h     |    1 +
 sha1_file.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 8e1af26..daa2d4e 100644
--- a/cache.h
+++ b/cache.h
@@ -724,6 +724,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int add_alt_odb(const char *path);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index f08493f..19f9725 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -356,6 +356,11 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
+int add_alt_odb(const char *path)
+{
+	return link_alt_odb_entry(path, strlen(path), NULL, 0);
+}
+
 static void read_info_alternates(const char * relative_base, int depth)
 {
 	char *map;
-- 
1.6.1.150.g5e733b
