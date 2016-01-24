From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Sun, 24 Jan 2016 16:45:22 +0100 (CET)
Message-ID: <7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMrE-0001Ww-75
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbcAXPpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:55041 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbcAXPpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:34 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MhMg2-1ajpgH2ohm-00McIC; Sun, 24 Jan 2016 16:45:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WdlZh2xO+glzzSPehVZjXEwyxHX1YsTulmPibAB49OaGNFtwbpK
 rsr/QmUJkVwn/amKtRcaoIjLuT9FDQqlzArfTUFcTulSMVR6Zb37GHKHlWnmJ7ogWaAoWj+
 15tKcCrk8C3LJhS4W4aQNtxk7P+A+0Ar5V9Jh7DE+LV8j1Ut33loUbDlisU9JNx4qj/2c81
 BXUucHrWgvPS5xpaIFPdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9lr5PRGhwfg=:b9kGLOXMRvzgD+3rcpdyfh
 3adsXC01UtIK5kRyhr4ugjrRTMdrnOSdLKNdGZmRE9rYWhJjZIte8b+qvxmMbUleJai32gjfN
 O0JCn3aWN6FE/8bDAJ79VK+w7IQ7hEj4GHUYGD42ieYZZWHLhmGywCxHiASbCZtuDPabLJS2o
 3aEBpW6adlPIoQyX83x32fZyx4T+cUSEr/RYDwACXMBtNnoqFlkNX8hkG7c/aqICTt543o94k
 Q4Z6WDHrwnVdqujFapDQrPulHT5XXOlZVGkLHIRLxilnSyeV8L1U3RoxwaopU3iNWAXlKKUZ/
 0bqbycwNbLc2ADbc3svqYr+J18cTENMC8v7nj/KQoXuz/u0u2tRPvRjViBy4c0M/MvlI/wLQY
 y1pFT8cBQNYE7YyRBscKjExwTWtouz3Oj46x5VqoFTbeDvCrir4FJBJ30a2vLslTR+vMd3xYh
 9aJafgqPZp/qZ+H/j3wcT0yzYA51jFWnxWX6HlzOk2ISFPKSkdp4Moh76wrGbzb9FJ/h4bCYj
 gGFN/m12UxZwEf0XKm2y6eTqXU3Z8Sy8/i6zjbahG1U75NarvzPaM9YZa0E+K8TXP6MgZrprq
 CFysu20kcwgL43cIYgNZC7V+Jco1cB7cVbj00D9Wis4+BsoGkeyokPJBGr7cJBgnFwZdtKeWC
 GVGPDIPlterXVjDlb/Y1lPP2J7cepGGzBgtBpGVyx3Ft+7HV5sx1Cvc56YKWsOUulkntrW6dg
 HX9rC0/k9PL2DEzE0Pylh9luhJ9P7y6pQSJOjJ4HMYUcHwLLEUxplXgFEeUlNEOfm58TZNgO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284680>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

The test separator char is a colon which means any absolute paths on
Windows confuse the tests that use global_excludes.

Suggested-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0008-ignores.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 4ef5ed4..68749f5 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -5,7 +5,13 @@ test_description=check-ignore
 . ./test-lib.sh
 
 init_vars () {
-	global_excludes="$(pwd)/global-excludes"
+	# On Windows, avoid using "C:" in the global-excludes paths.
+	if test_have_prereq MINGW
+	then
+		global_excludes="global-excludes"
+	else
+		global_excludes="$(pwd)/global-excludes"
+	fi
 }
 
 enable_global_excludes () {
-- 
2.7.0.windows.1.7.g55a05c8
