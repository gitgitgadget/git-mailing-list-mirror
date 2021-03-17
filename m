Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBAAC4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D964E64
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhCQVmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhCQVmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:42:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9EC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:42:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so3244576ote.6
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tn3aIPozr/DhapeR47zFY5oQ4bjvx2xvurJyNL2z3VE=;
        b=PURF55dwq5iSRjkxJr23MfaIBbl44FbAFN7fao0a4x+S8filFvDTTvx9GfbiNdFmv5
         DIBCdLEddj0CEZDB63cschYpeQOlYZqQi7x9++ASd2jr9U4mDXXyiCXP9tasHZHKsIqW
         LM59hOVLikMVsWVxWk+JZIV3fDtD6R600/COEwr/s5AmlyuYPfDhwuIyhUEf7h1mePGY
         yK4lO7cQZ2P5R7v7Su6Pzi0d5OLXw8io69akBkagI/KMacyP5cnqpk3hkvSWIds0w9zu
         Yx/2CCVtvKbIexPB2bTnuxPPbHtdjsevku9/uKSUmR2ie/amtzgYrwIjJjHeL6fJEX1u
         8ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tn3aIPozr/DhapeR47zFY5oQ4bjvx2xvurJyNL2z3VE=;
        b=Y7enXGKG56DCgmLtxSA0nt3k30kKzsWeopLeC7gky/qsBh9Uxucd5w6JIs8LOfjzXS
         OMi+isFw4xp0oJwuIuFCfHEPFskghTu8u9ZTOETsx8aP46Ppp/c0MFF1JLVdoRqVqe3t
         StdibkCiWGzTGTVZ3fB4G4EK6ww9Jj7+eQmHnpnhiih6LKZ7x8k7ozO8aONG+/jI3pwr
         l0Luagd2MwQnkKtHNwgB3OjO0IcA6KpAtVnAe2dW9NCzGnpb1GZ2MwmqJpZiINlRHJ/K
         4YDYzu3iiO0L9Os31d4HJYuvbt44KobP/RKg4bPDto2Q4FQUgrdgLEE1FeQXob+j/2oL
         lyCw==
X-Gm-Message-State: AOAM530abTi/erl3ssIFKSCBMY6COFDeCD69NOe6hnmde92iojwU4k0w
        G59shEyms5f/+EP9xITSXaMi/2hxJ0+xE9+Rn28=
X-Google-Smtp-Source: ABdhPJziEGemMccuHctKJvWD5oDmIPbbzWfIb2/AmMQpNBiVurH1uvVVgvyqQbT9J2ke/fGuIEfQB9zJcEUgzI3CnTA=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4979419otf.345.1616017333246;
 Wed, 17 Mar 2021 14:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com> <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 14:42:01 -0700
Message-ID: <CABPp-BFArfpnirzWZYpX6PnsgLkE+2rcDVjycG6iRWz5Kz0H9g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Complete merge-ort implementation...almost
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 10:24 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series (nearly) completes the merge-ort implementation, cleaning up
> testsuite failures. The exceptions are some t6423 failures being addresse=
d
> independently[1].

This series was subsumed into
https://lore.kernel.org/git/pull.905.v2.git.1616016485.gitgitgadget@gmail.c=
om/.
So, ignore this topic and look for the changes over there.

(Reasons for the curious: This series had fixed t6409 and t6418 and
the submodule TODO passes, while the other series fixed t6423.  The
other series could not have been included when this was submitted
because it depended on the not-yet-submitted ort-perf-batch-10.  Why
not just wait?  Well =C3=86var wanted a way to test his changes against
merge-ort, this early submission provided that and helped him find a
bug -- see https://lore.kernel.org/git/20210308150650.18626-1-avarab@gmail.=
com/.
Now that we can fix all the tests, I'm withdrawing this one and
including it with the other fixes.)
