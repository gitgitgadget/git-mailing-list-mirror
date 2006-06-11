From: Junio C Hamano <junkio@cox.net>
Subject: invalid command name "listrefs"
Date: Sun, 11 Jun 2006 09:50:47 -0700
Message-ID: <7vu06rfxg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 18:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpT9I-0001yH-9s
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWFKQut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWFKQut
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:50:49 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25033 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751037AbWFKQut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 12:50:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060611165048.VSEY11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Jun 2006 12:50:48 -0400
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21662>

Starting gitk, "File->Reread references" results in an error
dialog.

This patch resurrects the procedure from an older version, and it
seems to work for me, but with the updated code it might be that
you wanted to use a different mechanism to implement rereadrefs
procedure -- I dunno.

-- >8 --
gitk: rereadrefs wants listrefs 

The listrefs procedure was removed during the course of
development, but there is still a user of it, so resurrect it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/gitk b/gitk
index 9be10a4..ba4644f 100755
--- a/gitk
+++ b/gitk
@@ -5196,6 +5196,24 @@ proc rereadrefs {} {
     }
 }
 
+proc listrefs {id} {
+    global idtags idheads idotherrefs
+
+    set x {}
+    if {[info exists idtags($id)]} {
+	set x $idtags($id)
+    }
+    set y {}
+    if {[info exists idheads($id)]} {
+	set y $idheads($id)
+    }
+    set z {}
+    if {[info exists idotherrefs($id)]} {
+	set z $idotherrefs($id)
+    }
+    return [list $x $y $z]
+}
+
 proc showtag {tag isnew} {
     global ctext tagcontents tagids linknum
 
