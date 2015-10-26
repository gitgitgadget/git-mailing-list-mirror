From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 6/6] Correct fscanf formatting string for I64u values
Date: Mon, 26 Oct 2015 14:15:33 +0100 (CET)
Message-ID: <9f9e70a1704d8388f520535192e263089e36860e.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Waldek Maleska <w.maleska@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqhci-00019v-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbbJZNPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:61402 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbbJZNPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:35 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LoEcP-1aSXPT1hjF-00gFKn;
 Mon, 26 Oct 2015 14:15:34 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:tF7bNp9D3n8HgBnXRbdgfd+u0ZfNWmjGexPcVkH3IbqbXSD6D8l
 B3QyMnOZeeE8SEqKAu+TZiEwp2kH2SdfwuxAqQlAWTsKA3McrLLmhZSKOW8kwFi1z5RNwz9
 uUQEs4py7dMEVe6O6QTbpkNlH21FIrseXKDHlMGmtv8G6nUfXc8Qdl/wkLLnFof2cDunITs
 Wbglx/+XxxuVJZ4yBDtDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lrLd0+W33dU=:8kR/dMgHaKACU49WiINRCy
 yZcgqIpZJR8ZJ2hWjvX/l1uzFDUOt/wtjoRilefZp/uEjJ/4PcW2E8BG/mETVOEusSSCdVXbH
 +Q8t/3y7APde1otOvm//NG16gX/t7m6+0/czMReDk+OirUGhDuyfM7VLrdecit0BVkODQLO8W
 Nh1Hz9tewTFWF+QT1JQ20ezR9oveVPigA3qKAhD6a7yDgGjF8UwrVlFBUfxnCrtpbGtrqlht7
 Hm6/GiKGeN3vTEmC3jgWzJQUdXT9vjbcW6Rs+J7IGg5J8bQbhLXd3v/ome58MAFtT8+Pd59zp
 S21pGONHMVlg9YnIG80NaVYtJC3ckaxnq7/1ZrsQAh/HQTZGhntJyvHanEYrY4Ysa3ZpxjJCF
 j2+eajnS5+8J0FBIInVCWJE25HccmfsoFKzGfWrUfl9eD7OB/C17/09zlGoRd7UiBtL55i3KP
 z8rGUfDAhJTa/+ZgZ0aaSn7muuGptkSaXCakWHxVstItU5Ab5NAANaosp7gRqEGC3GJ/mgB3Y
 EDnRhGsDRm7ZWeCaurdW8VqSEWVlp531O+EgXNAoaQQFGtFrK8SUFL/InTduvlGq/ZWGRMd6+
 Y/dPE4c8zQNmKl3oSe95mSRXiOY9xqlqRYqPbIw8Bqt5IaX/LPHixSTdcBtzAbTi7K/ejfZnK
 7z9pCT1WJqckGK6wadqyGtwoudBBTr5odr9WDT4cLSzcirvro5sp06vHEdc7tSbrXctbwjkyy
 7MfvuOI0wodvuQd5KDug2TnzQfp84aCh/rNfQ9v+W+9neyPFCJ03e+H8aC0thmdntFsspVVB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280195>

From: Waldek Maleska <w.maleska@gmail.com>

This fix is probably purely cosmetic because PRIuMAX is likely identical
to SCNuMAX. Nevertheless, when using a function of the scanf() family,
the correct interpolation to use is the latter, not the former.

Signed-off-by: Waldek Maleska <w.maleska@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c      | 2 +-
 git-compat-util.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b677923..df3e454 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -240,7 +240,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			 * running.
 			 */
 			time(NULL) - st.st_mtime <= 12 * 3600 &&
-			fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) == 2 &&
+			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
 			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
 		if (fp != NULL)
diff --git a/git-compat-util.h b/git-compat-util.h
index 610e8a5..87456a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -296,6 +296,10 @@ extern char *gitbasename(char *);
 #define PRIuMAX "llu"
 #endif
 
+#ifndef SCNuMAX
+#define SCNuMAX PRIuMAX
+#endif
+
 #ifndef PRIu32
 #define PRIu32 "u"
 #endif
-- 
2.1.4
