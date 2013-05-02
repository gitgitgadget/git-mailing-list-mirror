From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/9] t1508 (at-combinations): simplify setup
Date: Thu,  2 May 2013 19:09:26 +0530
Message-ID: <1367501974-6879-2-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtiN-0002D0-V6
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759396Ab3EBNiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:14 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:60939 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759290Ab3EBNiE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:04 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so314117dad.23
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CVGivlsokupJajyPTPDHMJ52fKOdfcuEipQwmh/WIrY=;
        b=Ru9VTcU866fDczHd7kh7fSQuqwDOTKZHFC9d6MnfjNzH4W1bFmjs7lUQfjJLnVvKHu
         oBmYDCEMzhs/KXxQKhOeov6Kt4HEI2KF0SxKYkm/KuS1az35LsbRd8kv0XE62hXKbB1n
         vAMyUAvTL+yLxt6o0m8EER6nZG0BpsMVtzbDARjWolOrQZW9IPuzvQmhVc8Ed77FwfEo
         wtzGGOJ1KrkxQ3ChnlPP3j6kE4fVEVBQFgLauxbEdXGKuT99P0WSsaGK+ktjnO2Bifzk
         RKVdSHC7KfBHlLe10MZtYv9502jk0J54Cit/RKX7ObRui77JBZqKuDs1+mewzsEdrom+
         /0ow==
X-Received: by 10.66.161.69 with SMTP id xq5mr9997614pab.136.1367501884442;
        Thu, 02 May 2013 06:38:04 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223199>

From: Felipe Contreras <felipe.contreras@gmail.com>

Instead of setting the configuration variables branch.<name>.merge and
branch.<name>.remote by hand, use the shortcut 'git branch -u', which
is exactly equivalent.  It's much more readable now.

[rr: commit message]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index d5d6244..46e3f16 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -31,10 +31,8 @@ test_expect_success 'setup' '
 	git checkout -b new-branch &&
 	test_commit new-one &&
 	test_commit new-two &&
-	git config branch.old-branch.remote . &&
-	git config branch.old-branch.merge refs/heads/master &&
-	git config branch.new-branch.remote . &&
-	git config branch.new-branch.merge refs/heads/upstream-branch
+	git branch -u master old-branch &&
+	git branch -u upstream-branch new-branch
 '
 
 check HEAD new-two
-- 
1.8.3.rc0.40.g09a0447
