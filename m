From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 12/19] mingw: skip test in t1508 that fails due to path
 conversion
Date: Tue, 26 Jan 2016 15:35:14 +0100 (CET)
Message-ID: <5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:37:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4kM-0005tn-O7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966140AbcAZOh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:37:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:61780 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966309AbcAZOfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:17 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MRoRF-1aYucc0czB-00SzLL; Tue, 26 Jan 2016 15:35:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Psr2Z0kJaMlmx/CAOnj2pK3PWwd0ja7w/drV4sSNLRdYzzjy+gU
 0d64IPAlUr9nwYfwSbzFGDKKod+Gj6ZCDLQ5gR5guH+RbxlfoZqTJk9d1Jlwsh42AyUhCLf
 k5AumgQtOjaSuyJY6RF1HOC1Vm7gcbeK+FgUd54jXLohwECR3We25ej77Ue4Il8ATIK7glO
 Pn1Rv9zZPhoTaGsoyT+2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+wfN0i9r9Ec=:DqzrPKlcb8kjRQOpbw0Y2M
 4c7akh2byTM9yhBD7r+/7EzRBvSWHM+WhzBG7i6AUEv1tztvxT0lCORbvXclwLkw3/fZfrcLT
 YxZ6FErFXJvfOA6owi+VgyAUjL5rGikdYl/LkDpgnhqIx8kBz/Z5tZtWIsifeukf3iwNxxl5Q
 Ew+HeXrIi9cAPpHhP7vDYicITAGlSezAaDUtNpR3Cz8YDCPWooz77Hq95+ZEStGK2INP8Ympe
 pb68w5nJpllj0UoA6XrYAmygFnqd0wMwf/KkyGPgz6KgFLyBDiQ52G0lsUF85EX3xB1FjtiSy
 ESb9gLFAqNbcxCR0gNtxcxP36vd/ItkGH5jrMhkdixn/LoLowqk2cbp9UzofdnmedLvo17aIt
 TbN+yi4FwKoWCfciRyHPut9bunYIz9UzI7VSQbalaTWtmf2OH/Jy70XWS7rhHClc63UAjW9pK
 ZPT4eV9vCrsuPzCX9GCsuUJd+WlWStJWEc+xQMJxm6m5sXnN+nQylsP46RmtB/Wvfk2lBUyWF
 ynjpTbEOvtw7j5WIeaAYVnVYdUb3I/Z6AeidzVi+PUFgWdM3n8dtZHhu1J8JFLctSsxLHyl3v
 jprc9JfOfBn7B3dN1q8oT40H0AmhoATo43ataA+heBo4UyzDxWLcJno+lbW8+AoRbnebUu9R2
 r3PzL1PcuWOSZXvo5ek8ML0pww7J+z8AbNjGh6Xu7r9SOpWrpdyDwTJQsZoaNV4m8YgJaB99K
 +6wEwdTo/XFrMIcmvF7er9pMp2ioKy4ik9uGFMfhIXC+gUH3LS+32OY2TFnsp1qnKYBCnxOK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284834>

In Git for Windows, the MSYS2 POSIX emulation layer used by the Bash
converts command-line arguments that looks like they refer to a POSIX
path containing a file list (i.e. @<absolute-path>) into a Windows path
equivalent when calling non-MSYS2 executables, such as git.exe.

Let's just skip the test that uses the parameter `@/at-test` that
confuses the MSYS2 runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1508-at-combinations.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 078e119..c59d554 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -35,7 +35,10 @@ test_expect_success 'setup' '
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
-	git checkout -b @/at-test &&
+	if ! test_have_prereq MINGW
+	then
+		git checkout -b @/at-slash
+	fi &&
 	git checkout -b @@/at-test &&
 	git checkout -b @at-test &&
 	git checkout -b old-branch &&
@@ -64,6 +67,7 @@ check "@{-1}@{u}@{1}" commit master-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
 check "@@/at-test" ref refs/heads/@@/at-test
+test_have_prereq MINGW ||
 check "@/at-test" ref refs/heads/@/at-test
 check "@at-test" ref refs/heads/@at-test
 nonsense "@{u}@{-1}"
-- 
2.7.0.windows.1.7.g55a05c8
