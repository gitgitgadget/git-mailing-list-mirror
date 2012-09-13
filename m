From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/6] rev-list/log: document logic with several limiting options
Date: Thu, 13 Sep 2012 16:04:38 +0200
Message-ID: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2L-0006kX-4g
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab2IMOEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56519 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752228Ab2IMOEq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:46 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0F156208E9;
	Thu, 13 Sep 2012 10:04:46 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 13 Sep 2012 10:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=II5c/DlOjPr6jHxoZ90wOfVY+
	+o=; b=HcGEedOyZtpTXibcc0Kh0W7j2PKeG59z1gDs2RKlxEKTmvIUt5DAulj/B
	XNRoHxC6HSDndL6WpGJsVnC2ZFbjvggqyTCITJD4v4x51u+C7Mp9MOTvrJ0RYgEY
	KoxvEG+cPf8+SfTXfPdYUyu28KITyzl+k4HzJ27SKbo1P1t3rc=
X-Sasl-enc: uVpthbojXaT/k8E2jd8F5VnML9q4HSPV1La72Gv5KgDM 1347545085
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A2D7B4825A8;
	Thu, 13 Sep 2012 10:04:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205374>

So, this turned out to be a bit longer.
I decided not to implement "--debug" for "git log --grep" and such
because the current code does a lot of special casing, so that the
existing debug code happily outputs OR nodes in cases where the code
in grep.c effectively does AND (without changing the expression nodes).

So, this series sets up a few more tests to prove to myself that I'm not
completely off in my understanding of the limiting options, and to make
me confident enough for the documentation patch 6/6 (v2 of the old 1/1).

5/6 documents (by a test) an issue which I consider a (now) known failure:
'git log --all-match --author=me --grep=foo --grep=bar' does not AND the
greps (whereas it does without --author). I don't describe this corner
case in the doc patch.

Michael J Gruber (6):
  t7810-grep: bring log --grep tests in common form
  t7810-grep: test multiple --grep with and without --all-match
  t7810-grep: test multiple --author with --all-match
  t7810-grep: test interaction of multiple --grep and --author options
  t7810-grep: test --all-match with multiple --grep and --author
    options
  rev-list/log: document logic with several limiting options

 Documentation/rev-list-options.txt | 15 ++++++-
 t/t7810-grep.sh                    | 90 ++++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 15 deletions(-)

-- 
1.7.12.463.gbd9d638
