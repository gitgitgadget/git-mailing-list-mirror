From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: guitools: add the path in the confirmation dialog for tools which needs one
Date: Thu, 20 Oct 2011 21:32:30 +0200
Message-ID: <2fef219736a0787ed864b5c18adf31f7a4e8acda.1319139139.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 21:32:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGyM3-0006Z8-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 21:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab1JTTcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 15:32:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35732 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1JTTce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 15:32:34 -0400
Received: by bkbzt19 with SMTP id zt19so3920979bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zHWZLj6zYqnQz5P/Aj0q0qVvS92nL6fk1sJINrVyVn4=;
        b=WznU+6hLdDjUJb+hd7XZf4FGjCXXvXvb6vszs+9sKXmXWPj3RR5yut4sJsCEQ3CW00
         Pd2MJXpmA2PpV/uBJpxrutS5LFeHZrOK4/KOlfhEwP4pmGqsqBQa8AWKY9TOV2eMZMsE
         k5Tuy1AsSN/ySPKNVIdFiuDJ5syvRVULPFCUk=
Received: by 10.204.154.209 with SMTP id p17mr9058218bkw.20.1319139153286;
        Thu, 20 Oct 2011 12:32:33 -0700 (PDT)
Received: from localhost (p5B2AD78D.dip.t-dialin.net. [91.42.215.141])
        by mx.google.com with ESMTPS id f7sm2154812bkc.1.2011.10.20.12.32.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 12:32:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.759.gfc8c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184039>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/tools.tcl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 95e6e55..39e08f0 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -87,8 +87,14 @@ proc tools_exec {fullname} {
 			return
 		}
 	} elseif {[is_config_true "guitool.$fullname.confirm"]} {
-		if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
-			return
+		if {[is_config_true "guitool.$fullname.needsfile"]} {
+			if {[ask_popup [mc "Are you sure you want to run %s on file \"%s\"?" $fullname $current_diff_path]] ne {yes}} {
+				return
+			}
+		} else {
+			if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
+				return
+			}
 		}
 	}
 
-- 
1.7.7.759.gfc8c6
