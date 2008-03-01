From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/2] unpack-objects: allocate NUL byte at the buffer end
Date: Sat,  1 Mar 2008 22:21:22 +0100
Message-ID: <12044064831419-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12044064822655-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 22:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZA4-0001nU-Bk
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759158AbYCAVVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759048AbYCAVV0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:21:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33848 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758859AbYCAVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 16:21:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3448B6CF0072;
	Sat,  1 Mar 2008 22:21:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9NvJ9u2N-wWY; Sat,  1 Mar 2008 22:21:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0C7CE680CDAB; Sat,  1 Mar 2008 22:21:23 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12044064822655-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75702>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-unpack-objects.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9d2a854..1845abc 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -86,7 +86,8 @@ static void use(int bytes)
 static void *get_data(unsigned long size)
 {
 	z_stream stream;
-	void *buf = xmalloc(size);
+	char *buf = xmalloc(size + 1);
+	buf[size] = 0;
 
 	memset(&stream, 0, sizeof(stream));
 
-- 
1.5.4.2.g4b5fd.dirty

