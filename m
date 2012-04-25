From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git p4: fix unit tests
Date: Wed, 25 Apr 2012 09:16:54 +0100
Message-ID: <1335341814-1598-2-git-send-email-luke@diamand.org>
References: <1335341814-1598-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 10:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMxPj-0000kB-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 10:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab2DYIRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 04:17:06 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41988 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2DYIRD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 04:17:03 -0400
Received: by wejx9 with SMTP id x9so946970wej.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 01:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=LOhaPP2Tc4jM/VIXKEqWl5FCH4cKIxfMeWbHEkx2h3U=;
        b=dju0ISyvEoviaRA8klsqsB5u1UbjtzioW0/cNKU6fH1D9b6bKhuKyML7DHrgaZhjl8
         NxKNhkGYuqidBp1t5ULLaJih0WCi8cYuMqUX4Scsi5Xj6XXEsZydro1vBtuvn1hCsRjc
         DI82Ue/d1Pf5Fi3WDFGWVfmo4s0l6x43gqQBLHcynxySBHKJy0rOevLmCLFgegWrfiZe
         bd5j6gpT1OY0T88iOgfZH+fPIrIn4QimGqrahtwpNEkTSUeIfgxR6xrYK9z4MqiSy2HL
         sgIZcfu6t5wBtkjWmLow6aEG5YW8vZOhZg3h3wC83jEo+Cb2mlscy8+Nw8P8iGpMxkjx
         M1bA==
Received: by 10.180.75.241 with SMTP id f17mr4239577wiw.11.1335341822280;
        Wed, 25 Apr 2012 01:17:02 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm35739849wib.3.2012.04.25.01.17.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 01:17:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.473.g0796
In-Reply-To: <1335341814-1598-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQkygO66VOfi47dH4QRHQOHI9f/9bJNC+B1pTCMm3TYJzWtqn388HgVz2I93x3G4EwGI7HRi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196301>

The submit-edit tests relied on P4EDITOR being unset. Set it
explicitly to an empty string.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9805-git-p4-skip-submit-edit.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 4a72f79..353dcfb 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -91,7 +91,7 @@ test_expect_success 'no config, edited' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		EDITOR="\"$ed\"" git p4 submit &&
+		P4EDITOR="" EDITOR="\"$ed\"" git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 5 wc
 	)
-- 
1.7.10.473.g0796
