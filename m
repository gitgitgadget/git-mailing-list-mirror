From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] Update documentation for http.continue option
Date: Fri, 11 Oct 2013 22:35:45 +0000
Message-ID: <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 00:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUlJQ-0003FK-J2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 00:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab3JKWfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 18:35:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32966 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828Ab3JKWfv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 18:35:51 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 489F42807F;
	Fri, 11 Oct 2013 22:35:51 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
In-Reply-To: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235925>

Explain the reason for and behavior of the new http.continue option, and that it
is disabled by default.  Furthermore, explain that it is required for large
GSS-Negotiate requests but incompatible with some proxies.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fca7749..461c9dc 100644
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
+	disabled.  Defaults to disabled.
+
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
 	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
-- 
1.8.4.rc3
