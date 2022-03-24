Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AECC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351949AbiCXQxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbiCXQwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F80B0D0A
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h16so3111599wmd.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GBSYoKFMiXxL47tbCdtlqToK9/DpNmOfcvl8sunsaH4=;
        b=pR+061qBZZto+AR8x06Wbv81hSvjvt0uRMyUq3c2/kJdS8zI8+px+2rIWrTu4N6orV
         Pecr5+zT7QkqpiboW9Ewat07nR1FHyYBzFV/ElAO0/gP5UVv8ffFBW7vSEnrAy3eerGX
         0ZzA181fCRLso6/kswRDtj9eM7irWRa7R++JLxptfKJlWCp9a9wF8bi1N+k+aXiqQXTX
         9X8K+rAimTMJNIEVvdVBepWatM5N9hxtJXS86hd1w8TWMvy4jSZ22xobRGlNb2r6Da6W
         qkilgot0oA7Vj14gM2JOZuzNBCH2MYyvAK9phtZwt7We1dovfx602PXyLwIJk3vsOXMl
         qQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GBSYoKFMiXxL47tbCdtlqToK9/DpNmOfcvl8sunsaH4=;
        b=zx6rVs2hQT1t9YtlmVXch52j4T1E8t/HPjceZnDRozJXD0Z/UCmJimXKAri4ghVMWM
         JhlAVXddr/zhAdAQ/98xgXp6/L+nNmPoAWei+F8dRIYzyo9DfohWt2IvbOTg8G5U3QND
         /5he66COkUdlOweCCZDiGqIsIrdfwwByr4E5pG3DUjjfCk6BAyXtfC0vYdb3A0W7yZfd
         u9OYx1UAinxbJh8fbBWfpleg1YmJ/gq8sf9OrtLXGGZHQX22nM4h+9q+DnVCuX9E9FQz
         JsqM4L2t9vFP6Ls+0edsY7F4UX79yBrrkdx2KIeHF5Ywhi1Y24jk+yjKjRBMTZhT19D/
         KhqQ==
X-Gm-Message-State: AOAM533b83Et2qQPje4kcF0i/Y0D+R25WyEWsYIvl4S+x+Qz6V4Ys8kF
        uInha5vWheQRbsIlTZEDDdwlBKnOJIM=
X-Google-Smtp-Source: ABdhPJzKiyZH04HCw5OoXnAQ5eWq0mxhUg9Lj5nOXO69e8ja/WvknL4RPvXDSTPxDR510do84rk7Mg==
X-Received: by 2002:a05:600c:3482:b0:38c:40:9b30 with SMTP id a2-20020a05600c348200b0038c00409b30mr15140214wmq.68.1648140620301;
        Thu, 24 Mar 2022 09:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm4526530wrh.18.2022.03.24.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:19 -0700 (PDT)
Message-Id: <2dd06ad2f712752e218de1d512edeedbed563ad4.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:41 +0000
Subject: [PATCH v8 25/30] t/perf/p7519: speed up test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
to touch thousands of files.  This takes minutes off of test runs
on Windows because of process creation overhead.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5241eb6c4e5..a6c2a910e70 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -98,6 +98,13 @@ trace_stop () {
 	fi
 }
 
+touch_files () {
+	n=$1 &&
+	d="$n"_files &&
+
+	(cd $d && test_seq 1 $n | xargs touch )
+}
+
 test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
@@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
+	: 1_file directory should be left empty &&
+	touch_files 10 &&
+	touch_files 100 &&
+	touch_files 1000 &&
+	touch_files 10000 &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
@@ -199,15 +207,15 @@ test_fsmonitor_suite () {
 
 	# Update the mtimes on upto 100k files to make status think
 	# that they are dirty.  For simplicity, omit any files with
-	# LFs (i.e. anything that ls-files thinks it needs to dquote).
-	# Then fully backslash-quote the paths to capture any
-	# whitespace so that they pass thru xargs properly.
+	# LFs (i.e. anything that ls-files thinks it needs to dquote)
+	# and any files with whitespace so that they pass thru xargs
+	# properly.
 	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			sed '\''s/\(.\)/\\\1/g'\'' | \
+			grep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

