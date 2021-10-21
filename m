Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD5C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0638610A4
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhJUXhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:37:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63092 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:37:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEFAC151159;
        Thu, 21 Oct 2021 19:35:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IjUKPkbN1F0FrgS1LMl5w3rzXe3zSN+7y1rO0x
        2nI5U=; b=g9mtafKQjxRFPcMD3WpZFIJSYhkzuTI3SFtBMnMHE0femwsd1GpzXN
        ZHh+KnKg7SfFpUR8D87ZmqHHHeiXZV9rkQnQq0j8vuYJFzDDHVUm5CbMECiQUXHp
        CHodi8RiO1owIxm//IAkjXCW7DKC7oWWNdthJXdWtXE5mNnHHi7a4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8662D151158;
        Thu, 21 Oct 2021 19:35:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBCAA15114D;
        Thu, 21 Oct 2021 19:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kalyan Sriram <kalyan@coderkalyan.com>,
        git <git@vger.kernel.org>
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
        <xmqqbl3ihu6l.fsf@gitster.g>
        <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
Date:   Thu, 21 Oct 2021 16:35:23 -0700
In-Reply-To: <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
        (Matheus Tavares's message of "Thu, 21 Oct 2021 20:25:03 -0300")
Message-ID: <xmqqee8egddw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90A8ACF0-32C7-11EC-BA1A-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On Thu, Oct 21, 2021 at 7:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
>> >> Hello,
>> >>
>> >> I was curious why git-submodule does not have an `rm` command. Currently
>> >> I have to manually delete it from .gitmodules, .git/config,
>> >> .git/modules/, etc. See [0].
>> >>
> [...]
>> I'd imagine that the happy-case implementation should be fairly
>> straight-forward.  You would:
>>
>>  - ensure that the submodule is "absorbed" already;
>>
>>  - run "git rm -f" the submodule to remove the gitlink from the index
>>    and remove the directory from the working tree; and
>>
>>  - remove the .gitmodules entry for the submodule.
>
> I think "git rm <submodule>" already does these three steps, doesn't it?

Wow, that is a unnerving layering violation, but I suspect it is too
late to fix it. So perhaps "git submodule rm" would just become a
synonym for "git rm"?

Thanks.
