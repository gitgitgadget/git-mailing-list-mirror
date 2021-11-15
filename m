Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEAC4332F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCBD61B2B
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhKOJX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhKOJXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 04:23:21 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612EEC06120F
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:19:51 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id az37so33371916uab.13
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7ub0mKmLc9lHlpOS+oirrEMqMOffdul14SEKqOFF0g=;
        b=bz/9RSrrV8PXSNqYpgr/VZ7gBw810TXjS9AELipls99GCq3f1OhbSIGqJ/V7Lb02Xj
         KtnV5XIYGNsQuZh/bhe9ALxFEGsM8BLnBmTyVM3RNkJk69bZl6kP9UO1ouesQOaDSvX2
         LNuXKfc7Mw1/MqbdbEJa/QPQLBd/T04NOTRnQSxb3OIAFk+I+2ygImZ41TcdW9K7ztSe
         9RjsrB/+4bmSyJ202rdJv33T5+jESrCLFzVPxWhBs4OGATTbkZk927KjkgVoYsMKogGB
         CsUAKRnpsGelVCvJdhPkmVVF6tDWBd2wSamWMn5p8oe+oo9Uc3o/m6sKpZ4V0+Lqq/yg
         Q/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7ub0mKmLc9lHlpOS+oirrEMqMOffdul14SEKqOFF0g=;
        b=Opw1W7emLz84bw2fmQ2rOM/d3JH/1jZIdhUCnLRfwjfCovSqtmm8Oc8LOlp5qEuePF
         5jNtzeYoTYwRPPyhfkPW5dgIuQk16LVrZh4xSkJWA1FhZdqzMaq+DKwdDG3aGNhvR7Ll
         JxV+epcCB5cE7YX1MPuEX6Zp/nkvBcpR6c01clvPUwLoz3RDTkfQ+pBgH91p6M+wurzC
         7E7oDXzXja6gQ2VAm0fqSpSnjM/UY2diaL8YRcHLsIEyc1d1fcBrylTKortPDHHSfpk3
         YW+eWZfSzeZRfxCpHQ4jkDGFWCpF13gBUmnDYwUi7MJ7YxSn/u9ptwMznRKiT2BWJnaQ
         agBg==
X-Gm-Message-State: AOAM532unGk2Rsi9YBCOUNmSblH04iCFuOaGHd55LpRFKoX/+dNdvwyI
        D+QKg/Fi1NdOrNsPzOSQo1xp1CK+SlZeYgmhg3E=
X-Google-Smtp-Source: ABdhPJy6SpR1HLiR3tcDbhe4+OuGZk0VHL4Vz9HZiwPnxODiHQRtECqXjkEGsYrrW4IR9eEH5Ah1OIP4h8XRzjn/SCM=
X-Received: by 2002:a05:6102:72a:: with SMTP id u10mr41300079vsg.9.1636967990269;
 Mon, 15 Nov 2021 01:19:50 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com> <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
 <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com>
In-Reply-To: <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com>
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Mon, 15 Nov 2021 16:19:38 +0700
Message-ID: <CADL96rs0M15E+CnycBsDqGbiibDFx4KeMthLspQH1=Bw3PS3gg@mail.gmail.com>
Subject: Re: git pull bug report
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> the remote mainline have three commits ahead
Where did you get this info? This is not true in my case.

* local is ahead of upstream. confirmed by `git status`:

```
$ git status
On branch main
Your branch is ahead of 'github/main' by 1 commit.
  (use "git push" to publish your local commits)
```

If remote was ahead, `git status` would say so. And this is my
personal repo in GitHub with only me as the sole developer/contributor
so I can assure you that the upstream has no commits ahead of my
local.

Best regards,
Erwin

On Mon, Nov 15, 2021 at 4:12 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 15/11/21 15.56, Erwin Villejo wrote:
> > There is nothing to reconcile since the branches have not diverged:
> > local is ahead of upstream. So I think it is a bug, no?
>
> You have the situation like:
>
> ---o---a (your mainline)
>     \
>      b---c---d (remote mainline)
>
> Your mainline only have one commit ahead of base point `o`, while the remote
> mainline have three commits ahead of `o` but unrelated. In this sense, your and
> remote mainline is divergent - you need to either merge or rebase.
>
> Next time, keep your mainline pristine (don't commit any local changes on it,
> instead branch to the topic branch and commit there).
>
> --
> An old man doll... just what I always wanted! - Clara
