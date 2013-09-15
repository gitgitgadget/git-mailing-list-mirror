From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] t7406-submodule-update: demonstrate behaviour when run without init beforehand
Date: Mon, 16 Sep 2013 01:38:22 +0800
Message-ID: <1379266703-29808-2-git-send-email-rctay89@gmail.com>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 15 19:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLGHo-0007yb-6c
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 19:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab3IORix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 13:38:53 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64214 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab3IORiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 13:38:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so4450604pab.38
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sHxD1xOrToZnLWVUIFuK974AceIqkF7N4slzWLwbXJg=;
        b=0huDMAUJQYWCm5DvyXbumGuQd51Ak15mz9eKysdd/1jrm5tx1S2eL1EaDjMmMiqecz
         TBBTRPK7FFjVRkeJt+6hh04jQCyh1K16FD+tGlbiG7x7xtCDvAhulVUzBWLEmLQawuxF
         LsUMHEYEuwmdyPhk+5tLdFmvOp5SmcgOwd94Z88l3/xXxAGRZPNpOymLLWms6+H/IeN/
         HgaBl2AbCwOEzKT8EE9VTWUwHKqVWxPkV8f5aIDshZUOoocgELUIUYHCVtYFbx1TNidH
         URaTiXrUb4/IQXvQz2rackd3dppzayMLLEfj9Bwnv8sg+khNuXvU9gUSlpR8LJeR/QO8
         8ORg==
X-Received: by 10.66.196.168 with SMTP id in8mr26266144pac.18.1379266731232;
        Sun, 15 Sep 2013 10:38:51 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg ([42.60.190.192])
        by mx.google.com with ESMTPSA id uw6sm25617621pbc.8.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 10:38:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1379266703-29808-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234822>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7406-submodule-update.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f0b3305..00475eb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -66,6 +66,26 @@ test_expect_success 'setup a submodule tree' '
 	)
 '
 
+test_expect_success 'setup a repo with uninitialized submodules' '
+	git clone super super2
+'
+
+test_expect_success 'submodule update <path> warns without init beforehand' '
+	(cd super2 &&
+	 test -n "$(git submodule update submodule)"
+	)
+'
+
+test_expect_success 'submodule update is silent without init beforehand' '
+	(cd super2 &&
+	 test -z "$(git submodule update)"
+	)
+'
+
+test_expect_success 'cleanup repo with uninitialized submodules' '
+	rm -rf super2
+'
+
 test_expect_success 'submodule update detaching the HEAD ' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
-- 
1.8.4.rc4.527.g303b16c
