From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/3] t9020-*.sh: Skip all tests when python not available
Date: Sat, 25 Aug 2012 18:26:06 +0100
Message-ID: <50390AAE.6090602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 19:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5KAo-0001Xy-HA
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 19:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2HYR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 13:29:00 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:50072 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754549Ab2HYR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 13:28:57 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 73E0E384080;
	Sat, 25 Aug 2012 18:28:56 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D716038407F;	Sat, 25 Aug 2012 18:28:55 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 25 Aug 2012 18:28:55 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204278>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Florian,

Since python is not installed on MinGW, this test fails with
an "unable to spawn script" type message when attempting to
execute svnrdump. So, could you, in addition to the previous
patch, squash this into commit 2d597d73 ("Add a test script
for remote-svn", 20-08-2012).

Thanks!

ATB,
Ramsay Jones

 t/t9020-remote-svn.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index cd7604e..e6ed4ca 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -4,6 +4,12 @@ test_description='tests remote-svn'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PYTHON
+then
+	skip_all='skipping remote-svn tests, python not available'
+	test_done
+fi
+
 # We override svnrdump by placing a symlink to the svnrdump-emulator in .
 export PATH="$HOME:$PATH"
 ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
-- 
1.7.12
