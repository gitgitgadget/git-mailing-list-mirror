Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B55A20401
	for <e@80x24.org>; Sun, 25 Jun 2017 04:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdFYEes (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 00:34:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34586 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdFYEer (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 00:34:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so22508469wrc.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MEgZzDlUVXDQ1z+evpml6JHshm2R/MPODzyN/1S682o=;
        b=RoKnDnCEa+UyJqgY1u1ZOGofexghUE4NxXcy2ngm9209r6SOPwo4lhS6BA+gxwiIQU
         l25Vxfzilhjy+9GgWuiaapt+jydb7zDy5NMH2JYC709bHWkWasxky9LO8zl6YWpC+CCf
         6CayVW2FVQGuVJXMSjPRB0REESInpqyq91/IYWXv1g12X5+vrkVRlO0Hpbib0830d8rV
         UMYbHNUKrHZ9SIP3Tx++W4sJKn3bABuLXYIbwDoXjFdWjREhKlEKGj14Alc/LaLdajlP
         D5gCRVw6hzDVHCi7vx94zxJvC2NOlgHaEIaRQozBptOPidMufq9IuoSyzfDNNw2yuvw3
         lNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MEgZzDlUVXDQ1z+evpml6JHshm2R/MPODzyN/1S682o=;
        b=o3JLkF43Su8jaDLFv/JyWzdII8QtulPlHuRF4WR18DgshNbtR1OhA/bdvnBdAiv88p
         1yzU6lqddv9xR9EKhlvXWTYHWHucpPNdwLRHkbHRbA++ocDrVQ6idfENN/pnZdYMcVu1
         YYaP09/aXZVjrd7+Uq/MsojKm02Sj7U7zdLNIZOUwVKeVt6MBz99UCLychdiyke0b9RD
         sCFOJ6SGE+TMU69/vGoqiIjFwIpeJYgmG6zigIbBrRF+hid2WF4nImZrsuceUna1Lp/j
         W1jHGPsUCDizoy+DlKvZYNfbLhjXYr208Cbaw+mb8taLzKm+z31dAch4I9Y6dv/PvZgg
         2BmA==
X-Gm-Message-State: AKS2vOyW7feSQQxQV3zdM2bGd7oYk0r6f/mZR2YCdHTNgBskIEjLdD7t
        6Z9QACxag2s9DPxe
X-Received: by 10.28.29.21 with SMTP id d21mr9314279wmd.37.1498365285561;
        Sat, 24 Jun 2017 21:34:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id a99sm4977943wrc.64.2017.06.24.21.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 21:34:44 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/3] t1301: move modebits() to test-lib-functions.sh
Date:   Sun, 25 Jun 2017 06:34:28 +0200
Message-Id: <20170625043429.23337-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.517.gf6399a5ea5
In-Reply-To: <20170625043429.23337-1-chriscool@tuxfamily.org>
References: <20170625043429.23337-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the modebits() function can be useful outside t1301,
let's move it into test-lib-functions.sh, and while at
it let's rename it test_modebits().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1301-shared-repo.sh  | 18 +++++++-----------
 t/test-lib-functions.sh |  5 +++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1312004f8c..dfece751b5 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -19,10 +19,6 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	)
 '
 
-modebits () {
-	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
-}
-
 for u in 002 022
 do
 	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
@@ -88,7 +84,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(modebits .git/info/refs)" &&
+		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$y"
 
 	'
@@ -98,7 +94,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(modebits .git/info/refs)" &&
+		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$x"
 
 	'
@@ -111,7 +107,7 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
 	umask 002 &&
 	git update-server-info &&
 	echo "-rw-rw-r--" >expect &&
-	modebits .git/info/refs >actual &&
+	test_modebits .git/info/refs >actual &&
 	test_cmp expect actual
 '
 
@@ -177,7 +173,7 @@ test_expect_success POSIXPERM 'remote init does not use config from cwd' '
 	umask 0022 &&
 	git init --bare child.git &&
 	echo "-rw-r--r--" >expect &&
-	modebits child.git/config >actual &&
+	test_modebits child.git/config >actual &&
 	test_cmp expect actual
 '
 
@@ -187,7 +183,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
 	echo whatever >templates/foo &&
 	git init --template=templates &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits .git/foo >actual &&
+	test_modebits .git/foo >actual &&
 	test_cmp expect actual
 '
 
@@ -198,7 +194,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	test_path_is_missing child.git/foo &&
 	git init --bare --template=../templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits child.git/foo >actual &&
+	test_modebits child.git/foo >actual &&
 	test_cmp expect actual
 '
 
@@ -209,7 +205,7 @@ test_expect_success POSIXPERM 'template can set core.sharedrepository' '
 	cp .git/config templates/config &&
 	git init --bare --template=../templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
-	modebits child.git/HEAD >actual &&
+	test_modebits child.git/HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5ee124332a..db622c3555 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -216,6 +216,11 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
+# Get the modebits from a file.
+test_modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
 	config_dir=
-- 
2.13.1.517.gf6399a5ea5

