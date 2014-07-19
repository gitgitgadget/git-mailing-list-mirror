From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] mergetool: don't require a work tree for --tool-help
Date: Sat, 19 Jul 2014 17:35:16 +0100
Message-ID: <1405787717-30476-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8XeK-0001x1-4F
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 18:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbaGSQiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 12:38:12 -0400
Received: from avasout05.plus.net ([84.93.230.250]:36766 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbaGSQiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 12:38:12 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id UGe91o0042iA9hg01GeAlK; Sat, 19 Jul 2014 17:38:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=DIIB4k9b c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=-CTs9-ESCwAA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=CwKZp920ywpLzcFawDMA:9 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X8XbR-0007xp-CS; Sat, 19 Jul 2014 17:35:17 +0100
X-Mailer: git-send-email 2.0.2.611.g8c85416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253895>

From: Charles Bailey <cbailey32@bloomberg.net>

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
You can call git difftool --tool-help outside of a work tree but not
mergetool --tool-help but there's not real reason for this restriction
and it can be easily relaxed by deferring the require_work_tree call
until after the options have been parsed.

 git-mergetool.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9a046b7..e969dd0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -14,7 +14,6 @@ OPTIONS_SPEC=
 TOOL_MODE=merge
 . git-sh-setup
 . git-mergetool--lib
-require_work_tree
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -372,6 +371,8 @@ prompt_after_failed_merge () {
 	done
 }
 
+require_work_tree
+
 if test -z "$merge_tool"
 then
 	# Check if a merge tool has been configured
-- 
2.0.2.611.g8c85416
