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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8034C1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFDCNg (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33262 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDCNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id q186so14443119oia.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kx4d2muhZB2o265hqWGguwiqE3bKLdJqG3ngIRcLfa4=;
        b=VrHjiaThsNukneCIehA8BTYu1PMECbyODzKRy8d8uqteZ9jaBhrvtZLbU8JShE09RC
         fwQjxOsFTUOWfMDuHBqNuOFMwvSBm7U30tNZuR8pwI+Z8j8o4jd3Yhx3qZpkklKHckKt
         ioq9NsML2tkVXDLQHWuUr/fNHhZeeLDO3gnTACdw6aYARwMqLEo5AvOeyV/d2u8eklIV
         LJeXMvmCL8rD6U09ATC6q/bjz4xfyVNA+hPF7CKnyEfsiNadgkwIC0mVNBFCVcUWT/Lu
         8z/WZrT3cM7CKnXhWllBXpN9TjF938SKepMrCrXsLrN+EVSplIU6eFtFDwg1Rfq20+ya
         arMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kx4d2muhZB2o265hqWGguwiqE3bKLdJqG3ngIRcLfa4=;
        b=KAduYPGax2QQCU8NwFB3B4aCQrWnacdsMnw/gR66EEeAQMMQl5gkuokhNrT6pxQTPJ
         lrFftpCnWELsbhcxxnZJ60Un/fKdWLDXjfYgdo7/OK4/pg/Rla/LuTxEZ63ZZ8Aw6CIR
         viN/9ffzJZq1i3wifMySAJFE/A0bz2YNpzakVskkVWUi5MHhU6C4nkxjlAqMITckL5nw
         Kh6csuHsGzmv23rs4L95FFVcg1NnADABusKKsv1SUGQs+DMapXFX1hkFch+tjlFG8EmL
         UBro8lY1PAQ2nOCdrWRBtK7MkuAGU8LnIEpX1bomF3Lvchpx1ve18rB6DJWsU84wjMuP
         98qA==
X-Gm-Message-State: APjAAAUYy9cpxgabV16AM+4NYAg4sq6wcCIfyoOrgc26mCZzAhkGBieN
        786Lr136J0F9xRNMc3na5Sne9WDn/m8=
X-Google-Smtp-Source: APXvYqw3JHHeObw/+CL52+rUIAwwSMD47/4Cb5W2ldxdEp9R9+icWrKfh0Nr+S/ec9Nt8pL7YFuonA==
X-Received: by 2002:aca:abd8:: with SMTP id u207mr1915454oie.136.1559614414357;
        Mon, 03 Jun 2019 19:13:34 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id o128sm6199384oih.48.2019.06.03.19.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/5] t5801 (remote-helpers): add test to fetch tags
Date:   Mon,  3 Jun 2019 21:13:27 -0500
Message-Id: <20190604021330.16130-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This used to work, but commit e198b3a740 broke it.

  e198b3a740 (fetch: replace string-list used as a look-up table with a hashmap)

Probably all remote helpers that use the import method are affected, but
we didn't catch the issue.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh  | 10 ++++++++++
 t/t5801/git-remote-testgit | 17 ++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 48bed7c2fe..238774bc17 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -303,4 +303,14 @@ test_expect_success 'fetch url' '
 	compare_refs server HEAD local FETCH_HEAD
 '
 
+test_expect_failure 'fetch tag' '
+	(cd server &&
+	 git tag v1.0
+	) &&
+	(cd local &&
+	 git fetch
+	) &&
+	compare_refs local v1.0 server v1.0
+'
+
 test_done
diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index f2b551dfaf..6b9f0b5dc7 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -12,9 +12,14 @@ url=$2
 
 dir="$GIT_DIR/testgit/$alias"
 
-refspec="refs/heads/*:refs/testgit/$alias/heads/*"
+h_refspec="refs/heads/*:refs/testgit/$alias/heads/*"
+t_refspec="refs/tags/*:refs/testgit/$alias/tags/*"
 
-test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC" && refspec=""
+if test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC"
+then
+	h_refspec=""
+	t_refspec=""
+fi
 
 GIT_DIR="$url/.git"
 export GIT_DIR
@@ -37,7 +42,8 @@ do
 	capabilities)
 		echo 'import'
 		echo 'export'
-		test -n "$refspec" && echo "refspec $refspec"
+		test -n "$h_refspec" && echo "refspec $h_refspec"
+		test -n "$t_refspec" && echo "refspec $t_refspec"
 		if test -n "$gitmarks"
 		then
 			echo "*import-marks $gitmarks"
@@ -49,7 +55,7 @@ do
 		echo
 		;;
 	list)
-		git for-each-ref --format='? %(refname)' 'refs/heads/'
+		git for-each-ref --format='? %(refname)' 'refs/heads/' 'refs/tags/'
 		head=$(git symbolic-ref HEAD)
 		echo "@$head HEAD"
 		echo
@@ -78,7 +84,8 @@ do
 
 		echo "feature done"
 		git fast-export \
-			${refspec:+"--refspec=$refspec"} \
+			${h_refspec:+"--refspec=$h_refspec"} \
+			${t_refspec:+"--refspec=$t_refspec"} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
 			$refs
-- 
2.21.0

