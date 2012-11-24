From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 13/14] fast-export: fix comparison in tests
Date: Sat, 24 Nov 2012 04:17:13 +0100
Message-ID: <1353727034-24698-14-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6GM-0002Mf-Vw
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab2KXDSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:16 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632Ab2KXDSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:18:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yyjFDLG1+Mb7Mf9+OuUUNY6/7vLXJVMc/hOizfpB82M=;
        b=yIi/0r8Ghl+UsXphzXpRZns0fzMNpVdKk6sqGUiPOQdPGmujMeCuqnOL/iixOO3ONp
         D2/Lijf7P//3U6Uozk6ZijBweemqzoQT5xk6NFeO27NtqlDkm/rdkK88PE6Mun6GOxo5
         eSpPmMMFPK5zdZmcYmyX+8jkyIJKFhmDl8uJsjexKv73QI0DQr8hTLImx969OHZuz9GU
         8dCKcbiz48Q4FrmhcfOpMll+4ADETlDtLn/zDNctJPTdLi1qAsXDi++BgOJFBV4cP/PE
         GLcKsIlJrGgfd4/mSABUPIwTjh2jgRklUD4GFohYzzkxprYkRl/l5yHnPBRq/D5u1S2N
         v2GA==
Received: by 10.204.129.66 with SMTP id n2mr1009245bks.94.1353727093076;
        Fri, 23 Nov 2012 19:18:13 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id u3sm5462710bkw.9.2012.11.23.19.18.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:18:11 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210296>

First the expected, then the actual, otherwise the diff would be the
opposite of what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9350-fast-export.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5948b65..1f59862 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -303,7 +303,7 @@ test_expect_success 'dropping tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -320,7 +320,7 @@ test_expect_success 'rewriting tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -351,7 +351,7 @@ test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
 		git fast-export master~2..master~1 > output &&
-		test_cmp output expected
+		test_cmp expected output
 	)
 '
 
-- 
1.8.0
