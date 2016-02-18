From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 4/7] submodule update: direct error message to stderr
Date: Thu, 18 Feb 2016 15:33:15 -0800
Message-ID: <1455838398-12379-5-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4l-0003zz-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948691AbcBRXdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:31 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34149 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948683AbcBRXd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:27 -0500
Received: by mail-pf0-f170.google.com with SMTP id x65so39838097pfb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MvvEYHK92ZNZPdnopBgfZTbjRtFT9g8rcXl2Lalbges=;
        b=kczvy/hxFUbhOxXl2sZ+XVYj0LeA2yZfAfNthd14Kjkab/vCFEu2U+mWmZMmf7G8a0
         tpHuN0U69zU1m3ZNj+RGXh0rNn8ReC0aBdVMD9n53gO76/XZBFeKaPNcfMn7DBDgxsCP
         KSpMQenLvKrZpAg+SgfsmBw/h5DS9Zd4Debwyq8qF1GFW4qd9asWkLEaotVGnIlX3Q28
         9YtQn7HmEVhTvu/8AaepUfyq1hxJKCjEo5D+OVLLF4JnMGZCmLuRBnzRQk4EygcTlsR0
         U+378T0p8K1hQvxTn9ScFDy9VgSMDrCQVjUkY8CaZPMEFKZ83RI8ltAo1hmuOXrerAYR
         Gk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MvvEYHK92ZNZPdnopBgfZTbjRtFT9g8rcXl2Lalbges=;
        b=L0HY8/+o5bsp8Bayh+XWrdZq3004qmvPbqldKI6ihfxsaS8uYNoC1JftLfrBW8+Fmn
         JOMrbtPavzEN9k7vyukAj7S+UGc8wOEvRVVeXYu6dHVZI/TUUcCFdJfnGa6TGs0TLGjq
         vRh2EqaQ7e3KydKKHigjmjnndaBZzAwKu/bisMNhdF9mJ8yc/C/p8LOtlTek9VyzNVYo
         cfZN2+dMj17oJU5MOS+Wqlzz5Y4EREMT+y/3HBXx5BfgaGM0Ai4d5oz0OxbNusQIo2oe
         c9en2U5AhjRUtRmwkKf/YBOmLXLGU+PqHqd/JZDR4uAfjxoxt/H2Fh15yB9s3nHx+ktp
         O0jQ==
X-Gm-Message-State: AG10YOQ5g7/gE+Waq70c1bV5P7ui/aZoBObTIc1kVIrsEDJA8CXMWcmk9jZP4EIYBzdqOF80
X-Received: by 10.98.42.150 with SMTP id q144mr8503672pfq.73.1455838407298;
        Thu, 18 Feb 2016 15:33:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id p21sm12799006pfj.67.2016.02.18.15.33.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286645>

Reroute the error message for specified but initialized submodules
to stderr instead of stdout.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh           | 4 ++--
 t/t7400-submodule-basic.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..9ee86d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -693,7 +693,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$displaypath'"
+			echo >&2 "Skipping submodule '$displaypath'"
 			continue
 		fi
 
@@ -702,7 +702,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
+			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..5991e3c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -462,7 +462,7 @@ test_expect_success 'update --init' '
 	git config --remove-section submodule.example &&
 	test_must_fail git config submodule.example.url &&
 
-	git submodule update init > update.out &&
+	git submodule update init 2> update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&
@@ -480,7 +480,7 @@ test_expect_success 'update --init from subdirectory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		git submodule update ../init >update.out &&
+		git submodule update ../init 2>update.out &&
 		cat update.out &&
 		test_i18ngrep "not initialized" update.out &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
-- 
2.7.0.rc0.34.g65aed89
