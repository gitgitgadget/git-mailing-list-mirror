Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD6C388F2
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B7B2224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/vJyeZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKCBfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:35:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58442 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKCBfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:35:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE3ADA3394;
        Mon,  2 Nov 2020 20:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IrXAOjJTkJjEaeKt5fU031oTSXI=; b=R/vJyeZi75YHK5QKWNJQ
        W7oi1Qn/9YJ3btLFGItmD08OSGCpmPWKTuWe7DgikdK2ItWBIy0fSAjfUmjcmyP1
        5n7ytrSuKWw32ltraz/KNepfLh7a/f52+M6c0W+xkCQpr+35XAg+n0eVnqNmOhmG
        Tync9ZxpG2JMwwgU2Q4r8Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=s1O3xYZTIWMvC0V64HRwLHyLLJf21cIKJ0YZidz1FbcCbP
        DIaD4UBS0mh64bwSCCdkBssMSuUVpq3sV4Ag1SIgkqe/9/UZioPL+ztznYe8WYR6
        Phsp+g6R5Ghm1khcFyt6TllbCU2gHQkoN84eL7Xc4LUtGxt0Ks7UCHKhmvLq0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2D30A3393;
        Mon,  2 Nov 2020 20:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D115A3392;
        Mon,  2 Nov 2020 20:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
        <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
        <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
        <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
        <xmqqeelh7y23.fsf@gitster.c.googlers.com>
        <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
        <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
        <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
        <X6CQpfuhRkAwmMou@pug.qqx.org>
Date:   Mon, 02 Nov 2020 17:35:42 -0800
Message-ID: <xmqqwnz3nrwx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3640E08-1D74-11EB-A09B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> At 14:29 -0600 02 Nov 2020, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>So the two options are:
>>
>>1. Use the script in contrib/ (or git-completion)
>>2. Use Oh-My-Zsh and enable the "gitfast" plugin
>>
>>In my opinion to use the Zsh default completion is not an option.
>>
>>Which is why I think distributions should package the Git Zsh
>>completion by default (like Hombrew does), which will happen more
>>easily if Git graduated those scripts and installed them by default.
>
> The option that you consider to be invalid is definitely *my*
> preferred option. That Homebrew's git package installs the completion
> in a way that overrides that from the zsh package was a source of
> continual annoyance for me until I put in a long-term workaround for
> that (I had just been removing the symlink every time I noticed that
> it had been created by a new install of the git package).

Thanks for a data point.  

My understanding is that Felipe's 1 & 2 are essentially the same
thing in the larger picture but they come in different packaging.

If we talk about two choices, I think they are between the Zsh
default or gitfast from oh-my-zsh.

And your preference is the former.  It is not like I picked a wrong
SO thread and was swayed by an oddball opinion of somebody who
prefers the Zsh default.  Even though the preference is up to
individual users, the important point here is that Zsh default is
not universally unusable for everybody and it is one of the valid
choices.
