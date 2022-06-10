Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB59C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiFJA03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiFJA02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51352B2D
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so383067wmq.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/HtlR/8woWVcB6tpY3Nnxi6/V6ubb2kVVJZAf2hl7eQ=;
        b=IxU6OP4ocPBLTaLcJnrx/5hiH2s4W+YDY/n9IVeF7fyCMytLREJI/uENoIsSgnvr/m
         M1XvnkU3NZqLaqxdEGUOvB7jmuWhQqqd7RnHl4dtBJKABNw2Slvpye8Nh4989SCYXYEd
         mHJhGDyStFLJAGskXE6XN0wAq+sUosk4Fj6sxeiDTt/n4Ar2BiPiKTNixY0dk4mqDGk9
         5Z4gPg4XKV8MQoeldvvs3SOpmUNntga89DH7DB0BuY30ZbHeCiFEbM8V/KIqJHqwcdFi
         ChAhtBHCyb8VXgJHID0WdtDHoJv41XrFlbtem4llfeyZQ/3bU11IClt0RukQjqWGvkaD
         qCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/HtlR/8woWVcB6tpY3Nnxi6/V6ubb2kVVJZAf2hl7eQ=;
        b=hg2jes3sIBNifvmBFyM8A0GYQ5mJTdZu7+h8zc/r4As9Nwi1oEP9fdjEEWGo0pnI24
         NBsGeu3r7l/5Ixk3T2GUvizsg8TgWEHwDt5vzxpVM8+B0RoVxGmzmmCbvqA2UDiDDyHr
         DMyyf2d44RxWDcwucrmjQeNTQ8JV6lWE8NXNDDtKHJBZWj1R9yIY0DYxGHE9jWcqLu9f
         /WFVAHfdsrw2KA943ln6W3YMR4HmIOM6DwZ5vG9JJLr+ZCPUTKcZfAP7o1lcjjpSMaB5
         c4dNH3NSH4/1sV/Pj6Rpp+PqLSSj0fSa/5dnJn8bcWLnC8/KikhL94/JEMcA/UejRZlK
         46QQ==
X-Gm-Message-State: AOAM530epd3B2qSOZkogoD9MHRnrP8bD+JGNuLOCqkhxZwxlFqhqq5oQ
        K3JazHDZWN5rcPbsZzbSfyzxPr3RvmM/Poa9
X-Google-Smtp-Source: ABdhPJwXrqBqg3ac4X75KpNHkU4nIuCl6GW6I7m6OlT0Izhx3M45Ok0pqirv6x/0DAaUVKESk+1Gbg==
X-Received: by 2002:a7b:c10d:0:b0:39c:4a17:1e90 with SMTP id w13-20020a7bc10d000000b0039c4a171e90mr5743388wmi.108.1654820783945;
        Thu, 09 Jun 2022 17:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0021004d7d75asm26439313wrn.84.2022.06.09.17.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:23 -0700 (PDT)
Message-Id: <0eec4debd0498b22a2279e53f3b9548ae3d673da.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:14 +0000
Subject: [PATCH 1/8] submodule update: remove intermediate parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When the cmd_*() functions in git-submodule.sh parse options, they
sometimes set an intermediate variable to "1", check if the variable is
set, and if so, pass a string option to "git submodule--helper".

In many cases, this parsing and unparsing is unnecessary because the
"git submodule--helper" command already understands the literal options
passed to "git submodule", e.g. when we see "--init", we don't need to
set "init=1" only to pass "${init:+--init}" again.

In cmd_update(), remove unnecessary "${variable+option}" expressions by
passing the literal option to "git submodule--helper update". Do this by
appending the string option into a catch-all "opts", so that the
intermediate variable becomes unused and can be removed.

This slightly changes the options we pass to "git submodule--helper
update" because we now pass every instance of the option instead of only
passing it once. This is probably a good thing though, because it's more
consistent to handle this in C instead of custom shell code.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fd0b4a2c947..f4679e0db80 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -38,17 +38,13 @@ recursive=
 init=
 require_init=
 files=
-remote=
-nofetch=
 update=
 prefix=
 custom_name=
 depth=
 progress=
 dissociate=
-single_branch=
 jobs=
-recommend_shallow=
 filter=
 
 isnumber()
@@ -246,6 +242,7 @@ cmd_deinit()
 #
 cmd_update()
 {
+	opts=
 	# parse $args after "submodule ... update".
 	while test $# -ne 0
 	do
@@ -257,7 +254,7 @@ cmd_update()
 			unset GIT_QUIET
 			;;
 		--progress)
-			progress=1
+			opts="$opts $1"
 			;;
 		-i|--init)
 			init=1
@@ -267,13 +264,13 @@ cmd_update()
 			require_init=1
 			;;
 		--remote)
-			remote=1
+			opts="$opts $1"
 			;;
 		-N|--no-fetch)
-			nofetch=1
+			opts="$opts $1"
 			;;
 		-f|--force)
-			force=$1
+			opts="$opts $1"
 			;;
 		-r|--rebase)
 			update="rebase"
@@ -287,13 +284,13 @@ cmd_update()
 			reference="$1"
 			;;
 		--dissociate)
-			dissociate=1
+			opts="$opts $1"
 			;;
 		-m|--merge)
 			update="merge"
 			;;
 		--recursive)
-			recursive=1
+			opts="$opts $1"
 			;;
 		--checkout)
 			update="checkout"
@@ -350,24 +347,18 @@ cmd_update()
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${GIT_QUIET:+--quiet} \
-		${force:+--force} \
-		${progress:+"--progress"} \
-		${remote:+--remote} \
-		${recursive:+--recursive} \
 		${init:+--init} \
-		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
 		${require_init:+--require-init} \
-		${dissociate:+"--dissociate"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		$filter \
+		$opts \
 		-- \
 		"$@"
 }
-- 
gitgitgadget

