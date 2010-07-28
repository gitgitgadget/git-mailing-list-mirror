From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B, -M and -C
Date: Wed, 28 Jul 2010 11:43:59 +0200
Message-ID: <1280310239-16897-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3CP-0007YO-Vr
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0G1JpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:45:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60865 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab0G1JpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:45:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9gFLB010454
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:42:15 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe3BA-0000Oc-Ob; Wed, 28 Jul 2010 11:44:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe3BA-0004PE-NU; Wed, 28 Jul 2010 11:44:00 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 11:42:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6S9gFLB010454
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280914940.08145@App+juzpyKNfcLIx86Ydsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152064>

These options take an optional argument, but this optional argument was
not documented.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm not really happy with my description of -Bn/m, which I essentially
took from eeaa46031479 (Junio, Jun 3 2005, diff: Update -B
heuristics). Someone with better understanding of how it works can
probably propose something better.

 Documentation/diff-options.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2371262..d07809c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -206,10 +206,18 @@ endif::git-format-patch[]
 	the diff-patch output format.  Non default number of
 	digits can be specified with `--abbrev=<n>`.
 
--B::
+-B[<n>]::
+-B<n>/<m>::
 	Break complete rewrite changes into pairs of delete and create.
-
--M::
+	If `n` is specified, it gives the threshold (as a percentage
+	of changed lines) above which a change is considered as
+	complete rewrite.  For example, `-B90%` means git will detect a
+	rewrite if more than 90% of the lines have been modified.  If
+	`m` is specified, then it is the minimum amount of deleted
+	lines a surviving broken pair must have to avoid being merged
+	back together.  See linkgit:gitdiffcore[7] for more details.
+
+-M[<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -218,9 +226,11 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
+	If `n` is specified, it has the same meaning as for `-B<n>`.
 
--C::
+-C[<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
+	If `n` is specified, it has the same meaning as for `-B<n>`.
 
 ifndef::git-format-patch[]
 --diff-filter=[ACDMRTUXB*]::
-- 
1.7.2.25.g9ebe3
