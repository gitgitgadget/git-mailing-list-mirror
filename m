From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] Added documentation for custom merge tool functionality
Date: Sat, 8 Mar 2008 20:47:06 +0000
Message-ID: <c869f1c4783c79dabb1fc3a9d19df64e08acbf8c.1205008859.git.charles@hashpling.org>
References: <b4c3c2a6ee8fbc73d9c4f4582cc9c4ae6e58b15e.1205008859.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 21:48:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5xa-0008Tz-GD
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYCHUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYCHUrR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:47:17 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:38965 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYCHUrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:47:16 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JY5wo-0002Sn-2X; Sat, 08 Mar 2008 20:47:14 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m28Kl7vA020074;
	Sat, 8 Mar 2008 20:47:07 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m28Kl7UG020073;
	Sat, 8 Mar 2008 20:47:07 GMT
Content-Disposition: inline
In-Reply-To: <b4c3c2a6ee8fbc73d9c4f4582cc9c4ae6e58b15e.1205008859.git.charles@hashpling.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 66e94c042ccae53324aae1a4d0899a1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76583>

Up until now, the configuration variables for custom merge tools were
documented in config.txt but there was no reference to the functionality
in git-mergetool.txt.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/git-mergetool.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index ac8969c..1af401c 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -24,7 +24,7 @@ OPTIONS
 -------
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
-	Valid merge tools are:
+	Valid built-in merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
 +
 If a merge resolution program is not specified, `git mergetool`
@@ -37,6 +37,28 @@ configuration variable `mergetool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
 `mergetool.kdiff3.path`. Otherwise, `git mergetool` assumes the
 tool is available in PATH.
++
+As an alternative to running one of the known merge tool programs
+`git mergetool` can be customized to run an alternative program
+by specifying the command line to invoke in a configration
+variable `mergetool.<tool>.cmd`.
++
+When `git mergetool` is invoked with this tool (either through the
+`-t` or `--tool` option or the `merge.tool` configuration
+variable) the configured command line will be invoked with `$BASE`
+set to the name of a temporary file containing the common base for
+the merge, if available; `$LOCAL` set to the name of a temporary
+file containing the contents of the file on the current branch;
+`$REMOTE` set to the name of a temporary file containing the
+contents of the file to be merged, and `$MERGED` set to the name
+of the file to which the merge tool should write the result of the
+merge resolution.
++
+If the custom merge tool correctly indicates the success of a
+merge resolution with its exit code then the configuration
+variable `mergetool.<tool>.trustExitCode` can be set to `true`.
+Otherwise, `git mergetool` will prompt the user to indicate the
+success of the resolution after the custom tool has exited.
 
 Author
 ------
-- 
1.5.4.3.432.g5ecfc

