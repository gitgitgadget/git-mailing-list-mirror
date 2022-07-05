Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3566C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 18:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiGESJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGESJN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 14:09:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19515140D0
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 11:09:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5140613123D;
        Tue,  5 Jul 2022 14:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fbuCZvSMjfIEy4ldhIgrFyYqx+eoRrAoy+56OU
        Nes3M=; b=OCodhCamOskpMPvETZuGKk826TXJXpOMKS5AXK0/YZWKAkanA2Y3O8
        RPKlVBkxOhTKi+bR2Q7n7rjXQlNeCos6ULWjVmq2T38ebAQrK1aSOwMHxN+Z7PSX
        GYLLi8KRnYSvnru7jYi9xZJq4R9LFkiPP0Oyez0If86R8GfAhU5ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4886313123C;
        Tue,  5 Jul 2022 14:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A761013123B;
        Tue,  5 Jul 2022 14:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Why `git am -3` apply patches that don't normally apply?
References: <CAMhVC3Z92hBsK0FbE4E_LV1CSxjR1zmu+MO8=iwR02BKqnwgUA@mail.gmail.com>
        <CABPp-BEkEKQZR=1duxSS4AVv9u5tnPk5CaLCM_fQWPbAqfSMxw@mail.gmail.com>
Date:   Tue, 05 Jul 2022 11:09:10 -0700
In-Reply-To: <CABPp-BEkEKQZR=1duxSS4AVv9u5tnPk5CaLCM_fQWPbAqfSMxw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 4 Jul 2022 12:23:49 -0700")
Message-ID: <xmqqmtdnjut5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92512682-FC8D-11EC-BE34-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> As per the documentation of -3:
>
>         When the patch does not apply cleanly, fall back on
>         3-way merge if the patch records the identity of blobs
>         it is supposed to apply to and we have those blobs
>         available locally.

I suspect that we would need to update this part, as the order of
"fall back" was swapped sometime in the recent past (and we have
fixed a few bugs that were introduced as fallouts).

Your description on how -3 works when it does the three-way based on
the concrete example was very clear and easy to understand, by the
way.

Thanks for writing it up.
