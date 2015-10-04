From: larsxschneider@gmail.com
Subject: [PATCH v2 4/4] git-p4: Disable t9819 git-p4-case-folding test on OS X
Date: Sun,  4 Oct 2015 11:06:17 -0700
Message-ID: <1443981977-64604-5-git-send-email-larsxschneider@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZingE-0000kK-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbJDSGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:34 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33843 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbJDSGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:30 -0400
Received: by wicfx3 with SMTP id fx3so91398814wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gtofapc0eAMpnGl3lfVfqiD29OE1ghIrXZTBLX+J49I=;
        b=ZxA8k8vxIBB4FjBkVUmIJCt0RwGPOOiWeHkHVpaW/puMvW4B3OR2m+g0qLyQVUEe8+
         G07YNrru8VX6u3HcC0BnLRpIS9zKj25uEYekktagQVPW+KDjVjjWiJ4HEhtUE4yZp8jY
         aO9VIuaah/yekHO+m69NWuuV7Fxa+itiiAeqkGPEUTsRTfQGfEN5LvZigv5ey5AN4uVW
         7t1IMkHsNIxRkXVLKFezdF41VFm+x9YrKS6VVDNIwQD4V3Y+8Ml8P7dSwuaDQJ5Uapd4
         7SCihFXH0RC/qv/5AJPrGGQxw2YMRWTw0rW3YuP+0yQ9kM1mAE8ApwJ+UN6bJNQonppz
         jMJA==
X-Received: by 10.180.36.193 with SMTP id s1mr7797603wij.84.1443981989155;
        Sun, 04 Oct 2015 11:06:29 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id o3sm10378607wif.22.2015.10.04.11.06.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Oct 2015 11:06:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279014>

From: Lars Schneider <larsxschneider@gmail.com>

The OS X file system is case insensitive by default. Consequently this
test does not apply.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9819-git-p4-case-folding.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index 78f1d0f..c69ae47 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -4,6 +4,11 @@ test_description='interaction with P4 case-folding'
 
 . ./lib-git-p4.sh
 
+if test_have_prereq DARWIN; then
+	skip_all='skipping P4 case-folding tests; OS X file system is case insensitive by default'
+	test_done
+fi
+
 test_expect_success 'start p4d with case folding enabled' '
 	start_p4d -C1
 '
-- 
2.5.1
