From: MustafaOrkunAcar <mustafaorkunacar@gmail.com>
Subject: [PATCH] Rewritten fetch-pack.c:filter_refs() using starts_with() instead of memcmp()
Date: Thu, 20 Mar 2014 12:04:49 +0200
Message-ID: <1395309889-340-1-git-send-email-mustafaorkunacar@gmail.com>
Cc: MustafaOrkunAcar <mustafaorkunacar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:05:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQZqn-0003T2-MK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbaCTKFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 06:05:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33304 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaCTKFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:05:05 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so445895eei.19
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YgQrQcRbhjxNvhR/HsP2ixFECZCzbLSVxIv7LxDS/as=;
        b=QEV3zEht7aSkxuCTcZgiuYDhkPN/gUHiXPQ70Yfzhc1T8b2nV6iKFABhdhav6AfGpf
         vRqOz3ZxBNRznIPLkkwvhXbG28asuIZELpVq2DgIIj/N53CUIw5FcHrJsB7RXgbdtotO
         qqw8Ml7KtzvvGKA2uRM5zot4hxiNJBh7JlRx2HJFJjzgCoEDJuLzOg8IWPBWo/8cElBw
         IK0MKJ7+ZoaugKuSrzsxkvEwklWVDHhJ1lnSbDtL9o+q5X+clOv38IX0Z+eQr4DlJVY4
         oUpYOF6YjVOl/yoXo57UUWCgEkaTFdyrpztyCPP9KvRDb6LFxJuhcY1yTg6Pu9YSZ8Bs
         +U1w==
X-Received: by 10.14.47.12 with SMTP id s12mr84150eeb.116.1395309904298;
        Thu, 20 Mar 2014 03:05:04 -0700 (PDT)
Received: from localhost.localdomain (pc-240-100.wls.metu.edu.tr. [144.122.240.100])
        by mx.google.com with ESMTPSA id bc51sm3147643eeb.22.2014.03.20.03.05.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:05:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.286.g5172cb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244529>

Hi, I have completed one of the microprojects -14th one: "Change fetch-pack.c:filter_refs() to use starts_with() instead of memcmp()." The only line in the function filter_refs() containing memcmp() is changed with starts_with(). I plan to apply for GSoC 2014. Any feedback is appreciated. Thanks. 
Signed-off-by: MustafaOrkunAcar <mustafaorkunacar@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f061f1f..17823ab 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -506,7 +506,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		int keep = 0;
 		next = ref->next;
 
-		if (!memcmp(ref->name, "refs/", 5) &&
+		if (starts_with(ref->name, "refs/") &&
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
-- 
1.9.1.286.g5172cb3
