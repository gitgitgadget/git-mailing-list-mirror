Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0788BC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD7A20740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T3uZXQJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfL0Wdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:33:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51585 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0Wdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:33:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48D0D24201;
        Fri, 27 Dec 2019 17:33:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhslxVZmLx0Vs+AK6AzJ2OAlq94=; b=T3uZXQ
        J+O99w0VK6x9bcAPxN9aTojTRth01kivRl5f18NsqTXgxaoM/FlAVOomMcL6+0Ie
        pjCpFFFCG9xGGxFnbjVnoCkJb/I5EpVZNSgde3qZFYt4gkgujFS+uM4p0B47qTpf
        25fh3C9qqnxYa1vq03SCvB/X34aTCUFBbKS14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c7KlgUjDzcRRZWSrbMNb1P5C1eaAMUxu
        zRqaPQ0SMRxh2DqnmwRu8ua+ksEdVTXXp+KExKZ9Qekv1Ge4NKKEc9OgXto6fO67
        2bIHL/q9ywXgpzWbwmppQ09es9xVrlkcBje7r03qCwOVG3lQR8evt/U/htcVN3fJ
        8rH8cThcYAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4036524200;
        Fri, 27 Dec 2019 17:33:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A11F5241FE;
        Fri, 27 Dec 2019 17:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/2] sparse-checkout: document interactions with submodules
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
        <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
        <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
        <CABPp-BHnTyYJ=RgQhnrRvcwSRd=kGHR=j5uvuVRYZjDNYAdX8Q@mail.gmail.com>
Date:   Fri, 27 Dec 2019 14:33:45 -0800
In-Reply-To: <CABPp-BHnTyYJ=RgQhnrRvcwSRd=kGHR=j5uvuVRYZjDNYAdX8Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 27 Dec 2019 13:46:09 -0800")
Message-ID: <xmqqtv5liek6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2164A04-28F8-11EA-BA42-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 27, 2019 at 10:47 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Junio asked what the behavior is between the sparse-checkout feature
>> and the submodule feature.
>
> Does this first sentence help future readers?  It is what spurred you
> to write the documentation, but it seems like something that could
> just be left out.

I tend to agree.  It can safely go below the three-dash lines.
