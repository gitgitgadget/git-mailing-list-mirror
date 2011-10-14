From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: fix multi selected file operation
Date: Fri, 14 Oct 2011 10:19:26 +0200
Message-ID: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 10:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REczS-0001qE-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 10:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab1JNITe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 04:19:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48563 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1JNITc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 04:19:32 -0400
Received: by bkbzt4 with SMTP id zt4so2516835bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sw+50rFPupPpVn6aUB1dv8nrmbDIPfULWYPlS+ZjVIU=;
        b=RXOnmpJxbTFOD+WGdENkqRkDNgRL6Acif+QyKodRK05qVPryPbR1eO/DXkqpF37eBh
         D6nwklJtDIturnRGAY4kvf1fmh/0P4/m3YkdWS/J7+JJ5T8JUHgy74Edxzo9PfSjDNeH
         TRYlopE0pR6ni+6dNHzgW09j9ilRzt/JH6c8M=
Received: by 10.204.138.88 with SMTP id z24mr5054638bkt.17.1318580371641;
        Fri, 14 Oct 2011 01:19:31 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id k26sm7527215bks.1.2011.10.14.01.19.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 01:19:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183557>

The current path for what we see the diff is not in the list of selected
paths. But when we add single paths (with Ctrl) to the set the current path
would not be used when the action is performed.

Fix this by explicitly putting the path into the list before we start
showing the diff.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f897160..e5dd8bc 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2474,6 +2474,7 @@ proc toggle_or_diff {w x y} {
 				[concat $after [list ui_ready]]
 		}
 	} else {
+		set selected_paths($path) 1
 		show_diff $path $w $lno
 	}
 }
-- 
1.7.6.789.gb4599
