From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/9] t1508 (at-combinations): increase coverage
Date: Thu,  2 May 2013 19:09:29 +0530
Message-ID: <1367501974-6879-5-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtip-0002b0-DE
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759661Ab3EBNis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:48 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:45587 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3EBNiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:12 -0400
Received: by mail-da0-f49.google.com with SMTP id p5so313953dak.8
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=U4h/9lag9PrhiwzqjN19BGacjDkHsM0Ngy1e5r0CpgU=;
        b=KNtfxZ8zV39HF5tNaEuR/qgYI8QQ7JYWZRAORWAUokThV8mSKqMsQcioGRRlaII+NB
         iVHgY544t58falYO1RTK1DbAiNCyEUkzucSteMNhmkbpoQR/nZTzY0zUrjb1k4w8E9T0
         hTYn79Xr2sktEQMQXl7+Jkc74OLydjqvUBClKHrev3UKmf+BUdN453HByaKwhpYE/NxK
         if/nQIJCwlMik8BqfSXuPReTIHNjdpYsmiqSQA772IQgdhd/b4xKE0qmRI5n9bi+CsNv
         tGixO4PFx4n5GXZr6W91IyYR0cu2bECKA3Ke+tJZIL+lZoULM2zThbptW2vhjrikS7zw
         unkQ==
X-Received: by 10.66.162.67 with SMTP id xy3mr9760926pab.94.1367501891700;
        Thu, 02 May 2013 06:38:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223205>

Add more tests exercising documented functionality.

It is worth nothing that HEAD@{-<n>} is senseless because @{-<n>}
cannot be used with anything other than HEAD anyway.

[fc: contribute a couple of tests]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 55fdd0f..eaa5337 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -42,13 +42,21 @@ test_expect_success 'setup' '
 
 check HEAD refs/heads/new-branch
 check "@{1}" commit new-one
+check "HEAD@{1}" commit new-one
+check "@{now}" commit new-two
+check "HEAD@{now}" commit new-two
 check "@{-1}" refs/heads/old-branch
+check "@{-1}@{0}" commit old-two
 check "@{-1}@{1}" commit old-one
 check "@{u}" refs/heads/upstream-branch
+check "HEAD@{u}" refs/heads/upstream-branch
 check "@{u}@{1}" commit upstream-one
 check "@{-1}@{u}" refs/heads/master
 check "@{-1}@{u}@{1}" commit master-one
 nonsense "@{u}@{-1}"
+nonsense "@{0}@{0}"
 nonsense "@{1}@{u}"
+nonsense "HEAD@{-1}"
+nonsense "@{-1}@{-1}"
 
 test_done
-- 
1.8.3.rc0.40.g09a0447
