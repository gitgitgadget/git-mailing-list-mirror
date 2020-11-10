Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A177C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BCC20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 05:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqkKuZ3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgKJFlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 00:41:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50435 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgKJFlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 00:41:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33626109C2C;
        Tue, 10 Nov 2020 00:41:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=prvZD/yi5lgCUO9bMJepyg7/ZUE=; b=rqkKuZ
        3cbl7zfiVxZczllzqPSHp2CHK+FUw9Xz2a2dESekjqbqYvv5HkWlB/c9j0LSjEs6
        B+RUI2mZt8D7Zn0/OyyKKtEF4ec8nt2jHVMe4SMJFez68KxVOTDH9jJTzNui3ksc
        F5hFvhfIkJvBS9m/ZpCQg07EyLo8QSGrfHMHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=odArajPF+mOwE3Zz8ippLOJvPyzx7B0c
        JrQUpd4ooovDaQX6YVDHWzk0VKxahRflOVnAr5kXpFD3lII8fM48OyrQv3woAKWj
        Dn2e2Vw4nDgsdJqW5CbZa8gPBwHHbxS/BA82+qIJmpVfMFusrriS+Cv09ngxkP3f
        9EAdkh3um0w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C502109C2B;
        Tue, 10 Nov 2020 00:41:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76A04109C29;
        Tue, 10 Nov 2020 00:40:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     hukeping <hukeping@huawei.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        Patrick Hemmer <git@stormcloud9.net>,
        "Rafael Ascensao" <rafa.almas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch: make output filename configurable
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
        <xmqqwnyubagr.fsf@gitster.c.googlers.com>
        <9d4b387655024b24a20ce2384740b03a@huawei.com>
        <xmqqr1p27x8d.fsf@gitster.c.googlers.com>
        <8b97c61e983c432aab1063912d6266b9@huawei.com>
Date:   Mon, 09 Nov 2020 21:40:55 -0800
In-Reply-To: <8b97c61e983c432aab1063912d6266b9@huawei.com>
        (hukeping@huawei.com's message of "Tue, 10 Nov 2020 04:44:21 +0000")
Message-ID: <xmqqk0ut93bs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F3503A6-2317-11EB-BA07-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hukeping <hukeping@huawei.com> writes:

>>> Does it worth to add a new configuration variable for this or just a
>>> hard-coded value is enough?
>>
>>I personally would say "yes, the current code that limits to 64 is enough", but you,
>>as the person who said that you do not like the current hard-coded value, are not
>>in the position to ask that question, I would have to say---if it were enough for
>>you, you wouldn't have complained about 64 in the first place ;-)
>
> The original motivation is to lengthening the limit because of
> file name truncated problem, so update the value to a larger one
> seems like the simplest way for me.

It actually would be an improvement to me if we shorten the current
hardcoded limit.  In fact, 64 is still a bit too long to fit in
dired buffer and raising the limit will make it even worse.

In other words, you are forgetting that a larger limit is not always
a better limit.

I am not saying that between my wish to keep 64 as near optimal (and
possibly make it shorter) and your wish to make it longer to avoid
truncation, the former wish is more important than the latter.  The
former however is at least as important as the latter [*1*].

And once you realize that one hardcoded limit never is ideal for
everybody, you wouldn't even dream to suggest that raising the limit
to another hardcoded value is better. Adding a configuration knob is
a way to treat people with respect and give them choice to suit the
system to their taste.

The names of output files from format-patch is a very local matter,
because once it is fed to "git send-email", the receiving end does
not even care how many letters you used for your filename---after
all, you may not have used an intermediate file at all.  It is a
good place to give personal choice, as opposed to parts of the
system where interaction among multiple people happens (e.g. we
wouldn't dream of making the characters allowed in refnames
configurable---that would cause chaos between hosting sites and
fetchers), where we give more careful thought before making things
configurable in order to avoid fracturing the ecosystem.

Thanks.


[Footnote]

*1* ... exactly because we know that most users who used Git in the
past 15 years were happy with the current limit as we haven't seen
much complaint until your patch.  We cannot tell if they wanted the
limit to be shorter, or longer, though.

