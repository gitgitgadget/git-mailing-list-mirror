From: larsxschneider@gmail.com
Subject: [PATCH v2 3/4] git-p4: return an empty list if a list config has no values
Date: Thu,  3 Sep 2015 18:35:47 +0200
Message-ID: <1441298148-63885-4-git-send-email-larsxschneider@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:36:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXUd-0000Jg-FD
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbbICQf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:35:59 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33342 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbbICQfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:35:55 -0400
Received: by wiclk2 with SMTP id lk2so4931216wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QvN4En9mQTAdlzsj5gnYs5lTZKnoVH4WO6rdIRw0f9I=;
        b=Uy/0rAvbeTO3knulzjMkjrkYmBGOmgPI8AmudXHfS2ai83xfkQZGKVrmS1e61aOhzp
         j3bWLvEyv8SCtES2QcLgLKEQRdPaoxvhASJXoAj5RTqhAz+UGkGDhTGnjqwR47PxkRA/
         ZaSclEW2WqZCiwG4Ctbmibqo4ZE8GNv/K43Li4SymA4Xfm1VH33gzexweJ9aY3nsC/Wb
         psOie0JPbJrrqLATj2mqCUrWn683Jyx+YIDShENMvZjjlpUgAfaDgQsiJByN1tgAdTDQ
         m+1r3X/gcp2A/obLPfQBA/o+lKJKFirKK05ZnBKYPC0Jeoi/jGBVPC2N0O3r1+QfQr48
         OE1w==
X-Received: by 10.194.109.228 with SMTP id hv4mr44259272wjb.110.1441298154232;
        Thu, 03 Sep 2015 09:35:54 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id sd14sm20446876wjb.36.2015.09.03.09.35.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 09:35:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277226>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index ae1a4d3..4d78e1c 100755
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
1.9.5 (Apple Git-50.3)
