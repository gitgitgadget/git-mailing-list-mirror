From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/24] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Fri, 12 Dec 2014 09:56:40 +0100
Message-ID: <1418374623-5566-2-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2U-0004Db-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbaLLI5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:24 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43820 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934681AbaLLI5X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:23 -0500
X-AuditID: 1207440f-f792a6d000001284-7f-548aade94232
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 29.47.04740.9EDAA845; Fri, 12 Dec 2014 03:57:13 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nB023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:12 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqPtybVeIwfEHehZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLf5NqLHYvLmdxYHd4+/7D0weO2fdZfdYsKnU4+IlZY/Pm+QCWKO4
	bZISS8qCM9Pz9O0SuDPub33OXrCUt+LlxVlsDYy/uboYOTgkBEwkrt/n62LkBDLFJC7cW8/W
	xcjFISRwmVGiY85zdgjnGJPEk7OrmEGq2AR0JRb1NDOB2CICahIT2w6xgBQxC/xglJg4+whY
	kbBAksTs8xPYQTawCKhKnPtQChLmFXCW2Nj6jhlisZzE1nXeIGFOAReJiy1PWEBsIaCSrSs6
	WScw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJg/DsYu9bLHGIU
	4GBU4uF9kdoVIsSaWFZcmXuIUZKDSUmU9/tkoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3r9R
	QDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv3BqgRsGi1PTUirTM
	nBKENBMHJ8hwLimR4tS8lNSixNKSjHhQXMQXAyMDJMUDtJdtLcje4oLEXKAoROspRkUpcd5W
	kLkCIImM0jy4sbC08YpRHOhLYd46kCoeYMqB634FNJgJaPDyLR0gg0sSEVJSDYylSRVnXqx4
	+8/i533Gjqp/jO2JVTp9t98ETe/i9PS+/U905prliS/+PVLY97Ywfy7rOpMnR2ME0nReJO38
	4nyfP2LmJrn8hKDKJTvimc1+PC1LmbX08vTvG1NezgvlOmCd8GWannvu0eQvy1qN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261322>

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
