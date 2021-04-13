Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CEC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3663E61220
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhDMSO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:14:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65100 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhDMSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 14:14:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E74A5122561;
        Tue, 13 Apr 2021 14:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nP116LMGatjMEZ92IIMGZaMp/f0=; b=N3l4Di
        6v4Xva9Cv62LzYNYcuEwD2UBvEWlng7jCAeN7ZJ5Twf7fLQIMPEz9XV3vTG5tW/s
        Wigk0wZK+arvakAj/NYYJE6Z4vJbB6uO0lgpScqOjNrnt1FhU/qO6CEyUUzSHUdl
        GQzOg2/c2E7ML9tGlOOAinEXRQ6QgNDXu59R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jgnVcd3z3oGtjMVAec8XiYlycpMsDZ+C
        OGeY2p3pun+RPqjtqha99HLmjtSAbvImDai9iPYRKth/wpf1f5u1t5+aL733zqef
        tEv22yHjIDl0i/VATIJqrS5X8QpvMkbrx2PbAeYlUs17DSp1LcaacT2VWS98/v3f
        4IIVj3vRxPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E11FD12255F;
        Tue, 13 Apr 2021 14:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30F8612255E;
        Tue, 13 Apr 2021 14:14:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
        <xmqqsg3vb51n.fsf@gitster.g>
        <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
Date:   Tue, 13 Apr 2021 11:14:32 -0700
In-Reply-To: <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
        (Christian Couder's message of "Tue, 13 Apr 2021 09:33:38 +0200")
Message-ID: <xmqq7dl6m4qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 197CE8DC-9C84-11EB-9515-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It might be desirable to make it easier for people to migrate from
> ".command" to ".cmd". I agree this is debatable, but I don't see a big
> downside in it. Maybe, if no argument was passed at all the first time
> the command is called instead of the empty string, the command could
> then know that it's called for the first time. I am not sure this
> would be very helpful in practice though.

An integration of the trailer mechanism into the "git commit"
command, which cannot emulate "-s" at the end-user level, is
something I would call a big failure, though.

>> This and the other (omitted) example demonstrates how the initial
>> "empty" invocation is useless by using "replace".  Which also means
>> that you cannot add more than one trailer of the same <key> with the
>> mechanism (since the older ones are replaced with the latest).
>
> You can add more than one trailer with the same key if you don't use
> "replace" but use "--trim-empty" on the command line, so that an empty
> trailer added by the initial invocation is removed. And we can later
> add a `trailer.<token>.runMode` to remove the initial invocation.

As I said in the other message (not the one you are responding to),
trim-empty is not a viable workaround.  Imagine what happens when
you want to always add a trailer (unrelated to signed-off-by), for
which it is perfectly valid not to have any value.  An attempt to
work around the problem "extra call without being asked from the
command line" behaviour has on our emulated "signed-off-by" example
with --trim-empty would nuke such an unrelated trailer.

Besides, if the command produced non-empty value, e.g.

	[trailer "baz"] command = "echo B $ARG Z"

the extra call without being asked from the command line will still
give "baz: B  Z" that is not empty.

So... I am very curious to learn what the intended use case is for
this puzzling feature.  If it turns out to be that it behaves only
because it was coded that way without any real benefit, I would
strongly prefer not to carry it over to the new .cmd thing, which is
an attempt to deprecate .command to get rid of its broken parts (so
far, we identified two---only the first occurrence is replaced, and
the replacement can break command line syntax) while salvaging its
good parts (being able to programmatically decide the value).  And
so far what I heard hasn't convinced me that this behaviour falls
into the latter category.

Thanks.
