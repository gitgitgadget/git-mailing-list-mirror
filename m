From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] Allow running the test suite against installed git
Date: Mon, 16 Mar 2009 18:03:10 +0100
Message-ID: <1237222992-19421-1-git-send-email-git@drmicha.warpmail.net>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 18:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGFH-0007qy-EC
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbZCPRD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbZCPRD3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:03:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42343 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753247AbZCPRD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 13:03:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id C5BED2F0F09;
	Mon, 16 Mar 2009 13:03:26 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 16 Mar 2009 13:03:26 -0400
X-Sasl-enc: XbeCJMD9xgBGI6npxtl9HbVZUcOHw3Q30c1Fw3lYiGKC 1237223006
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 229BE12A89;
	Mon, 16 Mar 2009 13:03:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113347>

Part 1 corrects only an inconsistency which does not matter as long as
you run tests against git compiled in a checkout only: There,
$GIT_EXEC_PATH contains git, in general it does not.

Part 2 allows running the test suite against a git installed anywhere in
the file system. This has at least 2 use cases:
- Test an installed distro package after the installation.
- Run easily current tests against older versions, or vice versa, if you
  have those versions installed somewhere.

Note that one still needs git compiled in git.git for test helpers etc.,
and also because I did not adjust the paths to templates and such. I did
not really feel a need for that.

Also, in t0000 there is still one explicit use of "../git" which is fine
because it simply tests for the presence of a build, which we need
anyways.

v2 incorporates feed-back by JCH: variables are named GIT_TEST_INSTALLED
and GIT_TEST_EXEC_PATH now, the latter defaulting to the output of
$GIT_TEST_INSTALLED/git --exec-path.

Also, we exit gracefully in case we cannot run $GIT_TEST_INSTALLED/git.

Michael J Gruber (2):
  test-lib.sh: Test for presence of git-init in the right path.
  test-lib.sh: Allow running the test suite against installed git

 t/test-lib.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)
