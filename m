From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 04/12] submodule update: direct error message to stderr
Date: Mon, 29 Feb 2016 11:14:02 -0800
Message-ID: <1456773250-5510-5-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTH7-0005dx-51
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbcB2TO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:26 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32875 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcB2TOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:23 -0500
Received: by mail-pf0-f173.google.com with SMTP id 124so35485954pfg.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gS9F7//tF7KMwhYn5RK9sv50s1qdD2qk+thn2igqYAc=;
        b=pW1yfQI49u/5L3TITDoCIsk/qH0NsWj6TdUhkiC+nt7RXZo9QlgTNXSIyygikrunOo
         tf8dGla9xCkB9hYQUPV3g776jGrXi5Zzg0bA7gHJdgNP7L/uhU/tRkuZ76LxkfhhJog+
         rkxTcdG1YyMuytN+vvivKez09FnG620VPSNZerHtt9THLwvHPXw2b7p95Eq7V0cunDRv
         WNpsKaJ9DNq3c/B0wfkloy3ZJaJ/wFXS416g2dNzwazIglRVXTOFGPX6sm8Xbm0Co7/K
         eRkSvUJj35LPdYu5+Pl48ytRbZvqPTG9KFkqNZkgfqdZ27HjahAz0mweTzeIYy+H+PRt
         N1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gS9F7//tF7KMwhYn5RK9sv50s1qdD2qk+thn2igqYAc=;
        b=H+YiBCALkPog9q4EfRjcZ0op5AOFjm91cQuUoA14hPeeX8XnoxnWPzKc+VXptZuChn
         iV9E/XOb5ZA01Mxw5bQ1ekqGhCbSkbUlo/P8t7rMoiqVNXgayBcZ/CG4038O86CQrNp8
         QOzNbr0PjeU9wBlZnNLvOxYXeOFrm4AUOl+Ho5MUxGOg/p7jJjBwZ2rNkDqZ5e7fh+ke
         RqjtzxlEWM1q5jcO8bMiEF1FvOmSB3owOFHuOdpCinxRttVrS6zwlWgQ6sPwoq5ebW4O
         zaFrKTK5vRekhDjKHdvp6IuGlOVbocqrRFY/cvJt+7JMzYpVnRLuWG30PDUJaLYzpJWX
         UUTA==
X-Gm-Message-State: AD7BkJI1Ew4oDvBteL6r1xtxOZZnf9kBJVGI1n8ejbWTlCLkMhq0M/ilOIoS8a3O3dYY11hi
X-Received: by 10.98.72.193 with SMTP id q62mr24394222pfi.117.1456773262280;
        Mon, 29 Feb 2016 11:14:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id ud10sm39947463pab.27.2016.02.29.11.14.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:21 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287879>

Reroute the error message for specified but initialized submodules
to stderr instead of stdout.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.7.0.rc0.37.gb7b9e8e
