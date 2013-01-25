From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/7] git-mergetool: don't hardcode 'mergetool' in show_tool_help
Date: Fri, 25 Jan 2013 01:43:50 -0800
Message-ID: <1359107034-14606-4-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfpx-00082T-A1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab3AYJoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:12 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42765 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3AYJoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:09 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so27074ieb.31
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E5Pjz2xp0eSIo5oPGj8SjBZbxGKkZkQXD8xaCDmQqz8=;
        b=feH6P1PaTiClG7ZFIRTEtZ1w78xCyOPbBTVjS0Jo/jKGATUOY80sTAmXe4rK8Ssxf4
         FflAkBEsmne+Nhp3p9TYQPMGy1iysjZeXywl1WS9TbGeXEp7BFQ7ANYaG+W7B6tyqbXD
         AH7uge8/NPuFCM6s7P5PyZtEaH6P49a2OoBICdY6dD6W3wxaGCQ2jyym6/4ttohU+bk1
         O58jhMyKfBiMkpfQRoiFPfJCnj3uAbjetBUMRZAK8Jywd2ZTiWsunmlu5MYsJ+CYvy6z
         g5Np5FcmjoQgsXzCLMenqKwKwMbmpXFKHxicDwkLtvaeQkumKJRfYifaOEmEijupGGG3
         gPIA==
X-Received: by 10.50.183.227 with SMTP id ep3mr3505014igc.107.1359107048994;
        Fri, 25 Jan 2013 01:44:08 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:08 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214526>

From: John Keeping <john@keeping.me.uk>

When using show_tool_help from git-difftool we will want it to print
"git difftool" not "git mergetool" so use "git ${TOOL_MODE}tool".

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1748315..4c1e129 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -188,12 +188,14 @@ show_tool_help () {
 			unavailable="$unavailable$i$LF"
 		fi
 	done
+
+	cmd_name=${TOOL_MODE}tool
 	if test -n "$available"
 	then
-		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
 		echo "$available" | sort | sed -e 's/^/	/'
 	else
-		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
 	fi
 	if test -n "$unavailable"
 	then
-- 
1.8.1.1.367.g22b1720.dirty
