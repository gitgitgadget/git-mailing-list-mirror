Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F972023D
	for <e@80x24.org>; Thu,  3 May 2018 11:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeECLFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 07:05:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36954 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeECLFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 07:05:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id q13-v6so21440768qtp.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMZzKEteUfyCzT/qZBfW7QReESHsFabSyTK1698rGqw=;
        b=lv6k7SWgQUyOA+5SPtVane9CHf/VDaJq+oyE6Gdaz0vi8lp2uD6Xtu46w6XwIJjEZy
         2rwZlo4ETwMKMZv3CJGMKlMRhu0hoeChE/+ho0h7PT5bChS2YO8DqWqEUD/B22sv3M11
         NRNkqyLUnsC2ixXmK3Wz2wmWhWPdAMKB+kuQmh9ASD9dPU3eK6FAXQF7EyFhTfmgCsa9
         4gGc29fztQeKSKKNOwoSEv8NSRpnZmTL++TUEqQbqJ/lSN3seNxiygNWIS2aPrwbgLH2
         sLHLm+TKWIUwnkZ+7ATW4EQNtagx8A/RRD7q09E3kJGihZk+IR5skMyGem/OByBvePys
         S+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMZzKEteUfyCzT/qZBfW7QReESHsFabSyTK1698rGqw=;
        b=EJP1zvS9+LgOF3wJR4Au6VrtZi9NdlgXw1Mhd+VMeH9OV0DtuD7YiYVI6gxIZoaleY
         thRvRRrsL/4ywCa7RhEMsD9YWMVsoQ9D7vQxqn/laJ0bsfMKjMX7sYQYfAV1bUGwj1gt
         I54ZF3LFnBrH2bvCowM3H1mbG5Q1y3rtboFcC6XxQouzROiz7T6E+DAqx98Q13G1niUJ
         ONRHzlyFoPiU9/b3pICu8JuZydqn8ckl8mtzi5gVzqwwEsyaUIB/AWcMxYipPnY6VnHg
         Q3tQuw7aAbWIF8Dqsu/a/9W0r/nuWr3jhHfv6yfU0ltamobkaUJRf7x9yivSmb4ZVYgA
         dpUg==
X-Gm-Message-State: ALQs6tDkRd8AEKYhQ4ZaQbjwUemfhdAR/+nid9/tXXdhgQgEMhr6XxBQ
        aV2GPXG/BvoJVTJOcuszrmuHuJ0z
X-Google-Smtp-Source: AB8JxZpCoib0WCMHNR84tioPjU5OCP7FbnxFZcnTxstStj1sZq6C/LjVNJnH0hC8KJRAYXSS3aAGpg==
X-Received: by 2002:a0c:9b8a:: with SMTP id o10-v6mr2997671qve.89.1525345500725;
        Thu, 03 May 2018 04:05:00 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id o14-v6sm12840833qta.23.2018.05.03.04.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 04:05:00 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        gitster@pobox.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH v4 1/3] submodule: clean up subsititions in script
Date:   Thu,  3 May 2018 06:53:44 -0400
Message-Id: <20180503105346.1758-2-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180503105346.1758-1-kcghost@gmail.com>
References: <20180503105346.1758-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'recommend_shallow' and 'jobs' variables do not need quotes. They only hold a
single token value, and even if they were multi-token it is likely we would want
them split at IFS rather than pass a single string.

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

