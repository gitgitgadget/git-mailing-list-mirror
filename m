From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/5] completion: add missing general options
Date: Sun, 15 Apr 2012 00:43:02 +0300
Message-ID: <1334439784-6460-4-git-send-email-felipe.contreras@gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:44:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAlf-0002JR-E6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab2DNVoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:44:23 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56990 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756306Ab2DNVoW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:44:22 -0400
Received: by lahj13 with SMTP id j13so3144617lah.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sc0C9/+sM8ERMwqQULYWkV4zdpqbEYVNQniQ33kqX6E=;
        b=I40iD1qF0FdkhKg2UadpgFir7DfntiPO1OOu2NHzldYYVKyclsLzYr+b80NVnBIq6J
         WdJoyS4BdoLXWK2odd8x9ro/UvKVjRrxwKPEiFEN0q1oxBa6rCePObDctRX65BYTfTwK
         LrCyn9bJ+2H41XagNOlJlUK1+MUCxgGacdghFChB5m45AnaoX380FxdkUNpI+kUT2A+o
         r9iKMRiALJZXTH6xL5vcqk5ph8Zq8gMNHjYG+zPQloALVZghk9QRE3HIxWf+1ODLplVP
         0KjmQoWB2Bq6gmzg7oRwR+3wXB+n97tekhED2r2g+NBcSCAjKfSN7qWSUENKaiXIMMSw
         rvLQ==
Received: by 10.112.82.131 with SMTP id i3mr2808390lby.74.1334439860941;
        Sat, 14 Apr 2012 14:44:20 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id f4sm3125303lbk.15.2012.04.14.14.44.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:44:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195521>

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
index 7bd37f5..f24c968 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -95,8 +95,10 @@ test_expect_success 'double dash "git" itself' '
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
@@ -117,4 +119,18 @@ test_expect_success 'double dash "git checkout"' '
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
