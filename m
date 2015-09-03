From: garga@FreeBSD.org
Subject: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu,  3 Sep 2015 13:35:47 -0300
Message-ID: <1441298147-83601-1-git-send-email-garga@FreeBSD.org>
Cc: Renato Botelho <garga@FreeBSD.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXUZ-0000FZ-GI
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbbICQgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:36:00 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35150 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbbICQfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:35:55 -0400
Received: by qgt47 with SMTP id 47so32967148qgt.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5uCZMtMw2o76MkImUPpWsPOaSrgB6VBCp+5kvhXRfNA=;
        b=r8am4dYnyK8Pv+DDtGICZOfY4M1u/T1TsNxLqX6ZAPh82eadSq52bXKR3N+OYQddSD
         w20WxpS3qY+XbCtQsln+ArDzQNSGXjY+/jgJSHb+cXfvch1TQbpHRL4x0a97Yut8DLxV
         C3XSlr3rLsGBtzWeQDqVlVuhrphN/j9ve/94kNeIRpg0U8vlKYrlVXbmsFPqWMEiOJwX
         yY2fCbqAj9dkt+yG74HAflI9vbUlDl5u8BhXBB+oPO/UqflgSuLD4+XkQBqtivSHHndX
         vsvucQh2toz2w+bOQkEnqPdK4UwMGzY97iLKDZk+k4zoMxmF6Y4otLQ4IUSZL1WE8PsS
         4A3g==
X-Received: by 10.140.235.216 with SMTP id g207mr3523938qhc.98.1441298154827;
        Thu, 03 Sep 2015 09:35:54 -0700 (PDT)
Received: from localhost.localdomain (mail2.bluepex.com. [200.247.39.210])
        by smtp.gmail.com with ESMTPSA id s12sm15187608qkl.2.2015.09.03.09.35.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 09:35:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277225>

From: Renato Botelho <garga@FreeBSD.org>

git-submodule and git-request-pull are written in sh but use perl
internally. Add them to be replaced by unimplemented.sh when NO_PERL
flag is set
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e326fa0..4dae0ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1795,7 +1795,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
+$(SCRIPT_PERL_GEN) git-instaweb git-submodule git-request-pull: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-- 
2.5.1
