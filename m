From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] version-gen: avoid messing the version
Date: Thu, 12 Sep 2013 20:17:26 -0500
Message-ID: <1379035046-6688-3-git-send-email-felipe.contreras@gmail.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 03:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKI65-0007LY-EW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 03:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3IMBWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 21:22:54 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:57874 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112Ab3IMBWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 21:22:43 -0400
Received: by mail-oa0-f54.google.com with SMTP id j10so605073oah.13
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yEWj7X0w7Vasf5aHwQsEDjXfJjBoGXhqpMNQhmeilWY=;
        b=N1brYAE24Ipjiev+Gtm/NLDB8RGkR+6eDVSBfFyhakbHgcRkQsqm6TnPG0vRI8fp1n
         z4HvPLlUqy1KFd6vMoA6J9vTecf+zHJw5+ofbL/7sqPCtE3ASVgsfz2iWD+pKjRR3f7z
         PhTCmtVIS6SFZ/pA1JtKz7PliEELqCxyJjpEeW8GJPvMXIp+GhNJ6tOvUO0RdQm5AhOU
         H2zCxEJmz/BjNdLjv/fRkreeeWYGL9f+8O8w6PmbINN8+TUtAOVG+OkCOCrEUofdkb4E
         QNg8vSIwzwuAqs0vbAG/9Un9H1x6kqZBqUT+hpTtX07Kq5FsNuxVGbnb6eMxM+/uJr1H
         DcdQ==
X-Received: by 10.60.65.37 with SMTP id u5mr150443oes.72.1379035362621;
        Thu, 12 Sep 2013 18:22:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm10367207oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 18:22:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234720>

If the version is 'v1.8.4-rc1' that is the version, and there's no need
to change it to anything else, like 'v1.8.4.rc1'.

If RedHat, or somebody else, needs a specific version, they can use the
'version' file, like everybody else.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e96538d..b3de2db 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,10 +26,8 @@ describe () {
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git && describe
+elif test ! -d ${GIT_DIR:-.git} -o ! -f .git || ! describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g')
-else
 	VN="$DEF_VER"
 fi
 
-- 
1.8.4-338-gefd7fa6
