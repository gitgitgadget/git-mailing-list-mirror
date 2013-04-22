From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/33] refs: document flags constants REF_*
Date: Mon, 22 Apr 2013 21:52:09 +0200
Message-ID: <1366660361-21831-2-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMnv-0004QV-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab3DVTxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:30 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46315 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754827Ab3DVTxa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:30 -0400
X-AuditID: 12074414-b7fb86d000000905-ed-51759539fba7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 87.4B.02309.93595715; Mon, 22 Apr 2013 15:53:29 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOE008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:28 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGs5tTTQYPJmbouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74828Rc8E7norddz+xNTAu
	4upi5OSQEDCRuHG3gxXCFpO4cG89WxcjF4eQwGVGibfnZjBDOBeYJN5sms8CUsUmoCuxqKeZ
	CcQWEVCTmNh2CCzOLOAgsflzIyOILSxgJ7F0ZyNYnEVAVWJqx36wel4BF4mn+68zQ2xTkDi+
	fRtYPaeAq8TpjhNg9UJANSsOTmWZwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5u
	ZoleakrpJkZIsIjsYDxyUu4QowAHoxIPr6B7aaAQa2JZcWXuIUZJDiYlUV6OKUAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIryi+UA53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUw
	WRkODiUJ3gyQoYJFqempFWmZOSUIaSYOThDBBbKBB2hDJEghb3FBYm5xZjpE0SlGRSlxXrdJ
	QAkBkERGaR7cAFhcv2IUB/pHmJcPpJ0HmBLgul8BDWYCGpyZUAIyuCQRISXVwGi/SKS455pz
	xwRd8RMJW2VD52022BcYsnrrw7vmGveWtU1fX2jUvIVXXIp17an2rRmvF3LsnlXL0luwRT3j
	ROH9qqMy+aE7Uie///jgeW/+bQ8mKWbDDVe91JWu/w52TZwVv5bL0TH7o8NJfp2jRsbXvudy
	P1P/KJHWszupsmmNWUGDKg/HTCWW4oxEQy3mouJEAK2ICDTGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222051>

Document the bits that can appear in the "flags" parameter passed to
an each_ref_function and/or in the ref_entry::flag field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 +++++++++++-
 refs.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index de2d8eb..30b4bf7 100644
--- a/refs.c
+++ b/refs.c
@@ -158,7 +158,17 @@ struct ref_dir {
 	struct ref_entry **entries;
 };
 
-/* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
+/*
+ * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
+ * REF_ISPACKED=0x02, and REF_ISBROKEN=0x04 are public values; see
+ * refs.h.
+ */
+
+/*
+ * The field ref_entry->u.value.peeled of this value entry contains
+ * the correct peeled value for the reference, which might be
+ * null_sha1 if the reference is not a tag or if it is broken.
+ */
 #define REF_KNOWS_PEELED 0x08
 
 /* ref_entry represents a directory of references */
diff --git a/refs.h b/refs.h
index a35eafc..17bc1c1 100644
--- a/refs.h
+++ b/refs.h
@@ -10,8 +10,21 @@ struct ref_lock {
 	int force_write;
 };
 
+/*
+ * Bit values set in the flags argument passed to each_ref_fn():
+ */
+
+/* Reference is a symbolic reference. */
 #define REF_ISSYMREF 0x01
+
+/* Reference is a packed reference. */
 #define REF_ISPACKED 0x02
+
+/*
+ * Reference cannot be resolved to an object name: dangling symbolic
+ * reference (directly or indirectly), corrupt reference file, or
+ * symbolic reference refers to ill-formatted reference name.
+ */
 #define REF_ISBROKEN 0x04
 
 /*
-- 
1.8.2.1
