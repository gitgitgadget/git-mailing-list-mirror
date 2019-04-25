Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8026F1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfDYJyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfDYJyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so10855270plo.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cd608Ig3G+RmuqNxHKJ5+L67jKPXtl5IZitUAWtwr60=;
        b=Wxg4poWM2JVqM2fw3jMAxFfk/PtCZuWVg0vPSzMA1qe9WBY4pVb+fvzeKiCTildNjy
         mcdn1scWbKel4RDebhn8pMD1hnUw9Ny6rmXJnzXeRVUZCgjJuRN++marAfE753Bj2Upo
         kC0RgucjB/5Rst33n6h12knGaZKDU+vSms8cX0y0rjjjqwo4hnLSIlrUhEEuvFqR5H+O
         6IEgougfOQ8+N+adfHy/+fUDlLGSgbUH9RqK9Whi92cyz1kTdA6Rh4dyFQVgELdddBDR
         wOCEkxF24EY4G/0m5mHPQB71c0GfRwAo0Ihe8GjkblZdRoUvuT4zjj3/jDS5gltsk54z
         qOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cd608Ig3G+RmuqNxHKJ5+L67jKPXtl5IZitUAWtwr60=;
        b=YUQ2Ng6ukD9VwmQXCbqsjUhjmzhDHZGwvwGHg1CvY92wNXy1X6FZnBTSN+DCwD31lQ
         ZHKLHPKl0ttpGUQutOfwhlrXIZraHM/CL0vmELKKAjl1hfMICq7jDV2VF/rj2/X5VDQA
         3zHm+Z00GNgSCqlYJzcqHAdnyqAKHe0ECs1TM6asJzU+kXcpXdHdh8XpaRn4yfQXvLQI
         HyHIdzhoOVwXjc6+xqzC5tm0xNtAMq7SAORaV76/hCtc69bY9TgdYKTTY4OJpK+2AR/L
         XKdzc/6TE+v9WMyduFkMJttZReioF8GO2eBsS4YKt8VAOZNiYZPkG3Da322GBtXGa3dt
         fYxA==
X-Gm-Message-State: APjAAAXaTntejjyUZY3uhHX4zIxa5KgQ597wHluPqwVLTwqHMIBAKBeF
        sCE4YHTD2o/Ss5suninAGEqezqSn
X-Google-Smtp-Source: APXvYqxStzWgB9dsJqSoHVzSaW+WltU4TBRtNtTHVUIOvKR27neLWgEb2A8cUpLm88xxQWASyvLpPQ==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr39386427plp.179.1556186078842;
        Thu, 25 Apr 2019 02:54:38 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k65sm45345408pfb.68.2019.04.25.02.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:38 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/6] t7610: add mergetool --gui tests
Message-ID: <0f632ca6bf4f5e76d18b17435a8e565b4cdc3cc0.1556185345.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 063f2bdbf7 (mergetool: accept -g/--[no-]gui as arguments,
2018-10-24), mergetool was taught the --gui option but no tests were
added to ensure that it was working properly. Add a test to ensure that
it works.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 69711487dd..dad607e186 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -145,6 +145,28 @@ test_expect_success 'custom mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master &&
+	( yes "" | git mergetool --gui both ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" ) &&
+	( yes "" | git mergetool --gui subdir/file3 ) &&
+	( yes "d" | git mergetool --gui file11 ) &&
+	( yes "d" | git mergetool --gui file12 ) &&
+	( yes "l" | git mergetool --gui submod ) &&
+	test "$(cat file1)" = "gui master updated" &&
+	test "$(cat file2)" = "gui master new" &&
+	test "$(cat subdir/file3)" = "gui master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.1000.g11cd861522

