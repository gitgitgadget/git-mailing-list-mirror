From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 2/9] test-lib.sh: convert $TEST_DIRECTORY to an absolute path
Date: Sun, 17 Nov 2013 23:12:43 -0500
Message-ID: <1384747970-25481-3-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDH-0003vc-5L
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3KRENW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:22 -0500
Received: from smtp.bbn.com ([128.33.0.80]:32201 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3KRENV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:21 -0500
Received: from socket.bbn.com ([192.1.120.102]:57934)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGD8-0009cc-QG; Sun, 17 Nov 2013 23:13:18 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0C0513FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237965>

From: Felipe Contreras <felipe.contreras@gmail.com>

If $TEST_DIRECTORY is specified in the environment, convert the value
to an absolute path to ensure that it remains valid even when 'cd' is
used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Reviewed-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b25249e..d303e6c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -26,6 +26,10 @@ then
 	# outside of t/, e.g. for running tests on the test library
 	# itself.
 	TEST_DIRECTORY=$(pwd)
+else
+	# ensure that TEST_DIRECTORY is an absolute path so that it
+	# is valid even if the current working directory is changed
+	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then
-- 
1.8.5.rc1.208.g8ff7964
