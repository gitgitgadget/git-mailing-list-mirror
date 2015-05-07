From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 09/12] t7406: use "git pull" instead of "git pull --rebase"
Date: Thu,  7 May 2015 16:44:05 +0800
Message-ID: <1430988248-18285-10-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:45:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQP-0005jY-3r
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbbEGIot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:49 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33188 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbEGIoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:46 -0400
Received: by pacwv17 with SMTP id wv17so34439649pac.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H18eD3evnj84QG73606rt7TPGX7npIDrVO2h9/Rau1U=;
        b=opBsHEJTXDpZaNrHXbh99TrhiUBRxG05tHbYC5yTqgkwkjtjqSy8+/I789bwhaKQLV
         ir/U1jQ0GCVt/kZJ/vYn/ORbEQgNS/bnxbaq+ZXfzaj+49vttODW+7r1OjyF/GIom3ej
         w/CfgY4i0ZoqczJKr6C66BftC7etlcwIPPh7iRlnSSsYtBiPscZ6AOkdmXtCWjS3Rtq4
         gO6xlUUthA2LX3JF5xfIAWJzWDFkMWz8z4iYXKM6HxQNbJzx8F41nYQyHlB2IIS8JpSU
         zxA1TzY+R2xh2HDD/3YSOvS3Lp1wtK/b46Dod0rwh0kX0VAu6AWePBzpOWDJC0gaQdG1
         xtfA==
X-Received: by 10.68.129.72 with SMTP id nu8mr4960191pbb.145.1430988285781;
        Thu, 07 May 2015 01:44:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268519>

At this point, the HEAD of super/submodule/ is a direct descendent of
submodule/ and thus a fast-forward merge can occur. There is no need to
rebase.

Call "git pull" instead of "git pull --rebase" in order to reduce
dependence on git-pull's functionality, and thus prevent the whole test suite
from failing when git-pull is rewritten to C.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * This is a new patch in the patch series.

 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..e38d830 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -44,7 +44,7 @@ test_expect_success 'setup a submodule tree' '
 	) &&
 	(cd super &&
 	 (cd submodule &&
-	  git pull --rebase origin
+	  git pull origin
 	 ) &&
 	 git add submodule &&
 	 git commit -m "submodule update"
-- 
2.1.4
