From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 13/35] write_packed_entry_fn(): convert cb_data into a (const int *)
Date: Tue, 16 Sep 2014 21:33:34 +0200
Message-ID: <1410896036-12750-14-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydC-0003Ol-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaIPTli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:38 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50603 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754892AbaIPTli (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:38 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:41:38 EDT
X-AuditID: 12074412-f792e6d000005517-13-541890cb4133
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D7.45.21783.BC098145; Tue, 16 Sep 2014 15:34:35 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcH001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:33 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1D09QSLE4NQldouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOeLqokbGgi63izYdrTA2MP1i6GDk5JARMJM4d28EO
	YYtJXLi3nq2LkYtDSOAyo8TRa++hnBNMEnN2PAXrYBPQlVjU08wEkhARaGOU2HVxMyuIwyzQ
	zSjx/sRpoAwHh7BAuMStg2ogDSwCqhK/3/9nBLF5BVwljnWuZYVYJyexYTdInIODEyj+dV8B
	iCkk4CJx8K7fBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCwk5o
	B+P6k3KHGAU4GJV4eD0eiYcIsSaWFVfmHmKU5GBSEuX91y0RIsSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmE94cvUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYL3Zj9Q
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2vsRpJ23uCAxFygK
	0XqK0ZijpeltLxPHus5v/UxCLHn5ealS4rw2IKUCIKUZpXlwi2AJ5xWjONDfwrzvQKp4gMkK
	bt4roFVMQKvO9oiBrCpJREhJNTD6XP496/T1N284fErvh7zhW+ba2aTS8mDZskZGXcZkhdez
	ww9uUvoSKO+27ZJmZ67mLc0Xu00y9iYcjzpRVeX879Ia86qH/BcN/4vG3Z5g8vvm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257164>

This makes it obvious that we have no plans to change the integer
pointed to, which is actually the fd field from a struct lock_file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 11c76ec..4f313bc 100644
--- a/refs.c
+++ b/refs.c
@@ -2217,7 +2217,7 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
+	const int *fd = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-- 
2.1.0
