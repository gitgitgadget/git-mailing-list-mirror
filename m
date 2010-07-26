From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Clarify help message when no remote is specified in fetch/pull.
Date: Mon, 26 Jul 2010 18:32:09 +0200
Message-ID: <1280161929-18620-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 26 19:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdR9W-0002VX-LH
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0GZRHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 13:07:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35620 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144Ab0GZRHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:07:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6QGUXJe022193
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 18:30:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdQb7-0001Bt-G8; Mon, 26 Jul 2010 18:32:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdQb7-0004rU-Cs; Mon, 26 Jul 2010 18:32:13 +0200
X-Mailer: git-send-email 1.7.2.19.g9a302.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Jul 2010 18:30:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QGUXJe022193
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280766636.88609@dH/EHs/OQhCbqOWD8ofYlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151858>

The message is especially confusing when "git fetch" is ran from "git
pull", for users not aware of "git fetch". The new message makes it clear
that "fetch" means "fetch new revisions", and gives hint on the solution.

We don't add a advice.* configuration option since this message doesn't
appear in normal use, and shouldn't disturb advanced users.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I already gave this a try a long time ago:

  http://thread.gmane.org/gmane.comp.version-control.git/143229/focus=143404

This version should fix the drawbacks mentionned by Junio.

 builtin/fetch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6eb1dfe..1b67f5f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -845,7 +845,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	int exit_code;
 
 	if (!remote)
-		die("Where do you want to fetch from today?");
+		die("No remote repository specified.  Please, specify either a URL or a\n"
+		    "remote name from which new revisions should be fetched.");
 
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
-- 
1.7.2.19.g9a302.dirty
