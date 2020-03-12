Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7EC1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F32320663
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3C64kvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCLPgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:36:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33479 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgCLPgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 11:36:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so8020542ede.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=racRVYT+HpHD9gkMTj+Squw7Puokfe/39BZra8geK48=;
        b=A3C64kvz7dgtr1sUbqBKRpH9CmtADdR5o5jEC+6W3Irmz/YZoVrywvTtaFCW1W2AxE
         hpXnXqORy6PusM9BXI4q6P3nXDcdCrUD1TeWytecgaSrSJ4eajdxYHD1aL/Yoidyd5Hw
         5TsEtWVzLuZzScV0Y+LKh5W97OcoaPBxa7VfEbyv90f4qWfKi10RXiCN4cFYN5n402hJ
         LcWDQCxGcyYWSqQSkTUmScbAXyaf0xc/7wM4Poop6Jdjl9QMbb4prckgrCOp2GuPFHNU
         dLgS0C04CHT2Nd+99WhiSOCymf25XvlEg7h7Sd7MNqtkuW2DOvP6BaF5aRYasCMEIbIu
         Zxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=racRVYT+HpHD9gkMTj+Squw7Puokfe/39BZra8geK48=;
        b=DDaW2SykniIRt719pCKwgasXjVSA8MdgsDkrkWf3dbr5UKlowaKyPX5j9N9O33u2Fu
         gRV6olnobcAdN46EutMxKiFhsKCRGQE4fNzU4Dv8SFo6lI/8As+Xtp/cQDwxO009JN+7
         U+DiDortSeusKuSPX2B9cvXhG3nt/RwRX6nbpB/g0TG1fwem6Et+O3bzX9bioseR0Ven
         UNiBgbEhv7YKEWcoX2nF4TaZgtjkGVVR/BH9Shx2rphJPKt59wzTJ0FFJp0K5o+3T2s8
         0q9ta3uCy9eQVf8CXNAzcuqkSnPJS3I0gUjH+mTkslwnDYUcuvglmGIW9hlp4SJ2/A4g
         Gv9g==
X-Gm-Message-State: ANhLgQ1dgAbGZ8nWbOfAqUQ665pb3uYBAd+VVfZOGTkp/dLnfnh1iNaD
        1l6uxG0zppjR8wpIA2IFbF5LlHbs
X-Google-Smtp-Source: ADFU+vuHs36de2yQ9KgoI+R5SL6J9Ftsg8XShrbrJpESXc95ICldbN7lhY7qO0WqBcY8DkkJBinl+w==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr7100307ejb.360.1584027404927;
        Thu, 12 Mar 2020 08:36:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm3355641edi.37.2020.03.12.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:36:44 -0700 (PDT)
Message-Id: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Mar 2020 15:36:43 +0000
Subject: [PATCH] connected.c: reprepare packs for corner cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While updating the microsoft/git fork on top of v2.26.0-rc0 and
consuming that build into Scalar, I noticed a corner case bug around
partial clone.

The "scalar clone" command can create a Git repository with the
proper config for using partial clone with the "blob:none" filter.
Instead of calling "git clone", it runs "git init" then sets a few
more config values before running "git fetch".

In our builds on v2.26.0-rc0, we noticed that our "git fetch"
command was failing with

  error: https://github.com/microsoft/scalar did not send all necessary objects

This does not happen if you copy the config file from a repository
created by "git clone --filter=blob:none <url>", but it does happen
when adding the config option "core.logAllRefUpdates = true".

By debugging, I was able to see that the loop inside
check_connnected() that checks if all refs are contained in
promisor packs actually did not have any packfiles in the packed_git
list.

I'm not sure what corner-case issues caused this config option to
prevent the reprepare_packed_git() from being called at the proper
spot during the fetch operation. Even worse, I have failed to create
a test case to prevent a regression.

Placing a reprepare_packed_git() call inside chck_connected() before
looping through the packed_git list seems like the safest way to
avoid this issue in the future. While reprepare_packed_git() does
another scan of the pack directory, it is not terribly expensive as
long as we do not run it in a loop. We check connectivity only a
few times per command, so this will not have a meaningful performance
impact. In exchange, we get extra safety around this check.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    connected.c: reprepare packs for corner cases
    
    I included how I found this (integrating v2.26.0-rc0 into Scalar), but I
    am able to reproduce it on my Linux machine using real fetches from
    github.com. I'm not sure why I was unable to reproduce the issue in test
    cases using the file:// URLs or the HTTP tests.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-579%2Fderrickstolee%2Ffetch-reprepare-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-579/derrickstolee/fetch-reprepare-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/579

 connected.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/connected.c b/connected.c
index 7e9bd1bc622..ac52b07b474 100644
--- a/connected.c
+++ b/connected.c
@@ -61,7 +61,11 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * object is a promisor object. Instead, just make sure we
 		 * received, in a promisor packfile, the objects pointed to by
 		 * each wanted ref.
+		 *
+		 * Before checking for promisor packs, be sure we have the
+		 * latest pack-files loaded into memory.
 		 */
+		reprepare_packed_git(the_repository);
 		do {
 			struct packed_git *p;
 

base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
-- 
gitgitgadget
