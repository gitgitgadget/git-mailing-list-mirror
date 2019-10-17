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
	by dcvr.yhbt.net (Postfix) with ESMTP id D70031F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406801AbfJQXfV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:35:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43040 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406743AbfJQXfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:35:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so1888810plj.10
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjP/WhL2OFnXTnxLQQhDiOdVdDO/qxDMzJatvdC6Kvg=;
        b=c2yh1yb64WeV2MaOXS+0G99zG8SvQln6gZjqdB+kJvbCg86sK3q8G/tgFWa8Y/qw0k
         BnFyPlooQCVfui8pOSOl4M7tzKinMBJ/z81Dl7dkgqK75K1YaiMG99MH8ngvH90oYTWn
         //Uh6WDqurx34tZKbJH4A5g5BkQfK3D91X9UgYpxPfHPEPLuW2krtZxs3CkQOKmw8SYL
         vspG2Z4zgbf3tmH5c3lgp5YyPyFoQ96+lvCWktIv/5UTh1+KZcILOmoXq4lPopeh8sbl
         5ddQiUflX/2jDG+1MDioOfKBPXqv9vVzOLO2dX16zgOmJWAeqghQYo5Vjrn619XvCSLd
         gpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjP/WhL2OFnXTnxLQQhDiOdVdDO/qxDMzJatvdC6Kvg=;
        b=pKqmtsKlHUL9CWnxh/V2gej+kExSpP2cSoyxWvP+FwkqiaG50bHLRueAaXleafviqK
         kk/J8fy6BOdQoCZymLBhpcrZWAQmStEZajg8qEIHSA4zzox8Ck9JfvlfUNPR7g8YbU1t
         Hu4mXWZCu/fYyiRHa3p4JiGqwV1KBgObcGZmV+5ZUBVWWYtwMEITs6d/2/Zq8dzNzoxc
         87o9NQowrFOgDAt4Hsoht5EgBdEQ1CsvnUGzNoZOqzCpirr3JDAjZwnRBCOuU2dVy13b
         eSAd10ZxwaQKiPjALkNyy9vGmlYfNNH4+VjXxJRNfCcHwdjp0PE5PGzy6qYcrYtIyx7O
         qDAQ==
X-Gm-Message-State: APjAAAUiCo54npPWQBnd9yplaNJ+HGyDyJKD1KjW3PxFLPA04x908DTR
        SU5zjiJOId2gkcLWDqTVRm3TjEtc
X-Google-Smtp-Source: APXvYqxgL6sWRiVcVL+5A83MA3yAOrlmvEbzJUzc1XG/Ujd7TYcn31K/FUbg/ReH/CqJVTYr5eR4mA==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr6373846ply.142.1571355319709;
        Thu, 17 Oct 2019 16:35:19 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w189sm4080747pfw.101.2019.10.17.16.35.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:35:19 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:35:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4.5/12] t5520: replace test -f with test-lib functions
Message-ID: <542cd04c2ebda88b8fa63dc4dcb1c42d10afc844.1571355109.git.liu.denton@gmail.com>
References: <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file() so that future developers
will have a better experience debugging these test cases. Also, in the
case of `! test -f`, replace it with test_path_is_missing().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I just realised that test_path_is_missing() is a much better replacement
than `test_must_fail test_path_is_file`. Please use this patch instead
of 04/12.

 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 55560ce3cd..004d5884cd 100755
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
+		test_path_is_missing file
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e

