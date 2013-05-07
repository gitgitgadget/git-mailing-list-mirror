From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/11] tests: at-combinations: @{N} versus HEAD@{N}
Date: Tue,  7 May 2013 16:55:05 -0500
Message-ID: <1367963711-8722-6-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsr-0008Tb-G6
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab3EGV45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:57 -0400
Received: from mail-gg0-f181.google.com ([209.85.161.181]:63915 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3EGV4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:54 -0400
Received: by mail-gg0-f181.google.com with SMTP id q1so244211ggm.40
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jSGWyG+9GkJvPoNHcn1KQSZw2tw0Yb2GkG2aqBuyC6Y=;
        b=sAz4OBFUGL9CBPmuxDzfvR6SM2T3JTnRBxjXkerFnPh26i4WGLybzjxPCa/mCc6ztX
         WCbAtwhqmYwuujUdb2MtKu7jeuMQ7eeTpsa3DK0kf0vZoXb64Ph2WqaWM/p6d0ujYKHW
         HjZEHtnVYQu7ZaKjN3rqMgBdtiwb1xyDRKrbpCWP/y+z7mDAbnW3hQBHz84+dQXj8Q21
         trjYSbTUo+PdVhe2XSt5KhzOL4Msj001vPCgMrWGvga3hOZOYV8Ac0y/mdBLRvzYY3XA
         1VJUZgyigsql5drYeiAfnK0WwwbR6kpuqAgNENhqNa8qINhxAcDNPrH1e0e81H9aAmnc
         spfQ==
X-Received: by 10.236.88.228 with SMTP id a64mr1328979yhf.85.1367963814171;
        Tue, 07 May 2013 14:56:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm58386322yhj.12.2013.05.07.14.56.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223610>

From: Ramkumar Ramachandra <artagnon@gmail.com>

All the tests so far check that @{N} is the same as HEAD@{N} (for
positive N). However, this is not always the case; write a couple of
tests for this.

[fc: simplify some wording]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1508-at-combinations.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 58cd1fe..13b0372 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -59,4 +59,17 @@ nonsense "@{1}@{u}"
 nonsense "HEAD@{-1}"
 nonsense "@{-1}@{-1}"
 
+# @{N} versus HEAD@{N}
+
+check "HEAD@{3}" commit old-two
+nonsense "@{3}"
+
+test_expect_success 'switch to old-branch' '
+	git checkout old-branch
+'
+
+check HEAD ref refs/heads/old-branch
+check "HEAD@{1}" commit new-two
+check "@{1}" commit old-one
+
 test_done
-- 
1.8.3.rc0.401.g45bba44
