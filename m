From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 24/26] struct ref_update: Add type field
Date: Mon, 10 Mar 2014 13:46:41 +0100
Message-ID: <1394455603-2968-25-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcO-0007t1-VR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaCJMri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:38 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49923 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbaCJMrh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:37 -0400
X-AuditID: 12074411-f79ab6d000002f0e-39-531db468aa38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 38.DD.12046.864BD135; Mon, 10 Mar 2014 08:47:36 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwm025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:34 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJuxRTbYYOFHVYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8bZ32fZC7r5Kh4v6WFrYPzM1cXIySEhYCKxZdZE
	VghbTOLCvfVsXYxcHEIClxkllu5ZC+WcYJKYtnEbG0gVm4CuxKKeZiYQW0RATWJi2yEWkCJm
	gSuMEp+//mIHSQgLWEhs//iYEcRmEVCVmLt8A9gKXgEXiUsXr7FArJOTmPJ7AVg9J1B8+pUH
	YLaQgLPEyz3NrBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAk+
	wR2MM07KHWIU4GBU4uE9+FYmWIg1say4MvcQoyQHk5Io78S1ssFCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHgzFwPleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvPWb
	gRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQdERXwyMD5AUD9DebSDtvMUFiblA
	UYjWU4yKUuK8c0ASAiCJjNI8uLGwlPKKURzoS2HeVpAqHmA6gut+BTSYCWhw83EpkMEliQgp
	qQbGNNHsl5ui3WVOGFupng979eGt6AceVd8jny6smntNpviP8jf+/Gll3Hsu2rw74zP1llDg
	MT6rU7Maplg0t4VZaV6+H2Z4dnPZKfM/ucKOr+d0br2XZD/fv2n3wugFX8/nrN6k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243743>

This is temporary space for commit_ref_transaction()

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 73aec88..1fd38b0 100644
--- a/refs.c
+++ b/refs.c
@@ -3279,6 +3279,7 @@ struct ref_update {
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
+	int type;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3402,7 +3403,6 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 {
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
-	int *types;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3411,7 +3411,6 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
-	types = xmalloc(sizeof(*types) * n);
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3429,7 +3428,7 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &types[i], onerr);
+					       &update->type, onerr);
 		if (!update->lock) {
 			ret = 1;
 			goto cleanup;
@@ -3457,7 +3456,7 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, types[i]);
+			ret |= delete_ref_loose(update->lock, update->type);
 		}
 	}
 
@@ -3471,7 +3470,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(updates);
-	free(types);
 	free(delnames);
 	return ret;
 }
-- 
1.9.0
