From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 25/36] rebase: cherry-pick: fix sequence continuation
Date: Sun,  9 Jun 2013 14:24:39 -0500
Message-ID: <1370805890-3453-26-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHk-0003yF-0c
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3FIT16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:58 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36903 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab3FIT14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:56 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so3069148oag.34
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=guvL5OLcYdhtL0XZHhtSapqlSTTWyCSdxco4pDXASJI=;
        b=UQd4sWzpTWNb9IAHZdz0A94PWZLRCgiTzUsu8prjJRZwnQC1NvBLO+nxDPaaXoHLsx
         PxLTpjvDutXacDQ5plkYa1m4P3ss8yOqFEMohMfEogcILUsy4qOS0Xu7Gg4lLawBexsb
         Mq8vf2G/+mH8Onhs/HAdXnhIYRKbjUecMcSqeyJkTqnUuVXdrAjkr40/p2X9pyyQj4vF
         HjihW5EeXzrLP+rKIfk2u8QtH1X5JCepqIRhdqmcAbdPnsYvHes3sy1889CPvDDG+qK2
         h08Xa2FaSdNhsYqE5vuLphPs5ra+HhXj6VGbUDiiGV0+6NDrgwFSRlwBbyj2HqqqMCZ1
         4rfw==
X-Received: by 10.60.79.68 with SMTP id h4mr5796011oex.39.1370806076012;
        Sun, 09 Jun 2013 12:27:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wv8sm16039252obb.2.2013.06.09.12.27.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227135>

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
