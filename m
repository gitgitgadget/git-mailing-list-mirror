From: mhagger@alum.mit.edu
Subject: [PATCH 4/7] real_path(): reject the empty string
Date: Tue,  4 Sep 2012 10:14:27 +0200
Message-ID: <1346746470-23127-5-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oP1-0003Vv-Md
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab2IDIWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:22:23 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:55394 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab2IDIWV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:22:21 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2012 04:22:21 EDT
X-AuditID: 1207440f-b7fde6d00000095c-7a-5045b8978c5c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E2.C5.02396.798B5405; Tue,  4 Sep 2012 04:15:19 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSY025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:18 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqDt9h2uAwa9JbBZdV7qZLBp6rzBb
	PJl7l9ni9or5zA4sHn/ff2DyePiqi93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M94dOMVe
	sJyj4v7abUwNjFfZuhg5OSQETCTWH7rKCmGLSVy4tx4ozsUhJHCZUeLMj0VMEM5pJolLq68y
	gVSxCUhJvGzsYQexRQTUJCa2HWIBsZkF0iVOLGgHs4UFLCUmr/sKVsMioCrR8KwVbAOvgIvE
	hfVNLBDbFCV+fF/DDGJzCrhKvPrwGmgzB9AyF4mPD5wnMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRropebWaKXmlK6iRESPvw7GLvWyxxiFOBgVOLhrfrkEiDEmlhWXJl7iFGSg0lJ
	lNdus2uAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe26uBcrwpiZVVqUX5MClpDhYlcV71Jep+
	QgLpiSWp2ampBalFMFkZDg4lCd5924EaBYtS01Mr0jJzShDSTBycIIILZAMP0IZHIIW8xQWJ
	ucWZ6RBFpxgVpcR5b4AkBEASGaV5cANgkf6KURzoH2He1yBVPMAkAdf9CmgwE9Bg1/cuIINL
	EhFSUg2MdtduG1/lcHSY4yp7eYnhm5NHGfmEGJn+btWPCL7+WeF3H6ORqW7N0vbcC8erhdc9
	Uvzs9Y7v7YqvM/d31S9gs190Kej2SYXtSutlnHfUXjkc+vtkdIa/XEXLRnVr6zchJT/nC3Rx
	s5znKtGNc9M/1fXMaZFg8Y92291SEtc3WzAcfPpBbom+EktxRqKhFnNRcSIA1NtE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204725>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c        | 3 +++
 t/t0000-basic.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 5d62430..3e8325c 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,6 +35,9 @@ const char *real_path(const char *path)
 	if (path == buf || path == next_buf)
 		return path;
 
+	if (!*path)
+		die("The empty string is not a valid path");
+
 	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 		die ("Too long path: %.*s", 60, path);
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 363e190..1a51634 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -454,7 +454,7 @@ test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
-test_expect_failure 'real path rejects the empty string' '
+test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-- 
1.7.11.3
