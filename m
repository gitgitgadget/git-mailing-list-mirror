Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886C22023D
	for <e@80x24.org>; Thu,  3 May 2018 11:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeECLFH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 07:05:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34176 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeECLFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 07:05:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id m5-v6so22248736qti.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RDa2v6Ndfg3JNsveqqrZYSf+Bg1PholcP7DdLN3dEqs=;
        b=oET8NrPNUo9Nt8mLyK8ATDocSY+rNPIfpi+LF4/JorVsI4Q7M1FbE5Uz1ogYyKWXZ9
         +LbI4nZjdpO+Fd9lwQARKiWNidQVBfYT1lhFKfqUNGl1id8gjCjI4QX/mEHmaz91nxs1
         yffmwpP3hJnuo61aB09B6SVWkwrMXuYL9kekqgzXg7qlPPZs2oaJLwW8kGvA6rm+oMZs
         CrTkOxFi+KYDCtHJfePaDB2/Q/XREE2YDa4RtlbaRdHGVhiLmytey3uR4sXhrelRWZN6
         hRDMVfJ55Hx8FkCPu5Ccl9m6Odw3SYegLjYD45K3SKy9e8Yu0QHBJQVJtFJKfVa9Py+R
         ikqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RDa2v6Ndfg3JNsveqqrZYSf+Bg1PholcP7DdLN3dEqs=;
        b=TWPZNDkC65PPleS+6iabyi1Rcq/nytXveKeqWjkwbG3MIva6TLU9uEM429THl1HqmV
         pqWcxZXPpMfp4WbyjDoVXQGKSOvGBrGyK2joAM/r0nWwWPMoYXaD4KA49HJWFfdRzjBD
         jXet3pJy4z+E6bnovn6yqzGB+x4jJ1gZb64Ovvc1gape2d2Zs194kzFZURlOB1xj7zdo
         PIxUyPg1qqjlHDmVaWW7Y/SvyhmjdTmMWCEfjs9M76uzVOxAJvwmbxxSE5Yp/RxGLYQb
         yWrLYk/yhYCTEsEzbOQU5HQZ8wo2g+/CwHtqB/Vf1iYvVxyeosfz6646Iw/Eh2Dm0z+R
         3VBw==
X-Gm-Message-State: ALQs6tCIFF3pL329d7wxsJGSc5GYNdFVlMtDdZ0lspiwKOAW1L9Zji/t
        oNDs2e7pocchOmJxhFZ/D00DKjZc
X-Google-Smtp-Source: AB8JxZqv+EdW5CsPAbboYabOdzvUwMRGi/GBcE+zIzgFSY0RoXsZLhcjF9QmoXAwNtYnqFQWqHlw0Q==
X-Received: by 2002:a0c:f086:: with SMTP id g6-v6mr2997719qvk.54.1525345501666;
        Thu, 03 May 2018 04:05:01 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id o14-v6sm12840833qta.23.2018.05.03.04.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 04:05:01 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        gitster@pobox.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH v4 2/3] submodule: add --progress option to add command
Date:   Thu,  3 May 2018 06:53:45 -0400
Message-Id: <20180503105346.1758-3-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180503105346.1758-1-kcghost@gmail.com>
References: <20180503105346.1758-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--progress' was introduced in 72c5f88311d (clone: pass --progress
decision to recursive submodules, 2016-09-22) to fix the progress reporting
of the clone command. Also add the progress option to the 'submodule add'
command. The update command already supports the progress flag, but it
is not documented.

Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
---
 Documentation/git-submodule.txt |  7 +++++++
 git-submodule.sh                |  5 ++++-
 t/t7400-submodule-basic.sh      | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 71c5618e8..d1ebe32e8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -239,6 +239,13 @@ OPTIONS
 --quiet::
 	Only print error messages.
 
+--progress::
+	This option is only valid for add and update commands.
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 --all::
 	This option is only valid for the deinit command. Unregister all
 	submodules in the working tree.
diff --git a/git-submodule.sh b/git-submodule.sh
index 262547968..39c241a1d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -117,6 +117,9 @@ cmd_add()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--progress)
+			progress=1
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference_path=$2
@@ -255,7 +258,7 @@ or you are unsure what this means choose another name with the '--name' option."
 				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 		(
 			sanitize_submodule_env
 			cd "$sm_path" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a39e69a3e..b5b4922ab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -126,6 +126,22 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
+test_create_repo parent &&
+test_commit -C parent one
+
+test_expect_success 'redirected submodule add does not show progress' '
+	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
+		2>err &&
+	! grep % err &&
+	test_i18ngrep ! "Checking connectivity" err
+'
+
+test_expect_success 'redirected submodule add --progress does show progress' '
+	git -C addtest submodule add --progress "file://$submodurl/parent" \
+		submod-redirected-progress 2>err && \
+	grep % err
+'
+
 test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
-- 
2.17.0.1.ge0414f29c.dirty

