From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Fri, 13 Apr 2012 02:50:03 +0300
Message-ID: <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 01:50:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITms-0005Bd-4e
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762287Ab2DLXum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:50:42 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60889 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758232Ab2DLXuk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 19:50:40 -0400
Received: by lahj13 with SMTP id j13so1992598lah.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CLNnMsW06cIZc3phWWGF6c1fZZWrvGOwuuduR7nBr8A=;
        b=RuALBmY2/6FPW/6XNDGDQnrNrDAbzbVUk6vAb8Eb/dPTi10L7vDxosXn2NRQ5plvlJ
         w1VRVKVgPGY3Ie4B6bts9C7LIHWzh7FFx+23kKQBa0p7vMOMWDQgMsfOtEBZKIdqxpBt
         TvEBb/bwGYp6iMeV6RsGm3uZUfsXgSAWmIXegLHkFWm1F1lnPcAq+v09+YYyCnzT0O73
         c2FvhvMlC6AYZ4vj6M+M9uu4YIDq67zlCplfHcmPA136CxcFGtvEW/TvsRGe7dIxzCvu
         gwWYaRqlbIreUgTh2k8Oc7Z0RxX4i50L5BGevt7Tu466KE38nzFth9SPqUXnHWPjuLZ6
         EHOQ==
Received: by 10.112.11.9 with SMTP id m9mr45458lbb.60.1334274638781;
        Thu, 12 Apr 2012 16:50:38 -0700 (PDT)
Received: from localhost (84-231-136-182.elisa-mobile.fi. [84.231.136.182])
        by mx.google.com with ESMTPS id nq2sm7671761lab.6.2012.04.12.16.50.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:50:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195394>

All other options that accept an argument are completed this way, plus,
the '--foo bar' format doesn't seem to work correctly at the moment.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 t/t9902-completion.sh                  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6a8cf9f..efed24a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2638,7 +2638,7 @@ _git ()
 			--git-dir=
 			--bare
 			--version
-			--exec-path
+			--exec-path=
 			--html-path
 			--info-path
 			--work-tree=
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f2075af..fd2ed3e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -90,7 +90,7 @@ test_expect_success 'double dash "git" itself' '
 	--git-dir=
 	--bare Z
 	--version Z
-	--exec-path Z
+	--exec-path=
 	--html-path Z
 	--info-path Z
 	--work-tree=
@@ -119,7 +119,7 @@ test_expect_success 'double dash "git checkout"' '
 test_expect_success 'general options' '
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
-	test_completion "git --exe" "--exec-path " &&
+	test_completion "git --exe" "--exec-path=" &&
 	test_completion "git --htm" "--html-path " &&
 	test_completion "git --pag" "--paginate " &&
 	test_completion "git --no-p" "--no-pager " &&
-- 
1.7.10.1.g1f19b8.dirty
