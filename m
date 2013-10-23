From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/15] t5510: prepare test refs more straightforwardly
Date: Wed, 23 Oct 2013 17:50:35 +0200
Message-ID: <1382543448-2586-3-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:52:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0j5-0001y6-T9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3JWPv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:51:56 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42189 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504Ab3JWPvy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:51:54 -0400
X-AuditID: 12074414-b7fb46d000002a4d-3c-5267f0983534
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 87.D2.10829.890F7625; Wed, 23 Oct 2013 11:51:52 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLst009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:49 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqDvjQ3qQwdd2DovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74/yPLcwFHwQqNm89wNTA+Jy3i5GTQ0LAROLok05mCFtM4sK99WxdjFwcQgKXGSX+3b/D
	COFcYZK4svMRWBWbgK7Eop5mJhBbREBNYmLbIRaQImaBicwSx6cvAnI4OIQF3CRmfdQBqWER
	UJVo/H+BBcTmFXCW+P13F1iJhICcxMNvsSBhTgEXiQvHp7OC2EJAJRMWTmWfwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI0IrsYDxyUu4QowAHoxIP74OWtCAh
	1sSy4srcQ4ySHExKorxz3qUHCfEl5adUZiQWZ8QXleakFh9ilOBgVhLh3XEXKMebklhZlVqU
	D5OS5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMHr+h6oUbAoNT21Ii0zpwQhzcTBCSK4
	QDbwAG2IASnkLS5IzC3OTIcoOsWoKCXO2wCSEABJZJTmwQ2ApZdXjOJA/wjzJoJU8QBTE1z3
	K6DBTECDpyxJAxlckoiQkmpg1ON9WxSavq71r+jptS/EPHI5gszqeJq1PfS6nT+3z57H9KDv
	3itX70Un/cotZrPP5LhvqrI8NdNQbM6Gx57buAOuS04Kqj8ebKOuv9RbT/6UuOaV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236515>

"git fetch" was being used with contrived refspecs to create tags and
remote-tracking branches in test repositories in preparation for the
actual tests.  This is obscure and also makes one wonder whether this
is indeed just preparation or whether some side-effect of "git fetch"
is being tested.

So use the more straightforward commands "git tag" / "git update-ref"
when preparing branches in test repositories.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5510-fetch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c5e5dfc..08d8dbb 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -88,7 +88,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
 	cd prune &&
-	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+	git update-ref refs/remotes/origin/extrabranch master &&
 
 	git fetch --prune origin &&
 	test_must_fail git rev-parse origin/extrabranch
@@ -98,7 +98,7 @@ test_expect_success 'fetch --prune with a branch name keeps branches' '
 	cd "$D" &&
 	git clone . prune-branch &&
 	cd prune-branch &&
-	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+	git update-ref refs/remotes/origin/extrabranch master &&
 
 	git fetch --prune origin master &&
 	git rev-parse origin/extrabranch
@@ -117,7 +117,7 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
 	cd "$D" &&
 	git clone . prune-tags &&
 	cd prune-tags &&
-	git fetch origin refs/heads/master:refs/tags/sometag &&
+	git tag sometag master &&
 
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
@@ -128,7 +128,7 @@ test_expect_success 'fetch --prune --tags with branch does not delete other remo
 	cd "$D" &&
 	git clone . prune-tags-branch &&
 	cd prune-tags-branch &&
-	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
+	git update-ref refs/remotes/origin/extrabranch master &&
 
 	git fetch --prune --tags origin master &&
 	git rev-parse origin/extrabranch
-- 
1.8.4
