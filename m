From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH 2/2 (v2)] t7406: "git submodule update {--merge|--rebase]" with new submodules
Date: Thu, 17 Feb 2011 09:18:46 -0700
Message-ID: <1297959526-8089-2-git-send-email-olsonse@umich.edu>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 17:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq6Zj-0005W1-FI
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 17:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab1BQQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 11:19:17 -0500
Received: from smtp.mail.umich.edu ([141.211.12.86]:34358 "EHLO
	tombraider.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab1BQQTN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 11:19:13 -0500
Received: FROM localhost.localdomain (zektor.gpcc.itd.umich.edu [141.211.2.203])
	By tombraider.mr.itd.umich.edu ID 4D5D4A80.35AD3.3644 ;
	Authuser olsonse;
	17 Feb 2011 11:19:12 EST
X-Mailer: git-send-email 1.7.4.1.42.g43f9f
In-Reply-To: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167091>

This patch adds two new test cases in t7406 to ensure that the --merge/--rebase
options are ignored for "git submodule update" with new modules.  These test
that a simple checkout is performed instead.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
---
 t/t7406-submodule-update.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index bfb4975..141251c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -203,4 +203,28 @@ test_expect_success 'submodule init picks up merge' '
 	)
 '
 
+test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
+	(cd super &&
+	 rm -rf submodule &&
+	 git submodule update submodule &&
+	 git submodule status submodule >expect &&
+	 rm -rf submodule &&
+	 git submodule update --merge submodule &&
+	 git submodule status submodule >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
+	(cd super &&
+	 rm -rf submodule &&
+	 git submodule update submodule &&
+	 git submodule status submodule >expect &&
+	 rm -rf submodule &&
+	 git submodule update --rebase submodule &&
+	 git submodule status submodule >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.4.1.42.g43f9f
