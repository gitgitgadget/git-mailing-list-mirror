From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/10] git submodule update: Redirect any output to stderr
Date: Wed, 16 Sep 2015 18:39:04 -0700
Message-ID: <1442453948-9885-7-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAp-0006Ku-3V
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbbIQBjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:40 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33358 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbbIQBjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:20 -0400
Received: by pacex6 with SMTP id ex6so4761959pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PPOmbc+plnS7+6vMB9bpQvVmmsGtGwZqVwun/QUtb8=;
        b=nuCkE9PkTHeWQI6c0gMNyBZfxtU+BTBJXE455/GkhLfUQ028Ae+MOwxvy2Kfim2ITk
         Gm0Ig56WNGEIWAo0fVeZ/AxWTR5ET3k+aGvsaR7HCOQOt951JNOIdjSQ7TH7U1IHSGVa
         bePDs6w63AguHsQ+v1gLoetdi739ImM1wUJ/kNnZYQZnSCH8vX6IotUqQFaO1qUy7ZQp
         BihKq628P2Jkr/npIjy+QdLRcbLWINlfQg2IVSIm1nnPIgJwDrXLcEgC1wKL/6nTEDjd
         3Tcrxg7TkOmsvFKB7E1/ZMqng766LVa5z+gLBoWCyKNqHbIYT0bC5j+e9vPnuZyt0GkC
         LkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PPOmbc+plnS7+6vMB9bpQvVmmsGtGwZqVwun/QUtb8=;
        b=JYBruADHzBX7HpBfuV+1Sdy+95feVqmHnQzu2cHUEGu7e3GJ3Q8DkdeAtIegbZY16N
         6B6KvCvQQuPCvylhlwdmN4GSg/4RjIHfuvt/sdxG67qDGU6RT3RiTBUEwiDxFglO4yUj
         POrxWDY+vJiQDts6sbfo8r34Lywc8NnMSGYQD4fzEghBJAuzWqlydd/C9/3KDeEbrbY5
         gsZ8Y6b09vKQKde3i3dGf146L10PXUd55SNUU/I2e4P4xRBDoZ+oMp4pf3xAml7gWr5v
         YmR75RWS/8krI4zqaQ92SC2O6qlOA8+3itfydJPvPLOqRqvqnxPSHmFWv44ih3HKwh9U
         J40Q==
X-Gm-Message-State: ALoCoQknH36qd2bhZnRtn1M6zuAXa21qiHHcad9d4GrUremMSaxUQv0DS0mk51PGkxfQ0v2EV+vc
X-Received: by 10.66.253.170 with SMTP id ab10mr66381798pad.135.1442453960257;
        Wed, 16 Sep 2015 18:39:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id dh1sm564059pbd.49.2015.09.16.18.39.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:19 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278100>

There are no tests, which fail by this.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b0eb9a..7ef3247 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -663,7 +663,7 @@ cmd_update()
 		die_if_unmatched "$mode"
 		if test "$stage" = U
 		then
-			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
+			say >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
 		name=$(git submodule--helper name "$sm_path") || exit
@@ -684,7 +684,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$displaypath'"
+			say >&2 "Skipping submodule '$displaypath'"
 			continue
 		fi
 
-- 
2.6.0.rc0.131.gf624c3d
