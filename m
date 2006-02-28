From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] git-apply --whitespace=nowarn
Date: Mon, 27 Feb 2006 17:13:59 -0800
Message-ID: <7v4q2kuvxk.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtRQ-0006sr-9x
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWB1BOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWB1BOI
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:14:08 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7841 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751879AbWB1BOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:14:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228011226.PLFP6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 20:12:26 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16905>

Andrew insists --whitespace=warn should be the default, and I
tend to agree.  This introduces --whitespace=warn, so if your
project policy is more lenient, you can squelch them by having
apply.whitespace=nowarn in your configuration file.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Not in "next" but will be shortly.

 apply.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

114b085dd7b82c3ca74760c896e86c425127cf76
diff --git a/apply.c b/apply.c
index a5cdd8e..d5cb5b1 100644
--- a/apply.c
+++ b/apply.c
@@ -39,7 +39,7 @@ static enum whitespace_eol {
 	warn_on_whitespace,
 	error_on_whitespace,
 	strip_whitespace,
-} new_whitespace = nowarn_whitespace;
+} new_whitespace = warn_on_whitespace;
 static int whitespace_error = 0;
 static int squelch_whitespace_errors = 5;
 static int applied_after_stripping = 0;
@@ -55,6 +55,10 @@ static void parse_whitespace_option(cons
 		new_whitespace = warn_on_whitespace;
 		return;
 	}
+	if (!strcmp(option, "nowarn")) {
+		new_whitespace = nowarn_whitespace;
+		return;
+	}
 	if (!strcmp(option, "error")) {
 		new_whitespace = error_on_whitespace;
 		return;
-- 
1.2.3.gbfea
