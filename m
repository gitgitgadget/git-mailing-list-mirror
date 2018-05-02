Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A5F21847
	for <e@80x24.org>; Wed,  2 May 2018 01:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeEBBEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 21:04:23 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38820 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeEBBEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 21:04:20 -0400
Received: by mail-qk0-f194.google.com with SMTP id b39so10042961qkb.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FgwwLfwB8njl//EVzKhssgb/OoLi4ufxhWWTolWrxUU=;
        b=TPPGtkMbgsKnAs9Gvd9+bJDF/AlhwQW6zL/na6wQuYQHS5PpUi60dvwRfkWUeM3IkJ
         a8TnLfJQKsu5Gm0zp/YRHvsqjU3+ljT+hyRDQ+IAvWLSyli4mrRUbE/AnVQANvqsVEQn
         O4VCXkll0Y6Nq666XjMnVbCR6adiM3fivyPRTX71zl+tid3Pe3B77/HdykNR6th2za93
         SXuunPZrntw2REmRiBbXoOrWAFT/++ItpKaY2nBX/viGmGb6VUAYAUb3h9h3TiRBCTn0
         LHpp0YGaxQPStO4ZzueXe1KyWMoKyI4NjQlUZY4gu/q03s9TLjg+nsuWphxNKYhUVclW
         ZmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FgwwLfwB8njl//EVzKhssgb/OoLi4ufxhWWTolWrxUU=;
        b=UXfxTqgslHN3/KIEmJCliPKk1UEFGXS+N3EnLE2/70uaTabHwgzIwNQIbjwuMWsj7o
         8S48FL9+3Gg8X/I6xPtXXF6hLIQLjkdDqo3KyCC6PDVda0LEMu2/928VRQS3DxDgJTjM
         2gJAB95o0djf1HU8VWTQ6QXLC9QMaE5UhoyhYFGNPlp6LMyugB88cBg+0zSO8kDt0rb3
         shNdxB3x4bWKvccUXcD2mZukEAhXPJT0BvLkYhAn/+EF8nugM4dMX6VoVdi47mdFc7pG
         ihYUZdFSALN8ENbyiYLsSI35AriJzGGkJuACydZoyeGxJMo1SJzxiWV8P1inz7NMfq3y
         gLdQ==
X-Gm-Message-State: ALQs6tBUOiuNUsj9ulK/0MWSQdjcLW7B/vQnZxFewdzaO7FFs3V7/YO/
        JwrWo59uvouB/6BugUxfX38DfCBK
X-Google-Smtp-Source: AB8JxZo/RHLmeZoBsZHZBnZZiNZvDz5xzQH+JdNArC3t8qC8EsllV/S0k+caszGkorB1JBKienK0qg==
X-Received: by 10.55.66.74 with SMTP id p71mr13393688qka.59.1525223059619;
        Tue, 01 May 2018 18:04:19 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id p8-v6sm11076835qtp.73.2018.05.01.18.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 18:04:18 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 1/3] submodule: clean up subsititions in script
Date:   Tue,  1 May 2018 20:55:26 -0400
Message-Id: <20180502005528.19740-2-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180502005528.19740-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502005528.19740-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'recommend_shallow' and 'jobs' variables do not need quotes (they never contain
spaces) and do not require any additional prefix, therefore remove the
unnecessary subsitition.

'progress' is a boolean value. Treat it like the other boolean values in the
script by using a substitution.

Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
---
 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963c..262547968 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -465,7 +465,7 @@ cmd_update()
 			GIT_QUIET=1
 			;;
 		--progress)
-			progress="--progress"
+			progress=1
 			;;
 		-i|--init)
 			init=1
@@ -542,14 +542,14 @@ cmd_update()
 
 	{
 	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
-		${progress:+"$progress"} \
+		${progress:+"--progress"} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
-		${recommend_shallow:+"$recommend_shallow"} \
-		${jobs:+$jobs} \
+		$recommend_shallow \
+		$jobs \
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-- 
2.17.0.1.ge0414f29c.dirty

