From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 01/14] t3600-rm.sh: Don't pass a non-existent prereq to test
 #15
Date: Tue, 14 Dec 2010 18:19:09 +0000
Message-ID: <4D07B51D.9000705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZsM-0004cc-S2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab0LNSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:22 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52458 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753550Ab0LNSpV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:21 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsG-0006iq-YJ; Tue, 14 Dec 2010 18:45:21 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163661>


Commit c91cfd19 (tests: A SANITY test prereq for testing if we're
root, 2010-08-06) introduced a SANITY prerequisite which had very
similar semantics to RO_DIR. That commit removed the code to set
RO_DIR, but forgot to replace RO_DIR with SANITY in test #15.

In order not to skip test 15 unnecessarily, since RO_DIR will never
be set, we pass the SANITY prerequisite instead.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t3600-rm.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..cd093bd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -96,7 +96,7 @@ test_expect_success FUNNYNAMES \
     "git rm -f 'space embedded' 'tab	embedded' 'newline
 embedded'"
 
-test_expect_success RO_DIR 'Test that "git rm -f" fails if its rm fails' '
+test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	chmod a-w . &&
 	test_must_fail git rm -f baz &&
 	chmod 775 .
-- 
1.7.3
