From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Move the console error messages to message dialog
Date: Sat, 27 May 2006 15:55:32 +0530
Message-ID: <4478291C.7000507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050100000307080304020607"
X-From: git-owner@vger.kernel.org Sat May 27 12:25:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjvzI-0006W5-R5
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWE0KZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWE0KZi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:25:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:5381 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751454AbWE0KZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 06:25:37 -0400
Received: by wr-out-0506.google.com with SMTP id i21so213340wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 03:25:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=MmM24waM7bX3XN2PNv53aLd49NmJrfIVQ2nJcj9Znsk5XIiTYcNllVPwj4CyeauiuEqd1zd9zR7ckOZ1Sv/qrQfoDpOtSg/Yt4eO+wijdkEQDvIYF5No9fEHYTdIu4nkArczLPZFQosq63Qum8HCGEMSefzvIMZbmzt+MrTrhSo=
Received: by 10.65.188.10 with SMTP id q10mr117315qbp;
        Sat, 27 May 2006 03:25:36 -0700 (PDT)
Received: from ?192.168.2.39? ( [59.92.132.221])
        by mx.gmail.com with ESMTP id e13sm376877qbe.2006.05.27.03.25.35;
        Sat, 27 May 2006 03:25:36 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20844>

This is a multi-part message in MIME format.
--------------050100000307080304020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050100000307080304020607
Content-Type: text/plain;
 name*0="0002-gitview-Move-the-console-error-messages-to-message-dialog.t";
 name*1="xt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-gitview-Move-the-console-error-messages-to-message-dial";
 filename*1="og.txt"

gitview: Move the console error messages to message dialog

This changes display the error/warning info using message dialog
rather than printing them using print

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index c708534..b836047 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -983,10 +983,15 @@ class GitView:
 		try:
 			self.treeview.set_cursor(self.index[revid])
 		except KeyError:
-			print "Revision %s not present in the list" % revid
+			dialog = gtk.MessageDialog(parent=None, flags=0,
+					type=gtk.MESSAGE_WARNING, buttons=gtk.BUTTONS_CLOSE,
+					message_format=None)
+			dialog.set_markup("Revision <b>%s</b> not present in the list" % revid)
 			# revid == 0 is the parent of the first commit
 			if (revid != 0 ):
-				print "Try running gitview without any options"
+				dialog.format_secondary_text("Try running gitview without any options")
+			dialog.run()
+			dialog.destroy()
 
 		self.treeview.grab_focus()
 
-- 
1.3.3.g4d548-dirty


--------------050100000307080304020607--
