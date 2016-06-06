From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH V2 2/3] pretty.c: rename strbuf_wrap() function
Date: Mon,  6 Jun 2016 17:13:39 +0200
Message-ID: <20160606151340.22424-3-william.duclot@ensimag.grenoble-inp.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wEq-0008Rd-3C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbcFFPOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:14:32 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:36931 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184AbcFFPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 11:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 645D620AE;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIbbIXaho0_Y; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4BB3D20A5;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 48A0D2066;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hckjFVKSEY1f; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-032048.grenet.fr [130.190.32.48])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 29DEB2077;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc1.1.geac644e
In-Reply-To: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296519>

The function strbuf_wrap() is not part of the strbuf API, yet prevent to
extend the API to include wrapping functions. Renaming it to something
more specific allow to use "strbuf_wrap" for the strbut API.

Signed-off-by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Signed-off-by: Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 pretty.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 87c4497..2b9e89a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -904,8 +904,8 @@ static void parse_commit_message(struct format_commit_context *c)
 	c->commit_message_parsed = 1;
 }
 
-static void strbuf_wrap(struct strbuf *sb, size_t pos,
-			size_t width, size_t indent1, size_t indent2)
+static void strbuf_wrap_message(struct strbuf *sb, size_t pos,
+				size_t width, size_t indent1, size_t indent2)
 {
 	struct strbuf tmp = STRBUF_INIT;
 
@@ -926,7 +926,8 @@ static void rewrap_message_tail(struct strbuf *sb,
 	    c->indent2 == new_indent2)
 		return;
 	if (c->wrap_start < sb->len)
-		strbuf_wrap(sb, c->wrap_start, c->width, c->indent1, c->indent2);
+		strbuf_wrap_message(sb, c->wrap_start, c->width, c->indent1,
+				    c->indent2);
 	c->wrap_start = sb->len;
 	c->width = new_width;
 	c->indent1 = new_indent1;
-- 
2.9.0.rc1.1.geac644e
