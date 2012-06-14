From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] Explicit error when curl_exec() fails
Date: Thu, 14 Jun 2012 10:57:23 +0200
Message-ID: <1339664243-31952-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Simon.Cathebras@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 10:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5sM-0000VL-M2
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 10:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab2FNI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 04:57:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52590 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350Ab2FNI5m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:57:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5E8vccQ029503
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:57:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5s2-0007Nb-S2; Thu, 14 Jun 2012 10:57:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5s2-0008KC-Q7; Thu, 14 Jun 2012 10:57:38 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Jun 2012 10:57:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E8vccQ029503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340269059.92921@tDzvq5mTA9v3GMjgtfUvag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199981>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/install-wiki/db_install.php | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contrib/mw-to-git/t/install-wiki/db_install.php
index b34772a..99d24e0 100644
--- a/contrib/mw-to-git/t/install-wiki/db_install.php
+++ b/contrib/mw-to-git/t/install-wiki/db_install.php
@@ -41,6 +41,9 @@ function get ($page_name = "") {
         curl_setopt($curl, CURLOPT_URL, $url);
 
         $page = curl_exec($curl);
+	if (!$page) {
+		die ("Could not get page: $url\n");
+	}
         curl_close($curl);
         return $page;
 }
-- 
1.7.11.rc0.57.g84a04c7
