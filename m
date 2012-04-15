From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/5] completion: add missing general options
Date: Sun, 15 Apr 2012 22:44:18 +0300
Message-ID: <1334519060-2348-4-git-send-email-felipe.contreras@gmail.com>
References: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVNY-0002Nm-QZ
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab2DOTox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:44:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59084 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2DOTov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 15:44:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so3570484lbb.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZE+PepaQH41jCZrRS2OKFF3d+r/xjR7u1f24c5JD3pA=;
        b=GesE/3WwYdqPqBeOhtOeTb1uu4n8/73MMpiB+2W2eIrw51f5TvlvfjPdFqTiENlnVe
         YTRWfMLUGFDL7SUj0EMzVUA6veGuLHSsI/DpHRddGNI8gcXOG+I38s4trmHI1Q1e0Ob3
         p4gU98Gphv+E/e1yLyTzWeDtBeTourXM1Tn09n8At0eBODh1xWuWPIqYV6BM4gyyax++
         iCA8axDlI66lxKz+S5Wv6WR9tyAM2WaD9S28qU/xjW93auN1N2v+EXF4nJImlrsHpdm+
         FoQcswbM+AJbCmLtN30hDXHP2WsR8yTZ67gG1dYjbMhc2++qmhu8T48vc4RY9M1lkGSk
         d1tw==
Received: by 10.112.100.134 with SMTP id ey6mr570711lbb.18.1334519090817;
        Sun, 15 Apr 2012 12:44:50 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id h8sm21539708lbx.8.2012.04.15.12.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195578>

And add relevant tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    2 ++
 t/t9902-completion.sh                  |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8c91faf..b837704 100755
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
