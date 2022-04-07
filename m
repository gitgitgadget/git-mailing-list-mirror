Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D8EC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbiDGQj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiDGQj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B690517DCB6
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:37:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so8633419wrg.12
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uZkR3PI5MJkXOn/lR2yjY3s5vGUc6R6k0YtTByrEnsU=;
        b=eGVaz7LPUSwm5R003KSQ06JzsHn5H586uufwz7TpVmgz1dNWrOepgceBoCENe0fqxW
         CquNMnRXgwrAGjjd53DeKQMK5+bp6BgI2KQ+Lr9ISd5hxg5BFixfweSUnDZJHuOVwMdY
         FcB8hxwUP4dRFFwVv7FAQOTrCpgs2R7YHyXje+CxTCzI/201JFVYl/b2XPu82ARRDAye
         rmiiuw6GH/VFrk0yHKT8YL8C5sWC5aqfoSRxgq3MbF2Hb5RvPwha4dRPLY+WIGwniyjc
         xFoK4Ge2WSMo4cMr67NTN+VJEakjDu3AicJBwVRm3oXy+kOkOkvKTgnRf0OcLeevZXR8
         WARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uZkR3PI5MJkXOn/lR2yjY3s5vGUc6R6k0YtTByrEnsU=;
        b=o0Bhq8heR+CAqDG7gwxDczTxLGmxyPBcgvA9EBTO4RKrrQVJEC1PyFOQ1xM+DHAZd6
         DDwUbKX035HDSIdlX7dzeg6AXqz/oiyQI+Lm08o9pkwNta2mj7mQd9cNTrWItCRBfBPo
         m0y7P+U6C1gXs8X4dgRYB2N9r4onxqh5FlVrebRqH/u8CS9ATVrEsaK7vU9s/A/Y3sEH
         qOIDy9rnalafn50Y9zB+OsySArRhtE0gV19TMGNDcwAsrNZTaV0iAPHai165BvidD03W
         ENyTWd7EnyCUMBeP8sBkTU6f8JijE5pgkUeENBxtuW3Kjq0+zDaFDlKvhDNglDjj4Z+r
         2tfA==
X-Gm-Message-State: AOAM5313QNT73aR4I0AGIylUynOhYgMtTo6Cl/mWc50f4WN+wkJ0wPeK
        r3Hf/crIHeIHcWZ/ldpR7zGMG57B4ms=
X-Google-Smtp-Source: ABdhPJynMAMVY8SxNnRMc5e25zVV0V9QAeZ6cOmdws2sm/9n3sV1fwEvp5LzPG97vNY5y227UPG12g==
X-Received: by 2002:adf:8002:0:b0:206:de8:85c with SMTP id 2-20020adf8002000000b002060de8085cmr11378444wrk.237.1649349443757;
        Thu, 07 Apr 2022 09:37:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm8264741wmq.6.2022.04.07.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:37:23 -0700 (PDT)
Message-Id: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Apr 2022 16:37:18 +0000
Subject: [PATCH 0/4] Sparse index integration with 'git show'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues our sequence of integrating builtins with the sparse index.

'git show' is relatively simple to get working in a way that doesn't fail
when it would previously succeed, but there are some sutbleties when the
user passes a directory path. If that path happens to be a sparse directory
entry, we suddenly start succeeding and printing the tree information!

Since this behavior can change depending on the sparse checkout definition
and the state of index entries within that directory, this new behavior
would be more likely to confuse users than help them.

Here is an outline of this series:

 * Patch 1: Add more tests around 'git show :' in t1092.

 * Patch 2: Make 'git show' stop expanding the index by default. Make note
   of this behavior change in the tests.

 * Patches 3-4: Make the subtle changes to object-name.c that help us reject
   sparse directories (patch 3) and print the correct error message (patch
   4).

Patches 2-4 could realistically be squashed into a single commit, but I
thought it might be instructive to show these individual steps, especially
as an example for our GSoC project.

This series is based on the current 'master'. I know that Victoria intends
to submit her 'git stash' integration soon, and this provides a way to test
if our split of test changes in t1092 are easy to merge without conflict. If
that is successful, then I will likely submit my integration with the
'sparse-checkout' builtin after this series is complete.

Thanks, -Stolee

Derrick Stolee (4):
  t1092: add compatibility tests for 'git show'
  show: integrate with the sparse index
  object-name: reject trees found in the index
  object-name: diagnose trees in index properly

 builtin/log.c                            |  5 ++++
 object-name.c                            | 25 +++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh | 33 ++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)


base-commit: 07330a41d66a2c9589b585a3a24ecdcf19994f19
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1207%2Fderrickstolee%2Fsparse-index%2Fgit-show-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1207/derrickstolee/sparse-index/git-show-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1207
-- 
gitgitgadget
