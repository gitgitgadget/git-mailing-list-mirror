From: larsxschneider@gmail.com
Subject: [PATCH v1 2/2] git-p4: suppress non test relevant output
Date: Sun, 20 Dec 2015 17:44:29 +0100
Message-ID: <1450629869-49522-3-git-send-email-larsxschneider@gmail.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 17:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAh6C-0007yH-MK
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 17:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457AbbLTQoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 11:44:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34198 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbbLTQog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 11:44:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id l126so8347700wml.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 08:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sF0CGLxnQEyAKOL7dofykM16O9Jv0w5J5xJwQ5GsjeU=;
        b=ZcwqW7sy1rJhgxAv1aSmVftWIRFXKPhRj7cw6C8OwVp27U2IO/CzntLjiDZ8+mCeMF
         1h5gTY4I/MY0qVYc5YTPRpsVIL6Oafu5N/V7G1o7fdIrU7kAkRKRV/Ks3p3dQkg19KWf
         NhPuX5g3UX0NIaFXumAlz+zpSpwQ7jFgDjjYzHGJSHr29fRGlwfJaxSk9UaWsDao5T3t
         zgLztmcA5VyBySxAwpu5ErS4FXUP7XmRpp5vI2LzhTgdVmSXa2x0y9pjRfj+1QXOZGl5
         enCJZDeW4NWfd79XcDchZxEr+67hfeWqGsx3qLa3YE1EPYYO80+31XOFRNcwwBF19Kq6
         1c7w==
X-Received: by 10.194.71.104 with SMTP id t8mr15124811wju.177.1450629875358;
        Sun, 20 Dec 2015 08:44:35 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id g127sm16057280wmf.24.2015.12.20.08.44.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 08:44:34 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282774>

From: Lars Schneider <larsxschneider@gmail.com>

If tests are executed in verbose mode then the retry logic clutters the
test output. Suppress that clutter.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 30bf7ae..03f29c1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -174,7 +174,7 @@ retry_until_fail() {
 	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
 	do
 		sleep 1
-	done
+	done >/dev/null 2>&1
 }

 kill_p4d() {
--
2.5.1
