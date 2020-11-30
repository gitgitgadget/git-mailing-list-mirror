Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65114C63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 21:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180152073C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmr432hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgK3VW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgK3VW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 16:22:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56618C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 13:21:40 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i2so18223941wrs.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 13:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCq0rdb29F1bCvIF1TPV6Ym5Q8/HQ9uCx+h1ABfO7bg=;
        b=Jmr432hpE51H++rzM9uvqKI6IdQUd4enKWTEGjOe/Run9ghpC4i/1/AeNWmlODmBu2
         q3ooV21aQFWDkxtXL/cgb0NqaLKVJiYlvNwXthFTyEYzpYxbbR3wvwvaQfGbeiskf+y4
         MGkfvmwr5cl58xVWTF0GiEmYgID0gcF+v+kg151PnVL4ddgDmjtGbCJDCabVjcgRbRS4
         HRI4MukSnRFgAmYQoYkE6u6w187ehRNMe/+ZJyUs6dsDNad7dNzXFYMGD6P6mNoPurLS
         Q2wfs8VRx7aWoB6NF/5C3mRzw7THJYy/G+8x3EHzP50xtRd5bpEjP4fJbLM/fL3wUrka
         PnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCq0rdb29F1bCvIF1TPV6Ym5Q8/HQ9uCx+h1ABfO7bg=;
        b=TcnRcc8C476aAjNmGTMgW/q0jCfWScdMdMn5T5jGJx4F7/wHhW3es10e/PCjxIR3tW
         rzOm3VI8w4Luy3k5bgEHnW53Zxt/voUqgOyaK0woTNgp1STAosoOWbm0RCFmafoglZTj
         loueqFpqvAadcFgou9ZBfZJp6VYCgo3Eh+kRIKd1jcFQQGaC26ZMYzWZbC4/NWlEG3Qs
         FjtXtp50VxJ+6vyoaD3pGTsC4RxMLGlpUf10OPe55u7TDATc9Mm06Bw97vR0USz2QlMV
         Qm4IQpF3mE1r987Yy+2guKdABsZSA9E63uCaM9gPvTn9D9JeEDq5Kvue9p9ZFCIqlz5N
         smGw==
X-Gm-Message-State: AOAM531oVSxhof0TkwEUOcoHDG7V9bGXO437syZc0kNMEytpkWpcaOfi
        t+pyGg2Q1gzyp7EWXzvvKGJP8s8DDW9wGOKR7kC1s4cyvXdIiw==
X-Google-Smtp-Source: ABdhPJywaPzcc9WFVMJbwUmXn2P6BSS2KFfC/TWzoTjsc+ThFrBcTCqNz4lC5piSlnLYBIrQltzrdjEwtpQZb3l3ims=
X-Received: by 2002:adf:e788:: with SMTP id n8mr30703963wrm.84.1606771299128;
 Mon, 30 Nov 2020 13:21:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
In-Reply-To: <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 30 Nov 2020 15:21:28 -0600
Message-ID: <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 2:28 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Mon, Nov 30, 2020 at 12:26 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> > Until the reftable code is actually merged into git, I work on the
> > reftable library itself at github.com/google/reftable. I've asked our
> > opensource team if we could switch off the CLA enforcement for this
> > repo, to facilitate back & forth imports of fixes.
>
> I've asked our lawyers, but this is not currently possible, unfortunately.

Maybe I'm not understanding something correctly.

Git's license is GPLv2. When you add your Signed-off-by line you are
saying you are authorized to provide this code to the Git project
under its open source license.

Therefore, I should be able to take your patches, and rework them in
any way I want as long as I keep Git's license.

I don't need your permission, you are supposedly giving it by adding
your Signed-off-by line.

Read: https://developercertificate.org/

If you are not authorized to provide these patches under an open
source license, then you should not add your Signed-off-by line.

And if these patches cannot be used by the Git project, nor can we
work on them in a collaborative manner, then what's the point in
providing them?

Sounds to me Google has not made its mind about actually contributing
these changes.

Or am I missing something?

Cheers.

-- 
Felipe Contreras
