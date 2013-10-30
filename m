From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/23] t5510: prepare test refs more straightforwardly
Date: Wed, 30 Oct 2013 06:32:51 +0100
Message-ID: <1383111192-23780-3-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOWc-0007EM-4G
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab3J3Fk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:40:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61756 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab3J3Fk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:40:57 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:40:57 EDT
X-AuditID: 12074412-b7fc96d0000023d5-1e-52709a436cb9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.D2.09173.34A90725; Wed, 30 Oct 2013 01:33:55 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbID014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:33:53 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOs8qyDI4MkcRYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74+2VNUwFnwQqNpy4wd7A+JK3i5GTQ0LARKLv9hlGCFtM4sK99WxdjFwcQgKXGSWubXrJ
	BOFcYZLoW36YDaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwERmiePTFwE5HBzCAp4SF1qFQGpY
	BFQl+j5/A+vlFXCRmDXxOgvENgWJG81TWUFsTgFXiU+7brKD2EJANU3tn9knMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iREStkI7GNeflDvEKMDBqMTDa/AgP0iI
	NbGsuDL3EKMkB5OSKG/alIIgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8048DlfOmJFZWpRbl
	w6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfAqzwQaKliUmp5akZaZU4KQZuLgBBFc
	IBt4gDbwgBTyFhck5hZnpkMUnWJUlBLnVQBJCIAkMkrz4AbAEswrRnGgf4Qh2nmAyQmu+xXQ
	YCagwXtY8kAGlyQipKQaGFP2bbp25bHlz9B7P1teteWHcSfYtfbLrnq6K684bjq3kf1JK/Pe
	vMdF2qfyfUoPl+6rmr9Np7Zz9jolzU1OYTO7Wa8pbbwU+oJrgpXmbdvVPLnaumYl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236965>

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
1.8.4.1
