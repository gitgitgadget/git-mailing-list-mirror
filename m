From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/9] t1508 (at-combinations): improve nonsense()
Date: Thu,  2 May 2013 19:09:28 +0530
Message-ID: <1367501974-6879-4-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtin-0002b0-H9
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543Ab3EBNiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:13 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:38212 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3EBNiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:09 -0400
Received: by mail-pb0-f47.google.com with SMTP id uo1so353310pbc.20
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4iOcWPa0ihjh9AWzlnF+4nCoQrteMJfZBVJ8lWhpWZc=;
        b=XVxnsiy/qQsUBAav3aXROWoK/c5i9qzNpT+sYg+UoONihHgP0VbYjPp1PnasgpWnU8
         8DAztKWYV8dz5ny3SqGa2Y1OvUTqpycM2FULUmaoDxjQ0NASCo9lSfaBjqIOiHXOjGLC
         8/mVqpDGnHSLN9GpIr1JW9yWblzIQ+02vRuZzmct0W1TW7Ttc9npDcPwys9UPhsqxJd5
         NKWf/3iO53Cob77zkBHje0dRIBxD+XarISRGfxJJS/GceTgNDeIQIy9vWxsLachDubkL
         O7keNqLd3w1TSXL46J2cpko7XyLA/WA5YYJH5vru7UULFcnQz0l5bGh8hxsqwpfI12t6
         ywtw==
X-Received: by 10.68.20.74 with SMTP id l10mr9051149pbe.150.1367501889401;
        Thu, 02 May 2013 06:38:09 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223203>

From: Felipe Contreras <felipe.contreras@gmail.com>

nonsense() is checking at the wrong abstraction layer: it doesn't need
to invoke a 'git log' at all; it is sufficient to check that 'git
rev-parse' can't resolve the argument.

[rr: commit message, minor modification]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index cacb2d0..55fdd0f 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -17,7 +17,7 @@ test_expect_${4:-success} "$1 = ${3:-$2}" "
 }
 nonsense() {
 test_expect_${2:-success} "$1 is nonsensical" "
-	test_must_fail git log -1 '$1'
+	test_must_fail git rev-parse '$1'
 "
 }
 fail() {
-- 
1.8.3.rc0.40.g09a0447
