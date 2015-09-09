From: larsxschneider@gmail.com
Subject: [PATCH v4 3/5] git-p4: return an empty list if a list config has no values
Date: Wed,  9 Sep 2015 13:59:08 +0200
Message-ID: <1441799950-54633-4-git-send-email-larsxschneider@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2P-0001L2-6s
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbbIIL7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:59:38 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33472 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbIIL7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:16 -0400
Received: by wiclk2 with SMTP id lk2so154284453wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8A/W6FqRa0n3hID/NX6eyIv9RcbshELGJyFZ5j7SzY=;
        b=qjIkvWzr6u5b3pu8FZY4MceoSwO9m+7ZTeWBefvK1LgjlSy9INEZ7OfGSOEgr2XEmg
         /nsuXWY2Zkm48QGeAo3XWnnvulGmjs9Ayco3CZIuqXjdRPnLQlJJ7nwtOwTUe9ODd2E9
         /dnsvfMDko3cuF7aphZnzgtlsgp56xBhQRo16QaPMRb+bn75gAfIRng+VLhi5xm2nA26
         tcftx4SeChZvB5S4Cx+qvge1qlN6WXalovhkyfIlx2WgUAcWO7lsZJ6rNHxthCszQysg
         aunWfWP8PB9hzVpO0hfw0ThuZkY1FWanthlpX3jh7/sjdng7X76Ok9BLvdIpx5Lee7Es
         NefQ==
X-Received: by 10.180.88.164 with SMTP id bh4mr52551623wib.18.1441799955064;
        Wed, 09 Sep 2015 04:59:15 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277549>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 40ad4ae..90d3b90 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -638,6 +638,8 @@ def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
         _gitConfig[key] = s.strip().split(os.linesep)
+        if _gitConfig[key] == ['']:
+            _gitConfig[key] = []
     return _gitConfig[key]
 
 def p4BranchesInGit(branchesAreInRemotes=True):
-- 
2.5.1
