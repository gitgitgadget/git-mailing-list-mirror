From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/33] refs: define constant PEELED_LINE_LENGTH
Date: Mon, 22 Apr 2013 21:52:13 +0200
Message-ID: <1366660361-21831-6-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:00:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMup-0005bC-JX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab3DVUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:00:38 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63488 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754761Ab3DVUAh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:00:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2013 16:00:37 EDT
X-AuditID: 12074412-b7f216d0000008d4-2f-5175953e8084
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FC.7F.02260.E3595715; Mon, 22 Apr 2013 15:53:34 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOI008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:33 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGs3tTTQ4G2zmUXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGesvf6KpeAJe8X+vlMsDYyN
	bF2MnBwSAiYSL6b3skPYYhIX7q0HinNxCAlcZpT4sO4TO4RzgUnixboTLCBVbAK6Eot6mplA
	bBEBNYmJbYfA4swCDhKbPzcygtjCAk4SJ9q6gJo5OFgEVCWun5ABCfMKuEh0XFnOBLFMQeL4
	9m1g5ZwCrhKnOyDGCwHVrDg4lWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZ
	JXqpKaWbGCGhIrSDcf1JuUOMAhyMSjy8Au6lgUKsiWXFlbmHGCU5mJREeTmmAIX4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8IrmA+V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFk
	ZTg4lCR4v00GahQsSk1PrUjLzClBSDNxcIIILpANPEAb5EG28xYXJOYWZ6ZDFJ1iVJQS53Wb
	BJQQAElklObBDYBF9StGcaB/hHn5QNp5gAkBrvsV0GAmoMGZCSUgg0sSEVJSDYx2U/9aiv/f
	u2li3y6TA6U/67qeqB6t4l1xc8Zq/m//27bf8WWw/LM9j3nHo11Fe3V4/HdGuN7KtslTUCuJ
	3+rfkLiicCXDbemnPO4zNN0+73RI/bcrIXGbk+cjl7kMNYIz3I/sClnw9tKs/zvnebRus3b+
	u7Xx5OdlreGn2pIv7SxmXvMoxYNNiaU4I9FQi7moOBEAu72a3MUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222070>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index efad658..e1e9ddd 100644
--- a/refs.c
+++ b/refs.c
@@ -805,6 +805,9 @@ void invalidate_ref_cache(const char *submodule)
 	clear_loose_ref_cache(refs);
 }
 
+/* The length of a peeled reference line in packed-refs, including EOL: */
+#define PEELED_LINE_LENGTH 42
+
 /*
  * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
  * Return a pointer to the refname within the line (null-terminated),
@@ -897,8 +900,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		}
 		if (last &&
 		    refline[0] == '^' &&
-		    strlen(refline) == 42 &&
-		    refline[41] == '\n' &&
+		    strlen(refline) == PEELED_LINE_LENGTH &&
+		    refline[PEELED_LINE_LENGTH - 1] == '\n' &&
 		    !get_sha1_hex(refline + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
 			/*
-- 
1.8.2.1
