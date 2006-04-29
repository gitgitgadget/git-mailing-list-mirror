From: colin@horizon.com
Subject: Re: fatal: git-write-tree: not able to write tree
Date: 29 Apr 2006 09:23:24 -0400
Message-ID: <20060429132324.31638.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 15:23:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZpQ7-0001jQ-TK
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 15:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWD2NX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 09:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWD2NX0
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 09:23:26 -0400
Received: from science.horizon.com ([192.35.100.1]:42555 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750709AbWD2NXZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 09:23:25 -0400
Received: (qmail 31639 invoked by uid 1000); 29 Apr 2006 09:23:24 -0400
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19302>

diff --git a/git-am.sh b/git-am.sh
index eab4aa8..872145b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -376,6 +376,13 @@ do
 			echo "No changes - did you forget update-index?"
 			stop_here $this
 		fi
+		unmerged=$(git-ls-files -u)
+		if test -n "$unmerged"
+		then
+			echo "You still have unmerged paths in your index"
+			echo "did you forget update-index?"
+			stop_here $this
+		fi
 		apply_status=0
 		;;
 	esac

Er... it's very non-obvious to me why you'd want to stick a workaround
here when you could instead fix git-write-tree to do it.  That seems
like The Right Thing.
(It would also be helpful to mention at least one unmerged file by name.)
