From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 22:44:16 +0300
Message-ID: <1334519060-2348-2-git-send-email-felipe.contreras@gmail.com>
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
	id 1SJVNX-0002Nm-My
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab2DOTor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:44:47 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53524 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab2DOToq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:44:46 -0400
Received: by lahj13 with SMTP id j13so3492422lah.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V0tfktrihB0sULdQHqqcX1L0RBJqsgQ09eMUDy9FuYU=;
        b=nfQvijDDAiXiP9aiwVoXSzAwgG0zDYBFsiFih4n15jRJx06lqrpzIeWf7BEC+RW6R7
         Q1FLxrW2FBpMHPBw9fTlGVKkjszJRvb//xtHflaKTFwf8VAaph5pO4UheeHhEWtIs5+e
         le4my42kUkKxgeMbVnFx1P8NwtE68k//qhLWx2JJUZ1W8aVLU40DbGQuHXQQx7tRgX5j
         l+ZoA68HqzOHNFDPzyy8UEr1holIXDHPwvloeoFptKxiZFFeEZulV+N5Ha/4L6460Mp5
         4MF6u0Oa7poXv23i8RlZVvkbVHA1cyExqIvmPmIulMmey0xwd/4EB5zdR+ohONqqwzoo
         eStQ==
Received: by 10.152.112.100 with SMTP id ip4mr8160723lab.1.1334519085009;
        Sun, 15 Apr 2012 12:44:45 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id u4sm16930629lad.5.2012.04.15.12.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195580>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..db2d3cc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -304,16 +304,16 @@ __git_ps1 ()
 	fi
 }
 
-# __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
 {
-	local c IFS=' '$'\t'$'\n'
+	local c IFS=$' \t\n'
 	for c in $1; do
-		case "$c$2" in
-		--*=*) printf %s$'\n' "$c$2" ;;
-		*.)    printf %s$'\n' "$c$2" ;;
-		*)     printf %s$'\n' "$c$2 " ;;
+		c="$c$2"
+		case $c in
+		--*=*|*.) ;;
+		*) c="$c " ;;
 		esac
+		printf '%s\n' "$c"
 	done
 }
 
-- 
1.7.10.1.g1f19b8.dirty
