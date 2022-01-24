Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C9C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiAXTCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbiAXS7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39919C0619C4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so34528wms.3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ex1XfveK6ufetEy7Dd3dm2nhPI+EIa22orWtOTsCY7A=;
        b=aP1Qyph6HGhrqNkvpODjWQQtoaIFE3vqhE4HNJFyc3rrtd/2Q074jIzDGflPN0EazK
         +aMB5Q7U5t+P61c8RlwpVea7FIKXhS/vCH44pzEaDq39ckyvGHD9LCOd9t6t9+HLw8Jc
         iogbzCtT1KoO7uL1n+g7NHSr/KiAiYTvIzLsPGGpCySLbvLDM6Rn7RLoYvL5olYluvW7
         0Ck3gHtDI/4BcZuryztwET9lpvMnmCgS3je3GeeP4D23xUuKE9fhBdnUOk6z6boFPzXV
         /PAEYh5qkb674sWBOTEwoDLZwzumTBuLC1F2G1bcUsCh4aKMgiiZwKWB+VTXNqYkauwi
         844w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ex1XfveK6ufetEy7Dd3dm2nhPI+EIa22orWtOTsCY7A=;
        b=JnfaEBGZo7RSZqABHHP9tSYwahwa7ryaTrWS/twepuouyyHgIvy+EKeVUT8bcrL6D1
         AkFpru/5e6sosJkWmkdAtkoZXkvUlystchGMevSa5vnfxci7ZB+fD0woSNjTGpdt8aXw
         wt/7QR1CYvgmW+PAauWWDMwd9xIR5xYM180n1xrVBayvduFnfGkz9acTP6rSWFrk25St
         L5dZDKvTI5qj4KIe3mcsBYvQecr18BFgIwWnOKO9wj1Hh64W3fyDKnd6FWaOuuJpi3T1
         jzojuf/rFP5EoliAyj62CJNykspQ53fixXB8hP+g6ASMQFJVlTLAIU84qTWghO+lnz7n
         Wnqg==
X-Gm-Message-State: AOAM533nnUmiLr+Mo8sg0U4wmbUo8PgZrJMVWpIv2hBbnn7QfIge4xbg
        UwgME9L2Vti/2h66tdX0MgpJs58jm6A=
X-Google-Smtp-Source: ABdhPJxDI/HR7QP6mZovmM0stzoavsdHXVZ8ZbRMY36DS9eWULBR21bhqIKEoFCynYK2CR05ahOysg==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr3031266wmi.41.1643050588669;
        Mon, 24 Jan 2022 10:56:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm14559653wrq.66.2022.01.24.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:27 -0800 (PST)
Message-Id: <1a6bd1846bcb061d3dc70870139cb4bc076d2a25.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:13 +0000
Subject: [PATCH 8/9] ci: use `--github-workflow-markup` in the GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This makes the output easier to digest.

Note: since workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details), we need
to remove the explicit grouping that would span the entirety of each
failed test script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 4ed8f40ab02..72efdb556ed 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -176,7 +176,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
+			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
@@ -188,7 +188,7 @@ then
 	cache_dir="$HOME/none"
 
 	export GIT_PROVE_OPTS="--timer --jobs 10"
-	export GIT_TEST_OPTS="--verbose-log -x"
+	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-- 
gitgitgadget

