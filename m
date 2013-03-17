From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] t1507: Test that branchname@{upstream} is interpreted as
 branch
Date: Sun, 17 Mar 2013 23:17:09 +0100
Message-ID: <20130317221708.GA7707@camk.edu.pl>
References: <1363459903-32358-1-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 23:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHLtq-0001Y2-K6
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab3CQWR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 18:17:28 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:53455 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab3CQWR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 18:17:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id ACD1D5F004B
	for <git@vger.kernel.org>; Sun, 17 Mar 2013 23:15:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1ABeGUVaCArH for <git@vger.kernel.org>;
	Sun, 17 Mar 2013 23:15:16 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 38C5B5F004A
	for <git@vger.kernel.org>; Sun, 17 Mar 2013 23:15:16 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 3FB4848385; Sun, 17 Mar 2013 23:17:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1363459903-32358-1-git-send-email-draenog@pld-linux.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218379>

Syntax branchname@{upstream} should interpret its argument as a name of
a branch. Add the test to check that it doesn't try to interpret it as a
refname if the branch in question does not exist.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---

Maybe I'm too cautious adding this test. But just in case here it is.

 t/t1507-rev-parse-upstream.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index d6e5761..b27a720 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -54,6 +54,10 @@ test_expect_success 'my-side@{upstream} resolves to correct full name' '
 	test refs/remotes/origin/side = "$(full_name my-side@{u})"
 '
 
+test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
+	test_must_fail full_name refs/heads/my-side@{upstream}
+'
+
 test_expect_success 'my-side@{u} resolves to correct commit' '
 	git checkout side &&
 	test_commit 5 &&
-- 
1.8.2
