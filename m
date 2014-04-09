From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] remote-helpers: allow all tests running from any dir
Date: Wed,  9 Apr 2014 13:50:00 -0500
Message-ID: <1397069404-7451-2-git-send-email-felipe.contreras@gmail.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxjU-0006K8-5I
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934030AbaDITAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:13 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34495 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:11 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so3219941obc.13
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FUL104lc15N3LC7p+8cKyZSpnZRzRB4A4w8RGq5RuI=;
        b=lXJoRMo6B1nv15/lz8r2u6aDs6dDHoP7RUpjVKz0aB4Af85f21w/E4o9loITxRbNaD
         3xnwuYysbFVDII6YOcD+zpMVFWOJYz87IAON2CEfnHoBGV1r5nSaUWORdg8h0M8GJxJ3
         WyToTjNHT29rKpTNVxbWlpl2u9fy9V6TEckC7DlT+EfWot9xw0dmF2RY/7ROSOI0J1ov
         5YI+tz5y5LyUMvbnpKoqjzvglIuiujm/c4uCyQR7y+ykJLxJmXxN77QvyW5n343xjCLj
         fSXQrhku45Ndt2Warvl2rY/KJYUSUvpWRymhBzLUcJOIEK25htNlts/Louem3gS5umKZ
         Ku0A==
X-Received: by 10.182.74.137 with SMTP id t9mr1902670obv.79.1397070011462;
        Wed, 09 Apr 2014 12:00:11 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cq1sm7332452oeb.4.2014.04.09.12.00.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245989>

Commit d3243d7 (test-bzr.sh, test-hg.sh: allow running from any dir)
allowed the tests to run from any directory, however, it didn't update
all the tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 3 ++-
 contrib/remote-helpers/test-hg-hg-git.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index e24c51d..d86e147 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -8,7 +8,8 @@
 
 test_description='Test bidirectionality of remote-hg'
 
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 6dcd95d..b23909a 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -8,7 +8,8 @@
 
 test_description='Test remote-hg output compared to hg-git'
 
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
-- 
1.9.1+fc1
