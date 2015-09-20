From: larsxschneider@gmail.com
Subject: [PATCH v6 3/7] git-p4: return an empty list if a list config has no values
Date: Sun, 20 Sep 2015 22:26:23 +0200
Message-ID: <1442780787-65166-4-git-send-email-larsxschneider@gmail.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCf-0003w1-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbbITU07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 16:26:59 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36154 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbbITU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:34 -0400
Received: by wicgb1 with SMTP id gb1so90382986wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8A/W6FqRa0n3hID/NX6eyIv9RcbshELGJyFZ5j7SzY=;
        b=sQUk2gQs6EmW6jQQJiLI+N6ipFvQbD/8Z6+apmnUY0kCO1/wZ47BuYjm1D8r6jv4Cc
         K8o11JX6Ba52FSzg14oi2h6HEoQDMRNrX9sKpzUnQIqyOclYhsLaGK7WvM/rn37TnqCA
         IHuJR8JAjDdmBGKAmPMjneQo24uM5nHiEkTaNvIqj+N0niF9ce7rzFq0nSc+dne+ZsML
         /Vv6SAg8kaQG1ZuL/E8hYFE5smthiNeddS3CwYFD5S3x01ZoYXw4yC8iag6I/+4/AU0t
         +t+7BfuRgBGUXatukBW3mmkZIQavxsxO3KaqANu7lpm8Q9G7TXIXwPMv7UNaLI0eBzFY
         buew==
X-Received: by 10.180.88.201 with SMTP id bi9mr9129785wib.21.1442780793416;
        Sun, 20 Sep 2015 13:26:33 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278267>

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
