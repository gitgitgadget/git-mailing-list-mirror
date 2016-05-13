From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] t6030: explicitly test for bisection cleanup
Date: Fri, 13 May 2016 15:44:29 +0530
Message-ID: <1463134469-26071-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 12:15:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1A8D-0001gL-U1
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 12:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbcEMKPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 06:15:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36411 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbcEMKPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 06:15:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id g132so9025005pfb.3
        for <git@vger.kernel.org>; Fri, 13 May 2016 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P+DHtXl9eLSfvaOph8sy2vACKXzBAkrcVAk53hoQji8=;
        b=nb0JIodVJvP+h8tmvNHwthTKkESPHrLpL2q5KC6vp3sICskJwHRMHItv1Sou+dSs7C
         y1u9zv6GdrA4NLn98oSSHv1as3OjU4p70NImogFMVMYwf1+vYBN9lnXYyqgTH5zbsSeg
         3ypsMJ4b7h+5Pdr++RE1S4txflFBh1CD1usz3/R+pZlhAUsgeNsBW4Ws0cy0uy1hiV6s
         aeqiegZsuWdF/f858tk3wBpxeZa8xwRD3AMKh1tnbSFis40YZQqU5K97VE5nadw2kx3j
         6m4d1Rdu6mt6MBYUDF8e7MPiBkCBp61G/2Px06+chzFABCCkwN81M2sP94ezhAwN9G0l
         Qmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P+DHtXl9eLSfvaOph8sy2vACKXzBAkrcVAk53hoQji8=;
        b=ZsL82m08oXhCxthWU+qaBcP6rhGcLjKq+33i3gs+Nu26S3fOR6Jd1pZ/waxNhlY9k3
         NMkba5XVhzygkPVAAqHTX4Q5PxMecQSu0zhWNIyW+4HiVzAvYwxKygqwiHX4zGBvVG9f
         TYJdY2nl9Bn0JmRa0riMhK4+HXlxcSu2yAH66gIST3oWn7T7YQKcoQCsUrYBK3PcvRBs
         t7aT/aHJ1ePO5XYQnmjCCw9p78mfQc4KaXBk2KHtv87WjTd7GjyPTiqt8vTubNKkiW7T
         380TbMLyPtZ+kVwD1uuTEHEilJ4AQ3bouy01RLqnnqcAONBzuBShH8CX0dVhT5+3ZMAr
         Z2Lw==
X-Gm-Message-State: AOPr4FW0d4Uf3KR2wPSmVaCub1K8jOVsreuYgHF6AWaqJFzhgCVqkaW6WOKWx6mba3mxGQ==
X-Received: by 10.98.4.195 with SMTP id 186mr21645068pfe.154.1463134536302;
        Fri, 13 May 2016 03:15:36 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id qb1sm26194340pac.44.2016.05.13.03.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 May 2016 03:15:35 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294520>

This is not an improvement in the test coverage but it helps in making
it explicit as to know what exactly is the error as other tests are
focussed on testing other things but they do indirectly test for this.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
I faced this problem while converting `bisect_clean_state` and the tests
where showing breakages but it wasn't clear as to where exactly are they
breaking. This will patch  will help in that. Also I tested the test
coverage of the test suite before this patch and it covers this (I did
this by purposely changing names of files in git-bisect.sh and running
the test suite).

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..1fb5ad9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git bisect reset cleans bisection state properly' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	! test -s "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	! test -s "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	! test -s "$GIT_DIR/BISECT_LOG" &&
+	! test -s "$GIT_DIR/BISECT_RUN" &&
+	! test -s "$GIT_DIR/BISECT_TERMS" &&
+	! test -s "$GIT_DIR/head-name" &&
+	! test -s "$GIT_DIR/BISECT_HEAD" &&
+	! test -s "$GIT_DIR/BISECT_START"
+'
+
 test_done
-- 
2.8.2
