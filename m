From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH RFC] for-each-ref: Field with abbreviated objectname
Date: Mon,  3 May 2010 22:25:19 +0200
Message-ID: <61d114759b023b3937f8417ce44c3361f345c6f1.1272918259.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 22:25:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92D1-0000px-6J
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 22:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab0ECUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 16:25:35 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54271 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756729Ab0ECUZe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 16:25:34 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F89AF4655;
	Mon,  3 May 2010 16:25:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 03 May 2010 16:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=atek7/+EqhgcOR2A2qSOlUqdvVI=; b=cqVkKipvocGamYJOl0pKzYv4DY7zNHd1rrEoEmFGZ5Td1caq/NcKGd2ymCXaaQDZUrp7XjU+SquvItPljs0S43RqvozM+4mophMmoXNK2aXK6JVsR1Zwmb8KcjwcUpUPcOxPMGjXH1ZhRy0xYZw6ll+KwkbPiGTW9Gj+BRMKUiM=
X-Sasl-enc: zUtmr3P7jRVeuQ3O2MLWPxTKP38gy6IqkWnxjwiQDlCN 1272918319
Received: from localhost (p5DCC068A.dip0.t-ipconnect.de [93.204.6.138])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 65F94437AB;
	Mon,  3 May 2010 16:25:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.328.g9993c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146253>

Introduce a :short modifier to objectname which outputs the abbreviated
object name.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    I hope this finds the favour of the for-each-ref-man.
    
    TODO: test, doc

 builtin/for-each-ref.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 62be1bb..3a97953 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -227,6 +227,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			strcpy(s, sha1_to_hex(obj->sha1));
 			v->s = s;
 		}
+		else if (!strcmp(name, "objectname:short")) {
+			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
+		}
 	}
 }
 
-- 
1.7.1.328.g9993c
