From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/2] git-p4: fix t9800 editor check
Date: Tue,  3 Apr 2012 08:38:34 +0100
Message-ID: <1333438715-14902-2-git-send-email-luke@diamand.org>
References: <1333438715-14902-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 09:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEyKS-0005Wo-8f
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 09:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab2DCHir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 03:38:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58858 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab2DCHip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 03:38:45 -0400
Received: by wejx9 with SMTP id x9so2177239wej.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 00:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=c+ENhjjLcY889ShtY0JbA1xClYwJAyhFdhIB4mfQKMI=;
        b=nq1IHOUD219LI2vueGG6kHVgJ3827kfXDjHb1tfxxkVnBmjHSKGebIAPDgrue42WvL
         qhKQEpwN7gRRRRDVn+Zo/JhQ8sFwG1nHqzj0NSZsWAd/KJpIffRAVWvz7FZ3JAwd7yN8
         DhF7fK5equ7dnzUHrNAuQygQVIhnjvpUls+KFE6tgL/8jDa/YtrEiBfAaFR25AMusvU7
         BaxBV8lJj43RNiT9d/oAeijGa/MuLKxNAzQlQo2EKweTFE+pqbJPBWYsI17+vHSILts0
         6MDev+28/2hTkPimEiL5vIF2vqFg4rTLLB2qyR41QSx3e1c/FX6A4GZJiMZftBGe/P3m
         ll/Q==
Received: by 10.180.97.41 with SMTP id dx9mr3600046wib.9.1333438724236;
        Tue, 03 Apr 2012 00:38:44 -0700 (PDT)
Received: from halilbut.cam.broadcom.com (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ff2sm66101034wib.9.2012.04.03.00.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 00:38:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.158.gd9e55
In-Reply-To: <1333438715-14902-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQnNplrIMHuvO2633fhPJNNpr29RE/0UW63GodbM4T2igEuwdsWWuMhexCZUQsbrcxGjsCAJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194601>

Use the skipEdit flag rather than the skipEditCheck flag as
the latter only worked if P4EDITOR happened to be unset.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4-basic.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 486c8ee..40f0b5c 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -335,7 +335,7 @@ test_expect_success 'detect renames' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		git mv file1 file4 &&
 		git commit -a -m "Rename file1 to file4" &&
@@ -394,7 +394,7 @@ test_expect_success 'detect copies' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		cp file2 file8 &&
 		git add file8 &&
-- 
1.7.10.rc0.158.gd9e55
