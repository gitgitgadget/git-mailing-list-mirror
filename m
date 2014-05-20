From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/19] git-bisect.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:20 -0700
Message-ID: <1400593832-6510-8-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRg-0000Bh-8E
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbaETNus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:48 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42665 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaETNuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:46 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so337467pde.14
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1PKhsmExVPTS37Uu4mCHwpkMxCT8SVHJV0YNL8a/CXo=;
        b=XOj/Rt5WVGew4uVVIJy/dr1P+5vI1vVPAeY4WWeJZBiMrl67Ik4xePwk2g/F8kyK/o
         Zg1XLv51SiF2OgZVAxu4Fu0RzV86mWv5fbE6PYyVNVuRvNjP+aujW8BbN9qovQA9yAuF
         0gtadkyZlVymHtFVUceyu6yzpFWUE0T55b5kkzVeX4plAkELo7cSBuuM6+HQO3pG2vHg
         rGKC2a5pTPfETCmGYUl3mwui544c4qV3T1w7qY8xEfjlHSd3nDV9YCtQhC8Wlui/h4UY
         4+9x3Tg32fmxro8hF/sqFx5N0W/yHDzorSKHbQX4Nh0s+wwo0DUndtSzHGnwSCldklZw
         xQ4g==
X-Received: by 10.68.132.42 with SMTP id or10mr50798078pbb.80.1400593846105;
        Tue, 20 May 2014 06:50:46 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249670>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-bisect.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index af4d04c..1e0d602 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -408,7 +408,7 @@ bisect_replay () {
 	bisect_reset
 	while read git bisect command rev
 	do
-		test "$git $bisect" = "git bisect" -o "$git" = "git-bisect" || continue
+		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
 		then
 			rev="$command"
-- 
1.7.10.4
