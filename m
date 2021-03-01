Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A6C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8708860230
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhCAWW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:22:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64862 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhCAWUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:20:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6879BAD118;
        Mon,  1 Mar 2021 17:19:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HaheigCSlGdgZJDjh1h9j3ZeaX0=; b=qeNlKZ
        FJ/7YePTE4DMEG8IJLVTD/rzy5i3+Q3o4Rt4tK7lFV0wNk9sdA2rOYdbN3xF9qQo
        v3srAXl0anyyHqTmi2dRvNQ2in5c0g30FTAUb9SiY73LahLd25Zi4odq8gkR06HS
        kGiDPGHaoL2F+yk2XG++uPRyCynUWviNEcleU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E+WOSpTXDOMN3u8A4rdkXrarNjXo3RUz
        cAPE4qVP/16slJ4HhiicrsXt1GWbJpeLpzeUW+WlhtkjjmjwX8MjtNMBsaHHYaep
        uiwp/zYAIvqxx2Lha8tcuWu4e4L9W2RKMUyIi5QslKwLAQ2ivOD71EteWHn+hZW7
        5lKqG9TK/rA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F908AD117;
        Mon,  1 Mar 2021 17:19:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8A3DAD114;
        Mon,  1 Mar 2021 17:19:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
References: <20201205014607.1464119-1-emilyshaffer@google.com>
        <20201222000220.1491091-1-emilyshaffer@google.com>
        <YCwhA6VIs16uMnJG@google.com>
        <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
        <YC2IzVxLgvC7N8qd@google.com> <xmqqlfbmi99f.fsf@gitster.g>
        <xmqq4ki0udu4.fsf@gitster.g> <YD1hfZqfu9bcMkra@google.com>
Date:   Mon, 01 Mar 2021 14:19:31 -0800
In-Reply-To: <YD1hfZqfu9bcMkra@google.com> (Emily Shaffer's message of "Mon, 1
        Mar 2021 13:51:31 -0800")
Message-ID: <xmqqtupums98.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 323B00DA-7ADC-11EB-9019-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> I said this on Feb 17th, but since then I think I saw you answer
>> "I'll do that" in responses to JTan's reviews in the past few days
>> (e.g. <YC7o2rUQOEdiMdqh@google.com>).  Would I regret if I merge the
>> topic down to 'next' today?
>
> Bah, I'm sorry I missed this - I had a broken mutt config and wasn't
> seeing replies, my own fault. Argh.
>
> I have some pretty significant changes from JTan's reviews, so I'd
> prefer if you would wait since it would be tricky to turn them into a
> patch commit now. But if you'd rather merge it and see a patch instead,
> that is fine with me.

OK, I still have it outside 'next', I think.
