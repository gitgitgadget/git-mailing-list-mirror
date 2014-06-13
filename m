From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/6] pretty: free the gpg status buf
Date: Fri, 13 Jun 2014 12:42:43 +0200
Message-ID: <3211097b9e6eb07b98d3cefdaf4eabd0d2eb55b0.1402655839.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOws-0007ft-K9
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbaFMKnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:43:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59233 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbaFMKm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:42:57 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E50FC20CE2;
	Fri, 13 Jun 2014 06:42:51 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 13 Jun 2014 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=5K
	8VcxWXTyAAGOZQ+ZgbaigcTqg=; b=uJGRp0Pc81tVYaIP0g3SjusogwtO7tlRWJ
	zyyeBekOS6aoBGrBXK2WNWM+OAh00m+hpoTROquOkcAkZcTdRSwKQDWlebnAdq0D
	OP5Z6domURcvfLuvgJQp4Ga4EZBwhLPli3h3H6qUkZKNzwcrOmZdvVhTX0Pj8I26
	fCYG3ZU6A=
X-Sasl-enc: zkaQ8douM9Q0soL0pn6wBExZX1ZpW9QFTTyUXNTbZcM1 1402656171
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7E4C368016B;
	Fri, 13 Jun 2014 06:42:51 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251541>

4a868fd (pretty: parse the gpg status lines rather than the output, 2013-02-14)
made the gpg status lines available to callers and made sure they freed
the used space, but missed one spot.

Free the status line buffer also in the remaining spot.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 pretty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pretty.c b/pretty.c
index 4f51287..f1e8a70 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1538,6 +1538,7 @@ void format_commit_message(const struct commit *commit,
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
 	free(context.signature_check.gpg_output);
+	free(context.signature_check.gpg_status);
 	free(context.signature_check.signer);
 }
 
-- 
2.0.0.426.g37dbf84
