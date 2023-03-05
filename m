Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0FC61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCEOCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 09:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCEOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 09:02:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A901A94E
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 06:01:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso10648995pjb.2
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xP3HzrSAcnHMFxczd5//h6gJPaET01mj71hstXm1e34=;
        b=CMDk4deNBoF31ImDYsIAZl0tAewrStbh0TSIQsp+HZz9aDGAA5b1YahIaM643hwcfl
         UtyJTCLoZX4SoIOV8WqalmqCnVstKm47LBMuGns4H6DC/PWol4I6AER8R8Kf6nNzsRZx
         6YHwjZER3fU23amvyzkSCR1BrebTVqFRgwyLaSytbli74udA+ZQY7p18YuBR/Sr469Vb
         YBaQRqu9EJuNNzOpEI2Waj2oq712ClMRxGanJlBzLtKZG2r9kZ5zLy+xyeomGc0j0qlr
         HbfGcx8mWoXwIxV6WQLIltQfwmcGB66C483MFhFYspfXEs+LtvgQZnABCUNBIDuNLQK0
         /u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xP3HzrSAcnHMFxczd5//h6gJPaET01mj71hstXm1e34=;
        b=B9ZOEzqkchVe4EVBXKN8w2648u1ZwqwJB+H4ODRKB1obaZ6emRoshVzwumy0/k2LWt
         ef3nl78Bi2VTj5CQyHMwelF7QgA5P5DQSl3sT67tCmwZCHvgTkyb21vQCDaOpJ+P0+a7
         dqD1sfej9T2QxkbVhGOhBn9kz8O+kY+K6rgEoUb5e7HZd4X5I9Bw5AwA1H8QlH7nukEV
         E6clezhGHZRsOD25aA6vmyUDJyq7Ueyx+xh4qe9sUrz1uZJvesHsbQK5Ijvix1SX6S6A
         guFyxabeMrfZ72rV/+CKnh4IWrBGdcJNgL2kjTcpuOEMG2tyyj8Sz1ZT5cI98IY9kmQi
         nPog==
X-Gm-Message-State: AO0yUKU7OBvmyWEtwlG3CRjOEI/7rWqhG5Yw0kVoNVSbvVL8Y1u21pjF
        b+sWAF2zWLwuIYAXiIh/YMRfgmYlmNiN46uMfeI=
X-Google-Smtp-Source: AK7set+QYsKdotf9++iiM85NWkqSOViQ0uvScvZP2Y3di2isXYy9DFlgPn5FzV5fe7FexbpSSNKSRJoCn0sraXRjNu8=
X-Received: by 2002:a17:903:41c9:b0:19e:2a1b:2797 with SMTP id
 u9-20020a17090341c900b0019e2a1b2797mr3242100ple.10.1678024850373; Sun, 05 Mar
 2023 06:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com> <CABPp-BGOtsjgfN5f=dSb0ZSEx8nzFs6SKrUm=2TtPPH5cKa4cA@mail.gmail.com>
In-Reply-To: <CABPp-BGOtsjgfN5f=dSb0ZSEx8nzFs6SKrUm=2TtPPH5cKa4cA@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 5 Mar 2023 15:00:39 +0100
Message-ID: <CAOc6etawNSEjwt9QsJE90ok5pJjf4xOJ6ZaFr9HkHu3+Sw89+A@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, Elijah!

Thank you for all of that feedback. Really good Will need to go
through it which will take me some time to digest but I did want to go
over one of the subjects.


> So, if I'm reading correctly (please double check me), since your
> merge strategy made no changes to the index or working tree, and
> returned a status of 2, and since !2 == !1 == 0, we'll treat this the
> same as a successful merge and commit the "results", i.e. the tree of
> the first parent.  Doesn't this tipped merge strategy thus behave the
> same as a `--strategy ours` merge when its preconditions are not
> satisfied?  If it does, that would be horrifying.

I think that is not correct. The possible values that come out of
try_tms_merge are 0 if nothing happened and 1 if the merge was
successful and we changed the index and the working tree. Then I think
I wrote this correctly following the call:

if (ret) {
  discard_index(r->index);
  if (repo_read_index(r) < 0) {
    ret = error(_("could not read index"));
    goto leave_merge;
  }
  goto ran_merge;
}
// regain lock to go into recursive
if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
  ret = -1;
  goto leave_merge;
}

Actually, if we will be switching to using a library, then this won't
be that important because we might be able to pull it off without
having to release the lock given that we would be running in-process,
but I wanted to clear up what the intended flow is there, just in
case.

Ok.... more questions or comments will be coming in the following
days. And thank you, again.

BR!
