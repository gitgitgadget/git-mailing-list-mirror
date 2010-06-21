From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] t/lib-pager.sh: remove unnecessary '^' from 'expr' regular expression
Date: Mon, 21 Jun 2010 12:37:13 -0500
Message-ID: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 21 19:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkx7-0007qr-QD
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916Ab0FURi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:38:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60802 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715Ab0FURi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:38:28 -0400
Received: by mail.nrlssc.navy.mil id o5LHbXeE008608; Mon, 21 Jun 2010 12:37:33 -0500
X-OriginalArrivalTime: 21 Jun 2010 17:37:32.0567 (UTC) FILETIME=[6DBE9A70:01CB1168]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149426>

From: Brandon Casey <drafnel@gmail.com>

Regular expressions matched by 'expr' have an implicit '^' at the beginning
of them and so are anchored to the beginning of the string.  Using the '^'
character to mean "match at the beginning", is redundant and could produce
the wrong result if 'expr' implementations interpret the '^' as a literal
'^'.  Additionally, GNU expr 5.97 complains like this:

   expr: warning: unportable BRE: `^[a-z][a-z]*$': using `^' as the first character of the basic regular expression is not portable; it is being ignored

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/lib-pager.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/lib-pager.sh b/t/lib-pager.sh
index f8c6025..ba03eab 100644
--- a/t/lib-pager.sh
+++ b/t/lib-pager.sh
@@ -9,7 +9,7 @@ test_expect_success 'determine default pager' '
 	test -n "$less"
 '
 
-if expr "$less" : '^[a-z][a-z]*$' >/dev/null
+if expr "$less" : '[a-z][a-z]*$' >/dev/null
 then
 	test_set_prereq SIMPLEPAGER
 fi
-- 
1.6.6.2
