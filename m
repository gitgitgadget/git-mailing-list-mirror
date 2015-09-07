From: larsxschneider@gmail.com
Subject: [PATCH v3 3/5] git-p4: return an empty list if a list config has no values
Date: Mon,  7 Sep 2015 14:21:16 +0200
Message-ID: <1441628478-86503-4-git-send-email-larsxschneider@gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQU-0000Ce-3w
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbbIGMV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:21:29 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34672 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbIGMV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:26 -0400
Received: by wicfx3 with SMTP id fx3so86846434wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8A/W6FqRa0n3hID/NX6eyIv9RcbshELGJyFZ5j7SzY=;
        b=otIKnVc30ZglSapWV33blPiQoJZDtxKO2NzOra/EYkWtcDyfvI+YBxQCx1QtU39h4D
         q4jFhpz+p8A8OHF1X9ydf1odaGWo/PpGWtwXZLLlFWj9Ks8iMd8LPkH0Bj8ngwnG/X3r
         llTYyl/0+CEcu9PqkF2EeAopw+JTdXgOUUaOwV993XH9sffjLi9KheRid3t8TtuQsqpO
         fWKkWzTEdfucJHxvWQEohtqU516RPGHjrEv/pVFKDeQgWzEoKBccAS5ZxtZvJr9/tMKh
         qPwncaEsnK9gjnnNZYShqpglyOVpOs6gmwKzSID3yRkU/M7yuKDW+/9/RK+kthCEphRd
         RQgg==
X-Received: by 10.180.72.241 with SMTP id g17mr35414837wiv.81.1441628485250;
        Mon, 07 Sep 2015 05:21:25 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277454>

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
