From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 04/14] apply: add t4137 for submodule updates
Date: Sun, 15 Jun 2014 18:59:20 +0200
Message-ID: <539DD0E8.1020501@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 18:59:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDmQ-0001YB-0L
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 18:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaFOQ7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 12:59:38 -0400
Received: from mout.web.de ([212.227.15.14]:55098 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbaFOQ7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 12:59:37 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LmLc6-1WNRBj09I2-00a16p; Sun, 15 Jun 2014 18:59:21
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:GBVakvOwqYAcCe4ZpIxY03iteqW5FhjcIaJyp04eq7wlkBNpSLJ
 CFGMEHfeMgvTpQhz2C0b0KKCdL3dYvBeqWXAdBQaoxp+Qo2N1UsK88cKdpvXsSgJROApJ2p
 OQTXrSTbuzJuIOwsiX3354csqKKBqu8GK2J+jHAenJ+ZTUNiIFMwmM1TH+t38y2Yql4kRE4
 xY2PAZa4N5NTWrFfeRAOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251686>

Test that the apply command updates the work tree as expected for the
'--index' and the '--3way' options (for submodule changes which don't
result in conflicts).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t4137-apply-submodule.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 t/t4137-apply-submodule.sh

diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
new file mode 100755
index 0000000..a9bd40a
--- /dev/null
+++ b/t/t4137-apply-submodule.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='git apply handling submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+apply_index () {
+	git diff --ignore-submodules=dirty "..$1" | git apply --index -
+}
+
+test_submodule_switch "apply_index"
+
+apply_3way () {
+	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
+}
+
+test_submodule_switch "apply_3way"
+
+test_done
-- 
2.0.0.275.gc479268
