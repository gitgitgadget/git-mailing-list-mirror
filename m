From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] git-bisect.txt: streamline run presentation
Date: Tue, 15 Mar 2011 22:24:55 +0100
Message-ID: <57605e2f4533a3c656d24f3a7ec6264e0bd949fe.1300224056.git.git@drmicha.warpmail.net>
References: <7vy64hehbh.fsf@alter.siamese.dyndns.org>
Cc: Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 22:25:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzbjr-0006K3-1U
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 22:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636Ab1COVZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 17:25:01 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39424 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841Ab1COVZA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 17:25:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7FC9420662;
	Tue, 15 Mar 2011 17:24:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 15 Mar 2011 17:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=TeTk1MTjYeWIHCCTl6p9f9knO1Q=; b=J3alWEA3/1e9zVqqz+LlQhq+Fo95aHtllYJFCUukQ9jgHPdVfz+pdi+UtyKiPBeIRN4OGssM/SbRYxJOrrCGdhpQp9wr2hCtSTp6r8nZag3gGx8ihcfLYuF2DBOnGft6JU8WJ6gGwAJJ7QBGGU9QWNXgZXmZerDuZfyzNaGJyCQ=
X-Sasl-enc: yqmfWx8ZaRa32vMqK2IJthpqdFo6bvBcLsXYCJ8isNRd 1300224298
Received: from localhost (p54859037.dip0.t-ipconnect.de [84.133.144.55])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E39744CCF7;
	Tue, 15 Mar 2011 17:24:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
In-Reply-To: <7vy64hehbh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169091>

Streamline the presentation of "bisect run" by removing one example
which does not introduce new concepts.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bisect.txt |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c39d957..47e8b1e 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -274,53 +274,35 @@ $ git bisect start HEAD origin --    # HEAD is bad, origin is good
 $ git bisect run make test           # "make test" builds and tests
 ------------
 
-* Automatically bisect a broken test suite:
-+
-------------
-$ cat ~/test.sh
-#!/bin/sh
-make || exit 125                   # this skips broken builds
-make test                          # "make test" runs the test suite
-$ git bisect start v1.3 v1.1 --    # v1.3 is bad, v1.1 is good
-$ git bisect run ~/test.sh
-------------
-+
-Here we use a "test.sh" custom script. In this script, if "make"
-fails, we skip the current commit.
-+
-It is safer to use a custom script outside the repository to prevent
-interactions between the bisect, make and test processes and the
-script.
-+
-"make test" should "exit 0", if the test suite passes, and
-"exit 1" otherwise.
-
 * Automatically bisect a broken test case:
 +
 ------------
 $ cat ~/test.sh
 #!/bin/sh
 make || exit 125                     # this skips broken builds
-~/check_test_case.sh                 # does the test case passes ?
+~/check_test_case.sh                 # does the test case pass?
 $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
 $ git bisect run ~/test.sh
 ------------
 +
-Here "check_test_case.sh" should "exit 0" if the test case passes,
+Here we use a "test.sh" custom script. In this script, if "make"
+fails, we skip the current commit.
+"check_test_case.sh" should "exit 0" if the test case passes,
 and "exit 1" otherwise.
 +
-It is safer if both "test.sh" and "check_test_case.sh" scripts are
+It is safer if both "test.sh" and "check_test_case.sh" are
 outside the repository to prevent interactions between the bisect,
 make and test processes and the scripts.
 
-* Automatically bisect a broken test suite:
+* Automatically bisect a broken test case:
 +
 ------------
 $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
 $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 ------------
 +
-Does the same as the previous example, but on a single line.
+This shows that you can do without a run script if you write the test
+on a single line.
 
 Author
 ------
-- 
1.7.4.1.404.g62d316
