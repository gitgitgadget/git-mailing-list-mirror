From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/5] t6040; test branch -vv
Date: Thu, 25 Aug 2011 10:30:20 +0200
Message-ID: <d55c61a6c667a8ef08c8ead8e3672050375253f9.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVKk-0008Qu-GF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab1HYIag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34595 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752879Ab1HYIad (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A219D20C58;
	Thu, 25 Aug 2011 04:30:32 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 25 Aug 2011 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=nv
	5BBAdCJrQwCTSBw1BV1iiLNzs=; b=I0v8pOncI+4zbblBLJIZg2YegeUhCYfxCg
	OR34uuIY3mQ1P2+mA+rxMr5IJMSe9yozzvWI/hJzXu1wdO7hW48VvckZy8eWWR7T
	6wYwdpZK5ZaSwhNUeG0rnkyYsJ5n/6b1BQpG/20iZUw2z8x1f5AGGljEU+uIh4SA
	WlQGhsCi0=
X-Sasl-enc: 6v4OMx8DBugHnrkHljS8xmKVg4yNeX1SVYRa6sz/Fi+s 1314261032
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1F2BE84014F;
	Thu, 25 Aug 2011 04:30:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180069>

t6040 has a test for 'git branch -v' but not for 'git branch -vv'.
Add one.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6040-tracking-info.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 19de5b1..19272bc 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -51,6 +51,22 @@ test_expect_success 'branch -v' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<\EOF
+b1 origin/master: ahead 1, behind 1
+b2 origin/master: ahead 1, behind 1
+b3 origin/master: behind 1
+b4 origin/master: ahead 2
+EOF
+
+test_expect_success 'branch -vv' '
+	(
+		cd test &&
+		git branch -vv
+	) |
+	sed -n -e "$script" >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'checkout' '
 	(
 		cd test && git checkout b1
-- 
1.7.6.845.gc3c05
