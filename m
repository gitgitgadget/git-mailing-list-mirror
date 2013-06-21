From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 2/3] remote: Add test for prune and mixed --mirror and normal remotes
Date: Fri, 21 Jun 2013 12:04:10 +0200
Message-ID: <1371809051-29988-3-git-send-email-dennis@kaarsemaker.net>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 12:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpyCl-0005mf-BN
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab3FUKET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:04:19 -0400
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:61364 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751350Ab3FUKES (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 06:04:18 -0400
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:16 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:16 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:15 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 12:04:15 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
In-Reply-To: <1371763424.17896.32.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 21 Jun 2013 10:04:15.0558 (UTC) FILETIME=[AFCE5E60:01CE6E66]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228588>

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 t/t5505-remote.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd10ff0..439e996 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -428,6 +428,15 @@ test_expect_success 'add alt && prune' '
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
+test_expect_failure 'prune and overlapping refspecs' '
+	(git clone --mirror one prunetst &&
+	 cd prunetst &&
+	 git remote add two ../two &&
+     git fetch two &&
+	 git remote prune origin &&
+     git rev-parse --verify refs/remotes/two/another)
+'
+
 cat >test/expect <<\EOF
 some-tag
 EOF
-- 
1.8.3.1-619-gbec0aa7
