Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E71C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 22:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGPWJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 18:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiGPWJW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 18:09:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CD655E
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 15:09:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o21so6181339qkm.10
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5f92GVHzjiGp7HXwqUoLK9k9mbPpDh/+HnAxsLsEEc=;
        b=TkdN0iobBjlY/B+2QXaMXMaZez5Xq6pSeBJ4+1FZOZ9K924cx7HVfvFOKxK/5H5eb3
         FSarAKm7HqKIG8CsDFH6DTE8ALOZyXzx+J6pbHs9vJTT2uDf/FHLmCDep2Mh75BmVG3P
         bz/LbO0jaxFXbndY/KG68KSXE+rwAnpompO6tiMFNAKtyCAzIUV3QrofT38G74DFGljU
         J7EbPUVV9eSU8JuT0y8gxzO/2pehL1wgOhs7DD75LWB90DUB3fZwRcYkJoXpBHVpI8EK
         FG6iER3k2FNEoYqEY0qEb09nXKHLyk+oTB+3ki2XP6E2GWSIhS4o0sGb8u79Xc4AkUkt
         RAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5f92GVHzjiGp7HXwqUoLK9k9mbPpDh/+HnAxsLsEEc=;
        b=DlV8oV3Wk8NKIWp5rkNBzQ//NKR2vlOySdWyHFb299+Zxd7v2LFPBeBVudwnzIhrT6
         ZoSGJ8N49QnNfc+9s7H7ztpaJXs9dAENNeeC0aLHyvbgQREzql4A462iLrsprPI4PJZU
         J78cj0tlqqGHUFTISvowLt6+day+QdJ9V76b7vTC6kOMmZfIBESzpiTMBylaCh6ZSZc3
         Ut+wB+9w4cU4Y77vfC0CbT0THzwN2VxDsnYmd9wJ5WbtByVTtvayOMAKQPoqUEmj1fho
         jA2f81AKPNAYGjcCGw5KQf/RZvHKHUhUgIIWyMo3ZkZY1iU0omfwml8hdyP5WW7d0ai+
         A3lA==
X-Gm-Message-State: AJIora+/vOLgaKVlMP/eOgTcyftkLnhufBlUMqeLkqXFjyqUK8TyyJBx
        Q+DiUvLqvV8zMmIxK5DX64h9f9+Q+nA9SHbWfpg=
X-Google-Smtp-Source: AGRyM1uXflPB11+dTKlEuUsf2JlAdB+Z5iI3MUkQywKxjy+D3/XauLrCAKQKVcU2bHYpCoWRg59F0Cd/uqM0sa8Yf8Q=
X-Received: by 2002:a05:620a:4547:b0:6b5:879c:5891 with SMTP id
 u7-20020a05620a454700b006b5879c5891mr13487134qkp.187.1658009359782; Sat, 16
 Jul 2022 15:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 15:09:09 -0700
Message-ID: <CABPp-BE++xWxWg5bJy9xj1i2QvFyGf+mKQvObdujNoPFU6M-Wg@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 6:07 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> When the user runs 'git rebase -i --update-refs', the end message still
> says only
>
>   Successfully rebased and updated <HEAD-ref>.
>
> Update the sequencer to collect the successful (and unsuccessful) ref
> updates due to the --update-refs option, so the end message now says
>
>   Successfully rebased and updated <HEAD-ref>.
>   Updated the following refs with --update-refs:
>         refs/heads/first
>         refs/heads/third

This seems good.

>   Failed to update the following refs with --update-refs:
>         refs/heads/second

This is good, but I think it could be improved.  Could we also include
the commit to which rebase would have updated the branch to?  That
would allow the user to manually update it if they want, or at least
see a range-diff between what we would have updated it to and what it
now has.  Without that information, the user might have difficulty
correcting that branch.


Anyway, I've only been able to find a few minor things in reviewing
this series.  It looks really good overall, and I'm sure lots of
people will be making use of it!
