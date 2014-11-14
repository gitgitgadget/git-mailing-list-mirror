From: Mike Blume <blume.mike@gmail.com>
Subject: [PATCH v3] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 09:08:05 -0800
Message-ID: <1415984885-59073-1-git-send-email-blume.mike@gmail.com>
Cc: Mike Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 18:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpKM4-0003jP-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 18:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbaKNRIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 12:08:12 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34334 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161302AbaKNRIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 12:08:11 -0500
Received: by mail-pd0-f176.google.com with SMTP id ft15so17008978pdb.21
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kLEGI03z/26I+Id+8oBwLKogvUqjN/YzaSEzA6WPS2A=;
        b=vXrsrU8Sm49WYF1pZh8iCnArnTEvGb114rFO1aDk0Hmpn2km76VU5O4tRQ8oSbBJoa
         EqWi72uGSbk9Hh9o5yeJc7HrjB/+0cqToPZXKkWbDjxWNkwghg2oKDK7cxiwCJWl+lru
         qFywCdkNKlVdEDQi0K+I0yFSvoHsJB0lJPdrK13IFN4Vpw95xzCqJG74aY+EtC/Q1xX5
         hDwSE9c4Fu6eeWPyeEmh9hFKB5iwdBEMa035W/c+ixWDKan9hBfVG658AgFkV9A4vIBf
         JxaciFha0DxFeis/ApYCcuGUMqd+yBSOP37Mz3bW8vy5tVsa/woSC8B7PjT+Ry46ipOk
         ZPbg==
X-Received: by 10.66.138.41 with SMTP id qn9mr9728504pab.82.1415984891164;
        Fri, 14 Nov 2014 09:08:11 -0800 (PST)
Received: from tcc-michael.Corp.Climate.COM (c-24-7-66-128.hsd1.ca.comcast.net. [24.7.66.128])
        by mx.google.com with ESMTPSA id f12sm28163193pat.46.2014.11.14.09.08.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Nov 2014 09:08:09 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.197.g60bf093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

listed bug doesn't reproduce on Mac OS Yosemite or Mavericks. For now,
just enable TTY on Mavericks and higher

Signed-off-by: Mike Blume <blume.mike@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Improved-by: John Szakmeister <john@szakmeister.net>
---
 t/lib-terminal.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5184549..7348f7e 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -29,7 +29,10 @@ test_lazy_prereq TTY '
 	# After 2000 iterations or so it hangs.
 	# https://rt.cpan.org/Ticket/Display.html?id=65692
 	#
-	test "$(uname -s)" != Darwin &&
+	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
+	# appears to be gone.
+	#
+	test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1)" -ge 13 &&
 
 	perl "$TEST_DIRECTORY"/test-terminal.perl \
 		sh -c "test -t 1 && test -t 2"
-- 
2.2.0.rc1.197.g60bf093
