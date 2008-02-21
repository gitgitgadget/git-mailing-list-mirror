From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] diff: fix java funcname pattern for solaris
Date: Wed, 20 Feb 2008 19:01:16 -0500
Message-ID: <20080221000115.GC6429@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:02:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRysw-0001pV-Gq
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764021AbYBUABT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763404AbYBUABT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:01:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3741 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762091AbYBUABS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:01:18 -0500
Received: (qmail 9422 invoked by uid 111); 21 Feb 2008 00:01:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 19:01:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 19:01:16 -0500
Content-Disposition: inline
In-Reply-To: <20080220235944.GA6278@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74577>

The Solaris regex library doesn't like having the '$' anchor
inside capture parentheses. It rejects the match, causing
t4018 to fail.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 58fe775..0f18ee9 100644
--- a/diff.c
+++ b/diff.c
@@ -1199,7 +1199,7 @@ static struct builtin_funcname_pattern {
 			"new\\|return\\|switch\\|throw\\|while\\)\n"
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
-			"[ 	]*([^;]*$\\)" },
+			"[ 	]*([^;]*\\)$" },
 	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
 };
 
-- 
1.5.4.2.247.g107bd
