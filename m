From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 14/39] write_packed_entry_fn(): convert cb_data into a (const int *)
Date: Fri, 26 Sep 2014 12:08:14 +0200
Message-ID: <1411726119-31598-15-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSU3-0004vv-VP
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbaIZKJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53323 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755688AbaIZKJN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:13 -0400
X-AuditID: 1207440e-f79da6d0000002fc-34-54253b49a37b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.49.00764.94B35245; Fri, 26 Sep 2014 06:09:13 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLx013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:12 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1PW0Vg0xeLhd1aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oynixoZC7rYKt58uMbUwPiDpYuR
	k0NCwERi7bcZ7BC2mMSFe+vZuhi5OIQELjNKzJ/xlAXC2cQkceP8TSaQKjYBXYlFPc1gtoiA
	msTEtkNgRcwCi5kkJhzaxAaSEBYIl7j7aRmYzSKgKjHr1TRWEJtXwFVi24EbbBDr5CQ27P7P
	CGJzAsUbt18Ds4UEXCRa1k9mmcDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJ
	XmpK6SZGSDjy7WBsXy9ziFGAg1GJh/fGOpUQIdbEsuLK3EOMkhxMSqK8XyxUQ4T4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8N4xAsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFk
	ZTg4lCR4i6yAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB0RFfDIwPkBQP0F4P
	kHbe4oLEXKAoROspRmOOlqa3vUwc6zq/9TMJseTl56VKifMesQQqFQApzSjNg1sES0SvGMWB
	/hbm9QUZyANMYnDzXgGtYgJapXREGWRVSSJCSqqBkTfnhjC3ZOmLrdfMLhwrs8xyf7szsYPl
	5kmzyC6bmcKF7F9bzcW5tJUe9aYFHpP8uOBF+PylV822zmK1rTv24069bo1aa8z6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257524>

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
