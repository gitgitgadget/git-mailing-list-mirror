Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C9E215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756368AbeEASPp (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:15:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36411 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756256AbeEASPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:15:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id q6-v6so15486782qtn.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CE9sf6KIVTlnZa4jbYDXpoSuZVA6RRPBO4tp1k9Y8BE=;
        b=GT9pnE/amjBRU32XudfRkV926dOCGvaCnAithexl/EPNjqyAh25/DtitSn1z9k3wPn
         5nEvrO2gsBtKn8Q/wr/BUJKjlYPa2vbV4MbI9MmOhEtSns5lc5gje9jGelfJIkOOqQoO
         OQkQ5LaqYrv6bXJIi8ftprZtEWl2cYl8rnxhnj/nn2wdFB6Zmm7Bo41faG1kCHmv6KmH
         zjlqa8F74dfumoFu7SclqThVkdxE6HA5+sS/iBq1rysfTDR/cJXuoBcYrzB4mzwQ4Y9i
         ug+e/aRrW2Ozb+NTTHobyX0/s27nACO5RKOsaqDxpt5WVD3i0owD2quZYDioUpeLPadj
         7dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CE9sf6KIVTlnZa4jbYDXpoSuZVA6RRPBO4tp1k9Y8BE=;
        b=GH4xrEGEFPyLLaXMlIrG/hHfyjk9xtj8mCihZDJOG9n74wy1oRdLgPgFm0/qNoaEyd
         VAqC/gB/SRrfI9IwLhZnvNXUVqupCspAbeTfm2WPUqJf6S6N92EkUCYm00oPGs1Yvnsx
         dw1rHf21L0U1Cu0KY1I6NBYu0nFOC62/IbrG3/GlJ568G0Fe/GtqfHVS1XVtL34GAZax
         9fTf7ZVM+N/R4+1ZDaNuzVijXsMuefTFbrr3LmcbZxMvf0sccM+W/MtqmqVf6RLDBntN
         oxZK+p+M7L5DYM5Gn/d/WOpiyowTa8hOEuDC997opC19idjzQHuPAbqb2L4MhdhP7HHV
         VPeg==
X-Gm-Message-State: ALQs6tD1k/YMcIS7KJf2V5Rpe40cdC893VG6hnZfK9qDk6lSJmPfWNXg
        mEw3lpuoYjVLqbzAHBJ3tcEW0THW
X-Google-Smtp-Source: AB8JxZqGYEzQX+gIdw+NVxbJk7NrLioOF3eNRy893t5kke2dxud3+nPFPZ/7IohKW1uYU3C8R7YByQ==
X-Received: by 2002:a0c:bd02:: with SMTP id m2-v6mr14256057qvg.123.1525198543595;
        Tue, 01 May 2018 11:15:43 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id z16-v6sm9271945qta.34.2018.05.01.11.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:15:43 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 1/2] submodule: Add --progress option to add command
Date:   Tue,  1 May 2018 14:09:07 -0400
Message-Id: <20180501180908.17443-2-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180501180908.17443-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--progress was missing from add command, was only in update.
Add --progress where it makes sense (both clone helper commands).
Add missing documentation entry.
Add test.

Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
---
 Documentation/git-submodule.txt |  7 +++++++
 git-submodule.sh                |  5 ++++-
 t/t7400-submodule-basic.sh      | 31 +++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

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
index 24914963c..aa1c0bb67 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -117,6 +117,9 @@ cmd_add()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--progress)
+			progress="--progress"
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference_path=$2
@@ -255,7 +258,7 @@ or you are unsure what this means choose another name with the '--name' option."
 				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 		(
 			sanitize_submodule_env
 			cd "$sm_path" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a39e69a3e..d7225a74b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -126,6 +126,37 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'setup test repo' '
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file &&
+	 git commit -m one)
+'
+
+test_expect_success 'clone -o' '
+	git clone -o foo parent clone-o &&
+	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
+'
+
+test_expect_success 'redirected submodule add does not show progress' '
+	(
+		cd addtest &&
+		git submodule add "file://$submodurl/parent" submod-redirected \
+			>out 2>err &&
+		! grep % err &&
+		test_i18ngrep ! "Checking connectivity" err
+	)
+'
+
+test_expect_success 'redirected submodule add --progress does show progress' '
+	(
+		cd addtest &&
+		git submodule add --progress "file://$submodurl/parent" \
+			submod-redirected-progress >out 2>err && \
+		grep % err
+	)
+'
+
 test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
-- 
2.17.0.1.ge0414f29c.dirty

