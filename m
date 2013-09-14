From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/3] version-gen: avoid messing the version
Date: Sat, 14 Sep 2013 01:28:47 -0500
Message-ID: <1379140128-12397-3-git-send-email-felipe.contreras@gmail.com>
References: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjQu-0008M6-C6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab3INGeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:34:09 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58344 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3INGeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:34:06 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so1988510oah.6
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAs49giqNHdJ7j3zja2rL9roYMrCDzzBL2b/6u+41vY=;
        b=DbdWfS2jrhByjprw00AfpguDRIpG65FCmAUkYF1M3Vt8s3rJaHR2tdJlv5boBYL5DQ
         mws8ZIqYSk/bWjP3K3AhyzhS8IWnmrT/kMa981+ybqtnjk5r+il98oUOgaaMhEsWF+hI
         MJS4zg8txEsGu1c9zTqUHtOJBLP/78LydKe50Ak4ALFCWerKhKU3EYpuj/kYU4ZQvm2V
         Bkr8H3RpWaoByUHKqP2fhFoyB52HWy0VG7hedj4N2jvdcUMmOfrF3PCw5LTDL8DNHcQ3
         DPaEEKtXdZJjsdQ+0eSqSl0ypNOn82/pbWIVfZHRj3dF8A54b3hezWCQkPKax0MKu0sk
         23PQ==
X-Received: by 10.182.181.34 with SMTP id dt2mr15660826obc.30.1379140445853;
        Fri, 13 Sep 2013 23:34:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm20972909oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:34:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234795>

If the version is 'v1.8.4-rc1' that is the version, and there's no need
to change it to anything else, like 'v1.8.4.rc1'.

If RedHat, or somebody else, needs a specific version, they can use the
'version' file, like everybody else.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e96538d..19902e9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,10 +26,8 @@ describe () {
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git && describe
+elif test ! -d ${GIT_DIR:-.git} -a ! -f .git || ! describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g')
-else
 	VN="$DEF_VER"
 fi
 
-- 
1.8.4-fc
