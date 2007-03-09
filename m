From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Adjust reflog filemode in shared repository
Date: Fri,  9 Mar 2007 23:38:57 +0100
Message-ID: <11734799371637-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 09 23:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPnk4-0006Th-3P
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 23:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767576AbXCIWjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 17:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767580AbXCIWjJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 17:39:09 -0500
Received: from mail17.bluewin.ch ([195.186.18.64]:47482 "EHLO
	mail17.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767578AbXCIWjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 17:39:08 -0500
Received: from spinlock.ch (85.1.204.128) by mail17.bluewin.ch (Bluewin 7.3.121)
        id 45C31E1C00A65A4F; Fri, 9 Mar 2007 22:39:03 +0000
Received: (nullmailer pid 29786 invoked by uid 1000);
	Fri, 09 Mar 2007 22:38:57 -0000
X-Mailer: git-send-email 1.5.0.3.942.g299f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41816>

Without this, committing in a group-shared repository would not work
even though all developers are in the same group.

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 refs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 76c08d0..9f1fb68 100644
--- a/refs.c
+++ b/refs.c
@@ -921,6 +921,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 				     log_file, strerror(errno));
 	}
 
+	adjust_shared_perm(log_file);
+
 	msglen = 0;
 	if (msg) {
 		/* clean up the message and make sure it is a single line */
-- 
1.5.0.3.942.g299f-dirty
