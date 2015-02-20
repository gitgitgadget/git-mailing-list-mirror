From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] GSoC ideas: git bisect fixed/unfixed
Date: Fri, 20 Feb 2015 11:31:56 +0100
Message-ID: <1424428317-1682-2-git-send-email-Matthieu.Moy@imag.fr>
References: <20150220020022.GC16124@peff.net>
 <1424428317-1682-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 11:32:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOksi-0003eh-H4
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbBTKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:32:18 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47984 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbbBTKcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:32:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW23X017704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:32:02 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW3JC031732;
	Fri, 20 Feb 2015 11:32:03 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YOksN-0000TS-Pv; Fri, 20 Feb 2015 11:32:03 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <1424428317-1682-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Feb 2015 11:32:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAW23X017704
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1425033126.1708@CXZStPQy6hYgG3yFMeC6OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264155>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 SoC-2015-Ideas.md | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/SoC-2015-Ideas.md b/SoC-2015-Ideas.md
index a3e988e..4641800 100644
--- a/SoC-2015-Ideas.md
+++ b/SoC-2015-Ideas.md
@@ -34,7 +34,9 @@ should be honored without checking the ownership.  Cf. $gmane/243628
 Takes eol attributes into account to correct lossage/addition of CR at
 the end of line, with updates to "am".  Cf. $gmane/257445
 
-### "git bisect --first-parent".
+### git bisect improvements
+
+#### "git bisect --first-parent".
 
 When your project is strictly "new features are merged into trunk,
 never the other way around", it is handy to be able to first find
@@ -42,6 +44,47 @@ a merge on the trunk that merged a topic to point fingers at when
 a bug appears, instead of having to drill down to the individual
 commit on the faulty side branch.
 
+#### "git bisect fixed/unfixed"
+
+"git bisect" is initially meant to find regressions (i.e. the new code
+is bad, and the old one used to work). The opposite may happen too:
+look for the commit which fixed a bug. It is already possible using
+"git bisect", but the user has to type "good" to mean "the bug is
+there" and "bad" to mean "the bug is fixed", which isn't convenient.
+
+It would be nice to allow the user to explicitely say "git bisect
+fixed" and "git bisect unfixed" instead. It is actually much harder
+than defining "fixed"/"unfixed" as aliases for "bad"/"good".
+
+A patch for this feature was sent to the mailing list in this thread a
+few years ago by Dscho:
+http://thread.gmane.org/gmane.comp.version-control.git/86063
+
+Unfortunately there were some problems with the patch and no one tried
+to fix them. So the same problem/suggestion is often reported on the
+mailing list, for example:
+
+    http://thread.gmane.org/gmane.comp.version-control.git/165141
+    http://thread.gmane.org/gmane.comp.version-control.git/170113
+    http://thread.gmane.org/gmane.comp.version-control.git/182398 
+
+A patch series to let "old/new" be used instead of "good/bad" was
+started here:
+
+http://thread.gmane.org/gmane.comp.version-control.git/199758/focus=199869
+
+There is still work to be done to complete it.
+
+Note than another feature with the name "git bisect fix" was suggested
+to do something else:
+
+http://thread.gmane.org/gmane.comp.version-control.git/169026
+
+Since there have already been discussions and patches, the remaining
+work is probably less than a GSoC, so this project should be grouped
+with another one (like git bisect --first-parent) to make a full GSoC
+proposal.
+
 ### Unifying `git branch -l`, `git tag -l`, and `git for-each-ref`
 
 These three commands are all about selecting a subset of a repository's
-- 
2.3.0.157.g79e124b
