From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 04/10] submodule update: direct error message to stderr
Date: Mon, 29 Feb 2016 18:07:14 -0800
Message-ID: <1456798040-30129-5-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZj7-00034x-C9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbcCACHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:33 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33738 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbcCACHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:31 -0500
Received: by mail-pa0-f44.google.com with SMTP id fl4so102375245pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KKBMyGMvr4kXeCyPE+xsvzROs8Cr1WI8cRRZO+qeBH4=;
        b=U/LuG0pjNGtcXD1/TGkxpDFCAzNYLxNfN5wOjuW4BSgf2i/rpD/Y2HKZ/Pd3z4os4z
         WNM36JQNaHPU5myjp20JllaK7jQ2lj1ZUSOn1DSdYwi6uWLyFbOUdSumsN2aRydmfMTr
         4nys7BszbN+KTyGXjT9NIPOwxw97P0ryfkFd9K9O8O+9AjPUJ3ubLvVocDGGnATjFZnD
         BOjEgVID7OIjN9iteEVimVSb2KGeLKQXUR9SNUg+J26VhWQGtLV3K/+anyl5jyQqkouq
         b9SuUBOor8ozmj6H21JG0ttvYtK/Egy0+expuxOOX7qGegCkoYyVzwUMnwJaSu6cgmst
         Unlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KKBMyGMvr4kXeCyPE+xsvzROs8Cr1WI8cRRZO+qeBH4=;
        b=isgvtbybQz5c0I7/AQKIf8pEQi5nbpt73SPKtQRKY0YGUX6pEsGXOiA3mZKRQ2RQf3
         SQvPxNU1sEvE9b69eLnQ7BTeDKvJU7NDArXXGUnGnxg9kGSoULM3p+t2L3B3P6pdP0BJ
         hsJA9NmoqBb/i3sHdnYN1u7iQ+QITW6NSuMZdLaFRrmRk6rn1Wnl7GIgQH70Ram7aQMM
         YRqK5XPzoKoEz+AQuc9cLj64hmkwSpSNL0gO0kygePLyO5QG0WYHujVc+DpQPdSxJK1x
         IvE2e/UJjYj+GQAn6PmucPH/z5o2n0Kaw0TDTEyqWj0cIsC1u9mrM9g7HasRq8kKZ81U
         YydA==
X-Gm-Message-State: AD7BkJLN140bk7S2vTKkh4h74RwO+aCQQffTEU8NQIMqE/2ksV9ARVK2GDQgV0C9WmOzIRS6
X-Received: by 10.66.102.70 with SMTP id fm6mr26454995pab.98.1456798051236;
        Mon, 29 Feb 2016 18:07:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id v7sm40897929pfi.56.2016.02.29.18.07.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:30 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287993>

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
2.8.0.rc0.1.g68b4e3f
