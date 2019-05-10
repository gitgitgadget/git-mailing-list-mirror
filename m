Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1801F45F
	for <e@80x24.org>; Fri, 10 May 2019 10:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEJKrE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 06:47:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38221 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEJKrE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 06:47:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so2844665pgl.5
        for <git@vger.kernel.org>; Fri, 10 May 2019 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxijIQ1kthjFw6IyKDkf3FtbeKyfPR7F7Oc3q7etbtc=;
        b=YYp7EYhs2Mn515p/On3nDG1Z6ZacbmT2uI5tTzPZjZp+172sONcE+3uXVq9k8Ls+HA
         6xZZyajPLJqPZeSzNEeuY6uvXxDGC2aHMjF+i09RCUX7sJ5qb4b81kgjGxI4TX2Ba3Pg
         RDwfskJGpQU2yX4mBqoexvRqkiQy/STAei/golqRggXYDjZ2pKTyESNf+EYbgPN/iR4A
         LIbCDsEaALdc7rXzb1Jkw/SzPt/dH+2G3RReRCyAxNhGITMHha3wvp+kMwQZFseshhqH
         +aEwZOl8crfAj+gOj+JLjgClBTARQo3DwlzIRJSpsZzPCRIcDNMAKW17gge6iojJ3jmz
         Aagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxijIQ1kthjFw6IyKDkf3FtbeKyfPR7F7Oc3q7etbtc=;
        b=VdH4n4UGjzyBFXcJkASFs4eQg1tBcZDsNSGIltKI0T1Uy+lSTEJXMhT2ITzrvyTm4x
         c8ovxOf/EF4W7bznridx9DwKK2GNTCoTExxZPmSJoUXlD2ICLRkLNtF6IVd4l9Mi7Zww
         jrlAOyOA1Q8rQo4XDFJte8Zby2Xfn3yu+WVTwJjZolkSCWgqXxGlYDoqWuw/3TrsEP0w
         lOKT4MFcBvb8B0Bgt8dxQ2qXhQscF7BkPpBGucN/YlPvstBie+JOdlaHh2+Lg78Y53ra
         mniHNZb/50G7A8Vv7caOBWP04zqIvuP+pSRp7Ev7XvToz62dqeuHKPS+QmniuxlvUJmq
         LDmA==
X-Gm-Message-State: APjAAAVuM+PTvHFNdfnoCrhawU2pcwCQEd7PfJpVp2wghapX/lCC3f19
        36dqiLxHdM2SkYxtE2/+7Nu4WiS7
X-Google-Smtp-Source: APXvYqxtEKw/sPYBbrFUmU1QmaT9SJHBa3MIxChVTBOfB2f+cn8vUUDhWryCSWg0Y3DXkOPDrS5anQ==
X-Received: by 2002:a63:6116:: with SMTP id v22mr12472528pgb.272.1557485222592;
        Fri, 10 May 2019 03:47:02 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id j22sm6703369pfi.139.2019.05.10.03.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:47:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 May 2019 17:46:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] init: make --template path relative to $CWD
Date:   Fri, 10 May 2019 17:46:57 +0700
Message-Id: <20190510104657.26585-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During git-init we chdir() to the target directory, but --template is
not adjusted. So it's relative to the target directory instead of
current directory.

It would be ok if it's documented, but --template in git-init.txt
mentions nothing about this behavior. Change it to be relative to $CWD,
which is much more intuitive.

The changes in the test suite show that this relative-to-target behavior
is actually used. I just hope that it's only used in the test suite and
it's safe to change. Otherwise, the other option is just document
it (i.e. relative to target dir) and move on.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c      | 3 +++
 t/t0001-init.sh        | 2 +-
 t/t1301-shared-repo.sh | 6 +++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 93eff7618c..6b72a9bb09 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -494,6 +494,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
+	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+		template_dir = absolute_pathdup(template_dir);
+
 	if (argc == 1) {
 		int mkdir_tried = 0;
 	retry:
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..802edb6c8f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -174,7 +174,7 @@ test_expect_success 'reinit' '
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
-	git init --template=../template-source template-custom &&
+	git init --template=template-source template-custom &&
 	test_cmp template-source/file template-custom/.git/file
 '
 
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index dfece751b5..2dc853d1be 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -136,7 +136,7 @@ test_expect_success POSIXPERM 'forced modes' '
 	(
 		cd new &&
 		umask 002 &&
-		git init --shared=0660 --template=../templates &&
+		git init --shared=0660 --template=templates &&
 		>frotz &&
 		git add frotz &&
 		git commit -a -m initial &&
@@ -192,7 +192,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	umask 0022 &&
 	git init --bare --shared=0666 child.git &&
 	test_path_is_missing child.git/foo &&
-	git init --bare --template=../templates child.git &&
+	git init --bare --template=templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
 	test_modebits child.git/foo >actual &&
 	test_cmp expect actual
@@ -203,7 +203,7 @@ test_expect_success POSIXPERM 'template can set core.sharedrepository' '
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
 	cp .git/config templates/config &&
-	git init --bare --template=../templates child.git &&
+	git init --bare --template=templates child.git &&
 	echo "-rw-rw-rw-" >expect &&
 	test_modebits child.git/HEAD >actual &&
 	test_cmp expect actual
-- 
2.21.0.1141.gd54ac2cb17

