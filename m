Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CFC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiF3VTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiF3VTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E245784
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so346224wrc.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=OwbA3auC3v3lvlwF9ecupzl1jyyozPLn60e/JUGVZJc=;
        b=bZ8bV9Z8J5WKE0ie2xvthHKWg+SRilxFm1cKaFAEKMrjIPqLSqM9Qy1y9TjljhKrgb
         BMIP6+JYSL4IXckIRyz2B0b7izJMZYsGRNyt+TtszAk24z0RmTwH9d+tisKQfB/FvcUf
         3ggQGQk2grMm/kq1umdOXuUtkXG5cuv/S65tFLsFHE7ukgJ5ZcAyuU3rqLFvisKAEHyl
         Q7b0CVmwzOgDOFROig1Qq738NKRbyKkR/xkbnpvlE82MY8Ci/+U4P75ac7xAq7yt5oFN
         07DuSwQuAkxeAo07RqnBladyNv/A4SAf/3iKNP9ZK4VFUbXMmlCd3z3zKF2G1SWbK/H0
         T0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=OwbA3auC3v3lvlwF9ecupzl1jyyozPLn60e/JUGVZJc=;
        b=KnQzoMX0JyvVT2c4UFgwBrZLf77TmVyeOxN61NQ5Ndxmw7CdlKF9s7srxUW+8eADcI
         Cwv6hkIhrl601DZG5MDO4iQwyuWYXZMhEryavL3CCExP40vuoC4z2ROQ7jz63nb3er6C
         LoXoVlZUa6IrY9bV8MTPbW7EUG01M4tIEFYTXihWYM/1jYeFMSgv2YDLMdejJrFVNKLh
         2PL/Gs0VYnhMaLJGFsQUBlngoyGG5GwDoGQFY4fpXICSV9Z5o+vN6LHWtjK6DrdICZEk
         oWdAkN5vbBcoZ5kygLQGLqzbc/i47rNks79QdVZvL/lNuQbmAMc/IeSxC7N3mUbYwjH+
         gpfg==
X-Gm-Message-State: AJIora8rU/XbspVB/t9ePiMvqkyRps7PuML9LvzCK7X8h1xxfWcyJw1d
        +GaOKmh/Uh919mGi0QUNzygWTE//sbg=
X-Google-Smtp-Source: AGRyM1uhOjkMgWYZj2OLiaUy5NcxLMX7/O6A6mP549GLEuBv92JhUnAqgtvI+Ja/svO7KGgzyg/csg==
X-Received: by 2002:a5d:4d02:0:b0:21d:31c5:ed18 with SMTP id z2-20020a5d4d02000000b0021d31c5ed18mr7840538wrt.673.1656623982803;
        Thu, 30 Jun 2022 14:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b0021b9e360523sm20862123wru.8.2022.06.30.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:42 -0700 (PDT)
Message-Id: <960fad98e8a8d4c123bb5040f616f856cb9925ea.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:22 +0000
Subject: [PATCH v2 02/18] git-submodule.sh: remove unused $prefix variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Remove the $prefix variable which isn't used anymore, and hasn't been
since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
2022-03-15).

Before that we'd use it to invoke "git submodule--helper" with the
"--recursive-prefix" option, but since b3c5f5cb048 that "git
submodule--helper" option is only used when it invokes itself.

So the "--recursive-prefix" option is still in use, but at this point
only when the helper invokes itself during submodule recursion. See
the "--recursive-prefix" option added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc436c4ca47..53847bbf6e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -41,7 +41,6 @@ files=
 remote=
 nofetch=
 update=
-prefix=
 custom_name=
 depth=
 progress=
@@ -127,7 +126,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -189,7 +188,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -346,7 +345,6 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-- 
gitgitgadget

