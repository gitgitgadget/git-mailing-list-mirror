From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 11/23] Introduce --commit-exists.
Date: Sat, 23 Apr 2011 17:22:40 +1000
Message-ID: <1303543372-77843-12-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCf-0004tb-Ml
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab1DWHY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:26 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab1DWHYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:20 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mHSz/QpKuZk9hdj1nGOPX6688OqDlRvmn/BjIrWKeeQ=;
        b=GMbZAe/8c3ube6W3SkreEDq5B6XSW62XhbsY/9a4VbSoaVh3jYnZcZ1Sbqie5PQHro
         ASgQknnyWZgMvdH4xSbTlJ9frzRlcKYPr3RVib29jDumuO1+VuKvJEhydtMFA2dN+Lsw
         dvuMAVKEJIJ7Y8ehHGOSP6SJyaWoYyk9btAz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x0zTXjovqtWQgGNJRzHTgHSmiJKZbMWR4jyTlAJ8Yhmhycqg4WTTtLK/rVDTf2e6WY
         aPsAr7cB23Dgl/jn06LtWdxG5Dq4HZjA+NUFRhMZCiwqNA3XHHGeVL/Naapam3ooHfHr
         gTf8wxjXcsNSq9H62DEH238PfxurYrVH96kQU=
Received: by 10.68.41.41 with SMTP id c9mr2023155pbl.32.1303543459711;
        Sat, 23 Apr 2011 00:24:19 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171965>

tweak commit
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 259a04c..9a4e06f 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -82,6 +82,8 @@ CONDITIONS
         Tests if the specified tag does (not) exist.
 '--ref-exists'|'--not-ref-exists tag'::
         Tests if the specified reference does (not) exist.
+'--commit-exists'|'--not-commit-exists commit'::
+	Tests if the specified commit does (not) exist.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index c21d669..af376d1 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -111,5 +111,16 @@ check_ref_exists_1()
 	fi
 }
 
+check_commit_exists_1()
+{
+	if test "$(git cat-file -t "$1")" = 'commit'
+	then	
+		echo "Commit '$1' exists."
+	else
+		echo "Commit '$1' does not exist."
+		false
+	fi
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622
