From: mhagger@alum.mit.edu
Subject: [RFC 07/13] one_local_ref(): use check_refname_format(..., REFNAME_FULL)
Date: Wed, 19 Oct 2011 22:55:10 +0200
Message-ID: <1319057716-28094-8-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdB4-0003da-JW
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab1JSUz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:26 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60905 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-QR; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183954>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of manually skipping over "refs/", let check_refname_format()
handle the whole refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index e52aa9b..30ee6d8 100644
--- a/remote.c
+++ b/remote.c
@@ -1595,7 +1595,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 	int len;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_refname_format(refname + 5, 0))
+	if (check_refname_format(refname, REFNAME_FULL))
 		return 0;
 
 	len = strlen(refname) + 1;
-- 
1.7.7
