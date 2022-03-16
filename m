Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093EC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiCPRtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiCPRtt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:49:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D02A254
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:48:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n17-20020a170902f61100b001538c882549so1569706plg.18
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=6zHIhZddaF1gW1/qPwv9lBaYA4hHEQnEJY+w3tWesew=;
        b=L854jxGdY/d1QAQYuomAl/ciaF09D41/1Yw62DLURY5aRLP+BvlkXp1TUw09nuo5Ww
         wo/1BNuX09IjinuWqEtrTm2RNvb1wSBGSJg+87hbLxNs2r8AsCSSZ77TCMWn2dUAQy3M
         NBcRSAl/XyhB0LSWTBDVWwYt1fuz85Y42wdGSgomMzvHoJ/oK+vQsoko8gKwGTO6SXTV
         PYcN1EwnqZkin/WCjeJxpUmkii0A7F7mPR5RyYbRS9rDxqjsF4dwR8PXWwS7iyMNuW/7
         tcEwKnynJUR5G1Bt+3k2chBws824RQ7Nnhr94yXYBQ9Wb8NsLdl676x/eIOUtkbSTwP2
         nPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=6zHIhZddaF1gW1/qPwv9lBaYA4hHEQnEJY+w3tWesew=;
        b=xdf7BDOA1O7WqupLkcdISvZ0GPMupBJma7uxx4OClZip+pi7uX+toKFT4GzI72B5Re
         edkJM+Ri2qs97FOav2OuwhcE2n7iBi4JqDk+XV3bjKidViVnMnrDl3L6iKuQCdmmtGbB
         Wm07EnQV5+lXiG3H2LGT3qFJ13A+G0XpJSTHsQNtF1Yogh4fZHBI+A11k9gQUXAcBwAf
         g0yFtS0I+IhZltBttjC8ViGuIM3hgq1JQ97PaQMGtSiGI8wqP71LMpL8xNtDfJUKTLsv
         0aX+U5HeMvNYGRrWO3v8n0XykiZGq+sof2+goPMO6sVbPm4+qf1wL4Nxs60ok0XOzMc2
         vV5A==
X-Gm-Message-State: AOAM533ClukI13sgOMDmnOOB8uktjJS1XE/dSHv2aWE0ZWq6czKpuQ4j
        FYThjXMPJfV8uWxnqDYu4i7+AjqGosNnIw==
X-Google-Smtp-Source: ABdhPJwNvGhxV93FiwsNbXQBEBB2gP6ZVCq3gIgrdHdNBc2fq36OU4NYXAfGvKGdDN+oXN0JgeUBKzIUqg0vcg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d645:b0:153:abad:be7d with SMTP
 id y5-20020a170902d64500b00153abadbe7dmr621896plh.118.1647452914881; Wed, 16
 Mar 2022 10:48:34 -0700 (PDT)
Date:   Wed, 16 Mar 2022 10:48:32 -0700
In-Reply-To: <xmqq5yogp6xo.fsf@gitster.g>
Message-Id: <kl6l5yodyej3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq5yogp6xo.fsf@gitster.g>
Subject: gc/recursive-fetch-with-unused-submodules (was Re: What's cooking in
 git.git (Mar 2022, #03; Mon, 14))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/recursive-fetch-with-unused-submodules (2022-03-07) 10 commits
>  - submodule: fix latent check_has_commit() bug
>  - fetch: fetch unpopulated, changed submodules
>  - submodule: move logic into fetch_task_create()
>  - submodule: extract get_fetch_task()
>  - submodule: store new submodule commits oid_array in a struct
>  - submodule: inline submodule_commits() into caller
>  - submodule: make static functions read submodules from commits
>  - t5526: create superproject commits with test helper
>  - t5526: stop asserting on stderr literally
>  - t5526: introduce test helper to assert on fetches
>
>  When "git fetch --recurse-submodules" grabbed submodule commits
>  that would be needed to recursively check out newly fetched commits
>  in the superproject, it only paid attention to submodules that are
>  in the current checkout of the superproject.  We now do so for all
>  submodules that have been run "git submodule init" on.
>
>  Expecting a reroll.
>  cf. <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com>
>  source: <20220308001433.94995-1-chooglen@google.com>

Is 'Expecting a reroll.' accurate? <xmqqr17dp8s9.fsf@gitster.g>
indicated that this topic would be queued.
