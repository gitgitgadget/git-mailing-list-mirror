From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t6041: do not compress backup tar file
Date: Mon,  9 May 2016 10:09:08 -0700
Message-ID: <1462813748-27538-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, megabreit@googlemail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 09 19:12:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azogM-0003kJ-9r
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcEIRJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:09:17 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33422 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbcEIRJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:09:17 -0400
Received: by mail-pa0-f41.google.com with SMTP id xk12so75106119pac.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZWVMwqOMfwVFA47J0puM75GLvEuJ00RdS5MeJ8r4GKA=;
        b=XmrrZoq8NcvutwpigVqk0kbOh1lCD+6j3nmJsA/CFE/dPpx8Ib6+kpXZDpDgRYojrg
         uGmK+rjNla1nuvuJQfx2l6+0fSldV/of5gwm5y1UgAbA9fGcwbI3Ttbb4YLhMm46E9nL
         aI98toRoyM0tcqySGwmDyt8cti7knMz7Pwzd4sCu5r2NpAkIYBtYurCHFN5gdAOFku3p
         w7sE6w0mQcL1mrdPZHKwBXofsTrslZJHPgOtco6b9jl8cIVU2n5qcWN2aE4hUVXs8M6D
         7dkJLpM6lxHETRO5tYJZAERDuxgMspkGXnsLx+Dq1yPxWmzPEp6q/2AdRpJ2a54Hxsyq
         PSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWVMwqOMfwVFA47J0puM75GLvEuJ00RdS5MeJ8r4GKA=;
        b=FXLr6OdpbGiSAX4uzOhVP+9hXUh7dmAxoBeli8iK2UUkcceg0zitLgK7I35lbXLrmw
         AmHXp02S0yFUobbGioDvAxmbwLMiO5bw3hUkd6vMmLtjI0WjzGMDZmOVrjZYe8WNSujz
         jo0V5vmTsp31ILFcHBI8++uUlVxSKE03gf0t0k2BcmrIRQfKMnkzGqWpPU76SPNpqLK9
         DW7HZ9Mrzn14lqB1baB/4kbin2jJxMrhL587NVIqU1UFVIp7nH8Tfu8JCtrgWZTA4Mq+
         GUMdum94I1IjFNZCYtOxycCosnMdVJg//KoUEJohXkt0P1fw7fpdshlYQEsWiN5BLQ5Y
         f7Sw==
X-Gm-Message-State: AOPr4FUBSHn9HD+16Ntm+6TI04tUw8Oem1r3arWhAJ2r1pWbyE7asu+dmGRbNpz4jCyV72wR
X-Received: by 10.66.81.136 with SMTP id a8mr51786774pay.113.1462813756076;
        Mon, 09 May 2016 10:09:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a59a:6edf:a038:16bf])
        by smtp.gmail.com with ESMTPSA id ut1sm42030887pac.46.2016.05.09.10.09.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 10:09:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.g63b3e6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294019>

The test uses the 'z' option, i.e. "compress the output while at
it", which is GNUism and not portable.

Reported-by: Armin Kunaschik <megabreit@googlemail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Thanks Armin for reporting these GNUism!
 Are there any more? (So we can do these patches as a
 series instead of one by one:)
 
 developed on top of origin/sb/z-is-gnutar-ism
 
 Thanks,
 Stefan

 t/t6041-bisect-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index c6b7aa6..62b8a2e 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
 git_bisect () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
 	git checkout "$1" &&
 	echo "foo" >bar &&
@@ -20,7 +20,7 @@ git_bisect () {
 	git bisect start &&
 	git bisect good $GOOD &&
 	rm -rf * &&
-	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-- 
2.8.0.37.g63b3e6f.dirty
