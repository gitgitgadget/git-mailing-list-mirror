From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Tue, 14 Dec 2010 18:37:43 +0000
Message-ID: <4D07B977.9010502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com,
	j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu2-0005Vk-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab0LNSq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:59 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:40786 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:58 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZto-0000TT-fA; Tue, 14 Dec 2010 18:46:57 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163671>


The BSLASHPSPEC tests (11-13) fail on cygwin, since you can't
create files containing an backslash character in the name.
In order to skip these tests, we simply stop (incorrectly)
asserting the BSLASHPSPEC prerequisite in test-lib.sh.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note t3700-*.sh has a test protected by BSLASHSPEC which
previously passed on cygwin and will now be (unnecessarily)
skipped. This test needs to be skipped on MinGW, given how
it is written; if you remove the single quotes around the
filename, however, it will pass even on MinGW.

 t/test-lib.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e74357..aee7d20 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1061,7 +1061,6 @@ case $(uname -s) in
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
-	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq NOT_MINGW
 	test_set_prereq SED_STRIPS_CR
-- 
1.7.3
