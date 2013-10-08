From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] Update documentation for http.continue option
Date: Tue,  8 Oct 2013 20:48:07 +0000
Message-ID: <1381265287-39331-3-git-send-email-sandals@crustytoothpaste.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 22:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTeCj-0003PS-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab3JHUsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:48:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60988 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756256Ab3JHUsR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 16:48:17 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 703032807F;
	Tue,  8 Oct 2013 20:48:16 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
In-Reply-To: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235795>

Explain the reason for and behavior of the new http.continue option, and that it
is enabled by default.  Furthermore, explain that it is required for large
GSS-Negotiate requests but incompatible with some proxies.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fca7749..5fff2b2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1516,6 +1516,15 @@ http.postBuffer::
 	massive pack file locally.  Default is 1 MiB, which is
 	sufficient for most requests.
 
+http.continue::
+	Ensure that authentication succeeds before sending the pack data when
+	POSTing data using the smart HTTP transport.  This is done by
+	requesting a 100 Continue response.  For requests larger than
+	'http.postBuffer', this is required when using GSS-Negotiate
+	(Kerberos) authentication over HTTP.  However, some proxies do not
+	handle the protocol exchange gracefully; for them, this option must be
+	disabled.  Defaults to enabled.
+
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
 	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
-- 
1.8.4.rc3
