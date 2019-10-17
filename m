Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D6C1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441762AbfJQXRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441747AbfJQXRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so2243626pgc.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N0RwbgMT7qOjOuF5P7xPwNJhhBdM1tVI5e8f7ty9QxQ=;
        b=nHyEbUzEjx94SZN7R+34n9OM6StRsYw78bASZti1RyF/pIV8PtO9lWllsOH9oSurrq
         KH+5/5IRIjJGcf10bWkUNZ5tIBxCzV5JLtI4uSAcJ0GMI1VUiOGCqKDWEMwcdjDrnUZB
         95Dz3VbNdTGsjwjYOlHaDGfyqmG9vXLPOfM2rceDcstSUTs4Cb9LRW1rqVM3oEQhNx2y
         8HC13B6pxkhDrsfwJPaNwebdS9zn0dK0McppXonZBpU9vtnNdrUKf8eid+ZAsQAZNpaI
         bbFdetAZDblqxQ3cDyA0Grha7m8vvF4ENUWpzA3S6Bxp/VMXvEdiROn15OgqlzMfv7MO
         LG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N0RwbgMT7qOjOuF5P7xPwNJhhBdM1tVI5e8f7ty9QxQ=;
        b=ldgpVJerSix/RerBnOIYLTnCOGlBcwKQDnegA+ncD9Hj+WiswY5R7jlN1Yvx6O3hX6
         UdDfFeXSGb9UpgbdQ3Gv+32/0qKYa8qlxZz887G2wE6IEzmz6CdMGLRcRXVa4MA9rAGW
         HItF1/XrnlVEicWbOGe9NU2BBX3smCqV+J7U6poRpzHYpp1l5cKd+IYumdUIVcwYrF5y
         L3xVA/uaj2lZq/+Ja6ElpX9AGAn3FtFX8Lx+nWyu2pOE1mqgvWEpuVZ7rvZX+sCuLALz
         jmcZ7IefgYRnUaRa/X75q1sVPUf8bgLF0m0/zKaMsyyWA9hBhDp8BKeshMtefElHDhhK
         IThg==
X-Gm-Message-State: APjAAAUEyltxlELuZCnyLnR7TUdlgsCN4eQCHnbpP0o/0ibnhAPBxMGf
        BEaLoLhCTcwlcpiVOK32tK1yckND
X-Google-Smtp-Source: APXvYqw8wazkRjMb7bjxIoADUWJX7e5LYS896RySMPVaS9zw/gXqF048jC6B+8s7LitHLQK5ruhZ4w==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr7238477pje.133.1571354225335;
        Thu, 17 Oct 2019 16:17:05 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 4sm3394188pja.29.2019.10.17.16.17.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:04 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 04/12] t5520: replace test -f with test_path_is_file
Message-ID: <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information. Replace `test -f` with test_path_is_file so that future
developers will have a better experience debugging these test cases.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 55560ce3cd..5ab5ec508a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -39,8 +39,8 @@ test_expect_success 'pulling into void' '
 		cd cloned &&
 		git pull ..
 	) &&
-	test -f file &&
-	test -f cloned/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned/file &&
 	test_cmp file cloned/file
 '
 
@@ -50,8 +50,8 @@ test_expect_success 'pulling into void using master:master' '
 		cd cloned-uho &&
 		git pull .. master:master
 	) &&
-	test -f file &&
-	test -f cloned-uho/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned-uho/file &&
 	test_cmp file cloned-uho/file
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	(
 		cd cloned-octopus &&
 		test_must_fail git pull .. master master &&
-		! test -f file
+		test_must_fail test_path_is_file file
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e

