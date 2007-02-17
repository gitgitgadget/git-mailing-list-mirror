From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/3] Improve default column widths by changing resize modes
Date: Sat, 17 Feb 2007 22:00:20 +0000
Message-ID: <200702172200.20859.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 23:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIXeI-0004c2-Kn
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 23:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbXBQWDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbXBQWDP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 17:03:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:7077 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030258AbXBQWDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 17:03:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so403984uga
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 14:03:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=LSRAd9qfFv9uUax0BWfbBqPTD5loKYUiUzJbVFtOCNB8umd8tCDth22Cu4WgayG5fPejz9HobsL5BwC1SpDLv+GybTy5pTvDc5aa/GiNDmWhQO/jgLR0Va7STpb+PyFCmrne3/o8lmwH0LVp0+ZIWewJIne4BulJ87jHFvKTJSo=
Received: by 10.67.106.3 with SMTP id i3mr4745736ugm.1171749793730;
        Sat, 17 Feb 2007 14:03:13 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id p32sm5437727ugc.2007.02.17.14.03.11;
        Sat, 17 Feb 2007 14:03:11 -0800 (PST)
X-TUID: 7e16d34d754c7300
X-UID: 241
X-Length: 1557
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40016>

The time column is not the best column to be auto stretched, it's
probably a fixed width because it's only showing dates.  The log column
is more typically variable, so have that one be the one that takes up
whatever space is left.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/listview.cpp |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index 12066f3..45e696b 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -64,15 +64,16 @@ void ListView::setupGeometry() {
 	setPalette(pl); // does not seem to inherit application paletteAnnotate
 
 	QHeaderView* hv = header();
-	hv->setStretchLastSection(true);
-	hv->setResizeMode(LOG_COL, QHeaderView::Interactive);
-	hv->setResizeMode(TIME_COL, QHeaderView::Interactive);
+	hv->setStretchLastSection(false);
+	hv->setResizeMode( LOG_COL, QHeaderView::Stretch );
+	hv->setResizeMode( TIME_COL, QHeaderView::Interactive);
 	hv->setResizeMode(ANN_ID_COL, QHeaderView::ResizeToContents);
 	hv->resizeSection(GRAPH_COL, DEF_GRAPH_COL_WIDTH);
 	hv->resizeSection(LOG_COL, DEF_LOG_COL_WIDTH);
 	hv->resizeSection(AUTH_COL, DEF_AUTH_COL_WIDTH);
 	hv->resizeSection(TIME_COL, DEF_TIME_COL_WIDTH);
 
+
 	if (git->isMainHistory(fh))
 		hideColumn(ANN_ID_COL);
 }
-- 
1.5.0.rc4.gb4d2
