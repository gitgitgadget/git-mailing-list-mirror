From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/23] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Fri,  5 Dec 2014 00:08:13 +0100
Message-ID: <1417734515-11812-2-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfVx-0002lY-44
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269AbaLDXIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:45 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:64234 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933201AbaLDXIo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:44 -0500
X-AuditID: 12074414-f797f6d000004084-97-5480e97b91f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 40.E5.16516.B79E0845; Thu,  4 Dec 2014 18:08:43 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8ddw027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:42 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqFv9siHE4PIOdYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3Bn3tz5nL1jKW/Hy4iy2BsbfXF2MnBwSAiYSh1bvYYawxSQu3FvP1sXI
	xSEkcJlRYsbss1DOMSaJl0t+M4FUsQnoSizqaQazRQTUJGaumg1WxCzwg1HidcMaoFEcHMIC
	8RI/VmuD1LAIqEo8eLSCFSTMK+Ai8WFmCIgpISAnsXWdN0gFp4CrxNSZrYwgthBQxbNNC9kn
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESYCI7GI+clDvEKMDB
	qMTDW7C7PkSINbGsuDL3EKMkB5OSKO/Zpw0hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4jY8A
	5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHi5XgA1ChalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvWUg7bzFBYm5QFGI1lOMilLivPUg
	CQGQREZpHtxYWNp4xSgO9KUwbylIFQ8w5cB1vwIazAQ0+GxDLcjgkkSElFQDo6j3nIMLJote
	PbL/vMnPGcHWey0XcFjNMFjx9Kj6tv9xzW/msL+M/rpRc8usy98enZ6v3t1482wy53yuMx1T
	VhUfVrxzJum2l93kef3Bwu8ygtXfCpptVli+72/1LleR3Ts931rsOv35s5x9dnrN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260810>

From: Ronnie Sahlberg <sahlberg@google.com>

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..005eb18 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
-- 
2.1.3
