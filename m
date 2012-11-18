From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/6] completion: simplify tests using test_completion_long()
Date: Sun, 18 Nov 2012 11:51:54 +0100
Message-ID: <1353235917-13059-4-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2US-0004tn-3Y
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2KRKw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab2KRKw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TY46XipDwtzoC7REhkFs0B8WQPSTq0/DmL6xe2auzwM=;
        b=Pqyyhrf7TWCB1K/RofWOrfbhUYevp0R3RssCn1lZHXkAHkZZTkUhWvVPMm/CnTrBQR
         f4lmyZsPfDrFJHQS/CJbnc416W64dCurgpQwVv6ffcgux27xJU3yLFuvbRJ23HB5i0AE
         mYNh3gChZ1KiNopBfgmx5xQEwnDuUPU2XsG7wAjeFsRoRy6D+YVc14pjbBe1gOnfGJXw
         elAfpxyns5Gs3mog0dtdaetnrbNN/c0hpEvEgJFtYREeZai52m0hwqz3kfT3xCL0NvBJ
         AW8k8pRSxPAyFAjMwrf62sqUK2KhryHuQofBOO+SRyVSDAxrDQYK/Fqy7eeabmmGLuVd
         4JIw==
Received: by 10.204.147.6 with SMTP id j6mr3737444bkv.61.1353235946073;
        Sun, 18 Nov 2012 02:52:26 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id a5sm851241bkw.8.2012.11.18.02.52.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:25 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210008>

No need to duplicate that functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f4c7342..6a250ad 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -172,7 +172,7 @@ test_expect_success 'basic' '
 '
 
 test_expect_success 'double dash "git" itself' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git --" <<-\EOF
 	--paginate Z
 	--no-pager Z
 	--git-dir=
@@ -187,11 +187,10 @@ test_expect_success 'double dash "git" itself' '
 	--no-replace-objects Z
 	--help Z
 	EOF
-	test_completion "git --"
 '
 
 test_expect_success 'double dash "git checkout"' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git checkout --" <<-\EOF
 	--quiet Z
 	--ours Z
 	--theirs Z
@@ -202,17 +201,15 @@ test_expect_success 'double dash "git checkout"' '
 	--orphan Z
 	--patch Z
 	EOF
-	test_completion "git checkout --"
 '
 
 test_expect_success 'general options' '
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git --exe" <<-\EOF &&
 	--exec-path Z
 	--exec-path=
 	EOF
-	test_completion "git --exe" &&
 	test_completion "git --htm" "--html-path " &&
 	test_completion "git --pag" "--paginate " &&
 	test_completion "git --no-p" "--no-pager " &&
-- 
1.8.0
