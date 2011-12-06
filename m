From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 6 Dec 2011 17:35:08 +0100
Message-ID: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 17:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXxzD-0001rz-IT
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 17:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab1LFQfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 11:35:12 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:31459 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1LFQfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 11:35:12 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 17:35:07 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 17:35:08 +0100
X-Mailer: git-send-email 1.7.8.424.gcb840
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186355>

The cpp pattern, used for C and C++, would not match the start of a
declaration such as

  static char *prepare_index(int argc,

because it did not allow for * anywhere between the various words that
constitute the modifiers, type and function name.  Fix it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is a really sneaky one-character bug that I cannot believe went
unnoticed for so long, seeing as there are plenty of instances within
git itself where it matters.


 userdiff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 7c983c1..76109da 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -118,7 +118,7 @@
 	 /* Jump targets or access declarations */
 	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
 	 /* C/++ functions/methods at top level */
-	 "^([A-Za-z_][A-Za-z_0-9]*([ \t]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
+	 "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
 	 /* compound type at top level */
 	 "^((struct|class|enum)[^;]*)$",
 	 /* -- */
-- 
1.7.8.424.gcb840
