From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t3404: begin "exchange commits with -p" test with correct
 preconditions
Date: Sat, 19 May 2012 15:14:16 +0200
Message-ID: <4FB79CA8.7080103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 15:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVjUH-0005sF-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 15:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab2ESNOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 09:14:20 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:35365 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876Ab2ESNOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 09:14:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2186813004D;
	Sat, 19 May 2012 15:10:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EB98819F6E3;
	Sat, 19 May 2012 15:14:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198030>

The test case shows a bug in 'rebase -p', but even if the bug were fixed
the test would fail because it did not ensure that the preconditions match
the postconditions that were checked. Insert the suitable 'git checkout'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Could it be that this bug existed since the test case was introduced
 in cddb42d2?

 (The bug in git-rebase has not been fixed since then, unfortunately.)

 -- Hannes

 t/t3404-rebase-interactive.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4983bd7..025c1c6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -247,6 +247,7 @@ test_expect_success '-p handles "no changes" gracefully' '
 '
 
 test_expect_failure 'exchange two commits with -p' '
+	git checkout H &&
 	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
-- 
1.7.10.2.529.g0c18cfd
