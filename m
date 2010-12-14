From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 12/14] t3032-*.sh: Do not strip CR from line-endings while
 grepping on MinGW
Date: Tue, 14 Dec 2010 18:35:48 +0000
Message-ID: <4D07B904.8040206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu1-0005Vk-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab0LNSq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:56 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:38256 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSqz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:55 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZtm-00025F-Zp; Tue, 14 Dec 2010 18:46:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163675>


By default grep reads in text mode and converts CRLF into LF line
endings, which causes tests 4, 6 and 8 to fail. In a similar manner
to commit a94114ad  (Do not strip CR when grepping HTTP headers,
2010-09-12), we set (and export) the GREP_OPTIONS variable to -U so
that grep will use binary mode.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t3032-merge-recursive-options.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index f70f6c4..29e049a 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -14,6 +14,7 @@ test_description='merge-recursive options
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
+test_have_prereq MINGW && export GREP_OPTIONS=-U
 
 test_expect_success 'setup' '
 	conflict_hunks () {
-- 
1.7.3
