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
	by dcvr.yhbt.net (Postfix) with ESMTP id 936041F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLBIf (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 20:08:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47095 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfKLBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 20:08:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so12024129pfc.13
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PnAPQWQsUEt4wwWHImoVnvv+5EITS4xBtB+T58NzyJ0=;
        b=cAULtbIZyeHnysOMEgkM+Lzwo0W2JWesfcamNhhGL1rUg1nRP3cPNVEJjZinlkT7KY
         2aDD+x9gBsqboUOYJrlzT7imk2vbn8Df0bBomk00HNyfL3jH41IbxifFtIhrIctGqczB
         1vVTIcPgUdpdI+rtho5xqnWGGlWy21CVqUZ5LMXlHN7EWmEjVOExDWJhcIigBUUUFD1y
         vrcNx0UNi5QiwV/4rM68QqupsaFSkkmcuqmuSv1fQTyGlJ3QHsXlYN5SXrGLSR73D5Nm
         zfk+Bj/iKdbvAcDp8ez8dyiXex2RiZ2KipKT0oQJgnb/QF+f6w8NzS+2kA3blZe6NguP
         19bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PnAPQWQsUEt4wwWHImoVnvv+5EITS4xBtB+T58NzyJ0=;
        b=piAaE6tCpXxKDPS5HcTeY2lJrtLdFmszC+VimAJwAXGZH4OzOz07R0MvykFgaFbYk/
         Lm8ltxkNtfKbVQJZ5b7Qe2zZTCBWJzrSjmlWVWWcVAAxYIOo8XS5YEYt/O48ML/o7EU3
         /ipvGTThumOGGE+ofDoB6UIxxcwOYDk7ZI8Wu1CBmHzx5EBuIfso3TTUqqIb1463uDO/
         wkHieAjhbT5YAHP2ma5deiglXlL7ErSC9571yamcNqor/y6vGkdCQ2uwTCkBMm6ox8LI
         gyd2uJnnr6WvVWcVpm4IKe/QlEvqTMKXzWcRhLWFmSpsWldUuyIWGPFZJJ7sOauxryj2
         aR0g==
X-Gm-Message-State: APjAAAVHVMlVOROhiyAiEtXKuvh+PnO1sGOlyPvZwbU4edV6Tf+/PcMW
        QXsAO5HYbkK8DbeKOJeLLLu5UeTF
X-Google-Smtp-Source: APXvYqzyRSJX8eNbNqkjFwrSKBQ999y+TaQ0qhK9QGBDzvcN2DkXguPAAjkv/V7uq4dVLj+6RLZT4Q==
X-Received: by 2002:a63:225f:: with SMTP id t31mr19000333pgm.358.1573520913333;
        Mon, 11 Nov 2019 17:08:33 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a6sm2967665pgc.4.2019.11.11.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:08:32 -0800 (PST)
Date:   Mon, 11 Nov 2019 17:08:29 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     James Coglan <jcoglan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH] t4215: don't put git commands upstream of pipe
Message-ID: <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
References: <20191018152121.GE29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018152121.GE29845@szeder.dev>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git commands are placed in the upstream of a pipe, their return
codes are lost. In this particular case, it is especially bad since we
are testing the intricacies of `git log --graph` behavior and if we hit
an unexpected failure or segfault, we want to know this.

Redirect the output of git commands upstream of pipe into a file and
have sed read from that file so that git failures are detected.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the suggestion, Gábor. (Is that how I should refer to you? I
recently learned that some poeple write their names in ALL CAPS as a
convention.)

A little late to the party but since this cleanup hasn't been done yet,
let's do it now. We can apply this patch to the tip of
'jc/log-graph-simplify'.

 t/t4215-log-skewed-merges.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index d33c6438d8..0a2555fb28 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -31,7 +31,8 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	git checkout _p && git merge --no-ff _r -m G &&
 	git checkout @^^ && git merge --no-ff _p -m H &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -68,7 +69,8 @@ test_expect_success 'log --graph with left-skewed merge' '
 	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
 	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -99,7 +101,8 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
 	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -139,7 +142,8 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
 	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -175,7 +179,8 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
 	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -210,7 +215,8 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	git merge --no-ff 4_p -m 4_G &&
 	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
 
-	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --date-order --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
@@ -250,7 +256,8 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	git checkout 5_r &&
 	git merge --no-ff 5_s -m 5_H &&
 
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	git log --graph --pretty=tformat:%s >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.24.0.300.g722ba42680

