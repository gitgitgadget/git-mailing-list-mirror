Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0407C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74931613CD
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhEBG1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 02:27:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54521 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBG1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 02:27:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C17FBC136;
        Sun,  2 May 2021 02:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AM2kNz5MawtlgSALScJRMS/BlOt/AskM8LuPNU
        DX51w=; b=u2QINaEzGVsX2pEWrIffL5mBdVkCDE+JlHd5JJAPpm39LlUreVTH4R
        6GHDtZgsnFDlcVIAUnTnnm1tJ6d+GOWxBgdW6bxV7ZHjRzU4eJrazeKVduTu1hEx
        WY0UGyoHL0x1pMv4diakd7h07kbbdLp4na1K1LiYRO5O71/UoeT1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 922D9BC135;
        Sun,  2 May 2021 02:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D56DBC134;
        Sun,  2 May 2021 02:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Josh Soref <jsoref@gmail.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
        <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
        <xmqqbl9zcawf.fsf@gitster.g> <xmqqk0ol7cka.fsf@gitster.g>
        <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
        <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com>
Date:   Sun, 02 May 2021 15:26:16 +0900
In-Reply-To: <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 1 May 2021 22:15:18 -0400")
Message-ID: <xmqqr1ipbqif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D1A0A46-AB0F-11EB-9DC8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, May 1, 2021 at 9:51 PM Josh Soref <jsoref@gmail.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > I am not sure why this is Co-au, and not the more usual "Helped-by".
>>
>> If you look at the thread, you'll see that the code in question was
>> written by Eric [1]. The only change from it was the addition of
>> `void` to the function prototype by me.
>
> Oops, I suppose I've been doing too much Go and C++ lately and am
> forgetting `void`.
>
> I don't have a strong opinion between Co-authored-by: and Helped-by:
> in this case. Here's my sign-off if you want to retain Co-authored-by:
>
>     Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

I am not in principle opposed to the idea of co-authored-by; for
this particular one, we historically have used Helped-by (i.e. a
reviewer offers "writing it this way is cleaner" suggestions on the
list and then gets credited on the next version), and it wasn't
clear to me if you consented to be a co-author of the patch.  If the
party who were named as a co-author responded that it is OK, I would
be perfectly fine.

