From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rev-list: heed --abbrev-commit option
Date: Mon, 22 Mar 2010 14:36:30 +0100
Message-ID: <b1b0f22cf3dc6d67f6094e761a1b7402b1471e97.1269264868.git.git@drmicha.warpmail.net>
References: <4BA76BDF.6060106@drmicha.warpmail.net>
Cc: Eli Barzilay <eli@barzilay.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 14:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nthqn-00043m-Ql
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 14:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab0CVNjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 09:39:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60324 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483Ab0CVNjT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 09:39:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2191DE9F96;
	Mon, 22 Mar 2010 09:39:19 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 22 Mar 2010 09:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=gvSfrjuCydyvbrKMNedNL2Mrc7M=; b=EjC/pZrtmIxIHDvGhJlWQUzmy1P2VOeiozqEXqU96xOjgHKRNsyndOEaDZCz+YGRJNM0PNv7kk2dM7OZ81awlloL7RVTt1XBTxmFEmhHauy6Y3uCkibyvRdmFunnI2BbQX58f5NPl2TDq6KsncWDiGDbW/gpilvFu10X1s/SJcU=
X-Sasl-enc: Ax2QdQj5A0AQk6Y5zQcJrphlc5lhwZAziiy9RAusRHG6 1269265158
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 80E444D09F3;
	Mon, 22 Mar 2010 09:39:18 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.435.g097f4
In-Reply-To: <4BA76BDF.6060106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142930>

Currently, rev-list has a default of "0" for abbrev which means that
switching on abbreviations with --abbrev-commit has no visible effect,
even though the option is documented.

Set abbrev to DEFAULT_ABBREV so that --abbrev-commit has the same effect
as for log.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Reported-by: Eli Barzilay <eli@barzilay.org>
---
I'm actually wondering why log and rev-list don't share the relevant
part of that code.

 builtin/rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5679170..eb8e2c2 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -313,7 +313,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
-	revs.abbrev = 0;
+	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
-- 
1.7.0.3.435.g097f4
