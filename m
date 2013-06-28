From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fixup-builtins: remove unused cruft
Date: Fri, 28 Jun 2013 21:16:19 +0530
Message-ID: <1372434379-24085-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 17:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usavc-0007tZ-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 17:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab3F1Pth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 11:49:37 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54691 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F1Ptg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 11:49:36 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so1116227pdc.33
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WPqNSZCCrJsPky13n5Rvc8MQqhtfCnTBJQUoQlOtJw4=;
        b=KfY5oKYQexyWqtBcmfF5uzBXsxN7VaoDTQhtaLm3LCElcLijiXec1W6WWIfc41mb6a
         pZ0Zj9Fw56LMi92T3e4syDAEU4IdxXGv5ldjt3s+pkPPE50YeyHarC7zZR5dx/9qJa2g
         BT4C1FbXAN/0SXo+/Bv8/83g7BvhDOrdlE3bnWfoCm1B5tnsLRctKzw4ktybXyaz/Fa4
         McBIz5i2ecS/fI7X7edxz37S/qNKbS2UwDPASFWfTlRYweo36q+e6Do1G97ibiWQZqtG
         IcBl/jNEAwEZKwZvOKUlq4a+mExhvmw2vLDpBXTEecBHkVH1K64QovhaWlh2yJQOOtGu
         OR2w==
X-Received: by 10.66.178.174 with SMTP id cz14mr12125266pac.136.1372434575881;
        Fri, 28 Jun 2013 08:49:35 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id qp4sm8648015pbc.41.2013.06.28.08.49.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 08:49:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.643.gebeea52.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229209>

The fixup-builtins script is only used by an unused remove-dashes target
in the Makefile: remove that along with the script.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |  3 ---
 fixup-builtins | 16 ----------------
 2 files changed, 19 deletions(-)
 delete mode 100755 fixup-builtins

diff --git a/Makefile b/Makefile
index e158376..6b0ddf8 100644
--- a/Makefile
+++ b/Makefile
@@ -2302,9 +2302,6 @@ check: common-cmds.h
 		exit 1; \
 	fi
 
-remove-dashes:
-	./fixup-builtins $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
-
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
diff --git a/fixup-builtins b/fixup-builtins
deleted file mode 100755
index 63dfa4c..0000000
--- a/fixup-builtins
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-while [ "$1" ]
-do
-	if [ "$1" != "git-sh-setup" -a "$1" != "git-parse-remote" -a "$1" != "git-svn" ]; then
-		old="$1"
-		new=$(echo "$1" | sed 's/git-/git /')
-		echo "Converting '$old' to '$new'"
-		sed -i "s/\\<$old\\>/$new/g" $(git ls-files '*.sh')
-	fi
-	shift
-done
-
-sed -i 's/git merge-one-file/git-merge-one-file/g
-s/git rebase-todo/git-rebase-todo/g' $(git ls-files '*.sh')
-git update-index --refresh >& /dev/null
-exit 0
-- 
1.8.3.1.643.gebeea52.dirty
