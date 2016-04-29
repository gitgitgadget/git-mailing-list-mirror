From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/14] WIP add test for git pull
Date: Fri, 29 Apr 2016 16:34:46 -0700
Message-ID: <1461972887-22100-14-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwP-0000u4-8X
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcD2XfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34152 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcD2XfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id r5so52040467pag.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RfJ9fVE8aszVfU0ACw3jk9lHSm7fFBzPuo/Mr81W7F8=;
        b=IhLIcTJ4pRvpzu0IaOBQRzr+/gSkvAAAlM+yIz8/9x4blGMmPkriNGv/w0/onLXjFn
         ZgSe8FfWj5mczI0HQs5OvPYwQpbt5RWYuj6U46AMBySZg3Mn9U23EmhKa995m8OLc8wx
         gbDEbG+Mo+B5IxCdFAfXncQdabWT2Ri8oXFK+7OuirsMs/jzwY/sM0TSN3TkG9rlMGb4
         fLuIu85iZ1o1KW+4EKUF+bZn9mLzu8dP2Edg4zm7awM5unCR3Ta1qiHkhcje0ip0Z5MT
         7phtwilATWrgUjYG0dn9UVggLCZMAtfNxdui9uWvkQncfFS3TDijr3fG7mAGmHZ34RE7
         4fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RfJ9fVE8aszVfU0ACw3jk9lHSm7fFBzPuo/Mr81W7F8=;
        b=NTRCLc4lEljabl6ZrUmTlf6SO/eEfKOuq+gJhSxG+ZMS26iECn2PBtowr2fi4E2kuw
         lr6Z4AJ7fCar0Rs4f0VSWvO0lDbFOMyWDZSH2LeP+DszEgw8EASTYpwseHcNB3WQWD/C
         w7C4eBGraYDQr9Gy9qZhJLEZ8fGaxyBluJjz4O6p3OyVy3sjFOX80MKyRV/ToP1GI/LW
         z76RGW+JtVWa7EjUAU/JoSn1Xo1caTai10HOX9MEt5ETT5yFoYhiUvC9R7nmGj8of6X0
         gtvDrowKS490UoRPto8x2GwgMw3Y9zr3S6CWQAXnJ3fm8/iVdFh4KiReZbqQHYb3o/PZ
         jrDg==
X-Gm-Message-State: AOPr4FUaC0lQ7YoLCWpyOLdNGJJKv7vOeGNW/TDnSXKGHSar4iPNPH9t79aLbJtROBWaFtKO
X-Received: by 10.67.8.100 with SMTP id dj4mr33102957pad.88.1461972912638;
        Fri, 29 Apr 2016 16:35:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id dh4sm26470644pad.37.2016.04.29.16.35.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293078>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5520-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..9bd1feb 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -599,4 +599,10 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull with protocol version 2' '
+	test_pause &&
+	git pull --transport-version=2
+
+'
+
 test_done
-- 
2.8.0.32.g71f8beb.dirty
