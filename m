From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Thu, 25 Jun 2015 14:27:03 +0530
Message-ID: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yN-0000H4-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbFYI5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:23 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36230 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbFYI5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:20 -0400
Received: by pdcu2 with SMTP id u2so49315180pdc.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqaVXG6y+lG+c0390F0qg/KsIvSY2C6owWntRGIxV0k=;
        b=Zb1SJVjBkRVVty2GPvESHxvT1b2wNOE81DHBcXvKAQa94DSllzuLMcqtgsX9PTDpPJ
         Ay07ApcOv9EDL8XguyAdpWvuzPor+q3E5yoNqNpRyVAoMTmrLZhtzKmMLEkwxydmp6yB
         QQdzu9ovWqimiOe2lRVnG/QUmDxac/bdumG0aetSXrnGet1hA15sZUzKkSlmZ8Gwhi6t
         Z5tXhqofpskDzAjas36uFDQn50vz4cE6ek8Qmx8vqQH9+L6IC22xYw4nhRp0UZajewt6
         qXDN1spKINBigInRv9wzrTesXaDPPGdqUH78vLyoUqgjs8yG7VFapIfYXlaaGPrg21v2
         QiyA==
X-Received: by 10.66.66.173 with SMTP id g13mr20647151pat.155.1435222639682;
        Thu, 25 Jun 2015 01:57:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272643>

Add a test suite for testing the ref-filter APIs used
by for-each-ref. We just intialize the test suite for now.
More tests will be added in the following patches as more
options are added to for-each-ref.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 t/t6302-for-each-ref-filter.sh

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
new file mode 100644
index 0000000..b1fa8d4
--- /dev/null
+++ b/t/t6302-for-each-ref-filter.sh
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
