From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] t/t4018: test whether the word_regex patterns compile
Date: Thu,  9 Sep 2010 14:02:47 -0500
Message-ID: <rRj7JpFIk_D_n7-wGkkucC32o5VKAledjObzc1bFHX8SBUchsp6UDflVKjnjY9xKm9Q48ir5iu8@cipher.nrlssc.navy.mil>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 21:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmOw-0008CF-02
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119Ab0IITDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:03:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54206 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0IITDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:03:06 -0400
Received: by mail.nrlssc.navy.mil id o89J33eI001978; Thu, 9 Sep 2010 14:03:03 -0500
In-Reply-To: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Sep 2010 19:03:03.0059 (UTC) FILETIME=[A0CD8E30:01CB5051]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155881>

From: Brandon Casey <drafnel@gmail.com>

Previously (e3bf5e43), a test was added to test whether the builtin
xfuncname regular expressions could be compiled without error by regcomp.
Let's do the same for the word_regex patterns.  This should help catch any
cross-platform incompatibilities that exist between the pattern creator's
system and the various platforms that the test suite is commonly run on.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4018-diff-funcname.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 61de8a2..620cd02 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -40,6 +40,11 @@ do
 		! ( git diff --no-index Beer.java Beer-correct.java 2>&1 |
 			grep "fatal" > /dev/null )
 	'
+	test_expect_success "builtin $p wordRegex pattern compiles" '
+		! ( git diff --no-index --word-diff \
+			Beer.java Beer-correct.java 2>&1 |
+			grep "fatal" > /dev/null )
+	'
 done
 
 test_expect_success 'default behaviour' '
-- 
1.7.2.1
