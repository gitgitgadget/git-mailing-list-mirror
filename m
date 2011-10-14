From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/3] git-gui: use "untracked" for files which are not known to git
Date: Fri, 14 Oct 2011 21:25:20 +0200
Message-ID: <446a8233349fd7d084fd01bf1176a4073ff17593.1318620267.git.bert.wesarg@googlemail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnNz-0002ST-6v
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab1JNTZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:25:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59108 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab1JNTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:25:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so353915bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=jN83tcY5yDWPcUYdwCr3BsLs411eeGJSbU42tikSVj4=;
        b=PMfAhi/1gEyAT88u7KjPkaKH0j+by+y01vO6+1u1trR16IOb2NgTaSwBNiqIEtD/5B
         oWzypfRlKcI8cAHNcxz4IWATvkv/C213zE4kI/at74UlPZN+gh/gfU3Nb7SdgHacXtiV
         PjqlTzN658a+yTgkXYDmYhaEDEqzA+6FEWoX8=
Received: by 10.204.130.9 with SMTP id q9mr7900528bks.43.1318620328222;
        Fri, 14 Oct 2011 12:25:28 -0700 (PDT)
Received: from localhost (p5B2AD5F0.dip.t-dialin.net. [91.42.213.240])
        by mx.google.com with ESMTPS id k26sm9427407bks.1.2011.10.14.12.25.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 12:25:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
In-Reply-To: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183602>

"untracked" is the right phrase for files new to git. For example
git-status uses this phrase. Also make the question shorter.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/index.tcl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index 3a9c8b7..014acf9 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -356,20 +356,20 @@ proc do_add_all {} {
 	global file_states
 
 	set paths [list]
-	set unknown_paths [list]
+	set untracked_paths [list]
 	foreach path [array names file_states] {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
 		?T -
 		?D {lappend paths $path}
-		?O {lappend unknown_paths $path}
+		?O {lappend untracked_paths $path}
 		}
 	}
-	if {[llength $unknown_paths]} {
-		set reply [ask_popup [mc "There are unknown files do you also want to stage those?"]]
+	if {[llength $untracked_paths]} {
+		set reply [ask_popup [mc "Stage also untracked files?"]]
 		if {$reply} {
-			set paths [concat $paths $unknown_paths]
+			set paths [concat $paths $untracked_paths]
 		}
 	}
 	add_helper {Adding all changed files} $paths
-- 
1.7.6.789.gb4599
