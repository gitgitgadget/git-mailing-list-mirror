Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068ADC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C511120752
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAj3abOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMVMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:12:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55546 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so11409041wmi.5
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfbViSfHUbjndNelIz7CSz9Guueddt8SxbOis6WrLbQ=;
        b=ZAj3abOFY9jQE1f+r7LrhJn3fRXz+chTa2HA77JGPWqremm/TZcHbj5VR94YPoacLD
         jszHwSE4fFiOpoSATR08DNw6/10DPl58OCA4Lca5Ug3YgYbMIsGgDLcM2KXAyRVhlBKx
         n2sIM/3DTDXbEq4zxiv27OCCRLYgFnq1ZYCQ2SVK2R6uqTNtupm+nyelTfR0xipfg75X
         cvjNgZpFoSeCDAOn1AkyCpl4PeHtTe3tdPwlpUJ18joJYH2XHh2sXjgJgwlkOBcrGGW9
         NSqilYWmcRGxVPOEen8drlfI/2ZpMwVc65u11D/2J+6RafoiXjuHQ5RB1ZgLNJdoU92F
         +RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfbViSfHUbjndNelIz7CSz9Guueddt8SxbOis6WrLbQ=;
        b=FAoa2HmEAuW1xmPeQB2TG3vGrNlF+U5yEsqFfAzkC/2ISNNQDj2W/vOd5RY/Hvb2OM
         Xy4jnmQFkM8nZKc2DaQMQRMy50jK69/nVAsip3cA9u7y3BWOkKl0M926W2eegy7un9jS
         CsdLy/Ws2nVQ3VnkgETaHdYCt8SteYxW+Eg145Zd2nNW82ip6gXGE0aJnxAOT3CcGmqc
         vsZslG1qjbR/8+GQ6LPlI2PwlB8GE9gxvhYwbuz8NbimyyQO+M9e1wDx894G/DwM1pHy
         CyTngTH0jKReRt3R7RNiXppDgbiEQoSQUUi7UrjA1G1SKa7GQI/hZ0xMGRI8TwTYubnT
         wrsw==
X-Gm-Message-State: ANhLgQ1iuhlNsaFU+S/F4y92+U5DorHODDWg4vQFVCvcDfab1yqb/qWh
        SZRyR99CUC3jPmiaDKxMpBDipr7C
X-Google-Smtp-Source: ADFU+vvc5Jp9ccn1YplvDbvKmJ4RAuMlyIsG07M1B4m+pGdB9kNNhhvenyVtP2DjZTbFm83JM/kdGg==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr12391921wmh.130.1584133916644;
        Fri, 13 Mar 2020 14:11:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm10184939wme.43.2020.03.13.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:11:56 -0700 (PDT)
Message-Id: <pull.579.v2.git.1584133915654.gitgitgadget@gmail.com>
In-Reply-To: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Mar 2020 21:11:55 +0000
Subject: [PATCH v2] connected.c: reprepare packs for corner cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, me@ttaylorr.com, peff@peff.net,
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
spot during the fetch operation. This approach requires a situation
where we use the remote helper process, which makes it difficult to
test.

It is possible to place a reprepare_packed_git() call in the fetch code
closer to where we receive a pack, but that leaves an opening for a
later change to re-introduce this problem. Further, a concurrent repack
operation could replace the pack-file list we already loaded into
memory, causing this issue in an even harder to reproduce scenario.

It is really the responsibility of anyone looping through the list of
pack-files for a certain object to fall back to reprepare_packed_git()
on a fail-to-find. The loop in check_connected() does not have this
fallback, leading to this bug.

We _could_ try looping through the packs and only reprepare the packs
after a miss, but that change is more involved and has little value.
Since this case is isolated to the case when
opt->check_refs_are_promisor_objects_only is true, we are confident that
we are verifying the refs after downloading new data. This implies that
calling reprepare_packed_git() in advance is not a huge cost compared to
the rest of the operations already made.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    connected.c: reprepare packs for corner cases
    
    I included how I found this (integrating v2.26.0-rc0 into Scalar), but I
    am able to reproduce it on my Linux machine using real fetches from
    github.com. I'm not sure why I was unable to reproduce the issue in test
    cases using the file:// URLs or the HTTP tests.
    
    Update in V2: I've updated the commit message to discuss the options
    presented on-list, but also provide why I'm keeping the code unchanged
    in light of that discussion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-579%2Fderrickstolee%2Ffetch-reprepare-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-579/derrickstolee/fetch-reprepare-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/579

Range-diff vs v1:

 1:  cde7aa20ca8 ! 1:  696a51bd5a0 connected.c: reprepare packs for corner cases
     @@ -27,17 +27,31 @@
      
          I'm not sure what corner-case issues caused this config option to
          prevent the reprepare_packed_git() from being called at the proper
     -    spot during the fetch operation. Even worse, I have failed to create
     -    a test case to prevent a regression.
     +    spot during the fetch operation. This approach requires a situation
     +    where we use the remote helper process, which makes it difficult to
     +    test.
      
     -    Placing a reprepare_packed_git() call inside chck_connected() before
     -    looping through the packed_git list seems like the safest way to
     -    avoid this issue in the future. While reprepare_packed_git() does
     -    another scan of the pack directory, it is not terribly expensive as
     -    long as we do not run it in a loop. We check connectivity only a
     -    few times per command, so this will not have a meaningful performance
     -    impact. In exchange, we get extra safety around this check.
     +    It is possible to place a reprepare_packed_git() call in the fetch code
     +    closer to where we receive a pack, but that leaves an opening for a
     +    later change to re-introduce this problem. Further, a concurrent repack
     +    operation could replace the pack-file list we already loaded into
     +    memory, causing this issue in an even harder to reproduce scenario.
      
     +    It is really the responsibility of anyone looping through the list of
     +    pack-files for a certain object to fall back to reprepare_packed_git()
     +    on a fail-to-find. The loop in check_connected() does not have this
     +    fallback, leading to this bug.
     +
     +    We _could_ try looping through the packs and only reprepare the packs
     +    after a miss, but that change is more involved and has little value.
     +    Since this case is isolated to the case when
     +    opt->check_refs_are_promisor_objects_only is true, we are confident that
     +    we are verifying the refs after downloading new data. This implies that
     +    calling reprepare_packed_git() in advance is not a huge cost compared to
     +    the rest of the operations already made.
     +
     +    Helped-by: Jeff King <peff@peff.net>
     +    Helped-by: Junio Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/connected.c b/connected.c


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
