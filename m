From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 amend] Documentation: bisect: add a few "git bisect run"
 examples
Date: Wed, 7 May 2008 07:34:30 +0200
Message-ID: <20080507073430.14ab87c3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff
X-From: git-owner@vger.kernel.org Wed May 07 07:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtcEm-0002RZ-4l
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 07:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYEGF3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 01:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbYEGF3k
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 01:29:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55661 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbYEGF3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 01:29:38 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9EDC51AB2C9;
	Wed,  7 May 2008 07:29:37 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0453A1AB2BC;
	Wed,  7 May 2008 07:29:36 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81406>

Before this patch, there were no "git bisect run" example.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

	Junio wrote:
	> As if there were improper examples, and as if this patch adds a proper
	> one.  Drop "proper" and add sign-off perhaps?  ;-)

	> s/install//; let's not set a bad example of installing first and then
	> testing.

	All the above should be fixed in this amended patch.
	Thanks.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 698ffde..f9b564c 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -224,6 +224,32 @@ tree to the pristine state.  Finally the "run" script can exit with
 the status of the real test to let "git bisect run" command loop to
 know the outcome.
 
+EXAMPLES
+--------
+
+* Automatically bisect a broken build between v1.2 and HEAD:
++
+------------
+$ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
+$ git bisect run make                # "make" builds the app
+------------
+
+* Automatically bisect a broken test case using a custom script:
++
+------------
+echo "#"\!"/bin/sh" > ~/test.sh
+echo "make || exit 125" >> ~/test.sh
+echo "~/check_test_case.sh" >> ~/test.sh
+chmod u+x ~/test.sh
+$ git bisect start v1.3 v1.1 --      # v1.3 is bad, v1.1 is good
+$ git bisect run ~/test.sh
+------------
++
+Here we first create the "test.sh" custom script. In this script, if
+"make" fails, we "skip" the current commit.
+And "check_test_case.sh" should "exit 0", if the test case passes, and
+"exit 1" (for example) otherwise.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.5.5.1.126.g9ca01
