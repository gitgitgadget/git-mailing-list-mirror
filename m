From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] completion: add missing general options
Date: Fri, 13 Apr 2012 02:50:02 +0300
Message-ID: <1334274603-3277-4-git-send-email-felipe.contreras@gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 01:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITmr-0005Bd-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762252Ab2DLXui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:50:38 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56331 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232Ab2DLXug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:50:36 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so2046018lbb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FNV54lUI/tW/5RGvu5CBiT+iR0Q+L8nMPVXCZmO6qj8=;
        b=ksqydeLxqdammtx/eb698d6ZIl2AzD1tvnWpKn1dfylZXIoLWDb3N97B996RYTfUvR
         jWrsMQYW1QUHURtbKGkjrXq/w1Uaonhr9drTzR0PYcRAZEYrDC36FVA2XTP62PCuilq7
         XJ59Ri7VcEEH/4/xEgaPnxsYH7qchP87Knx4QGv47fUHWTfuBefPloDV1iJMyamOMpXp
         paGqIr29PuYGYHLaiDlWshK6AWAMbWxMWcMz5k2j8e7S63cSPodeoZ/V3hXLcR4tb936
         ZrxBrnv8Zy+mXnpjrq5+Uguo+cLkpnnEH9PEoaiZ0RhLKguD7rXqZxj/LrgkszPG/dnv
         E4Ag==
Received: by 10.152.146.67 with SMTP id ta3mr104711lab.25.1334274635662;
        Thu, 12 Apr 2012 16:50:35 -0700 (PDT)
Received: from localhost (84-231-136-182.elisa-mobile.fi. [84.231.136.182])
        by mx.google.com with ESMTPS id c3sm9602738lbg.6.2012.04.12.16.50.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:50:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195393>

And add relevant tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    2 ++
 t/t9902-completion.sh                  |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9d36bb7..6a8cf9f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2640,8 +2640,10 @@ _git ()
 			--version
 			--exec-path
 			--html-path
+			--info-path
 			--work-tree=
 			--namespace=
+			--no-replace-objects
 			--help
 			"
 			;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3bbec79..f2075af 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -92,8 +92,10 @@ test_expect_success 'double dash "git" itself' '
 	--version Z
 	--exec-path Z
 	--html-path Z
+	--info-path Z
 	--work-tree=
 	--namespace=
+	--no-replace-objects Z
 	--help Z
 	EOF
 	test_completion "git --"
@@ -114,4 +116,18 @@ test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --"
 '
 
+test_expect_success 'general options' '
+	test_completion "git --ver" "--version " &&
+	test_completion "git --hel" "--help " &&
+	test_completion "git --exe" "--exec-path " &&
+	test_completion "git --htm" "--html-path " &&
+	test_completion "git --pag" "--paginate " &&
+	test_completion "git --no-p" "--no-pager " &&
+	test_completion "git --git" "--git-dir=" &&
+	test_completion "git --wor" "--work-tree=" &&
+	test_completion "git --nam" "--namespace=" &&
+	test_completion "git --bar" "--bare " &&
+	test_completion "git --inf" "--info-path " &&
+	test_completion "git --no-r" "--no-replace-objects "
+'
 test_done
-- 
1.7.10.1.g1f19b8.dirty
