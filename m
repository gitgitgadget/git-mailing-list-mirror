From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] unpack-trees: print "Aborting" to stderr
Date: Wed, 21 Sep 2011 09:48:36 +0200
Message-ID: <8b522de3711f339eea264dd7d8e44682af6c4865.1316590874.git.git@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 09:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HY5-0000EA-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1IUHsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:48:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37472 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1IUHso (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:48:44 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id A0BE328FC2;
	Wed, 21 Sep 2011 03:48:43 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2011 03:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=aw
	CVBL62RcngFNRKIMlcEGLdZio=; b=biFjvPhyRqQ5SEJIRuJ73vZxAme662lG8K
	WQTRkEwcU0afpDYEYhsJlkwUsZEGDh82t2/x6wGnfH+vRmXa6/+1AKFfDNHPRslT
	BezF+KCVV7lq6yiTMnZoSYd4QIp0BnLfy/vzgf7oKNGMCtdFp9bi7RZe7HA1eWKC
	WRgO0cj2s=
X-Sasl-enc: RnpxSGmQpz3Nc4PtRhWf0wbfEOvdSjk0AjzJeGrsdTyQ 1316591323
Received: from localhost (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0572D7C0651;
	Wed, 21 Sep 2011 03:48:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E7996AA.4040909@drmicha.warpmail.net>
In-Reply-To: <cover.1316590874.git.git@drmicha.warpmail.net>
References: <cover.1316590874.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181824>

display_error_msgs() prints all the errors to stderr already (if any),
followed by "Aborting" (if any) to stdout. Make the latter go to stderr
instead.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 670b464..237aed8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -159,7 +159,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		string_list_clear(rejects, 0);
 	}
 	if (something_displayed)
-		printf("Aborting\n");
+		fprintf(stderr, "Aborting\n");
 }
 
 /*
-- 
1.7.7.rc0.469.g9eb94
