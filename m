Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE33C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhLUMeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 07:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhLUMeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 07:34:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53AC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e5so26611974wrc.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=drLg+CYKswbd3xwDJpM2HA5rFtyvsqKMG9yjTN+5Ktk=;
        b=lnMmSp0NKCU68MykgkFPlx/ocymbSbEkXlws+JUuMCuWLaroDNukr+Pv4EgJaDtaIE
         vjqLKelfGJK0uYBue21fEDt5bwUlsbOGApUBgVttVPRK91u2qjI29I8+eWa2pWXL38Nj
         ygk7b8//581bY4JQXYsA0tN4OPUHNKmuScIUXPu6om7rkWoyIpvOeUscZjvwvFIj1WSN
         9jXnANTZyHWiBhulhhB5vHfhvDyPT4FP7N1PPzncXqZPBzvyPDOHzBfhLNBtD/Eq6iYx
         sRYr+e5qnAxd0247Q3026ZATULCecv/+tLT/CZBpiTIKqmZNZVK/BgzmV+OXiRuD/VLC
         4QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=drLg+CYKswbd3xwDJpM2HA5rFtyvsqKMG9yjTN+5Ktk=;
        b=repwcVL3WAFyK8HHQeN/88HjqPr0fUYHFm7+MR3Iq4uy7SwcD4O8GCnwTwxHhDgbbx
         uDhYEFNoz5LDKtCKKyj/ocExUeCK7IlZ08u2UY8Vne6L1AC933HvT0thcTCFw1FTdnpx
         d+b8rRLLE89F92YGokF6qPJs2Nbmw+WR1MbzvIQ4CsiVYYuZxQaovHo3mHdCh5pIzbn6
         4xd+yZGaTZ/fXo2WEczsn5+8nTkaY3VlC3DqGIgPut9nachQmz+F1NYWxdDzAdXZV9WR
         oRWOgXqrO3S0E4aktHojgOV91kD61hjEI9RTLZ9aeJm1Spib8LZG+T6hvoSf8M0s3JyB
         pezA==
X-Gm-Message-State: AOAM531sgTLDzQiyIux0IS1EuN2arNSh7au2kOzAWBQ5+grjZF8QlaN7
        KcgPcQCHRWHN23MXURLVrErG+DxBysE=
X-Google-Smtp-Source: ABdhPJz/MCSR0jS14fLlaKrUegMDCy9Cjp6z2naYaYvncXn/eVBtr5kMwd4WYBXwVBRDlPklH1W31w==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr2478012wrv.299.1640090039448;
        Tue, 21 Dec 2021 04:33:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm2156472wmh.35.2021.12.21.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:33:59 -0800 (PST)
Message-Id: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 12:33:56 +0000
Subject: [PATCH 0/2] tweaks to refs/debug.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

these are two small commits that helped me while debugging reftable support
for git.

Han-Wen Nienhuys (2):
  refs: print error message in debug output
  refs: set the repo in debug_ref_store.base

 refs/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1163%2Fhanwen%2Fdebug-tweaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1163/hanwen/debug-tweaks-v1
Pull-Request: https://github.com/git/git/pull/1163
-- 
gitgitgadget
