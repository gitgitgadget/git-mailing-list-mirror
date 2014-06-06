From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] pretty: free the gpg status buf
Date: Fri,  6 Jun 2014 16:15:26 +0200
Message-ID: <a4509bc715843834b9943640f83926a157327c2a.1402063796.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsuvl-0004CZ-MD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaFFOPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:15:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46747 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174AbaFFOPc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2014 10:15:32 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 79E002194F
	for <git@vger.kernel.org>; Fri,  6 Jun 2014 10:15:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 06 Jun 2014 10:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=xxlfj3RzzBHVGTfXEoYNcRYl0
	wU=; b=mbCBKWhSrglaZCSYO1tdbAoxtsnmufc5SXHh0O0RQ61F5rbdceeXHY47r
	29w9bGSoRaYacjwqxv8urcwx03b2Jf18GxEfrSf5UueagKnJtDqi4+HG+DGIseDs
	GlJ747PwslSajJA8BoCmZlnOkGyxuz57e+qRDBgJ6WCwE0xBPI=
X-Sasl-enc: 5w2KxE2zpbPybod2KMaL0ChyBmx69oEN0Euks2Ba4Nu+ 1402064132
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 201C968013E;
	Fri,  6 Jun 2014 10:15:31 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.533.gae2e602
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250916>

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
2.0.0.533.gae2e602
