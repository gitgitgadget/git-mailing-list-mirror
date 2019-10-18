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
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C2A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbfJRWKh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33659 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390408AbfJRWKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so3509343pls.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdbRREHR3G+YqzRMS3O8dG+eB1ZWdwu62/sUlzQo810=;
        b=NU2dJ7Lft92zeKRZnHMOxYuvS5vhz//UWq2qAlxpbJSGJ2z4hCeFwA3Osv+Oc/f6y3
         wTLpRwmu1RJRc8mqSO2oa5xUUWk4Z4zwNDMy1tvmojox1yYaye8xkyIKcNnEje/deWdg
         +FobhlT5Q2fGrWk3rtXH2pzR6+DJ75p3ScQo/KZ0fUEZnJ/MHftJOLKuPWPBUPtz5Eho
         fB5WMqj41iZKh7JIojJnIJD5o2LTXIZcqh9qpOFHw5+WCrWqjmTbadlYA/+5TN7r7pJ5
         UUWVn6m6CvhxBfrYcXR2CupmL4FLNmAtzrGZPlzB7K82IaXVLttnW9eUNdT30LWMn/i1
         DS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdbRREHR3G+YqzRMS3O8dG+eB1ZWdwu62/sUlzQo810=;
        b=oWWJj8cwslj8mH89Dxq7FtscL5obKcNcLLSEP56NncMpLAqupPQ8o3vOO0N6a5ktyl
         rz7+ooYHcgv6x/4s/xkGsure16jrlV8Z8d9zMGy1/B5CEKijNxcr63ErRlT0wiKdCP7A
         lBNOdhL/EOhwovxdfo3s6uSUCZEB8ncNc3TEICxvsdykbEYSkgrMMWsfVqO2Z9xADMLg
         daFuTzxMXMO8nhMHy3HwmzBNQjPCWKAI0D7JGtseyH+RdwS1bWQDs54OAX4CoGFSM0oC
         zCcw4f0oUctpJD8Z5rWBWbMeeHDXV+oNTeGEQWZIzxSpo/MZreH7JRe0SX4js6463mST
         oNeg==
X-Gm-Message-State: APjAAAUYIVYveCMs5PPbA27Cy287EMSMhhMe3VGudopCQCUVzRkwQqvT
        QAxGeufmdTCFC1gab0uChPP1v/pE
X-Google-Smtp-Source: APXvYqy7OMlHuyno59tCCVIOdJLtZJbT9la+G6lKc7KOpgYS+Vw3WYjPPSYP9MvUYqxLIBKhY1jx6A==
X-Received: by 2002:a17:902:d689:: with SMTP id v9mr7665622ply.198.1571436634584;
        Fri, 18 Oct 2019 15:10:34 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id c4sm6184013pgd.3.2019.10.18.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:33 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/15] t5520: replace test -f with test-lib functions
Message-ID: <c6ca45eb17644be2cefe16af67564f310ddd8ad2.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file() so that future developers
will have a better experience debugging these test cases.

Also, in the case of `! test -f`, not only should that path not be a
file, it shouldn't exist at all so replace it with
test_path_is_missing().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
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

