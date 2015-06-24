From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Thu, 25 Jun 2015 01:23:42 +0530
Message-ID: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qkK-0007mo-CY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbbFXTyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34218 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbFXTyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:02 -0400
Received: by pabvl15 with SMTP id vl15so35080358pab.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DOjJ+K2yQ6nnlItn6BRZ68+jgivXEmZx8/MfbPPkByE=;
        b=tiJw0hjYQH8ocPy4gq2myAAqobGt/knJqxquwhHeMofHLBq49uPeQ8hCEiwVPiuomo
         bIzKYdeMjGm0o/z0A/FAlP65WuVY6X4neUvD8gxUoeQ4ZKcharfMCuHpZA9PiSxHjBsW
         9KmfOnrKFEpcHL/hApKjZw1mlr5kublwbVvBJf9MgnvHB8PSBhX3ICLarVZ+tWdjqYEY
         6dZQK+S7hxP3vaJZTZAs7h08JJBSNvpSNKJ/8UtEJXli8O4orkkMuXF5NofRjFNZW3O1
         kGSkAdtzIeyBfZjqThyY5a0HE9CeKC4WT6tiJZn5lLYNJb7pdVT/jhD4zEMQhNtGkS3g
         4KQw==
X-Received: by 10.66.249.101 with SMTP id yt5mr83344927pac.116.1435175640924;
        Wed, 24 Jun 2015 12:54:00 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.53.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272592>

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
2.4.4
