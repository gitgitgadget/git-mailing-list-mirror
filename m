From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 01/19] t6301: for-each-ref tests for ref-filter APIs
Date: Mon, 22 Jun 2015 02:18:15 +0530
Message-ID: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mAS-0005GT-2E
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbbFUUsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:48:35 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35770 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbFUUsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:48:35 -0400
Received: by pdbci14 with SMTP id ci14so66143249pdb.2
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EPWKmHxTijwvClKcLFgUXrDz89whk/u+/eCgzNJCs0=;
        b=09Jz2fjZWIP0W6K4vpty6yxuqp/32vANf5x1lOs1c6/FsUua7aThg1mkP5peSeCKUW
         B2BIIn4qZIcfASBiLwU3f7tHRkCCp6KDIQeDFPLV4DQ5KF+YI5dIrO9n6JviNkom+Iai
         Je5SRO04c0Np63e01q7IBsy2ubdV8mceYnWX/VqzETNHzqqZiObMzdle1gODGg4gxnrk
         bv4F93BIAzBRjgJ0LOIUPwk8+2Qu9xS8XX46v6Z8t4nN51BnuGq/PE3CEJbB2ZlzGyaN
         A3csTl3P2+RDP/F4dz90nYM3rdYANEIyWHjnPf5XpJo7g5i8J6Ik/Kiby/7tXwaFsJom
         CHBw==
X-Received: by 10.70.128.13 with SMTP id nk13mr51877460pdb.21.1434919714610;
        Sun, 21 Jun 2015 13:48:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.48.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:48:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272288>

Add a test suite for testing the ref-filter APIs used
by for-each-ref. We just intialize the test suite for now.
More tests will be added in the following patches as more
options are added to for-each-ref.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6301-for-each-ref-filter.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 t/t6301-for-each-ref-filter.sh

diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
new file mode 100755
index 0000000..b1fa8d4
--- /dev/null
+++ b/t/t6301-for-each-ref-filter.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='test for-each-refs usage of ref-filter APIs'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+test_expect_success 'setup some history and refs' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git checkout -b side &&
+	test_commit four &&
+	git tag -s -m "A signed tag message" signed-tag &&
+	git checkout master &&
+	git update-ref refs/odd/spot master
+'
+
+test_done
-- 
2.4.3.439.gfea0c2a.dirty
