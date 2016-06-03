From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 29/38] split_symref_update(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:04:04 +0200
Message-ID: <68c836148e4c8655161fba54cd1fd56a0e48dbbb.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIU-0001b3-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbcFCVGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:06 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61178 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161001AbcFCVFT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:19 -0400
X-AuditID: 1207440f-8bbff700000008e4-66-5751f10df341
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 51.FB.02276.D01F1575; Fri,  3 Jun 2016 17:05:17 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kct003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:16 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMv7MTDcYPJLLYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGf0bX/GVjCdu+LdGtcGxmscXYyc
	HBICJhLfv1xn7mLk4hAS2MooserkTRYI5ziTRN/5b2wgVWwCuhKLepqZQGwRgQiJhlctjCBF
	zAJzmCRuP+xkBkkIC/hI7Hi9GqyBRUBVYuf/F2BxXoEoiUWnH7BBrJOTuDwdwuYUsJBo+byK
	FcQWEjCXaDx1mGUCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCFB
	x7+DsWu9zCFGAQ5GJR7eEy8Cw4VYE8uKK3MPMUpyMCmJ8u69AxTiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwpvyGijHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgXfQe
	qFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAPxxcAoAEnxAO3l/gCyt7ggMRco
	CtF6ilFRSpz3EMhcAZBERmke3FhYKnnFKA70pTBvIEg7DzANwXW/AhrMBDS44JE/yOCSRISU
	VAMjj4Ucd11VqqxjRjrnr0jW2xOEdgUVBLC/5QlgLGneqyQRJ/ZZpuekr8o6P/GPcl8ubz8Y
	xcvc9Xrh5cL3e4ou/TU2/qvGw/3rzpWTK8wLDd7PnH077K7+5LWyXbeub1cPqFww 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296398>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 24b7c60..8d3cf96 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3405,7 +3405,8 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct ref_update *update,
+static int split_symref_update(struct files_ref_store *refs,
+			       struct ref_update *update,
 			       const char *referent,
 			       struct ref_transaction *transaction,
 			       struct string_list *affected_refnames,
@@ -3556,7 +3557,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					    sha1_to_hex(update->old_sha1));
 				return TRANSACTION_GENERIC_ERROR;
 			}
-
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -3565,7 +3565,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
-			ret = split_symref_update(update, referent.buf, transaction,
+			ret = split_symref_update(refs, update,
+						  referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
 				return ret;
-- 
2.8.1
