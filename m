Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095FF1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfBQKLX (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:23 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40042 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:22 -0500
Received: by mail-pf1-f172.google.com with SMTP id h1so7071748pfo.7
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIu+ijDO5otQgsLx5p5x/bgZ4iR+gvTG+pIJvK5djzs=;
        b=kdfSedmaaHMRZaOUsKgrdySb7lrizRYtpxi332qnTwPZlTw5qA1G6YkLv4MU9A/efb
         pPzfvBu9gcjShlWx7AcKXDvfCDtzKuP/WMyuF/I2MjQIkI9Dd4kaoWh3o2kQZsLv6+jD
         5AqRJ5j2t8zsKY7VBXY+Ce8dkYy++aNpXdKqgcuRSk1yxT7Ncy3rYeI2nTEnE321eolh
         eVaj2d7Je+XepEfe4ibUjpKmrV7FLJExe0Q1g+gidkTUjPN0yMx4Fqnju16nu36dtrCu
         nbcUdnidHSr4Qz1RugOtu81E8ds24bUZ1oDNm/vyLbnJrQuQjAh/eGJGYBWLFtA48uHW
         i6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIu+ijDO5otQgsLx5p5x/bgZ4iR+gvTG+pIJvK5djzs=;
        b=N5hQTPyf6Law/kIkkyVHt7V3O7Rrlq2w0xJCjrCojHssnNa5qY91Q7KCevWagqGV+8
         xC8SsdW8ZIp2ileFKnb2PT1cKa3Sno28tOMC2Y3ND0Vb8XOMTgrFOFsp0wBDK4zMB9wS
         5rR/vb+vhyI3NK9HAlO0YvlL0DYm9khn/4msNoZI4xDqDA+E0cKhdNDIPFSeGWO+wwaH
         o43njoRCIbx3eh6lg0M4RlOP32Ddi8/0feodfbU1BZZ4FO+Fhy+5T4vQd1ODWK8Qxcks
         AvW0YZniD86VS1QZOxl1kCiGmqJkqzrcXHZtbhzW9EzpT99lR3nCfryVpShofpvUWbbF
         +E9w==
X-Gm-Message-State: AHQUAuZE0dNazpNYexs+BUcI0rVjtX+C9Uizm5cCMBLEx6YPpusAiG9y
        DTP9TBZrcfKTbWCmsGkLulK+PeYl
X-Google-Smtp-Source: AHgI3IYrKtXnFSWd7vaVINU21oDd5FvrSiJyMH/jEYPCuKmMcpdRv0bwKi+1/+EqfXC4R2I8ucyFIQ==
X-Received: by 2002:a63:1241:: with SMTP id 1mr4404973pgs.211.1550398281794;
        Sun, 17 Feb 2019 02:11:21 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p2sm14023541pfp.125.2019.02.17.02.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/31] submodule-config.c: use repo_get_oid for reading .gitmodules
Date:   Sun, 17 Feb 2019 17:09:10 +0700
Message-Id: <20190217100913.4127-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 76e9bdc437 (submodule: support reading .gitmodules when it's not
in the working tree - 2018-10-25), every time you do

    git grep --recurse-submodules

you are likely to see one warning line per submodule (unless all those
submodules also have submodules). On a superproject with plenty of
submodules (I've seen one with 67) this is really annoying.

The warning was there because we could not resolve extended SHA-1
syntax on a submodule. We can now. Make use of the new API and get rid
of the warning.

It would be even better if config_with_options() supports multiple
repositories too. But one step at a time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule-config.c                 | 20 +++++++-------------
 t/t7814-grep-recurse-submodules.sh |  6 +-----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 52702c62d9..ad4e2cf330 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -618,23 +618,16 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
+		char *oidstr = NULL;
 
 		file = repo_worktree_path(repo, GITMODULES_FILE);
 		if (file_exists(file)) {
 			config_source.file = file;
-		} else if (repo->submodule_prefix) {
-			/*
-			 * When get_oid and config_with_options, used below,
-			 * become able to work on a specific repository, this
-			 * warning branch can be removed.
-			 */
-			warning("nested submodules without %s in the working tree are not supported yet",
-				GITMODULES_FILE);
-			goto out;
-		} else if (get_oid(GITMODULES_INDEX, &oid) >= 0) {
-			config_source.blob = GITMODULES_INDEX;
-		} else if (get_oid(GITMODULES_HEAD, &oid) >= 0) {
-			config_source.blob = GITMODULES_HEAD;
+		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
+			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
+			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
@@ -642,6 +635,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		config_with_options(fn, data, &config_source, &opts);
 
 out:
+		free(oidstr);
 		free(file);
 	}
 }
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index fa475d52fa..134a694516 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -380,11 +380,7 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	fi
 '
 
-# Recursing down into nested submodules which do not have .gitmodules in their
-# working tree does not work yet. This is because config_from_gitmodules()
-# uses get_oid() and the latter is still not able to get objects from an
-# arbitrary repository (the nested submodule, in this case).
-test_expect_failure 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
+test_expect_success 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
 	test_when_finished "git -C submodule checkout .gitmodules" &&
 	rm submodule/.gitmodules &&
 	git grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-- 
2.21.0.rc0.328.g0e39304f8d

