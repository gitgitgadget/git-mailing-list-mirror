Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB9F1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfD2GVJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50198 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:09 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so14657167itk.0
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E0K0/ShcR2kASX7X6Zaj6mDUH2T/USNDsLRkTMmYgpQ=;
        b=o6DTbknkYvGpraKiPI/hAeb7iGq1uGBNskmwYnG1ml9kBGFgANv4NiYzU5ta/N79TJ
         3TKSloIRNnB3QOSp6clkmQxUUlePZNkwhF0XRDoyzzPrHnCjYOPGioSPblPm3E1/bCI3
         mMJWxPtupSsc+DpOtmPNnSWxl5+r6H0oKjySOiOMsAuzgWagEbLdipz2wdOoGCXcOw4b
         cmukcGIBkktdQIZGxBk8CnjSJAfbRnTJtDvNua0aahzkp4Vi0eJmzsfJh3z+KqgJivQi
         8g2a+tEP3p8nlOjPzqTsut10oUBP9xuVIHz8etOIDeG8tybVQDrB7VhoAqmo3lDpxxdu
         IZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0K0/ShcR2kASX7X6Zaj6mDUH2T/USNDsLRkTMmYgpQ=;
        b=fGuiZp7vb3zAyEw803aZWJmTIMe5m/74dFuHI15Xl0+A+dAdMYKyV7DlIwIdgF8BRp
         IYFRAaBPWj/CC1KrIXUyvhnguSzefL6E5pnQBGv8rRv68trbDhZ4h25mB+snU8npXRj2
         LVNXxpaZ1mvYvxgq6tDdUBy4NVvO5gEvsVqYyvuP3JzcUVJiEdd75//YVOV/wX0TambV
         JJgNEPP8iZGTGwYoafByaJNxO4Z99bphv9rlckPk8clVJaPWEsnDZpt5b1KfNwCYuHbK
         tk08yos6PAF8WFVcAgROZy61uBEcvKPPvMOwpzGTVexxvs94rDeQG3X6a+1+hVVumMtV
         zqlw==
X-Gm-Message-State: APjAAAXpI6rFJ/IheGywOzA0D/AYW8tCXKhfAlmNLqvLFMMYGH/GBJkM
        voXTPIErSfNAGchiZCsnUh5uzQ1p
X-Google-Smtp-Source: APXvYqy+hkXCkalfAq+9zd8R6wOCbPVgacwoORfdUAkeYATCn5aX8X+FCFwJQOlq0CnuSj3WDMY8dA==
X-Received: by 2002:a05:6638:2a4:: with SMTP id d4mr6743603jaq.118.1556518868481;
        Sun, 28 Apr 2019 23:21:08 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id w81sm14308456itf.23.2019.04.28.23.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:21:07 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/7] t7610: add mergetool --gui tests
Message-ID: <0f632ca6bf4f5e76d18b17435a8e565b4cdc3cc0.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
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
2.21.0.1033.g0e8cc1100c

