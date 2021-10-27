Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD2C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7216760F9B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhJ0OID (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhJ0OIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:08:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75AC061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v127so2724273wme.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lPtZCIP3Tmd+3Ce5USCL4gbojw2Uo3bHRPnJQQ3xCYM=;
        b=oM5D+djz9eCwaOKRs+LN8KNyha03bqL1cuikqfVWN5i4V86vuJPB+j5ZH+YB8X52My
         uvux4HaIZGJHHIHt9LhuXlKsRneIn+UANYf7wvC2xI4x/x4MFDXdtSvel9kDPe9i+b5r
         Wn0BMhd7eQC1IE25jO+sWf4r5gobxRF51v6o20EPRknINOG64JGiNqXO65QSIJm+d9zE
         oXRGBEbuPKE2FZJF25dZIDU4McAz1OwzdzoldWypOvMszWZWH4LdbvylHacR/PnYHh4V
         xQ1XLu94tT2zGCfPiLhU1bmxVbS/mNAZDIKo6fmyPEMiZnVS010xGEWX11U302Z8BJZA
         hkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lPtZCIP3Tmd+3Ce5USCL4gbojw2Uo3bHRPnJQQ3xCYM=;
        b=SuX2/tHtmpzfHEVooGCQfp+y6yeej53CyESjAKnp1d5Xni8EW4zRnSRPMB0h0TO/xd
         TRnWNbnhPxOMpebzcskhHIaylzC7uGbdONCnzucXa4D7JcjjNHRhYyUo8Iq08QosGT7d
         TFAAk2r0vP55HJHwXTlpH2R1AndbH/hnyhFiKtJOPkfzG7Qbomtt8My3lVe0aDnQ0APl
         Nb6LsGmH9c0X5FQMmBD8E/JLPl5cF4oz0CDnI9FIX9mSj1yDW54b2UG/+dLc88qsDU8v
         LxCpUyUfnTkEFsMtVtbDKfkadQGAqxKwNyg1h1qdJCcF1s0+b2fBpYgfwDFatSOcC97U
         SlSg==
X-Gm-Message-State: AOAM530f9wYOWMrIeXJCpeMuMBxyZ2hHlIRdZGt4QKPndB5UPSyGQHUM
        8YfEJydcJSbtW8/QRQi6hchoo76l+Xw=
X-Google-Smtp-Source: ABdhPJyPM+c2b6AbSk4bLfEKjWklRCaZLP6Mz4IITa+YBCMfFw3T9qgQJfK/SdJQrG7xpJR/lliubQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr6031280wmk.139.1635343533629;
        Wed, 27 Oct 2021 07:05:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31sm3493729wms.25.2021.10.27.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:05:33 -0700 (PDT)
Message-Id: <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:05:31 +0000
Subject: [PATCH 2/2] docs: add headers in MyFirstObjectWalk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In several places, headers need to be included or else the code won't
compile. Since this is the first object walk, it would be nice to
include them in the tutorial to make it easier to follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index bf0a7c1f766..ba8cca91b97 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -57,9 +57,14 @@ command). So we will send our debug output to `trace_printf()` instead. When
 running, enable trace output by setting the environment variable `GIT_TRACE`.
 
 Add usage text and `-h` handling, like all subcommands should consistently do
-(our test suite will notice and complain if you fail to do so).
+(our test suite will notice and complain if you fail to do so). We'll need to include
+the "parse-options.h" header.
 
 ----
+#include "parse-options.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	const char * const walken_usage[] = {
@@ -195,9 +200,13 @@ Similarly to the default values, we don't have anything to do here yet
 ourselves; however, we should call `git_default_config()` if we aren't calling
 any other existing config callbacks.
 
-Add a new function to `builtin/walken.c`:
+Add a new function to `builtin/walken.c`. We'll also need to include the "config.h" header:
 
 ----
+#include "config.h"
+
+...
+
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
 	/*
@@ -229,8 +238,14 @@ typically done by calling `repo_init_revisions()` with the repository you intend
 to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
 struct.
 
-Add the `struct rev_info` and the `repo_init_revisions()` call:
+Add the `struct rev_info` and the `repo_init_revisions()` call. We'll also need to include
+the "revision.h" header:
+
 ----
+#include "revision.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/* This can go wherever you like in your declarations.*/
@@ -624,9 +639,14 @@ static void walken_object_walk(struct rev_info *rev)
 ----
 
 Let's start by calling just the unfiltered walk and reporting our counts.
-Complete your implementation of `walken_object_walk()`:
+Complete your implementation of `walken_object_walk()`. We'll also need to
+include the "list-objects.h" header.
 
 ----
+#include "list-objects.h"
+
+...
+
 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
 
 	printf("commits %d\nblobs %d\ntags %d\ntrees %d\n", commit_count,
-- 
gitgitgadget
