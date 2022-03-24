Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F11C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiCXQx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350449AbiCXQwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AACB0D00
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w21so2928573wra.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=csSTLLvOXXHEVIyF+4iSBIHVXXVa6fmIaZ1XIryAyhM=;
        b=MD5FPZtsQqApP3b16PDasnD5F2FIH239a0XVuZJdwnTgqJqvB8B6G9rDjBfgyyMqV8
         +JGVKArarbZO4IFSOT8UHJEm6LuH30ZhzXh7P6iA8gIP5Uzsr0cMMhlu2IRS4pkzQ+oL
         tXdVb7K7FSoqgyI95c8SlDZH1ItMOr1kohn3z6dV29X4isgPo20MyCAwV7mrQy+Txj7T
         7mmFJw8RPYKxgNivI8PS4tgflNCgZHkFUg9zMJe7OBW17IL6M7j9BNE2gQjw4P8mFb8l
         0kINBFX11iZt4169MTu/YAHxHb2VWzVrTB8QKAETJp1FTFPa4X0iRRGJE3l/83315ZQW
         lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=csSTLLvOXXHEVIyF+4iSBIHVXXVa6fmIaZ1XIryAyhM=;
        b=QBxxqV3Sq8Az0xvfZHzop89WPsPJ7fVY9zpE9RTQQpeKtaVKnGXKpOL9o3nP1Sp/mR
         OEI5BoHGDZsv9pi58QklGA+E9uB0tpZJFKTOMjks2v0r226D4Mb3+3WWEvEujNOzLVu5
         yytxJe9nuKSfxUEkQ6RdAKqlegpBAwkjm9DnKuMukuYq1IKtY52t6wDpdecnXd/KsXXc
         Qn2ttX8Q1UTmNroayFYObb1mdMp/HcViKcI26LJ8jOoWnlWeC9bu+qfU9Y7FgLfvKqt5
         0DQg+pXOPSqgcsvjZFzBkLe8Ws0nS/c01Z89xzI/IeojdIWXXmXACow4RxuzqLcEmz4d
         FH+g==
X-Gm-Message-State: AOAM531qJb/AYNWaYIw/TWqB8m0bz6pfzxjrO06/ijUUbUAB7tjOE6W8
        Ht+x+gHZW5R8ml9JdxzOStyV7uSSRnI=
X-Google-Smtp-Source: ABdhPJzJuqm5b9/iNlQ6qwxp3DIwX3sbscp0A8PbztbLZc1n3GSJcAfHgRc6xk2B1e4YU/WlnAmyGA==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr5340053wre.333.1648140619074;
        Thu, 24 Mar 2022 09:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b0020400dde72esm2996301wru.37.2022.03.24.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:18 -0700 (PDT)
Message-Id: <bab9a9b0802dc6b0330b692b73d8850b3eb4e50e.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:40 +0000
Subject: [PATCH v8 24/30] t/perf/p7519: fix coding style
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index c8be58f3c76..5241eb6c4e5 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -72,7 +72,7 @@ then
 	fi
 fi
 
-trace_start() {
+trace_start () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		name="$1"
@@ -91,7 +91,7 @@ trace_start() {
 	fi
 }
 
-trace_stop() {
+trace_stop () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		unset GIT_TRACE2_PERF
@@ -133,7 +133,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor() {
+setup_for_fsmonitor () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$INTEGRATION_PATH"
 	then
@@ -173,7 +173,7 @@ test_perf_w_drop_caches () {
 	test_perf "$@"
 }
 
-test_fsmonitor_suite() {
+test_fsmonitor_suite () {
 	if test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
-- 
gitgitgadget

