From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 25/45] rebase: cherry-pick: fix sequence continuation
Date: Sun,  9 Jun 2013 11:40:37 -0500
Message-ID: <1370796057-25312-26-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliiz-00074a-1X
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab3FIQoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:05 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:65495 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3FIQoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:03 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so8864062obb.28
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=guvL5OLcYdhtL0XZHhtSapqlSTTWyCSdxco4pDXASJI=;
        b=VTGQzuAgo6h4APIJUS3HMPJW1RvciXeSb75PEQcbdLvpQ9YRfAdvCVvDK8eb6ik7dE
         y/cwYATggaTnWt0lDWF1OLI+v6CcWMuupRN2RTfgCVrpIoxuLKee7dEDdX9zL7R1urn2
         No31f++Wlj3Ocui0I8efyd6cyxYrouAFXSaRorVITUFzW2TRvF5Labwrauue4tJBr7/j
         0EX1RyX2T7umrOHPwoSsQHlzcOCQm+MpzdGmtm4+kNcFJT2qptpA35AlrVEmgHlFZslM
         UrmD/yyFlSLXsfZgNr6mOl0Tba6U4wXbrIYeqny6mVF0KrdJphSwjhRuRz+26H0lbWwA
         ZVkA==
X-Received: by 10.182.219.166 with SMTP id pp6mr4909182obc.66.1370796242043;
        Sun, 09 Jun 2013 09:44:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c10sm15205765oej.1.2013.06.09.09.44.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226997>

We are not in am mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index e142cfb..d8d32fe 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -5,12 +5,12 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
+	git cherry-pick --continue &&
 	move_to_original_branch
 	return
 	;;
 skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
+	git cherry-pick --skip &&
 	move_to_original_branch
 	return
 	;;
-- 
1.8.3.698.g079b096
