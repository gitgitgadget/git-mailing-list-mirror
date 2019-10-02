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
	by dcvr.yhbt.net (Postfix) with ESMTP id E22941F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJBGO4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:14:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33541 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJBGOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:14:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so9781886pfl.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y5nsxGwniYdzWzhw7CuH1u1piMKEoHhkdkJYUzZ7L8w=;
        b=CXzgNZCQeoDdOBdgbWG9UJcuiA7Zfam6VUwKGv+5m+imDsn8GwgcdLmVhlsHi3I8e3
         h8Nnh5BJhGb6mRVsInF37WcSs5v/v35VJ53G2BGNuGislukQkBqozjzq5ikLbwsI9gmh
         /D72I3qW7qohm7gWkumdqGFQ8sVjBIUtUz+lXXKkzAMeRWsFhRzYVc5pwLVS+Tsj8lkB
         VFwK0VfanvP1M3v+Y4I/ecLZ9wvaFaR+gVbgjfZ6NpOLx87xL/uLNmVevbTSi+VNGuUe
         EGrRA5Y1NP57t1E8pRZ68ZrH66KHOjpgZ337CVf9bf8ZgQkYn/EtVwMuVaGecNBIbo9/
         tUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y5nsxGwniYdzWzhw7CuH1u1piMKEoHhkdkJYUzZ7L8w=;
        b=h4B3yy+L5C7AZ7Oym+2O7PwtWr4/vcaMkfOKvaF/70H8TCujXH7bAD0CU2deW5AUBa
         oKmntpeIwAUsrRHJ1ZcCvxSqSU3BVtrTL/f9PVXrfDWbm+rsiWSsHi9YyGOda69bqR6f
         2zkTUZ/Uk9iwfBzi8cxs/yJx2JTOa5NUjHJBgu/2QEKAczb+kYIMhwFCv52SJpa019Ll
         XQjK0hOzIuGzaGoDHDmTSlXTp4X8CBmF0ph0x+WVzu70EX2ua6XzZI+9Q2sisclq1EeH
         jHfJ/qaX3ZfKC5ctGg09D4ySwKdKZi82aJ/f9bzyGwAC4RxgyfaQiBzPsU5cadzva/Jy
         QLUQ==
X-Gm-Message-State: APjAAAWXBI6MnZeCwkvDuDwQ0X+PtUSXv3YwEvtbj6udzHO1b/my1FEv
        bZWfSp1N3W4YoDPAiC/BqRSh7jx6
X-Google-Smtp-Source: APXvYqz+zeV9IxbfL3SiXrQf2zmZLn92YXqto4JQ6Jd3m4PEF+sO2FVOEF7Q9bbxVJPOFZgi4Zt9Cg==
X-Received: by 2002:aa7:81cb:: with SMTP id c11mr2668342pfn.251.1569996894608;
        Tue, 01 Oct 2019 23:14:54 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id o185sm6849041pfg.136.2019.10.01.23.14.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 23:14:53 -0700 (PDT)
Date:   Tue, 1 Oct 2019 23:14:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t0000: cover GIT_SKIP_TESTS blindspot
Message-ID: <08273a0d0deae610b93d7f5eb28b0df5f978bf20.1569996425.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the tests for GIT_SKIP_TESTS do not cover the situation where
we skip an entire test suite. Add a test case so we cover this
blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch was created as a result of me teaching test-lib.sh to
recognise GIT_RUN_TESTS as a variable, similar to the --run option. That
patch is polished up and ready to go but I realised that running
something like

	make T=t4???-*.sh -j

covers all the use cases I was thinking of so I'm abandoning it. If
anyone has any use for that patch, though, let me know and I can send it
in.

 t/t0000-basic.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4c01f60dd3..1c5c75920e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -391,6 +391,23 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 	)
 "
 
+test_expect_success 'GIT_SKIP_TESTS entire suite' "
+	(
+		GIT_SKIP_TESTS='git' && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test git-skip-tests-entire-suite \
+			'GIT_SKIP_TESTS entire suite' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-entire-suite <<-\\EOF
+		> 1..0 # SKIP skip all tests in git
+		EOF
+	)
+"
+
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
 		'--run basic' --run='1 3 5' <<-\\EOF &&
-- 
2.23.0.248.g3a9dd8fb08

