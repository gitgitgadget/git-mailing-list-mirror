From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] git-cherry-pick: improve description of -x.
Date: Fri, 19 Oct 2007 19:41:34 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071019174134.GD9906@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 19:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iivr4-0002Ez-QA
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763347AbXJSRlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbXJSRlh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:41:37 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:40711 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbXJSRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 13:41:36 -0400
Received: from localhost.localdomain (xdsl-87-78-67-237.netcologne.de [87.78.67.237])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 4FD0C40002C2F
	for <git@vger.kernel.org>; Fri, 19 Oct 2007 19:41:35 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Iivqo-0002as-MC
	for git@vger.kernel.org; Fri, 19 Oct 2007 19:41:34 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61737>

Reword the first sentence of the description of -x, in order to
make it easier to read and understand.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

I have two issues with "git-cherry-pick -x": When reading its manpage
description for the first time, I completely failed to understand the
first sentence, and had to try it out in order to understand.

Further, I am surprised that -x seems to be nonfunctional when the
cherry pick introduces a conflict.  Example:
  git init
  echo >dummy
  git add dummy
  git commit -m dummy
  git checkout -b br
  echo one >file
  git add file
  git commit -m one
  echo two >>file
  git commit -a -m two
  git checkout master
  git cherry-pick -x br         # conflict, tells me "-c ..." arg to use
                                # for the commit later
  echo '1d
  w' | ed file                  # resolve conflict
  git add file
  git commit -c ...

The prototype commit message now does not contain the
| (cherry picked from commit ...).

Is that by design (because there were conflicts) or an omission?
In case of the former, maybe the description of -x should mention this.

Thanks,
Ralf

 Documentation/git-cherry-pick.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 47b1e8c..c7d83ce 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -27,10 +27,10 @@ OPTIONS
 	message prior committing.
 
 -x::
-	Cause the command to append which commit was
-	cherry-picked after the original commit message when
-	making a commit.  Do not use this option if you are
-	cherry-picking from your private branch because the
+	When recording the commit, the original commit message will
+	be appended with a note that indicates which commit this
+	change was cherry-picked from.  Do not use this option if
+	you are cherry-picking from your private branch because the
 	information is useless to the recipient.  If on the
 	other hand you are cherry-picking between two publicly
 	visible branches (e.g. backporting a fix to a
-- 
1.5.3.1.153.g89df5
