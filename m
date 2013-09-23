From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 04/16] contrib/git-credential-gnome-keyring.c: add static where applicable
Date: Mon, 23 Sep 2013 11:49:05 -0700
Message-ID: <1379962157-1338-5-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCc-0007aR-TO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3IWSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14677 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3IWStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52408d0d0000>; Mon, 23 Sep 2013 11:48:45 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:25 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:25 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235221>

From: Brandon Casey <drafnel@gmail.com>

Mark global variable and functions as static.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 809b1b7..3ff541c 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -128,7 +128,7 @@ static char* keyring_object(struct credential *c)
 	return object;
 }
 
-int keyring_get(struct credential *c)
+static int keyring_get(struct credential *c)
 {
 	char* object = NULL;
 	GList *entries;
@@ -178,7 +178,7 @@ int keyring_get(struct credential *c)
 }
 
 
-int keyring_store(struct credential *c)
+static int keyring_store(struct credential *c)
 {
 	guint32 item_id;
 	char  *object = NULL;
@@ -212,7 +212,7 @@ int keyring_store(struct credential *c)
 	return EXIT_SUCCESS;
 }
 
-int keyring_erase(struct credential *c)
+static int keyring_erase(struct credential *c)
 {
 	char  *object = NULL;
 	GList *entries;
@@ -277,7 +277,7 @@ int keyring_erase(struct credential *c)
  * Table with helper operation callbacks, used by generic
  * credential helper main function.
  */
-struct credential_operation const credential_helper_ops[] =
+static struct credential_operation const credential_helper_ops[] =
 {
 	{ "get",   keyring_get   },
 	{ "store", keyring_store },
@@ -287,12 +287,12 @@ struct credential_operation const credential_helper_ops[] =
 
 /* ------------------ credential functions ------------------ */
 
-void credential_init(struct credential *c)
+static void credential_init(struct credential *c)
 {
 	memset(c, 0, sizeof(*c));
 }
 
-void credential_clear(struct credential *c)
+static void credential_clear(struct credential *c)
 {
 	free(c->protocol);
 	free(c->host);
@@ -303,7 +303,7 @@ void credential_clear(struct credential *c)
 	credential_init(c);
 }
 
-int credential_read(struct credential *c)
+static int credential_read(struct credential *c)
 {
 	char    buf[1024];
 	ssize_t line_len = 0;
@@ -358,14 +358,14 @@ int credential_read(struct credential *c)
 	return 0;
 }
 
-void credential_write_item(FILE *fp, const char *key, const char *value)
+static void credential_write_item(FILE *fp, const char *key, const char *value)
 {
 	if (!value)
 		return;
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
-void credential_write(const struct credential *c)
+static void credential_write(const struct credential *c)
 {
 	/* only write username/password, if set */
 	credential_write_item(stdout, "username", c->username);
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
