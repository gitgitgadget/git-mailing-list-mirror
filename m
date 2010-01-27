From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 01/23] Minor non-functional fixes to notes.c
Date: Wed, 27 Jan 2010 12:51:38 +0100
Message-ID: <1264593120-4428-2-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:52:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Rb-0000MC-TR
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0A0LwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525Ab0A0LwS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:18 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58953 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752742Ab0A0LwR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:17 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FBTMB3FU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:15 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:15 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138132>

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
1.6.6.405.g80ed6
