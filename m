From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/13] ref_transaction_create(): check that new_sha1 is valid
Date: Tue, 17 Feb 2015 18:00:19 +0100
Message-ID: <1424192423-27979-10-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:07:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlco-0007De-G6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbBQRHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:07:49 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62111 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791AbbBQRHt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:07:49 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2015 12:07:48 EST
X-AuditID: 1207440c-f79376d00000680a-0c-54e373beb3e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 64.E1.26634.EB373E45; Tue, 17 Feb 2015 12:00:46 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXe000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:45 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLuv+HGIwcUD6hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz+n+vZy44x1px9MkxpgbGfSxdjJwcEgImEts/bmWCsMUkLtxbzwZi
	CwlcZpSY8Ua3i5ELyD7OJHFj5ilGkASbgK7Eop5msAYRATWJiW2HwAYxC6xmkth6F6xZWCBA
	Yvf/Q8wgNouAqsTKaz3sIDavgKvE0dapbBDL5CTOH/8JVsMJFF/2axk7xGIXifkds5kmMPIu
	YGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESZDw7GL+tkznEKMDBqMTD
	azHhUYgQa2JZcWXuIUZJDiYlUd7woschQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4g1KAcrwp
	iZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd42kKGCRanpqRVpmTklCGkm
	Dk6Q4VxSIsWpeSmpRYmlJRnxoMiILwbGBkiKB2jvEpB23uKCxFygKETrKUZdjgXt+2cyCbHk
	5eelSonzLgYpEgApyijNg1sBSymvGMWBPhbmfQZSxQNMR3CTXgEtYQJaMv/PI5AlJYkIKakG
	xhgn9Rvzff8ut3W+ZrTii8a9bs2LzE+fdExpOP9wvtHih3J7Zjk9S9KNEXGaueWatlAfZ1/V
	VY7XXXsF9KL5Su48vRv8wedvo/zt838u/lbfG2sqZBBw+lHdniC+w63qwpeNz0bt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263966>

Creating a reference requires a new_sha1 that is not NULL and not
null_sha1.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index e3c4ab5..b9cf284 100644
--- a/refs.c
+++ b/refs.c
@@ -3690,6 +3690,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create called without valid new_sha1");
 	return ref_transaction_update(transaction, refname, new_sha1,
 				      null_sha1, flags, msg, err);
 }
-- 
2.1.4
