From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] t5510: ensure we stay in the toplevel test dir
Date: Thu, 1 Mar 2012 22:40:50 +0100
Message-ID: <80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DkU-0007ba-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131Ab2CAVlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:41:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:24475 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965082Ab2CAVk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:40:56 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:52 +0100
Received: from thomas.inf.ethz.ch (129.132.210.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:53 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <cover.1330637923.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191976>

The last test descended into a subdir without ever re-emerging, which
is not so nice to the next test writer.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t5510-fetch.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 8827828..dd035bf 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -431,6 +431,7 @@ test_expect_success 'fetch --dry-run' '
 test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	cd dups &&
+	test_when_finished "cd .." &&
 	git init &&
 	git config branch.master.remote three &&
 	git config remote.three.url ../three/.git &&
-- 
1.7.9.2.467.g7fee4
