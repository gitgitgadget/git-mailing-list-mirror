From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 2/2] checkout: add a test for creating a new branch with regexp as a starting point
Date: Sat, 31 Jul 2010 04:19:20 +0400
Message-ID: <20100731001919.GB24129@wo.int.altlinux.org>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 02:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeznU-0006U0-Ao
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 02:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab0GaATX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 20:19:23 -0400
Received: from vint.altlinux.org ([194.107.17.35]:44399 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0GaATW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 20:19:22 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 4B1103F80005
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 00:19:20 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 30FC63F48760; Sat, 31 Jul 2010 04:19:20 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152274>

Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 t/t2018-checkout-branch.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 1caffea..4d26b2a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -118,7 +118,20 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
+test_expect_failure 'checkout -b new_branch :/regexp' '
+	# clean up from previous test
+	git reset --hard &&
+
+	do_checkout old_regexp_branch branch1 &&
+	test_commit first '' '' '' &&
+	test_commit second '' '' '' &&
+
+	do_checkout new_regexp_branch :/first
+'
+
 test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
+	# clean up from previous test
+	git reset --hard &&
 	git checkout branch1 &&
 
 	do_checkout branch2 "" -B


-- 
ldv
