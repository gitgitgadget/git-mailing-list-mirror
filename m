From: Rene Bredlau <git@unrelated.de>
Subject: [PATCH] http.c: Avoid username prompt for certifcate credentials
Date: Fri, 21 Dec 2012 17:31:19 +0100
Message-ID: <1356107479-6668-1-git-send-email-git@unrelated.de>
Cc: peff@peff.net, gitster@pobox.com, Rene Bredlau <git@unrelated.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 18:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6dq-0004ve-JI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2LURn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:43:57 -0500
Received: from mailhub.rhein-zeitung.de ([212.7.160.30]:40678 "EHLO
	mailhub.rhein-zeitung.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2LURn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:43:56 -0500
X-Greylist: delayed 4297 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2012 12:43:54 EST
Received: from mailhub.rhein-zeitung.de (localhost.localdomain [127.0.0.1])
	by mailhub.rhein-zeitung.de (8.12.8/8.12.8) with ESMTP id qBLGW5qe006398;
	Fri, 21 Dec 2012 17:32:05 +0100
Received: (from uucp@localhost)
	by mailhub.rhein-zeitung.de (8.12.8/8.12.8/Submit) with UUCP id qBLGW5Ah006396;
	Fri, 21 Dec 2012 17:32:05 +0100
Received: from localhost.localdomain (nb-syngeni230.fritz.box [192.168.1.29])
	by blubber.de (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id qBLGVXQG020488;
	Fri, 21 Dec 2012 17:31:33 +0100
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211991>

If sslCertPasswordProtected is set to true do not ask for username to decrypt rsa key. This question is pointless, the key is only protected by a password. Internaly the username is simply set to "".

Signed-off-by: Rene Bredlau <git@unrelated.de>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 0a8abf3..44f3525 100644
--- a/http.c
+++ b/http.c
@@ -236,6 +236,7 @@ static int has_cert_password(void)
 		return 0;
 	if (!cert_auth.password) {
 		cert_auth.protocol = xstrdup("cert");
+		cert_auth.username = xstrdup("");
 		cert_auth.path = xstrdup(ssl_cert);
 		credential_fill(&cert_auth);
 	}
-- 
1.7.9
