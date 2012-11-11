From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 13/15] fast-export: fix comparison in tests
Date: Sun, 11 Nov 2012 14:59:50 +0100
Message-ID: <1352642392-28387-14-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
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
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6T-0007y6-EW
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab2KKOBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:22 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2KKOBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:20 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bTnm+CmVUrNYT/wITL54y6HoBLAkQQwPed0RZ3wh4Qk=;
        b=Kecf/uExGic/ksNGbhJoa/t1NiuAglTvnO8GkOaPfv6Ga3iAvQrPX2x/tlq5XGl3c/
         Y08BPKRk10kYY0ObDlZvOVHOANe9k3oV5mgxo3W7ys9KVORPgUKZMAzwKz3KgIQtN78j
         koOP/enbp04P03yhPlEkoE8JMDpdX4qJEen3eu3PKgsbiscZ/UXN4MT/O2Wgr1PYYoVy
         bFc3zsB2cw7SYbey9ToC+eXYNkL+8/9pPPGkiHCE7e6csdiCjsSHpi14bHGbpf+8BJ75
         rrhOYYhDKXHQDD720WbmOaz2jQooHMncBBqZ96GapxkIwl+eMQRRu1jpDmA+r731B4KY
         kUAw==
Received: by 10.204.130.21 with SMTP id q21mr6013194bks.5.1352642479786;
        Sun, 11 Nov 2012 06:01:19 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id gy18sm1492439bkc.4.2012.11.11.06.01.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:18 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209368>

First the expected, then the actual, otherwise the diff would be the
opposite of what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9350-fast-export.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 0c8d828..b7d3009 100755
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
