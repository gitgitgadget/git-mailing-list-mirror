From: larsxschneider@gmail.com
Subject: [PATCH v7 3/7] git-p4: return an empty list if a list config has no values
Date: Tue, 22 Sep 2015 00:41:09 +0200
Message-ID: <1442875273-48610-4-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9m5-0000PZ-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbbIUWlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:25 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36193 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbIUWlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:22 -0400
Received: by wicgb1 with SMTP id gb1so135410006wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txo/3gWjV8bt38pa7zswvoGPcxBFhP8k7TpMz1pGmUo=;
        b=hhGCVVv11vZJw4vvOkQFIlEHTay1WLiesHnz0v1yqckZXyx+B0lg1oJ5WapmbUropo
         yiyMdlIRnG06zgKlktsogVDurBgmzDXifGcq2NjAnlymF72WjGNvENIqp6A2ks75Rea7
         MwWpyS55kaj0ZR40yqIGAzp4WwCEYfg/0bUqtK5o7QNnFGvxs7vNBbxcUBJlmX4Ui+as
         ZOXxxRuoH7OE6HOqUHeVrbyAjSkx1pR7W+VL2AvukDFK7QynFvYbr3N1Io3ho/tbaQ/c
         caGMBgwJcEFcx55d/eZoZxhyFFLJ6FjeLL5WQzPKyH00xyilnh9JTpWuEx35K1IrrYvf
         eaRg==
X-Received: by 10.181.13.166 with SMTP id ez6mr17019846wid.24.1442875281726;
        Mon, 21 Sep 2015 15:41:21 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278350>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 2715895..e7d1b3f 100755
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
