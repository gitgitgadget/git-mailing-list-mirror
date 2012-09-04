From: mhagger@alum.mit.edu
Subject: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Tue,  4 Sep 2012 10:14:30 +0200
Message-ID: <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oPD-0003cr-MG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab2IDIWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:22:34 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:56617 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754033Ab2IDIWd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:22:33 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2012 04:22:33 EDT
X-AuditID: 1207440c-b7f616d00000270b-58-5045b8a31c20
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.2B.09995.3A8B5405; Tue,  4 Sep 2012 04:15:31 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSb025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:30 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLt4h2uAwfk/XBZdV7qZLBp6rzBb
	PJl7l9ni9or5zA4sHn/ff2DyePiqi93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M06ue8Fc
	sJGrYl77TZYGxiMcXYycHBICJhIHrnxlhbDFJC7cW8/WxcjFISRwmVHi6I1v7BDOaSaJpe/6
	mUGq2ASkJF429rCD2CICahIT2w6xgNjMAukSJxa0g9nCAp4SXadvgE1lEVCVaLu+CyzOK+Ai
	0XnxNhvENkWJH9/XgM3kFHCVePXhNVCcA2iZi8THB84TGHkXMDKsYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI11MvNLNFLTSndxAgJH54djN/WyRxiFOBgVOLhrfzkEiDEmlhWXJl7iFGSg0lJ
	lNdus2uAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe26uBcrwpiZVVqUX5MClpDhYlcV7VJep+
	QgLpiSWp2ampBalFMFkZDg4lCd5924EaBYtS01Mr0jJzShDSTBycIIILZAMP0IZHIIW8xQWJ
	ucWZ6RBFpxgVpcR5b4AkBEASGaV5cANgkf6KURzoH2He9SBVPMAkAdf9CmgwE9Bg1/cuIINL
	EhFSUg2MbvdP2bxJPhDVfUHj7Z6Nx1exX3uqJPz6ZdAsz6T5Zu1vmLJvyiyWjZtr/fHYFgXd
	25NEtQOs4k/tO1qkOkcucxm/wLf7lVrpU79v7xGU/ap9ZDvXvOrgn65sH3Ya/85hf3z10qlp
	n9e+Koyx3sW/ipOt84nWj1CLoKd232X+dXzm2XHPUb2OVYmlOCPRUIu5qDgRAKsp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204726>

From: Michael Haggerty <mhagger@alum.mit.edu>

These tests already pass, but make sure they don't break in the
future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

It would be great if somebody would check whether these tests pass on
Windows, and if not, give me a tip about how to fix them.

 t/t0000-basic.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index d929578..3c75e97 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -468,6 +468,17 @@ test_expect_success 'real path works on absolute paths' '
 	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
 '
 
+test_expect_success 'real path removes extra slashes' '
+	nopath="hopefully-absent-path" &&
+	test "/" = "$(test-path-utils real_path "///")" &&
+	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&
+	# We need an existing top-level directory to use in the
+	# remaining tests.  Use the top-level ancestor of $(pwd):
+	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&
+	test "$d" = "$(test-path-utils real_path "//$d///")" &&
+	test "$d/$nopath" = "$(test-path-utils real_path "//$d///$nopath")"
+'
+
 test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
