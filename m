Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90CD1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFDCNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40198 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDCNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id u11so18055199otq.7
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLJ96cE5/hO/RotU+tmJuqqMmqwq3TJiqG71abmsIG8=;
        b=a5pFewgTp+pRh84a8KsMdRRT/HoX3IbtmzuXO9RTv8rJCwKnA47sLn3OhmAjH3Ma9N
         tJUEXRwQ4l5NNaGeaFWKjkDaF6WjqPQtnf4gpMUs8K1kN+AHONeSuLAg/BbKmZBqopPX
         94T6d9DwiMm7dJCMDlNayqN5YVQWmVkb43ftOg/3iwuiQfSNr6NTD3oy2Gj/qY7g4VnS
         TU+1I9UAeCE3RZb8xar56YJH4+XVEP1Ee60inRXO3Pbtmd0kzTk6CmURirLyC5zSOcZX
         Wg5UCa2uhCkjZQSaOioiqibZe/B1pvGL3wzV7djygPyPChgEuEPBeSdVtnxXiQD35z5g
         XLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLJ96cE5/hO/RotU+tmJuqqMmqwq3TJiqG71abmsIG8=;
        b=kguG1Dt3IR6wldAuPqmV1U6VghJG7E+aBO70wT82T3ZqSaxAoiQQwexGbg3jhDPbG3
         pYdpIN06itXZ0LK087gU9BLYWH4TaQD0OsNwNQDlYYAd+UdqqFg12x+eQkiBXscoD0+l
         VWzJHfi7RUwB75ZWJG3Fui3KZyfvJtUWO6ms2v5reuBo6MKc2WFAaQviq88w22aE/CMM
         lhWA8g9VEP6tyo3R6ANl9wIEsflR8p7mzdU+WmiOdHTM/GyIckw/SYzbXmjHwuk6Gm4+
         NtDiK4xrQfhLtnMf7mfgG6QUmFDSUrW3r3SlS41h5opHEZmV49huoQqWt+ryozIyc5Qz
         GhPA==
X-Gm-Message-State: APjAAAUEJty2MApBZhJ9h7mznGmce4y4z6jkGu7vdtscYPzWjAqweTaO
        f0gYRs4cC12bGsXmy5UzQ+bkbxTTsWw=
X-Google-Smtp-Source: APXvYqzrdNM5of+aO+7Gp7S6jChNJFnfDDP8VUOFglqXC/FKPVfeEvV/gSaCimRuGKnR51pfT+Xd6Q==
X-Received: by 2002:a9d:3285:: with SMTP id u5mr3704767otb.266.1559614413015;
        Mon, 03 Jun 2019 19:13:33 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id m32sm4385340otc.55.2019.06.03.19.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/5] t5801 (remote-helpers): cleanup refspec stuff
Date:   Mon,  3 Jun 2019 21:13:26 -0500
Message-Id: <20190604021330.16130-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code is much simpler this way, specially thanks to:

  git fast-export --refspec

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh  |  8 ++++----
 t/t5801/git-remote-testgit | 11 ++++-------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d04f8007e0..48bed7c2fe 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'forced push' '
 '
 
 test_expect_success 'cloning without refspec' '
-	GIT_REMOTE_TESTGIT_REFSPEC="" \
+	GIT_REMOTE_TESTGIT_NOREFSPEC=1 \
 	git clone "testgit::${PWD}/server" local2 2>error &&
 	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
@@ -135,7 +135,7 @@ test_expect_success 'cloning without refspec' '
 test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
-	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2>../error) &&
+	GIT_REMOTE_TESTGIT_NOREFSPEC=1 git pull 2>../error) &&
 	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
@@ -145,8 +145,8 @@ test_expect_success 'pushing without refspecs' '
 	(cd local2 &&
 	echo content >>file &&
 	git commit -a -m ten &&
-	GIT_REMOTE_TESTGIT_REFSPEC="" &&
-	export GIT_REMOTE_TESTGIT_REFSPEC &&
+	GIT_REMOTE_TESTGIT_NOREFSPEC=1 &&
+	export GIT_REMOTE_TESTGIT_NOREFSPEC &&
 	test_must_fail git push 2>../error) &&
 	test_i18ngrep "remote-helper doesn.t support push; refspec needed" error
 '
diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index 752c763eb6..f2b551dfaf 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -11,13 +11,10 @@ fi
 url=$2
 
 dir="$GIT_DIR/testgit/$alias"
-prefix="refs/testgit/$alias"
 
-default_refspec="refs/heads/*:${prefix}/heads/*"
+refspec="refs/heads/*:refs/testgit/$alias/heads/*"
 
-refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
-
-test -z "$refspec" && prefix="refs"
+test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC" && refspec=""
 
 GIT_DIR="$url/.git"
 export GIT_DIR
@@ -81,10 +78,10 @@ do
 
 		echo "feature done"
 		git fast-export \
+			${refspec:+"--refspec=$refspec"} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
-			$refs |
-		sed -e "s#refs/heads/#${prefix}/heads/#g"
+			$refs
 		echo "done"
 		;;
 	export)
-- 
2.21.0

