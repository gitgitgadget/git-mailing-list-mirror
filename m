From: larsxschneider@gmail.com
Subject: [PATCH v3 2/3] submodule: fix &&-chain breakage
Date: Mon, 21 Dec 2015 00:19:54 +0100
Message-ID: <1450653595-22676-3-git-send-email-larsxschneider@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, peff@peff.net, Jens.Lehmann@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 00:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAnH9-00046l-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 00:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbbLTXUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 18:20:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33297 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbLTXUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 18:20:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so11091342wmn.0
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9wYiw3niZChm2Mi9fHJn5M3X6zuKqB516sctk/4/NA=;
        b=kEW98Fh+6vsNYeZ81x9IqVBgQS26bJ2C5bU3w5HeuMfAmOOEy6voqgJW64LZigwf1B
         p3oQpt+FD8KKKjQ/BHs1AO/Cp0HC7Ke8MmkA0DKVBjGVE2Ttw5t4H1fnS8N+DJvhCn3v
         VAxtHRBXPjFCSQko0n8qJLAHeED0CUbZDk6fcQR981p3xeAh+3bGji7lol1uh4qpMsnu
         How5vHXHKyssfnO03qSxu28RKngjf+S3i4EDLfz5CG9pQZc86QtBBLB0mI+2nkigj0eN
         HymkFQRUcZ6dkq5bOdY9klOEwgMbJX247rzMcu3JxICKgxp4f4eoQtR/GQjhVRbXCUoa
         GapA==
X-Received: by 10.28.1.202 with SMTP id 193mr9453013wmb.51.1450653600993;
        Sun, 20 Dec 2015 15:20:00 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id da10sm25396623wjb.22.2015.12.20.15.19.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 15:20:00 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282776>

From: Lars Schneider <larsxschneider@gmail.com>

---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..b5bd976 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -758,7 +758,7 @@ test_expect_success 'submodule update clone shallow submodule' '
 	(cd super3 &&
 	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 	 mv -f .gitmodules.tmp .gitmodules &&
-	 git submodule update --init --depth=3
+	 git submodule update --init --depth=3 &&
 	 (cd submodule &&
 	  test 1 = $(git log --oneline | wc -l)
 	 )
-- 
2.5.1
