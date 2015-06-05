From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] t7063: fix breakage with split index
Date: Sat,  6 Jun 2015 01:31:33 +0200
Message-ID: <1433547093-6616-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z115P-00009S-8N
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 01:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbbFEXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 19:31:35 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36399 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbbFEXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 19:31:34 -0400
Received: by laar3 with SMTP id r3so14889860laa.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gkRG/fqjLfkh7Eo/zFlGRWKcwMq0p2Mwgd4plOOoCjY=;
        b=Osa0dXmgd9P5zvCoSpNb5cIoQmTL3xqHdGZ2g5mgZPWibL22IDA7xp1yJJdnxRb9Gv
         fL3/d9edr++ZffnPoZ/kgSdWriQAk50JoHLJYudTq0X5fEu4gy8edX2qm2zXgya0hr8/
         UlT2oXUPiSrPaS15ySPVUU9J7bgK++D0bFxUeYMVoPzBKRAvJ3r2q/F94pRJtakS2EmD
         aOpqsipdeFzCinpu/3ZgpLjKcFbgK2Y3sL4J/Fy+0+/Tn13ekBJlzsvC2fPhdVCgL1rb
         2lMIa+XOpF/FIuYZFp2C+PtLY71y1jJHQcZ0mTHr5M1fJs88rITLGhyI++7Qh//7JXMx
         KmUA==
X-Received: by 10.112.159.162 with SMTP id xd2mr5409512lbb.67.1433547092553;
        Fri, 05 Jun 2015 16:31:32 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id du2sm2120060lbc.44.2015.06.05.16.31.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2015 16:31:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.184.g8e1974e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270895>

When running the test suite with GIT_TEST_SPLIT_INDEX set, tests 17-18
in t7063 fail.  Unset GIT_TEST_SPLIT_INDEX at the beginning of the test,
in order to fix it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Hi,

This breakage is both in the current master and next.  I'm not entirely
sure this is the best way to solve the issue, but unfortunately I don't
have any more time to look into this.

 t/t7063-status-untracked-cache.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index bd4806c..2f958c7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -8,6 +8,8 @@ avoid_racy() {
 	sleep 1
 }
 
+unset GIT_TEST_SPLIT_INDEX
+
 # It's fine if git update-index returns an error code other than one,
 # it'll be caught in the first test.
 test_lazy_prereq UNTRACKED_CACHE '
-- 
2.4.0.184.g8e1974e
