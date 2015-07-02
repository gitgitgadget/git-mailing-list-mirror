From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Thu,  2 Jul 2015 20:51:00 +0530
Message-ID: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgIm-0008NP-I5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbbGBPVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:21:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32957 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbGBPVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:15 -0400
Received: by pacws9 with SMTP id ws9so42776733pac.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlP11Ss8MmB4w6qdXqChoNoJCxHex8HeQZFKqDp73oc=;
        b=Sy2jSe7ES4VTxwpiXfUvt6Bg1kBJOA1xWhP5Cvr5IQ6F2bOctBPzDsW5PkQ+jPe10P
         iqoYDWdhGWsYl+HIKT2m1CZoE+W9TXl6nzLW+UslikXaMYxY4f1SObNR4qH4LL76yQAF
         j/opBdifz/2Rhv/6yGRSKBM2QkMEw4gQWCMvMneb93rEegzMdKOmRrH9zqf9A6Gcz98p
         nin+g/GAQVjP25RoSJ0nazKSFBgLIAmLFnUCccmQskpW/iWA886pQVeosUMHxFtK2AQT
         2b2juu4wRi3oWe0540Q9qfSbXbtmfFA7YvKBor4LJpPpFUsq1TkuI+bbwDQ0gNkakuTI
         Hz3A==
X-Received: by 10.66.119.105 with SMTP id kt9mr67981777pab.86.1435850475060;
        Thu, 02 Jul 2015 08:21:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.21.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:21:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273234>

Add a test suite for testing the ref-filter APIs used
by for-each-ref. We just intialize the test suite for now.
More tests will be added in the following patches as more
options are added to for-each-ref.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6302-for-each-ref-filter.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 t/t6302-for-each-ref-filter.sh

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
new file mode 100755
index 0000000..44d2f24
--- /dev/null
+++ b/t/t6302-for-each-ref-filter.sh
@@ -0,0 +1,20 @@
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
+	git tag -s -m "Annonated doubly" double-tag signed-tag &&
+	git checkout master &&
+	git update-ref refs/odd/spot master
+'
+
+test_done
-- 
2.4.4
