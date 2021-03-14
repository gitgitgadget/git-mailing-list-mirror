Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECEC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6877064EB2
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCNUIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNUIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 16:08:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DEC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 13:08:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f8so749419plg.10
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dIXy4djpuqeEVMb1CVKUuhVfvuqNYsHAmwjH2+qjP4=;
        b=OgxhddNY58kQBcbetlKFCVYBtJAh123B3FQoxCEXS/ioTQE+TtTwUnOk6rHU79y9iP
         LFvEyJVfIfhtStMWlm7cWv7P/LQEI5M6xAe1jhxyca/A91Q2BLBTAOs9OSX1K/d620J3
         Z55wXWY4PWlStgIZEeszg1YWaI63iTQVV4agJq2ln4eklo0CzcrtQHvEIi/+YXR7JTQM
         rpOEUlBulZLnO44gw7dg3WKY3GK9A/t0Oh9gjPDZH7uI24EZcXQ0I87jNu0ZBbe+SJnU
         x8hdPBqTeoIYXtzgBlV+E7kflwY9dvxymhegjeTY7qxilhVYiKKnbiCvyvSCJjI6cw+n
         pdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dIXy4djpuqeEVMb1CVKUuhVfvuqNYsHAmwjH2+qjP4=;
        b=K0r/u8KY+iWv6S7aL6WAECwuG20JT/o2fTeJwcjlW1vJIZ3g0SkNB4n2WzHtP2a8WX
         FdWiUdpI1L1cX5nHJSPWzCzOv6KNZDkUKpVKw0NPugj1xfon2966cnWfaMT3IIzubetK
         wQAVv3VHjPKofqbp8yEHFHseJvGyOUwlnbDNPSSmMWjhqcMwXQWUugS6iO3kl83jb0xz
         vBCxAGiQXzgbDbu0LJ6Y090CIql+4CuHuMWFZLIPNj6SbtKPx1kfiTbmvuBSBHoGuQtL
         ajeb6rYMBmK6UILrkq+2IoVAVW7Pk79SnBGEd5NZrv7G9FnSFJXGewIotpoc59PVi8fD
         vSPg==
X-Gm-Message-State: AOAM530Z46KVDfkDsuSX3N+WUE/8WFkU8c+sunR3APs+hTwrk/zClYPg
        e0KDyFME/Wa896WKqmlxxpUtM34FW06r1Y5+zQA=
X-Google-Smtp-Source: ABdhPJxFpL7G0/AWVOyqoaO8cLTOLF/ip/d5CK3/Lx8jsp3Lq0mRFkQEzGI3FhJjPtfBK8vd6/ZaMPeBfUtsFHNCwbQ=
X-Received: by 2002:a17:902:bd4b:b029:e6:a4a1:9d8b with SMTP id
 b11-20020a170902bd4bb02900e6a4a19d8bmr5580703plx.56.1615752498071; Sun, 14
 Mar 2021 13:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com> <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
In-Reply-To: <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 14 Mar 2021 21:08:07 +0100
Message-ID: <CAN0heSpu7mWCXTu3qUKN1VEiH3rqHpstEU_k1LktNhV-z8b2pQ@mail.gmail.com>
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Mar 2021 at 21:52, Derrick Stolee <stolee@gmail.com> wrote:
>
> I agree that the layers are confusing. We could rearrange and have
> a similar flow to what you recommend by mentioning the extension at
> the end:
>
> **WARNING:** Using a sparse index requires modifying the index in a way
> that is not completely understood by other tools. If you have trouble with
> this compatibility, then run `git sparse-checkout sparse-index disable` to
> rewrite your index to not be sparse. Older versions of Git will not
> understand the `sparseIndex` repository extension and may fail to interact
> with your repository until it is disabled.

I like it. I find this easier to read than the previous version. That
said, is `git sparse-index sparse-checkout disable` really the way to do
this? I don't see a "sparse-index" subcommand of git-sparse-checkout.
... Hmm, no, after building and installing your patches, I get

  $ git sparse-checkout sparse-index disable
  usage: git sparse-checkout (init|list|set|add|reapply|disable) <options>

Should that be `git sparse-checkout init --no-sparse-index`? I just
tried that on a fresh, empty repo. It seems to work in the sense that it
drops the config item. I'm guessing re-initing a sparse checkout is a
safe and sane thing to do?

I don't find any tests for this. If re-initing should be ok and in
particular if it should allow toggling the use of sparse index, it might
be good having a test. At a minimum to see that the command passes and
that the config item goes away? And check that the actual index is
rewritten back to the "old" format? (Sorry if you have that already and
I'm just bad at finding it.)

Martin
