Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DEAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiFJCB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiFJCBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26E4CA3F7
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so11523121wra.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxo57WXrbB1s9uw2aXgTIZGpxcgEDIRRjIaQehMuEbo=;
        b=T+Zq1N9jkt0p9IFUr2w9Isl64DfI8jDh1zub7sGfeNmhwTV2sAPxYLj01n2Ubce3wd
         Ed2wG1mSuzaUXp6aSuWjenBzQ0RQ8Q98Dv9ictzVKNJV0MI7geJoUjUDzKa8/QaXn7q6
         j4yli3IkUWd/CxeJ8Jron7j0x3+cOMp5BbiPE/hGJVP/Uolxu0kgTMMoFb7cNWhAdMCR
         JoSvwCjxmkNyXNwBm5JoC67MFtAWTp3ww+87+va/M9MLFRFinB175YyUvMTi7MB9P4NP
         9eQXfgdfxVsBqT7YoagnKKS4hOUYc5/l7iW/fSgSLCPIcW/q0ocWIT7OK04Hi/kycKuC
         8wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxo57WXrbB1s9uw2aXgTIZGpxcgEDIRRjIaQehMuEbo=;
        b=PL+n0ZijQ5eZ6GK3NU0owLQE4lG5os0yt9dtJ6ltt5hT0O7fv81tff7HhcyDRaAQJ5
         nXAc9uZKmHfG3HMrtATDaxlf/S14KyeeEukAe2MP6HnP1nFTgSqvXIFRaOt4bPTn9Gz2
         EjANw8O+wKqkWNFXhKzg0mfrwLuJ2ypJIGkmf4D8+Rb4p/8pavGJrbQHLzuvrgP4E5gB
         8WX6vontENAs4xZvIbKbo3Xq7FPppv5TBOjMCMhnDo1OFMVmY9MVZ88qXKtEwwwbc0zY
         EXsNEJPDcRjwZfDc37LYtyifHnlavYYXe7Ooo9a/5w4n75kMom/4wo0iPAR2cB0EGK4C
         X12w==
X-Gm-Message-State: AOAM531ZFUAC+znVwrut4DvYtbcq/YeD8Z+BMCDJYQUiqFuno5SoNBty
        nvirOICccwkop8K43LKDUrAKArIOWV4AlQ==
X-Google-Smtp-Source: ABdhPJymVJvaQt8srqdh0Xfa3YFtCLuSvLTPxMmXF12zCj/2/Z0pG2jEIf+SdSQwBcm7ktBXRsnYDQ==
X-Received: by 2002:adf:e58c:0:b0:210:2f76:93fc with SMTP id l12-20020adfe58c000000b002102f7693fcmr39306674wrm.573.1654826508049;
        Thu, 09 Jun 2022 19:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 04/20] git-submodule.sh: normalize parsing of "--branch"
Date:   Fri, 10 Jun 2022 04:01:16 +0200
Message-Id: <RFC-patch-04.20-f27723aa0a2-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
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

But there's been a logic error in that check, this looked like it
should be supporting:

    git submodule --branch <branch> (add | set-branch) [<options>]

But due to "||" in the condition (as opposed to "&&" for "--cache") if
we have "--branch" here already we'll emit usage, even for "add" and
"set-branch".

Since nobody's complained about "--branch <branch>" not being
supported as argument to "git submodule" itself, i.e. we want to
support:

    git submodule (add | set-branch) --branch <branch>  [<options>]

But not the first form noted above. Let's just remove this code, we've
never documented "--branch" as a top-level option (unlike "--quiet"),
so this looks like it was an accident of the implementation, which we
broke v2.22.0, so we also know it must not have been important to
anyone.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 53847bbf6e2..1b0a31b8383 100755
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
 		cached="$1"
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
2.36.1.1178.gb5b1747c546

