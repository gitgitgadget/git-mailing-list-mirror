From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Documentation - More examples for git bisect
Date: Thu,  5 Mar 2009 12:36:14 +0000
Message-ID: <1236256574-24764-1-git-send-email-johnflux@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 13:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfCrJ-0007tH-Mc
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 13:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbZCEMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 07:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbZCEMh7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 07:37:59 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:59119 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZCEMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 07:37:59 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4519585wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nqVtjw32enln6Llpj8Xb4eWHFdlaZvSFta6SaGr5X7E=;
        b=ncif/mVfmBxeW4DCQRktTqBJ3ZEcPCJ2SzE9tiZzfIF6Oq7B/TI40eReMtUBmmmYv1
         O1mvRvtmsqDTAiRtwSfQocPph3cJg+9aEoiQar2InKvON56BeUiG6LEj6o7eUWi3hewm
         n2saVjTTyiqTqf+uKnkNdU4/Tl/gAc72mUg+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LR+h0Yx+v5xeA0Yd4SqhXQenj57VQV0pU5gwhu6dl2cGdFHNgtIhA66TVBVq+tVqcn
         6hAYEehl9gi3aP7PEEgZDzmnrPiLIwSZqFu62/+ArW2TnLpWsWMmvvOmUYFTQEK8GQKL
         DXxYbAiU6buNjDOXWdV4KYXtAmKRmjA0o54Dk=
Received: by 10.142.11.20 with SMTP id 20mr504011wfk.291.1236256677237;
        Thu, 05 Mar 2009 04:37:57 -0800 (PST)
Received: from localhost.localdomain (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 22sm5774209wfi.1.2009.03.05.04.37.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 04:37:56 -0800 (PST)
X-Mailer: git-send-email 1.6.2.97.g1bcd6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112304>

Including passing parameters to the programs, and running more
complicated checks without requiring a seperate shell script.

Signed-off-by: John Tapsell
---
 Documentation/git-bisect.txt |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 147ea38..e65c1ca 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -212,7 +212,7 @@ If you have a script that can tell if the current source code is good
 or bad, you can automatically bisect using:
 
 ------------
-$ git bisect run my_script
+$ git bisect run my_script arguments
 ------------
 
 Note that the "run" script (`my_script` in the above example) should
@@ -252,6 +252,13 @@ $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
 $ git bisect run make                # "make" builds the app
 ------------
 
+* Automatically bisect a test failure between origin and HEAD:
++
+------------
+$ git bisect start HEAD origin --    # HEAD is bad, origin is good
+$ git bisect run make test           # "make test" builds and tests
+------------
+
 * Automatically bisect a broken test suite:
 +
 ------------
@@ -291,6 +298,15 @@ It's safer if both "test.sh" and "check_test_case.sh" scripts are
 outside the repo to prevent interactions between the bisect, make and
 test processes and the scripts.
 
+* Automatically bisect a broken test suite:
++
+------------
+$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
+$ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
+------------
++
+Does the same as the previous example, but on a single line.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.6.2.97.g1bcd6.dirty
