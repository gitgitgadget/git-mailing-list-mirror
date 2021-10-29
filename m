Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEEEC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD7360F92
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ2SAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:00:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20654C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r8so4770016wra.7
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yQQUn7xI0V4jh/rmBbeXLd/Qy6dPUwBvB2Kl9d7FoTo=;
        b=f+y0NRZKK8ybvk+PHEuuNC7CgfUCLhjnIgqzesrhiux1liOm2H6h9ZyAvflmalwly0
         9Kr7cETnxbPPF/BJmmN2jvsd8x7tP/ASy7UNSxsboHRaB10mp2KYkI+69FMsE/hZFgh2
         M5EiuxJL5X+cP6/gT1T7H+M7K93+Qw76pLSWOlqIy2VVdI+RePLrvPlyvgme4Zt0RgJN
         mi0+DxsUPXZ0GSYR1N/bG+nbBq2JT3/tI0IvEJ3vda+Uu++8F3XT8Lup3r3pyIPJkUCf
         QlwZiMNhcHE2zTqLEkBccmZYCIyP+QDvwnMGIh3BDv/NdMS1ySWP/f58g/5DNu/xg+Wy
         b8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yQQUn7xI0V4jh/rmBbeXLd/Qy6dPUwBvB2Kl9d7FoTo=;
        b=h1dgMWcRNuQpBR7l9+wnbRIMYUQ6OgxC2r65MpdMNjL1vxtThtxS315A0JJSGKH2rS
         YK4uHg2VBhLwlq19zL7mKXv6wJ33pFMna/fM967KEP6X6iTdqrfjizzBPC2nDZq9iLEq
         3HBPz2SP/2FLRMEAlFXYbm0xr96gqMNoCxsHldfoZBTe19GnePTYkXUk92dBnH+F2aS1
         wlAzXXdEOWRs/pZ00PeuVYaz0gyREqLUTOzeVqBqahT4hQrxg9x21BbV5h738oOc7X0Z
         vS1P+Rf0nCSpsTLW1FTDg9om7jBNGhWg0QHGPKr6dIGn6GlEG4I3JcfoduJT5on7QSvj
         mL5A==
X-Gm-Message-State: AOAM531G0m3vaXCNV4UZxrtljTYP+LEaOF4JlAfXOthOGvBcXZKY8wuV
        FgQuoNGiKpCYcyp/lRlO8MpREXhW9s0=
X-Google-Smtp-Source: ABdhPJyUGlnbnH8UsFkCtgVsyP8cWStMg5Yj6eA+PbpFmigs9lqSL6fKT3GZN2PxFmWhTo65944NHw==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr7641938wrr.189.1635530298817;
        Fri, 29 Oct 2021 10:58:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm6561353wre.21.2021.10.29.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:58:18 -0700 (PDT)
Message-Id: <7268f00c11fc0b9ece99f6a2940c124892791768.1635530296.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
        <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 17:58:16 +0000
Subject: [PATCH v2 2/2] docs: add headers in MyFirstObjectWalk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In several places, headers need to be included or else the code won't
compile. Since this is the first object walk, it would be nice to
include them in the tutorial to make it easier to follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index e22615105c0..ca267941f3e 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -61,6 +61,10 @@ Add usage text and `-h` handling, like all subcommands should consistently do
 We'll need to include the `parse-options.h` header.
 
 ----
+#include "parse-options.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	const char * const walken_usage[] = {
@@ -200,6 +204,10 @@ Add a new function to `builtin/walken.c`.
 We'll also need to include the `config.h` header:
 
 ----
+#include "config.h"
+
+...
+
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
 	/*
@@ -235,6 +243,10 @@ Add the `struct rev_info` and the `repo_init_revisions()` call.
 We'll also need to include the `revision.h` header:
 
 ----
+#include "revision.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/* This can go wherever you like in your declarations.*/
@@ -632,6 +644,10 @@ Complete your implementation of `walken_object_walk()`.
 We'll also need to include the `list-objects.h` header.
 
 ----
+#include "list-objects.h"
+
+...
+
 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
 
 	printf("commits %d\nblobs %d\ntags %d\ntrees %d\n", commit_count,
-- 
gitgitgadget
