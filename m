From: Patrick Welche <prlw1@cam.ac.uk>
Subject: 1.8.4 rebase regression?
Date: Mon, 16 Sep 2013 00:57:39 +0100
Message-ID: <20130915235739.GA712@quark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 16 02:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLMba-0000oz-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 02:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab3IPAXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 20:23:38 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45530 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3IPAXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 20:23:38 -0400
X-Greylist: delayed 1553 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Sep 2013 20:23:38 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-17-176-162.as13285.net ([92.17.176.162]:65416 helo=quark)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VLMCG-0002O0-Ex (Exim 4.80_167-5a66dd3) for git@vger.kernel.org
	(return-path <prlw1@cam.ac.uk>); Mon, 16 Sep 2013 00:57:44 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234825>

I just upgraded (via pkgsrc) from git 1.8.3.4 to 1.8.4. With 1.8.4, I had
local changes in glib, did a git pull --rebase. Some of my changes
conflicted, but

$ git rebase --abort
No rebase in progress?

so somehow the usual process of amending the edit, or skipping the patch
no longer works.

I found a similar report at:
http://mail-index.netbsd.org/pkgsrc-users/2013/09/14/msg018646.html


Another less important regression is that in an xterm, with 1.8.3.4 I see

$ /tmp/bin/git diff 
diff --cc glib/gmain.c
index 738e69c,5aaebd0..0000000
--- a/glib/gmain.c
+++ b/glib/gmain.c
@@@ -4953,32 -4921,32 +4953,48 @@@ g_unix_signal_watch_dispatch (GSourc
  }
...

but with 1.8.4, I see

$ git diff
ESC[1mdiff --cc glib/gmain.cESC[m
ESC[1mindex 738e69c,5aaebd0..0000000ESC[m
ESC[1m--- a/glib/gmain.cESC[m
ESC[1m+++ b/glib/gmain.cESC[m
ESC[36m@@@ -4953,32 -4921,32 +4953,48 @@@ESC[m ESC[mg_unix_signal_watch_dispatch (GSourcESC[m


(same xterm, no change of TERM in both invocations above)
git status in 1.8.4 does show red, so colour does work...

Thoughts on how to help debug?

Cheers,

Patrick
