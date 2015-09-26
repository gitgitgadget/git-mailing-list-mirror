From: larsxschneider@gmail.com
Subject: [PATCH v8 3/7] git-p4: return an empty list if a list config has no values
Date: Sat, 26 Sep 2015 09:55:00 +0200
Message-ID: <1443254104-14966-4-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKr-0007TH-4H
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbIZHzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:47 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33701 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbIZHza (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:30 -0400
Received: by wiclk2 with SMTP id lk2so47306652wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8A/W6FqRa0n3hID/NX6eyIv9RcbshELGJyFZ5j7SzY=;
        b=EBKtwgkQtsJ0hbMh7cQ63E52kjxZ8kTEf11rxaePcZdHLNJCHXfMbkGSfZwENEhMYp
         UdgMSKNH3QwxZu4uu5Du3NTzoE1U83ibugcpuJ/uEwTULQ0SdgHJwYLlcTrQOJVr2q7R
         sWCaUqFCrdWKktrNKVHehMtfXJuDCk66eV0H8CQNuPA8zQF5P+w1dh+aMZ8klOmx5eYW
         XHCwr4xj/YlHHIjWzG5+ahPgcYESDz3kH0baF5g8lGcnCljUhOa/x8sImX5i0sJAxzG4
         6E6p5DAckLy9nqGAdh1PY8AQPmljyHMGLtQty4UJ9Fp5UNDbK9289SMxGwUS2UmTXguK
         7AoQ==
X-Received: by 10.180.211.116 with SMTP id nb20mr7968323wic.50.1443254129742;
        Sat, 26 Sep 2015 00:55:29 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.25
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278691>

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
