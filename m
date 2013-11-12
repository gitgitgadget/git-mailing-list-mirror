From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 2/9] test-lib.sh: convert $TEST_DIRECTORY to an absolute path
Date: Tue, 12 Nov 2013 00:54:41 -0500
Message-ID: <1384235688-9655-3-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6we-0008KE-I6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3KLFzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:20 -0500
Received: from smtp.bbn.com ([128.33.1.81]:18719 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab3KLFzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:13 -0500
Received: from socket.bbn.com ([192.1.120.102]:44821)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wS-0002PG-4a; Tue, 12 Nov 2013 00:55:12 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7123F4004D
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237688>

If $TEST_DIRECTORY is specified in the environment, convert the value
to an absolute path to ensure that it remains valid even when 'cd' is
used.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b25249e..af172d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -26,6 +26,10 @@ then
 	# outside of t/, e.g. for running tests on the test library
 	# itself.
 	TEST_DIRECTORY=$(pwd)
+else
+	# ensure that TEST_DIRECTORY is an absolute path so that it
+	# works even if the current working directory is changed
+	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then
-- 
1.8.5.rc1.208.g8ff7964
