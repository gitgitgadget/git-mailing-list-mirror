Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9418520D14
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdFTH41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34948 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdFTH4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21285796wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xv9iPgsvUuoQY/cSL5o/o5Y+uJ5e79HWXkssP4B5qcM=;
        b=aU8IEAmSLxNDfKb5x/5S7k6tmyGHcfUD3VnU3ObMONtYWKX1pCzkoEUvIgafMdWq4m
         PcUXmnQn8oMW/8Lmi8l6pfkmYjH9GI4btPf1ZV63n+LWCschqBcdvfepY2Pvo2p61DqA
         RZ4H7tYMg4XbLrMn1c1MlDy3M5CL1LJaC5kSVzjYJGvuuvms1KDbJ9lfetNFbSoRlMvu
         391q8AYYBUW3XR+WhNx7qb1ooPKR8gdKsrFYSTK4Yyr3ihqdY9U59alGxehM/ml9/9gQ
         q0ZtEBkOkigLttq0w5HspcXclOf2lc3NG4WP44DD3XRUnS3403Z1a//vvaSISBGH/Azn
         w0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xv9iPgsvUuoQY/cSL5o/o5Y+uJ5e79HWXkssP4B5qcM=;
        b=LN6MJRTSMNH2umkRdxXkmDHplKDCzyBbDMR8+imZES3R5RhqoUTVOH9lu2UBqh/oY+
         kfDNrypKvAQaRJPz0Q2XtTiuuSao1QgTOOPTiqc05hVh/uyT3JPGXgetFxmzxEufPLRS
         9deAsB/jIIkYIg7VmagE9j7fysCuBkibtY/GC1JgXtxzVp+clIrxLirPccakuBdhpdG2
         naYyUWOo2I5s+r/pxvKe7JYHh5ufBaKo3LrLBuWBP8PH7PH/1JO4vu9kt+mDukvQtdFB
         iE9ix6YeY18bYyi1UV5SGu9nTYUPvm4VGG0DbCS3vkzam9YnyfF8SwMcU09K+Pkv4fm+
         yfUw==
X-Gm-Message-State: AKS2vOzEdURP+NcwhK35YU69OEmF07wA4vsaYbsASgYrlAjmn0i6eSRu
        wSFxSnLbGFuWKQgQ
X-Received: by 10.28.50.70 with SMTP id y67mr1816417wmy.62.1497945383451;
        Tue, 20 Jun 2017 00:56:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 26/49] odb-helper: add script_mode
Date:   Tue, 20 Jun 2017 09:55:00 +0200
Message-Id: <20170620075523.26961-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c                 | 4 ++++
 odb-helper.h                   | 1 +
 t/t0400-external-odb.sh        | 2 ++
 t/t0410-transfer-e-odb.sh      | 2 ++
 t/t0420-transfer-http-e-odb.sh | 7 ++++++-
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index 502380cac2..2efa805d12 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -49,6 +49,10 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(key, "command"))
 		return git_config_string(&o->cmd, var, value);
+	if (!strcmp(key, "scriptmode")) {
+		o->script_mode = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(key, "fetchkind")) {
 		const char *fetch_kind;
 		int ret = git_config_string(&fetch_kind, var, value);
diff --git a/odb-helper.h b/odb-helper.h
index 2dc6d96c40..44c98bbf56 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -13,6 +13,7 @@ struct odb_helper {
 	const char *name;
 	const char *cmd;
 	enum odb_helper_fetch_kind fetch_kind;
+	int script_mode;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index c3cb0fdc84..18d8c38862 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -49,6 +49,7 @@ test_expect_success 'alt objects are missing' '
 
 test_expect_success 'helper can retrieve alt objects' '
 	test_config odb.magic.command "$HELPER" &&
+	test_config odb.magic.scriptMode true &&
 	test_config odb.magic.fetchKind "gitObject" &&
 	cat >expect <<-\EOF &&
 	two
@@ -69,6 +70,7 @@ test_expect_success 'helper can add objects to alt repo' '
 
 test_expect_success 'commit adds objects to alt repo' '
 	test_config odb.magic.command "$HELPER" &&
+	test_config odb.magic.scriptMode true &&
 	test_config odb.magic.fetchKind "gitObject" &&
 	test_commit three &&
 	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
index cba89866e2..8de9a08d7c 100755
--- a/t/t0410-transfer-e-odb.sh
+++ b/t/t0410-transfer-e-odb.sh
@@ -90,6 +90,7 @@ test_expect_success 'setup first alternate repo' '
 	git init alt-repo1 &&
 	test_commit zero &&
 	git config odb.magic.command "$HELPER1" &&
+	git config odb.magic.scriptMode true &&
 	git config odb.magic.fetchKind "gitObject"
 '
 
@@ -120,6 +121,7 @@ test_expect_success 'other repo gets the blobs from object store' '
 	 test_must_fail git cat-file blob "$hash1" &&
 	 test_must_fail git cat-file blob "$hash2" &&
 	 git config odb.magic.command "$HELPER2" &&
+	 git config odb.magic.scriptMode true &&
 	 git config odb.magic.fetchKind "gitObject"
 	 git cat-file blob "$hash1" &&
 	 git cat-file blob "$hash2"
diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index 8a5f3adaa7..b8062d14c0 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -53,6 +53,7 @@ HELPER="\"$PWD\"/odb-http-helper"
 test_expect_success 'setup repo with a root commit and the helper' '
 	test_commit zero &&
 	git config odb.magic.command "$HELPER" &&
+	git config odb.magic.scriptMode true &&
 	git config odb.magic.fetchKind "plainObject"
 '
 
@@ -108,6 +109,7 @@ test_expect_success 'update other repo from the first one' '
 	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
 	 test_must_fail git cat-file blob "$hash1" &&
 	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.scriptMode true &&
 	 git config odb.magic.fetchKind "plainObject" &&
 	 git cat-file blob "$hash1" &&
 	 git pull origin master)
@@ -131,6 +133,7 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	mkdir my-other-clone &&
 	(cd my-other-clone &&
 	 git clone -c odb.magic.command="$HELPER" \
+		-c odb.magic.scriptMode="true" \
 		-c odb.magic.plainObjects="true" \
 		--no-local .. .) &&
 	rm -rf my-other-clone
@@ -141,7 +144,9 @@ test_expect_success 'no-local initial-refspec clone succeeds' '
 	(cd my-other-clone &&
 	 git config odb.magic.command "$HELPER" &&
 	 git config odb.magic.fetchKind "plainObject" &&
-	 git -c odb.magic.command="$HELPER" -c odb.magic.plainObjects="true" \
+	 git -c odb.magic.command="$HELPER" \
+		-c odb.magic.plainObjects="true" \
+		-c odb.magic.scriptMode="true" \
 		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
 '
 
-- 
2.13.1.565.gbfcd7a9048

