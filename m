From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Wed, 7 Feb 2007 21:38:36 +0000
Message-ID: <200702072138.36787.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 22:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuYA-0003Lc-06
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbXBGVle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbXBGVld
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:41:33 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:28157 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161430AbXBGVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:41:32 -0500
Received: by nz-out-0506.google.com with SMTP id s1so297042nze
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 13:41:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=EUZl1nlzWKlSMdAXjsqPzN6iXTeHeke+4xc7f8rSPv/V6jhcII9WmK55pckK4EgZSsLMCMUPe4Gtt4wzFLla60/sfRFrOWfQqXZpPmWo9DM0xxOGAhSNehftdjiP9ZLClCu2DcFsW3/Zf9gQILCGFokTX6Wvrdll8z4K6RxOiBg=
Received: by 10.64.156.3 with SMTP id d3mr14436326qbe.1170884492006;
        Wed, 07 Feb 2007 13:41:32 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q14sm1273764qbq.2007.02.07.13.41.28;
        Wed, 07 Feb 2007 13:41:29 -0800 (PST)
X-TUID: d0ea13c245a62ff2
X-UID: 224
X-Length: 2625
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38974>

The log window and changed files list would start at equal sizes.  This
patch gives them each a horizontal stretch factor making them have a 3:1
ratio.

The font for the log viewer is set to "Monospace", but this should
really be done in software and given a config setting (perhaps use the
patch view font)

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/revsview.ui |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/src/revsview.ui b/src/revsview.ui
index 3fb02ee..ad16200 100644
--- a/src/revsview.ui
+++ b/src/revsview.ui
@@ -55,11 +55,32 @@
        <enum>Qt::Horizontal</enum>
       </property>
       <widget class="RevDesc" name="textBrowserDesc" >
+       <property name="sizePolicy" >
+        <sizepolicy>
+         <hsizetype>5</hsizetype>
+         <vsizetype>13</vsizetype>
+         <horstretch>3</horstretch>
+         <verstretch>0</verstretch>
+        </sizepolicy>
+       </property>
+       <property name="font" >
+        <font>
+         <family>Monospace</family>
+        </font>
+       </property>
        <property name="lineWrapMode" >
         <enum>QTextEdit::NoWrap</enum>
        </property>
       </widget>
       <widget class="FileList" name="fileList" >
+       <property name="sizePolicy" >
+        <sizepolicy>
+         <hsizetype>5</hsizetype>
+         <vsizetype>13</vsizetype>
+         <horstretch>1</horstretch>
+         <verstretch>0</verstretch>
+        </sizepolicy>
+       </property>
        <property name="contextMenuPolicy" >
         <enum>Qt::CustomContextMenu</enum>
        </property>
@@ -72,16 +93,16 @@
  <layoutdefault spacing="6" margin="11" />
  <customwidgets>
   <customwidget>
-   <class>ListView</class>
-   <extends>QTreeView</extends>
-   <header>listview.h</header>
-  </customwidget>
-  <customwidget>
    <class>FileList</class>
    <extends>QListWidget</extends>
    <header>filelist.h</header>
   </customwidget>
   <customwidget>
+   <class>ListView</class>
+   <extends>QTreeView</extends>
+   <header>listview.h</header>
+  </customwidget>
+  <customwidget>
    <class>RevDesc</class>
    <extends>QTextBrowser</extends>
    <header>revdesc.h</header>
-- 
1.5.0.rc1.gf4b6c
