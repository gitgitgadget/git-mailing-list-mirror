Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38201F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKOBBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so4862572pgu.13
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfeGMNg6eFWjRHGLYhIIuUkmw5j6ckKkE2S4osRZgDc=;
        b=gMU33jtZt2K9zPTmRG+qcPbMIFjzFRMT88xBUiOZfs/vE4igoWV4TK9iZHMa+IzDe3
         jV/xyiF95DLXFKTXsGW1cDiCB7gDech6oDlUnjnIJ/EIZ7UiIrQUpJ4R/E3Tk1yV78IU
         R9ysWXn6/hBlOgEe7j7RYNCDe2cNegNm97FNLggOhPvk4Lk2owQnayWwrZCiBXkkS8Zv
         zZnW9eYJtj+7WkgB3rLe3vYrDOObT1o8Lz/vbTQTv3FUFBPgj5+UeI6G93zYpBrFzu+c
         ebL6mX1VV58VKhglQU/IZiIWzaSji9cHxc5OAHMuPxvCm07pwfJQMTue2bnzx6yWa4Qs
         zwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfeGMNg6eFWjRHGLYhIIuUkmw5j6ckKkE2S4osRZgDc=;
        b=g9X6At3y+xjFaCI829sq6HYUUU33RNZ6gDR8YGDrtp3/O1V9AQaZC4rZdyvUG7ocu1
         N44O8US5kJZRIJS1PnVAcB4SA0XAAbuQye6nYHs2mfYAy9Cd+anNuprXFe0xWKii6Yz9
         gMWrWTNvrdWtfQ5JIBA2B5+9FLsd3/+tkLx+bAhOUEqa2MOTGWOz9K2KfOrAV1sT26s7
         W5FbKnnOivaQ+Ev1mRx8w4bqUndqDz5RkaablqkPnw/A+9Jc7zVpsaKx1VpJu3qNwbMt
         vd6U7MN8MYp4FiYy+m0QjKPqxbx14i/T06I8dJPlkhvyvBYk9sqnb4XN1eFtygFddzlW
         jSig==
X-Gm-Message-State: APjAAAXTF/QcEHptBlsqpF3laiuWEy3qWYWw8/zk/wiVWS1zQjKza+a/
        zGxzcfZD9mj/jA07MB2cX4TfK9UU
X-Google-Smtp-Source: APXvYqydAyfOW16Lm7qOzf9xmgxrmUpSYBrendWcEsL7jtul8EtsFqvlDEoIPGGoFL/6rZjD5sw3sg==
X-Received: by 2002:a63:fe4d:: with SMTP id x13mr12771314pgj.82.1573779657088;
        Thu, 14 Nov 2019 17:00:57 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id o125sm7639775pfg.118.2019.11.14.17.00.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:56 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 10/27] t4138: stop losing return codes of git commands
Message-ID: <d617cbaaf1232e45b077786afaa9d3465a9bbd35.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4138-apply-ws-expansion.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 3b636a63a3..60435d6d41 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -17,8 +17,8 @@ test_expect_success setup '
 	printf "\t%s\n" 1 2 3 >after &&
 	printf "%64s\n" a b c >>after &&
 	printf "\t%s\n" 4 5 6 >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
+	test_must_fail git diff --no-index before after >patch1.patch.raw &&
+	sed -e "s/before/test-1/" -e "s/after/test-1/" patch1.patch.raw >patch1.patch &&
 	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
 	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
 
@@ -33,8 +33,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-2/" -e "s/after/test-2/" >patch2.patch &&
+	test_must_fail git diff --no-index before after >patch2.patch.raw &&
+	sed -e "s/before/test-2/" -e "s/after/test-2/" patch2.patch.raw >patch2.patch &&
 	printf "%64s\n" a b c d e f >test-2 &&
 	printf "%64s\n" a b c >expect-2 &&
 	x=1 &&
@@ -56,8 +56,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-	sed -e "s/before/test-3/" -e "s/after/test-3/" >patch3.patch &&
+	test_must_fail git diff --no-index before after >patch3.patch.raw &&
+	sed -e "s/before/test-3/" -e "s/after/test-3/" patch3.patch.raw >patch3.patch &&
 	printf "%64s\n" a b c d e f >test-3 &&
 	printf "%64s\n" a b c >expect-3 &&
 	x=0 &&
@@ -84,8 +84,8 @@ test_expect_success setup '
 		printf "\t%02d\n" $x >>after
 		x=$(( $x + 1 ))
 	done &&
-	git diff --no-index before after |
-	sed -e "s/before/test-4/" -e "s/after/test-4/" >patch4.patch &&
+	test_must_fail git diff --no-index before after >patch4.patch.raw &&
+	sed -e "s/before/test-4/" -e "s/after/test-4/" patch4.patch.raw >patch4.patch &&
 	>test-4 &&
 	x=0 &&
 	while test $x -lt 50
-- 
2.24.0.399.gf8350c9437

