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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4471F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKLXH7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37811 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so178231plb.4
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehClOtXeJvk1X2u2IfGOSvQ15sUfVAfCLDCqLTbaP6I=;
        b=Pg1qeId9xcQD3R977p73AXWXWTU9Xd77V317OxYDkX8vxJAruxVWzQk3HM+tgS0PG2
         uOxYE973XCkK1QPnIXCTfJX7Yp2sixPqnY1JdDqtaMlP4hOQNukT8crie2Q8MRfY8Fmc
         u5vl/nvxm97PuZol3OZU81JFyAArXF7a4L5AcgGOPehUEWnFWkOC2bBwh2tO8oS8H9zQ
         SyVMcjeWcc8Nsrw/lnEn3c7JUc2wSrBnj9h0B2jT62vOzEJG6tGX9GIxf9rp2OSqGoDD
         wdrzFICrE2akDemoY1SwjEshEqwFi8lypnQA51BZ41LhJnOPbb7jBc4y5XJmpt4PWhsv
         y2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehClOtXeJvk1X2u2IfGOSvQ15sUfVAfCLDCqLTbaP6I=;
        b=eJUo3UQBzTAjDxlrrVnb6W/A4tBwnyHq/4Q9nIJac7mydBHlTmth3+XhjvsF7XYuPq
         rEdpy4CixQQupUsLtFn+Y9L8pppunxrWB0u/wL+9tZSv+9JfKoi5QqQWKywnufzmdbjx
         5I9ZeX6xNNVUnRRZ6ZAiuMdH2AsU6WrXvawT6IScWZVFLZuq/KvKugm8BnQIu7EIeWnw
         NDXcNuEzpDQEiSzQLp6bHgi0aD/HbghIxlQAf+eKirww+FD0ME/iAzOeL+ItuweM7q+f
         GAJ96mMjKXUzNU6NMZQXaEuSXQWPCpjrZFf7ICVOvhbHrM0AboXpuKn4TzpDgemeXlo0
         GIFA==
X-Gm-Message-State: APjAAAUsabj0ngnc2P9pXWtp5O89Ucfq6TI5jYDRmgSNH1yOdKxRFlJF
        u4tk2Uhtyfj2ljrr+xd/8YUDGu9t
X-Google-Smtp-Source: APXvYqwVPZKnGEbXJC23LJ/ot2tAXWKD9OfDMQ8iD6YIF8MCZUIupxFk9gqFJcPvZTdLGjE9RCAR2g==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr292092plj.229.1573600077629;
        Tue, 12 Nov 2019 15:07:57 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id f8sm54811pgd.64.2019.11.12.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:56 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 05/14] t5520: replace test -f with test-lib functions
Message-ID: <00b7143b30d6527b25a48e6ba829d635170b6a43.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
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
2.24.0.346.gee0de6d492

