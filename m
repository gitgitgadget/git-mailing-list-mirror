From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] log: correctly identify mergetag signature verification status
Date: Fri, 27 Jun 2014 15:18:36 +0200
Message-ID: <41f5b516d13fd02408f66ee38704a6c1bb09cbb3.1403875032.git.git@drmicha.warpmail.net>
References: <53AD6C6E.1080208@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 15:18:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0W39-00074w-K7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 15:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbaF0NSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 09:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37689 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752822AbaF0NSj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 09:18:39 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5B4332169A
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 09:18:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Jun 2014 09:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=ZwE/6pPEuyKtogHFJrdqM2x1A
	1Y=; b=U1GsKqc2NDr02KjMmluptTDtQRSVyHrku215teeTHvBFLX3TSlOgeD3QO
	iWlT/VL7kUWQaNLNxbMh7si80z/vEUfweiEpahaUP109WNEseE3FO5r57S7e3BQ4
	nUx96vd3ziYUKTPUcdUswGPV3H8+BP8FYba2sbBPcR0Tb3YSeY=
X-Sasl-enc: RYMx9SZ4OrtgHBGhwz3VromS4RarmC7L9OKEpEqNDGBT 1403875117
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EF477C00003;
	Fri, 27 Jun 2014 09:18:37 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.563.g162087b.dirty
In-Reply-To: <53AD6C6E.1080208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252550>

A wrong '}' made our code record the results of mergetag signature
verification incorrectly.

Fix it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is the "color fix"...

 log-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 10e6844..fdea358 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -453,9 +453,9 @@ static void show_one_mergetag(struct rev_info *opt,
 					 &verify_message, NULL)) {
 			if (verify_message.len <= gpg_message_offset)
 				strbuf_addstr(&verify_message, "No signature\n");
-			else
-				status = 0;
 		}
+		else
+			status = 0;
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
-- 
2.0.1.563.g162087b.dirty
