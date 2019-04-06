Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008F320248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDFLh7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36226 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so4765808pfn.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=cbTq3NP8NfKC7EJkx1M0s2URiY0xkkIdGDMP+nUCt8VXF9ciVNAX4bNtJY82beCvno
         WLKRSWCzU04t4iQMxXdLkvNxc7cq6r2oa/oAM4aXj0zEUxhn/99iSraIb9iboti1MACy
         8JOcXQk3s8GR/o/MifWOzxgUicph1FEmY1sxmcWwM/u3u8SnbJ27HyTr7H9WNx3B7vZJ
         22HUH+2nmmLyDp5GMUk2/s5RsKQUmh2Z1SYjoTgwpuPfZV5lmoBSxI/zyI2Z3/RDFNpH
         aoFwjIViqmzdhcLlhv1P2x0k9c8KsiA96Y2tgAbXddZEdJGqLy1pgtgKwQxg/HJUoIsy
         Q3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=thIzdJ8kFk9CIEzDVSWplR7q9sRhcoOT19p6drTfrqq7LN1vD+88PFuvjEuGJYr0B9
         uWCs6+IfZ2vUZ2P8ssMqWLU2fY0+5cxHmEcDO3a5WoohVmId5Xm+SSZrQzN/oA4MXXX+
         Vecym5Yl+oGXV1OxpdKSCnN+Oi7JEZFXt0MPN/GssFxC1yaAK9WIvV0IGHbDRKWdOjS/
         CzEwY30NKDCaSICvBdTURs6qiv9Wa7sUGUJPIwvoliG6z/j8A8RUoYt7T+lHiF72giwO
         EEFxJaTMHz9MfXZXz8ichl/8ZVTmolcxPSRPx9mC5yp1acvf4j3neq/HlVkJZbzGxE8K
         zMHw==
X-Gm-Message-State: APjAAAW+B6occg6/1yn9cA+I7tGZhsfsh+dsgBGHS18aHde74G8h3qGB
        sOdhxoSY0a/LXKgDjvboP373y95f
X-Google-Smtp-Source: APXvYqzyZiLMcGJcSDmrzePEmNQvZdIUd8rjpYRWAk82/ioW+ynIvhwSELsp8hdPpjX1rJsV3jwnaA==
X-Received: by 2002:a63:5a1d:: with SMTP id o29mr17320459pgb.320.1554550678088;
        Sat, 06 Apr 2019 04:37:58 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id h127sm3861361pgc.31.2019.04.06.04.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 30/33] submodule-config.c: use repo_get_oid for reading .gitmodules
Date:   Sat,  6 Apr 2019 18:34:50 +0700
Message-Id: <20190406113453.5149-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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
index 66653e86b9..4264ee216f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -625,23 +625,16 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
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
@@ -649,6 +642,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
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
2.21.0.479.g47ac719cd3

