From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Tue,  7 Jul 2015 21:36:07 +0530
Message-ID: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:06:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVO5-0000tz-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729AbbGGQGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:06:21 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36081 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbbGGQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:06:20 -0400
Received: by pacgz10 with SMTP id gz10so41753207pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCq9ClkvRmL5HimUAN5Kc/Z1lflQEVSKlujNsYxs6PQ=;
        b=nWSZUXPU1dqIff9KCrpNFrbcalbRDBWMPxN55gopS6B2eGD7smk/tQdPRnv/H1YItT
         z6KvQttz7Ae/iUyWitUyp003Rb/8fNwiLqViB9+RAxM5PwgwmeD9gHsITDiMZiZraRSP
         gShLTULOAH9eKFsHTdEOlLWLq+Nu8erDb+OMVQURJjiS81TaiE3sEvM3iao7QCm6BSYO
         9EhqRY3PUB+hf3vz2lT1PbaSiZTOFjE5UmUbqUW7ZmG83ckvUWbI3xvSaQQILX93S2V7
         Qpwaw2iQfAL0t5hGREA/lX9xQvGS1Eyt8p1KOof6zf2sI24VJXhb1FRTSFY0J1vddo9x
         F+kw==
X-Received: by 10.66.221.193 with SMTP id qg1mr10162024pac.134.1436285180439;
        Tue, 07 Jul 2015 09:06:20 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.06.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:06:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273570>

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
2.4.5
