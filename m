From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/5] tag: factor out sig detection for tag display
Date: Wed, 10 Nov 2010 12:17:29 +0100
Message-ID: <fb76f7e44236f2e4ac2e4e26f1eb2128fb9943df.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8iW-00055t-CS
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab0KJLTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:32 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59989 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab0KJLT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:29 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 38DCB98C;
	Wed, 10 Nov 2010 06:19:29 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 10 Nov 2010 06:19:29 -0500
X-Sasl-enc: nUJ04u4vizwHKWqvMDa8wziytf0t+z4DW8pdBmF6jSPX 1289387968
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B08A040435A;
	Wed, 10 Nov 2010 06:19:28 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289387142.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161146>

Use the factored out code for sig detection when displaying tags.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/tag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 66feeb0..617a58f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -68,9 +68,9 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			return 0;
 		}
 		/* only take up to "lines" lines, and strip the signature */
+		size = parse_signature(buf, size);
 		for (i = 0, sp += 2;
-				i < filter->lines && sp < buf + size &&
-				prefixcmp(sp, PGP_SIGNATURE "\n");
+				i < filter->lines && sp < buf + size;
 				i++) {
 			if (i)
 				printf("\n    ");
-- 
1.7.3.2.193.g78bbb
