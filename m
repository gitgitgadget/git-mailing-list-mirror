From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 14/14] t{3032,6038}-*.sh: Allow SED_BIN_OPT to override the
 -b sed option
Date: Tue, 14 Dec 2010 18:43:52 +0000
Message-ID: <4D07BAE8.6070904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu2-0005Vk-TI
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882Ab0LNSrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:47:01 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:38270 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSrA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:47:00 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZtq-00026I-ch; Tue, 14 Dec 2010 18:46:59 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163673>


Some older versions of sed (eg. v3.02) do not understand the -b
(--binary) option. However, these versions of sed may have an
equivalent option we can use to request binary mode processing
(eg. -c or --nocr).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I nearly didn't send this patch, since my MinGW sed is somewhat old, and
most people would not have this problem. (Note I *think* I installed
using msysGit-fullinstall-1.6.4-preview20090729.exe)
So, feel free to drop this patch...

 t/t3032-merge-recursive-options.sh |    2 +-
 t/t6038-merge-text-auto.sh         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 29e049a..22d9988 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -13,7 +13,7 @@ test_description='merge-recursive options
 
 . ./test-lib.sh
 
-test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
+test_have_prereq SED_STRIPS_CR && SED_OPTIONS=${SED_BIN_OPT--b}
 test_have_prereq MINGW && export GREP_OPTIONS=-U
 
 test_expect_success 'setup' '
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index d9c2d38..4245d6e 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -14,7 +14,7 @@ test_description='CRLF merge conflict across text=auto change
 
 . ./test-lib.sh
 
-test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
+test_have_prereq SED_STRIPS_CR && SED_OPTIONS=${SED_BIN_OPT--b}
 
 test_expect_success setup '
 	git config core.autocrlf false &&
-- 
1.7.3
