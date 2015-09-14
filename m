From: larsxschneider@gmail.com
Subject: [PATCH v5 3/7] git-p4: return an empty list if a list config has no values
Date: Mon, 14 Sep 2015 15:26:30 +0200
Message-ID: <1442237194-49624-4-git-send-email-larsxschneider@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:28:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTne-0003kp-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbbINN0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:26:46 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35066 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbINN0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:26:41 -0400
Received: by wicge5 with SMTP id ge5so142793321wic.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8A/W6FqRa0n3hID/NX6eyIv9RcbshELGJyFZ5j7SzY=;
        b=QDagVepQw1cUBL66iJ+93s45C6seXzKCJbXX1VnSd8G1Xzeo+FIzuDkVGGJRCjlXt8
         qoxVAip1K48lgBK0frfuYPmi+hNMQjC9ipQdUl81ZNKNxxuQrToolUZ61aAiEI2KNTox
         ym3sUXC9Cn7K2S3+taMpnTxBdOaJYEHLe0ekiR9X31e7zPo6BB9Oj7vyq6HQt99bjIwZ
         PMyCRc5nIIJiXIdQrCKjR3k+h7Fd5lXe1tsmK4HmHMadgTLNf0Fx/H+hhh43KpjX8aih
         SSZAfYrZyqhLPhOwxquku0LQaM9Vw5lU0qQKNbUoXygs0M3+6w6r1ZAvYoPd9QtCzDQk
         haNA==
X-Received: by 10.181.13.166 with SMTP id ez6mr27025200wid.24.1442237200164;
        Mon, 14 Sep 2015 06:26:40 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.26.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:26:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277827>

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
