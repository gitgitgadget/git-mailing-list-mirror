From: Johannes Sixt <j.sixt@viscovery.net>
Subject: t6200: avoid path mangling issue on Windows
Date: Thu, 18 Apr 2013 08:42:25 +0200
Message-ID: <516F95D1.5070209@viscovery.net>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com> <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 08:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USiYE-0000FQ-N8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab3DRGma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:42:30 -0400
Received: from so.liwest.at ([212.33.55.23]:30708 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab3DRGma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:42:30 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1USiY6-000735-9t; Thu, 18 Apr 2013 08:42:26 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 102EF1660F;
	Thu, 18 Apr 2013 08:42:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221614>

From: Johannes Sixt <j6t@kdbg.org>

MSYS bash interprets the slash in the argument core.commentchar="/"
as root directory and mangles it into a Windows style path. Use a
different core.commentchar to dodge the issue.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6200-fmt-merge-msg.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index e7e945d..54b5744 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -179,8 +179,8 @@ test_expect_success '--log=5 with custom comment character' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
-	/ By Another Author (3) and A U Thor (2)
-	/ Via Another Committer
+	x By Another Author (3) and A U Thor (2)
+	x Via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -189,7 +189,7 @@ test_expect_success '--log=5 with custom comment character' '
 	  Common #1
 	EOF
 
-	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
+	git -c core.commentchar="x" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
-- 
1.8.2.1.1678.gf713add
