Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F395FC433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiDJLYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiDJLYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:24:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B0766606
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so19073045wrg.3
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26qoEvAhmtFVA73CF9+17LTxnIsEo6TY8/yc7YicL7s=;
        b=nu5cuongAiij+4mSB8zM6FFUBG+kU6r2kh889k+Cg8V9ZnnpKdFwejbbnSxSRPbyaV
         0zsAXqmDzxQIwG5GhF+euT4Eq2lRB7Gp/QbKfaEHiOzJnIsu0TpbipZ3WyYNoIQzE7d5
         8e3Sssm2u3uE2bSdDv2k4YOO4Lkrclly7HJjfAbvEmCOf313b37LMOi0YiHfbZo4VR7o
         04hPgTUM/oZFYnaORgatPt4nq8qmnoYA18URHbLB9Wo67yQDs42LYndMjDop8fqabQ1b
         h2FE6NKwJ1vui1ccGfFTjAnzfZZaRIuTwzImACSBnva1vwWD8jgVErYwHLY58jbbbNU4
         v5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26qoEvAhmtFVA73CF9+17LTxnIsEo6TY8/yc7YicL7s=;
        b=j5f+O7b/OK31Hpyv+g2ppPHtPcON8HzrA/rDZM5C+vJ/hZYWDi1TI/XBfUrFB6BWQE
         5PVDJGDMSe3b/fTwwkIXoyIvg/v2+yoLcMjJJZ/UwkdSwlITogPAJsNP4xgKcPTkmhTa
         zGDEr9TnZ/Ec6wcN3oxnVM8SnoG0cRRbtxzN/qKcs6JREYfQHszMDHldaQLLtI0iBR5j
         3+h042kV//+GsUEdkHdJbMYERGt01rSMkjvIFO+5qieLe7rocFyziA689RYVRNqR6wDk
         Tu+DrXm+DxR+jq2UErodlg3NYwOkSiE5FnPh0dBjMYmzJaiZYpNTKUWAz1VixRA4FFBL
         g29g==
X-Gm-Message-State: AOAM530xPQpPvqL482iKVHIZCtEeS34ujxCnr0hXC8iJs8U188TJuFLI
        3vRZOL5z5hObBzgyZSRRh4/dUzBjVyQ=
X-Google-Smtp-Source: ABdhPJwlk8a03f919e/WMr+U+DGQ+lJ0mnXKsL78zWcxie+C52WsW16mdLBb+lwAeeeZyl3vvnLW/A==
X-Received: by 2002:a05:6000:2c4:b0:204:14b4:e74a with SMTP id o4-20020a05600002c400b0020414b4e74amr20389438wry.608.1649589724338;
        Sun, 10 Apr 2022 04:22:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:22:03 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 5/6] t0066: remove redundant tests
Date:   Sun, 10 Apr 2022 14:18:51 +0300
Message-Id: <20220410111852.2097418-6-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove dir-iterator redundant tests since the new tests introduced in
045738486f (t0066: better test coverage for dir-iterator, 2022-04-07)
supersede them.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 24a4f1afef..974bb13092 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -894,46 +894,6 @@ test_expect_success 'dir_iterator_begin() should fail upon non directory paths'
 	test_cmp expected-non-dir-out actual-out
 '
 
-test_expect_success POSIXPERM,SANITY \
-'dir_iterator_advance() should not fail on errors by default' '
-
-	mkdir -p dir13/a &&
-	>dir13/a/b &&
-	chmod 0 dir13/a &&
-
-
-	cat >expected-no-permissions-out <<-EOF &&
-	[d] (a) [a] ./dir13/a
-	EOF
-
-	test-tool dir-iterator --dirs-before ./dir13 >actual-out &&
-	test_cmp expected-no-permissions-out actual-out &&
-
-	chmod 755 dir13/a &&
-	rm -rf dir13
-'
-
-test_expect_success POSIXPERM,SANITY \
-'dir_iterator_advance() should fail on errors, w/ pedantic flag' '
-
-	mkdir -p dir13/a &&
-	>dir13/a/b &&
-	chmod 0 dir13/a &&
-
-
-	cat >expected-no-permissions-pedantic-out <<-EOF &&
-	[d] (a) [a] ./dir13/a
-	dir_iterator_advance failure
-	EOF
-
-	test_must_fail test-tool dir-iterator --dirs-before \
-		--pedantic ./dir13 >actual-out &&
-	test_cmp expected-no-permissions-pedantic-out actual-out &&
-
-	chmod 755 dir13/a &&
-	rm -rf dir13
-'
-
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
 	mkdir -p dir14/a &&
 	mkdir -p dir14/b/c &&
-- 
2.35.1

