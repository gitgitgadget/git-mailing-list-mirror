From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/2] version-gen: fix versions
Date: Sat, 12 Oct 2013 02:07:08 -0500
Message-ID: <1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtO7-0005Ta-Nh
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab3JLHNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:17 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:47820 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab3JLHNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:14 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3110868oag.40
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mAeE1TKtaUveT86IJrD1j3VdDltyC1G7IFPomlSaZvU=;
        b=bYq9KjYu7abcocHXlT9G4+F02fMixdfg4PYdxdGuhKBT3vxOMNSW7ZY5TcbcUeCTSw
         8BZMZcpiDy+D5cUCr7muHZN61AvVmvhdR0EGNBi7E/PAuNvNxY4eUnNWCc9N6zZ3oppi
         ERedmYN5A+/f3VMu6S6+NbmMkEPJHZVVaORWW3l2hozdD+yCH7bDc18QcLSxjCvBUToK
         YqY2VCo2EtiZ2rjQR9TR+O1YpcC1ZFqcjrMVoZlTwAnxRfN6VQHI73gf3VJYQsqyzeTv
         MZ7NnoHMgBKVGoMmcmQ2OVhdpveclLAx9UuMDQtkpDj3c0YS4ldKpsrJN/NwSqYBGccn
         azaw==
X-Received: by 10.182.130.131 with SMTP id oe3mr17763098obb.34.1381561994499;
        Sat, 12 Oct 2013 00:13:14 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm101383114oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236009>

Virtually all packaging guidelines would prefer 1.8.4~rc1, over
1.8.4.rc1 or 1.8.4-rc1, so it makes sense to use that instead.

In particular, the only packaging we provide, git.spec, generates a
wrong version, because git-1.8.4 < git-1.8.4.rc1, changing to ~rc1 fixes
the problem as it's considered newer.

The same happens in dpkg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e96538d..c04c4de 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -28,7 +28,7 @@ then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git && describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g')
+	VN=$(echo "$VN" | sed -e 's/-/~/g')
 else
 	VN="$DEF_VER"
 fi
-- 
1.8.4-fc
