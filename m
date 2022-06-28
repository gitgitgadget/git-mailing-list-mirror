Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E0CCA480
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbiF1KGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbiF1KGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECB2E9F1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i25so11391734wrc.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLdd2zI7oDIBBxozChwG9QxyE+C58IfsKhy73Uc9Zww=;
        b=AR5yfeosf/2ujv7pbMIGzN9dZUoOmM3mxb9FVYVLna9Q+mAMnMPv5KsYNY7/gFGSUh
         HivapZGJwl99sF/34/9NeCrWdBe5+XpoUG4iY4fw0Pga7J09VUslHObaTgY/qd6a79Y9
         R+bERgeoSWsb48/QW2Ek7FdgBITJFRo2RFoIBkZym++UgA3CGWBnowroqs9HicHuBBQs
         HtXF472yyvtfO1lfKHzpIt7N90eFQfK+F+rjRAJ0Sd8PpLu12xs85/aoi591MPYGRyCb
         Ujn6o0RELz9Ydp8pbmFFUkwhnd22lNYgYTVQmVhfiuK5XXdyrGWPjaaX8K1HXCvRK6Eq
         epkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLdd2zI7oDIBBxozChwG9QxyE+C58IfsKhy73Uc9Zww=;
        b=D2wSvfU6pAUIJSOQ3uKMn/2B57PJBAD4opM5r+X9WQWaxuS+l+ZVUd12TmpImzEP4x
         S6M6Ffb3Ww9TIwkMRFOloeXwp28KQBlBU4xwwgswsMUh+zWNwUK11n28tyqj2xPTZScr
         ac/ISpzUo9oHtcKga2NKhMPHbq43FBkRm62kwkolhFtqTdyMEyu5I1ZtWrYi3Av88epr
         gJmVFGZE4Vl/hh1IzVk5eSrLtehETxb1jXooeEAPLvev3Ripk0G2LgO6iVyFMkLt7wby
         YGnliGRlWsM8yXAhptJn0yyWQwV4NgKHDHBXaFx+1Uf4mcEKRsOsfoIhSHkBkhODhD6z
         uCiQ==
X-Gm-Message-State: AJIora+ZuZ4tAWqJOxHLpE6UgvuzJCF/+LYCYD4TNpf/+APZmAY94MVC
        9h03663YxgZstyl23XCCCT8U3INTK5ondw==
X-Google-Smtp-Source: AGRyM1v2X0D8V4I+5l6P+geZvtwQxbkysvcCi6puKbe+NaYnTusARr+Q0asJG1PJpQ+E7e5z23JRmg==
X-Received: by 2002:a05:6000:1885:b0:21b:ad25:8ae6 with SMTP id a5-20020a056000188500b0021bad258ae6mr16368620wri.183.1656410772249;
        Tue, 28 Jun 2022 03:06:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/12] git-submodule.sh: remove unused top-level "--branch" argument
Date:   Tue, 28 Jun 2022 12:05:26 +0200
Message-Id: <patch-v4-04.12-52d97fd4c36-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
"--branch" option was supported as an option to "git submodule"
itself, i.e. "git submodule --branch" as a side-effect of its
implementation.

Then in b57e8119e6e (submodule: teach set-branch subcommand,
2019-02-08) when the "set-branch" subcommand was added the assertion
that we shouldn't have "--branch" anywhere except as an argument to
"add" and "set-branch" was copy/pasted from the adjacent check for
"--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
avoid "test <cond> -a/-o <cond>", 2014-06-10).

But there's been a logic error in that check, which at a glance looked
like it should be supporting:

    git submodule --branch <branch> (add | set-branch) [<options>]

But due to "||" in the condition (as opposed to "&&" for "--cache") if
we have "--branch" here already we'll emit usage, even for "add" and
"set-branch".

So in addition to never having documented this form, it hasn't worked
since b57e8119e6e was released with v2.22.0.

So it's safe to remove this code. I.e. we don't want to support the
form noted above, but only:

    git submodule (add | set-branch) --branch <branch> [<options>]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b99a00d9f84..20fc1b620fa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -574,14 +574,6 @@ do
 	-q|--quiet)
 		GIT_QUIET=1
 		;;
-	-b|--branch)
-		case "$2" in
-		'')
-			usage
-			;;
-		esac
-		branch="$2"; shift
-		;;
 	--cached)
 		cached=1
 		;;
@@ -609,12 +601,6 @@ then
     fi
 fi
 
-# "-b branch" is accepted only by "add" and "set-branch"
-if test -n "$branch" && (test "$command" != add || test "$command" != set-branch)
-then
-	usage
-fi
-
 # "--cached" is accepted only by "status" and "summary"
 if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
-- 
2.37.0.880.gf07d56b18ba

