Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF64C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhLCTEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:04:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbhLCTD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:03:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E77EF3112;
        Fri,  3 Dec 2021 14:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c8P9aH5+ZJvUXtgWNiaOoe0HP9kH3V6fS+p/JP
        tI9E8=; b=UZDCdH+G4RfeYbwtBIO70QD7n8YuemHQsEC0WdEZmjGF78fRTtzqJF
        jIMIQ+GJQopElu25D7FhNFBQfaHJIk0WVaqdsMVmLYPf7rgMVa70MRLOwdGDjwD3
        X377yfxR4Wpzk8dUQ9b/81lHBt1MT4MjSV/kc3fm+vJk1tzvbA6wE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54CE1F3111;
        Fri,  3 Dec 2021 14:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5ABFF3110;
        Fri,  3 Dec 2021 14:00:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
References: <20210916103241.62376-1-raykar.ath@gmail.com>
        <20211013051805.45662-1-raykar.ath@gmail.com>
        <xmqqczo8eahl.fsf@gitster.g> <YWiXL+plA7GHfuVv@google.com>
Date:   Fri, 03 Dec 2021 11:00:30 -0800
In-Reply-To: <YWiXL+plA7GHfuVv@google.com> (Emily Shaffer's message of "Thu,
        14 Oct 2021 13:46:39 -0700")
Message-ID: <xmqqfsr9secx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49C71806-546B-11EC-9CED-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Wed, Oct 13, 2021 at 05:05:58PM -0700, Junio C Hamano wrote:
>> 
>> Atharva Raykar <raykar.ath@gmail.com> writes:
>> 
>> > I have attempted to make a version of this series that is based on that topic [2],
>> > and added the superproject gitdir caching code in C [3]. It passes the tests,
>> > but I am not too confident about its correctness. I hope that branch can be
>> > helpful in some way.
>> ..
>> The "C rewrite" of the code [3] that unconditionally sets of the
>> submodule.superprojectgitdir varible seems straightforward enough.
>> 
>> Emily, how solid do you think your "superproject aware submodule"
>> topic already is?  Would it be stable enough to build other things
>> on top, or is it a bit too premature?
>
> As of the version I sent today
> (https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer%40google.com)
> I think it is stable enough to build on top of. There was general
> consensus on the semantics of submodule.superprojectgitdir as it's sent
> in v4.

Does the above statement still hold true today?

And more importantly, Atharva, are you on board with the plan Emily
suggested to have this one built on top of her series?

Thanks.
