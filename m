From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 11/19] fsck: Add a simple test for receive.fsck.<msg-id>
Date: Mon, 22 Jun 2015 17:26:36 +0200
Organization: gmx
Message-ID: <50f06eaadaca96dd87f7dccc1b62e8abb0032dd9.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cY-00078y-B2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbbFVP0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:55922 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbbFVP0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MXZ4Q-1ZdYzq43pm-00WTpM; Mon, 22 Jun 2015 17:26:37
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:1sgKlxib4F4wLcL+Mda3Wd1SozmDphN65yjqj3UdpVhTnVSNIfp
 ebNx9pxW7ngXfQWK/ejP7M8HUmXKQGuCpb3K55wGAJcg/pyKqiVCkFIRsaHG4DNE+s5ggPQ
 QY/UHV3+vd1vLQJsvqFJmg/x73B7Mbg/t8zSXME2Y/7rO+8M+JxpuHrJ8JGijXAOwe0xWGz
 /8LtUVi4oLn84re6aiswg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1FzxLrgpDR0=:zLU7RcJNK0SeOBNv9WFaXP
 4homEwcFPaEWgvkpDtVayFopo+I5DORaU0DapidzhlK8da/YcyjM/MIGETO7yV6oYP21QLg1A
 /L3GXfeWsG8+J6KMBYf1UloNNJdAUKipeaGxrxdIJ3CDRj6jQ0F9FKD31CEKpx9kv/nnj7uTW
 OgkN9PUlWbDp51iv4qWRiW6xWWulujU2105vD2z0XLwgXsljZfY0yZ4bp3vL2AbIR4e9SpSs4
 AQnO2ovWaqdKCcCSFN4vy+Nj4ewOtB4VYT3A6VLy/VAyHmKTdqAwWgkDnKDb2IO43vbQHprhr
 Ftbz+ID8EX4qQ25qsykSIdqX/wp96DSjDfM9f/i4HPGOc5Rrt/wwtWj+vb4U4Da8Y5m1bSk3F
 mcU0r0c/pKo+JLrTUHnVAtcQQufuZO+WhNzDOFSg1sTGVL8AlzFfdJ3gmxss572Njr+gfa0uC
 6wudLI0Cv5uGQaxvmLV7dyuKAd5eJHR2HbA9TIYtDljG+gg2yf+5Qbs/iJt/1mXkl0SDAdBlK
 EiAuf2d46vQhRyvnWv9pXhZjA9hWpz+D/K2HDfD4479NhppWyjSCOXZyo380LIuteQZ8rOaZC
 ReZ7OlafgmQRxQ3nj2vgdkC/ycXHwhubNkWRQQ0NupEk6t5KgeVqFnCx+BhzlIcCdLCyn7BVb
 uni9Llhy0upTxjeaEAfjEnD64d87tfeK7AjXgTu/9OVpik85OKaE14Ps+w6sJYiYkBgY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272383>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..36024fc 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,25 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit <<\EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.missingEmail=warn' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config \
+		receive.fsck.missingEmail warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missingEmail" act
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
