From: Adam Williamson <awilliam@redhat.com>
Subject: [PATCH] correct smtp-ssl-cert-path description
Date: Tue,  6 Jan 2015 11:01:00 -0800
Message-ID: <1420570860-12732-1-git-send-email-awilliam@redhat.com>
Cc: ruben@rubenkerkhof.com, artagnon@gmail.com,
	Adam Williamson <awilliam@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 20:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8ZSv-0007h6-3B
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbbAFTGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:06:48 -0500
Received: from happyassassin.net ([184.71.189.90]:34442 "EHLO
	mail.happyassassin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbAFTGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:06:48 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2015 14:06:47 EST
Received: from adam.happyassassin.net (adam.happyassassin.net [192.168.1.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.happyassassin.net (Postfix) with ESMTPS id 8FB2530993;
	Tue,  6 Jan 2015 11:01:18 -0800 (PST)
Authentication-Results: mail.happyassassin.net; dmarc=none header.from=redhat.com
Received: by adam.happyassassin.net (Postfix, from userid 1001)
	id AED7516A6D5; Tue,  6 Jan 2015 11:01:18 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262089>

The git-send-email documentation was never updated to reflect
the change made in 01645b74 to use the SSL library's default
CA trust store rather than /etc/ssl/certs as a hardcoded
default CApath. This corrects that, and also tweaks the rest
of the text a bit to explain more accurately what is required
for a valid CApath / CAfile.

Signed-off-by: Adam Williamson <awilliam@redhat.com>
---
 Documentation/git-send-email.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a60776e..30f7afa 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -199,10 +199,15 @@ must be used for each option.
 	Legacy alias for '--smtp-encryption ssl'.
 
 --smtp-ssl-cert-path::
-	Path to ca-certificates (either a directory or a single file).
-	Set it to an empty string to disable certificate verification.
-	Defaults to the value set to the 'sendemail.smtpsslcertpath'
-	configuration variable, if set, or `/etc/ssl/certs` otherwise.
+	Path to a store of trusted CA certificates for SMTP SSL/TLS
+	certificate validation (either a directory that has been processed
+	by 'c_rehash', or a single file containing one or more PEM format
+	certificates concatenated together: see verify(1) -CAfile and
+	-CApath for more information on these). Set it to an empty string
+	to disable certificate verification. Defaults to the value of the
+	'sendemail.smtpsslcertpath' configuration variable, if set, or the
+	backing SSL library's compiled-in default otherwise (which should
+	be the best choice on most platforms).
 
 --smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
-- 
2.2.0
