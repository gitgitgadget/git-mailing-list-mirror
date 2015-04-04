From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 1/3] git-p4: fix small bug in locked test scripts
Date: Sat,  4 Apr 2015 09:46:01 +0100
Message-ID: <1428137163-13219-2-git-send-email-luke@diamand.org>
References: <1428137163-13219-1-git-send-email-luke@diamand.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 10:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJjD-0008Fu-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbDDIqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 04:46:46 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33405 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbDDIqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:46:42 -0400
Received: by wgin8 with SMTP id n8so37112453wgi.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lBHu0VVFbbNsrWxgZtHQZiu5obA66/I6fEdlZaaMTUw=;
        b=L9RLPku1o2oy6iVpbJCneYIKfT47ZQUUN5fTDBCxykr6pZmhx5/IN7APs87CsnVgtM
         SbRmnYJWeQpnsTf+eJtaTy30XcToNbMeMP6njHnnQtdp36c9vSTQSQnzOTLF94b/IQV9
         ytyyqGotYDFZeD8AsAMsTkaCbwry0vLY7aCMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lBHu0VVFbbNsrWxgZtHQZiu5obA66/I6fEdlZaaMTUw=;
        b=Sz34DERHnHrlk1G100YYAkHa4GMk/iG/O9CGD2G6cn/X64eNT4gzwHTorc9k3V4ZRS
         iQitxOUCi0KkzEKJMhQO3KBwatKvfXe5/OwZvY8f+/CVSniJL105WeF/N3tZTPbnagwu
         50vgbJsAwogss3QGsDWCZ5fYpYZ+H96YezfXos4CySwdlEpjeK9zIKA8X3MWoVgma7R8
         GubF7QlAwqurME5+QSAcERJgh67XQ41qHMFM2V/wYEmb7aOkqlXUI8avhRH0MWuLG7zs
         n/G/bGikMyGVW8IQ4lOSdoXLPcKP0Qp+8YkVTb4S+ZbpTSVd/Pm+uPUznFyrFmL5Sdi1
         Ib9g==
X-Gm-Message-State: ALoCoQkOb67XHT2hsYZOTZSqV4OZ7HfMcbH8HBxIQncy35tgMd6MFSGS2WY1oFduHdrCq0vuBjq9
X-Received: by 10.194.178.164 with SMTP id cz4mr12030636wjc.140.1428137201538;
        Sat, 04 Apr 2015 01:46:41 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id s7sm2455742wjy.2.2015.04.04.01.46.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 01:46:40 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428137163-13219-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266770>

Test script t9816-git-p4-locked.sh test #4 tests for
adding a file that is locked by Perforce automatically.
This is currently not supported by git-p4 and so is
expected to fail.

However, a small typo meant it always failed, even with
a fixed git-p4. Fix the typo to resolve this.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9816-git-p4-locked.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index e71e543..ce0eb22 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -41,7 +41,7 @@ test_expect_failure 'add with lock not taken' '
 	(
 		cd "$git" &&
 		echo line1 >>add-lock-not-taken &&
-		git add file2 &&
+		git add add-lock-not-taken &&
 		git commit -m "add add-lock-not-taken" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit --verbose
-- 
2.3.4.48.g223ab37
