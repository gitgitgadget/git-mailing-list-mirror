Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BB921847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeEBAbF (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:31:05 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45788 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbeEBAbE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:31:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id x22so9997667qkb.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RDa2v6Ndfg3JNsveqqrZYSf+Bg1PholcP7DdLN3dEqs=;
        b=YOOdsO7F0Dox8GnCspMXPCuBalQKIZb+4tVfPcSHrzelmZBDLYq0ozDPaCMzJvKY2O
         P8EYeeygtp99vo1Fz/qIYEKiSyThq291Nfa33VRb26ZTGYI2bvptdSIYtkUaW4uY+Flr
         Ph0vS3vRnVw5Q0XNAelJVplkMVVHmqX6ohavy5Kbfn6BeNMKTG2YmDqgD6DLMCDP38cY
         3NHIVEMP5UvcYx76H8hJHXezW8OYX0lyXff+UwjFQAnDlhehi2Lm6J5ltMu8AsKbROUq
         XxSSx4AybNsC0ler8Q5jEBsSw2YkM7HpuWp1sP9+LGfcj7aOKbOyeQVpBC6sVyKjE3jU
         eIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RDa2v6Ndfg3JNsveqqrZYSf+Bg1PholcP7DdLN3dEqs=;
        b=A3eQY5ItsC//e33Yb+IFRZ4Ej6ZijiU7b9ytFfzhjCHB4vj58DMxHLYJSKJYmRJ7bu
         mdhs7tv8464LA+ypNxrqmjmYTXlS1/9iXGlzdax6LalXF88kXZ8ZS4ndrOBgPTfccFz3
         TasWv6LLME8moeDBd+5SZpWhKuI4OZnbyVN0ZSzX5luC1rF7a2cWUEMhwfkhIoFWM8bA
         PC/I+tP1/u5vHmeyv+FrGMDLAlByHaN7v/zGixW8gNHGpiUu5Ab5q+zXiCrIX17cXf6W
         t7RoBNdloHUujl/QPvfc5cAs1o38wMOn/3HHHrd0uZ7HEKVdpA0NYM6kuHKNJSzb5J4S
         232g==
X-Gm-Message-State: ALQs6tDrFllyA3u1kMLKHQTY34OtfQAQqUfzfp/yxzaK0Dhu4KGcXnqg
        B/PRQmxKeze7NdLHJQfW0MFmornf
X-Google-Smtp-Source: AB8JxZpPKhAGHgo7VN2qbr5n8YsNDeLgSzNYiJRAVV1P7vfq2vWLWPDGZHYv132B8I78N9DCUiBeTw==
X-Received: by 10.55.136.134 with SMTP id k128mr13968318qkd.428.1525221063098;
        Tue, 01 May 2018 17:31:03 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id q10-v6sm9706428qtk.7.2018.05.01.17.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:31:02 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 2/3] submodule: add --progress option to add command
Date:   Tue,  1 May 2018 20:27:58 -0400
Message-Id: <20180502002759.8207-3-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180502002759.8207-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502002759.8207-1-kcghost@gmail.com>
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

