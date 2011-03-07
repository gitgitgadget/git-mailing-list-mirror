From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/9] rev-list: --left/right-only are mutually exclusive
Date: Mon,  7 Mar 2011 13:31:38 +0100
Message-ID: <24852d917104e294726c54803d5c9012997506ca.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf5-0003Ub-1m
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab1CGMf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35185 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751701Ab1CGMfT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:19 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CE60B20829;
	Mon,  7 Mar 2011 07:35:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 07 Mar 2011 07:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=7I/ZM04aG2EqHX9FRFjFshpvbAM=; b=UZxr74pmcqP64RUh7C/eXE65Xy6623pWaXzNVTgJeZsQwegoPfCs1IH7gmSKD45y8UoXUr7GFMkRcA49fHg7XjuE7fk00KKEGSmZqkZrDXTHhhEOcvS9PYuu1WoBUcTKcpH0ITcS/jKdB4McmsCQs/CO7oGAmMg/YiF64Z2mbZ0=
X-Sasl-enc: J8e2J2O21g92/l4DsjthDwcP/NRazGwqRt/urpM2HHeX 1299501318
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4DFA2402397;
	Mon,  7 Mar 2011 07:35:18 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168586>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 0681c7c..1fcaeb7 100644
--- a/revision.c
+++ b/revision.c
@@ -1284,8 +1284,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--left-right")) {
 		revs->left_right = 1;
 	} else if (!strcmp(arg, "--left-only")) {
+		if (revs->right_only)
+			die("--left-only is incompatible with --right-only");
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
+		if (revs->left_only)
+			die("--right-only is incompatible with --left-only");
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
-- 
1.7.4.1.299.g567d7.dirty
