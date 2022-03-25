Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29FC433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiCYTki (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCYTje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD83F8FE2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so12095503wrr.9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=csSTLLvOXXHEVIyF+4iSBIHVXXVa6fmIaZ1XIryAyhM=;
        b=Kee4e8FBFIsguN6Et2/8ZllSh12te/RsOK2fWq00nysg6wglgx18h1X5JkgeFi17SY
         +Pmg8ST9lhOveoVEVa6tYsrtPb5Z5Y5NgzDoKpfhNDAlhjTtvEBW7YDKXAW2iI2RY3Gf
         XUiB59YmsWuacss11MjkTqE5Fkh20G/ozj2pUsXMDD8EjSuJRSo+Q0CSU5+O8+4bkCiv
         5oEyhPU9Va+MVXwGdW44Uhh0ENqVuPo7s3te524eHP56/KUtqKxdmPx5TAUcu7pHVI4M
         4egi3VcBrjp7lZJATkQ9QD88kJEMnpDRXD6tWwUK43ucm2qz/uzbAntdr7uGRhrRmh8Y
         OhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=csSTLLvOXXHEVIyF+4iSBIHVXXVa6fmIaZ1XIryAyhM=;
        b=q0frxotejBuETeLsSpXJjNrKYrIOR65xF5gaEyBLy3oPcoYFRh8eFMfoBYROk8yioZ
         haGksYRUkCQpts2uUHaTbbYSYRC7Gf7mYJPHByYV7ejfZdunI1hm/NajZnDSlDrEvv/Z
         gC9TKSEaabb6kUNeup9OWL6xWddWl6DbJLqlvwtPXKOhwjYKyW1J/gq5ld3xUb8y9CCv
         D/8HJyTuMu8fvq30Y87EHTuWrMww1vjcF/Tyw9kAPgDAj6pMdpKLwS6QZAE32xp05/7W
         3jFbnWWr9sY88xOoOb0IeBoxP8e+nqLixuMo3Kt+1JZQVWbG+innms9IAuRQMpEGvGzX
         k6UQ==
X-Gm-Message-State: AOAM532wNAFHdox3a3uCn/qsGOpXe1cYtTDJS3avh93ju/zy9JjNC/kf
        OWHMC2un4+eHBQ0h5e0pY/EEGZ98xQE=
X-Google-Smtp-Source: ABdhPJzWoG7NHkjRrHwWY4AVmKDIPYzu6x5Lhz2Fx7uqNTZqKqr7mKnkDCoyuEFZKJta88JvAAS/Mg==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr10119047wrq.13.1648231421240;
        Fri, 25 Mar 2022 11:03:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000024200b00205718e3a3csm5526603wrz.2.2022.03.25.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:40 -0700 (PDT)
Message-Id: <bb88cddc1379dddd3a65bb2cf9978257fbd7d60d.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:07 +0000
Subject: [PATCH v9 24/30] t/perf/p7519: fix coding style
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

