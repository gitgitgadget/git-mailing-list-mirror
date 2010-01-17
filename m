From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 01/20] Minor non-functional fixes to notes.c
Date: Sun, 17 Jan 2010 22:04:18 +0100
Message-ID: <1263762277-31419-2-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKK-0007dl-3d
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0AQVFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200Ab0AQVFJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62433 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754640Ab0AQVFA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:00 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002BLT880RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:56 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:56 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137330>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/notes.c b/notes.c
index 023adce..47e38a1 100644
--- a/notes.c
+++ b/notes.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "commit.h"
 #include "notes.h"
-#include "refs.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
@@ -93,7 +92,7 @@ static void **note_tree_search(struct int_node **tree,
 
 	i = GET_NIBBLE(*n, key_sha1);
 	p = (*tree)->a[i];
-	switch(GET_PTR_TYPE(p)) {
+	switch (GET_PTR_TYPE(p)) {
 	case PTR_TYPE_INTERNAL:
 		*tree = CLR_PTR_TYPE(p);
 		(*n)++;
@@ -195,7 +194,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	switch(GET_PTR_TYPE(*p)) {
+	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
 		*p = SET_PTR_TYPE(entry, type);
@@ -257,7 +256,7 @@ static void note_tree_free(struct int_node *tree)
 	unsigned int i;
 	for (i = 0; i < 16; i++) {
 		void *p = tree->a[i];
-		switch(GET_PTR_TYPE(p)) {
+		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
 			note_tree_free(CLR_PTR_TYPE(p));
 			/* fall through */
@@ -274,7 +273,7 @@ static void note_tree_free(struct int_node *tree)
  * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
  * - sha1     - Partial SHA1 value is written here
  * - sha1_len - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
- * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format).
+ * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format)).
  * Otherwise, returns number of bytes written to sha1 (i.e. hex_len / 2).
  * Pads sha1 with NULs up to sha1_len (not included in returned length).
  */
-- 
1.6.6.rc1.321.g0496e
