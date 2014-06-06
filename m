From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3]  verify-commit: verify commit signatures
Date: Fri,  6 Jun 2014 16:15:25 +0200
Message-ID: <cover.1402063795.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsuvl-0004CZ-5m
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbaFFOPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:15:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58673 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751601AbaFFOPc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2014 10:15:32 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AF2E9217DD
	for <git@vger.kernel.org>; Fri,  6 Jun 2014 10:15:30 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 06 Jun 2014 10:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=m6mvc+Jg3TsNWP9TY2wgeIOB2Wo=; b=aIZYmOiW8zY3e1KB22P2
	kQi8VWPl1I5oyivknLOmCk70zs9nLNzjSHJ0vRUuDxU8Roqovacd4Y0UKmd0BU5s
	hftL4xk9XU5c9sZ2513tIHkTH7btAjIcHrzUMqQlzNRXJX3QJR5OwYWeKZ/5Gi1R
	pBKYwIDjFdguxGMWbr+95sE=
X-Sasl-enc: zt1BlOMVA5GWlOHREfQ1A58i5wXgyYtCkkqa5oqUG1pP 1402064130
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 48701C00003;
	Fri,  6 Jun 2014 10:15:30 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.533.gae2e602
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250915>

Hi there,

Some of you may remember me from my more active times...

Anyways, a recent blog post about signed commits in git triggered me to
look at our tools for that again. It seems that we only have the
log/pretty family on the user facing side, but everything we need under
the hood.

So here's a suggestion to implement verify-commit in a way which is
completely analogous to verify-tag. In fact, it could be coded more
elegantly, but I kept it this way so that we could merge the two more
easily in case we wish to do so.

I will follow up with tests if the design principle is something we agree
upon.

Michael J Gruber (3):
  pretty: free the gpg status buf
  gpg-interface: provide access to the payload
  verify-commit: scriptable commit signature verification

 Documentation/git-verify-commit.txt | 28 +++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/merge.c                     |  1 +
 builtin/verify-commit.c             | 98 +++++++++++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 commit.c                            |  1 +
 git.c                               |  1 +
 gpg-interface.h                     |  1 +
 pretty.c                            |  2 +
 10 files changed, 135 insertions(+)
 create mode 100644 Documentation/git-verify-commit.txt
 create mode 100644 builtin/verify-commit.c

-- 
2.0.0.533.gae2e602
