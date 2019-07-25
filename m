Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15101F462
	for <e@80x24.org>; Thu, 25 Jul 2019 13:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbfGYNDC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 09:03:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389671AbfGYNDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 09:03:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47AFC86CB2;
        Thu, 25 Jul 2019 09:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ltOT8LCDwDw1
        C6dTvIFjbgHHzfg=; b=MVY6KgFRG22lDRmQB6sF3CVLbyrmZm1TetyTzs0+UzUq
        Yv340xih6cliY4dIZ3qE6eQuNpyKrO8nKtWxuCu7WfxQdXsqvpy25YMSrE6xY+zT
        IG9rmlGmQ0jsJnMp4vbQ5NpIihzBMFegkeoKuy+fY3hnUktOImRbpLFeGKsN8Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wC813x
        n2/FiKBUDEVEVDEeulMVJf+Sx/oDecC9ZKxMRsnQaW+FsztGp25u4ESYoUEg5Dn2
        GGrxS7x8lKzkM2lHWw+4lfE8IqE8CSN97iH6Y8sVKmCICVSDPYlO2VFXJks9U/m5
        Hg+0nWcdXYb8aJSL7LGDtHNIKMr9/gCaXYUIo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 402ED86CB1;
        Thu, 25 Jul 2019 09:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6274D86CAD;
        Thu, 25 Jul 2019 09:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com>
        <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
        <87muh57t5r.fsf@evledraar.gmail.com>
        <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
        <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet>
        <87lfwn70nb.fsf@evledraar.gmail.com>
        <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
Date:   Thu, 25 Jul 2019 06:02:54 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 25 Jul 2019 11:48:16 +0200
        (CEST)")
Message-ID: <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85E8F26E-AEDC-11E9-A171-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> OK, in short, barfing and stopping is a problem, but that flag is
>> not the right knob to tweak.  And the right knob ...
>>
>> >  1) We're oversupplying PCRE2_UTF now, and one such case is what's b=
eing
>> >     reported here. I.e. there's no reason I can think of for why a
>> >     fixed-string pattern should need PCRE2_UTF set when not combined
>> >     with --ignore-case. We can just not do that, but maybe I'm missi=
ng
>> >     something there.
>> >
>> >  2) We can do "try utf8, and fallback". A more advanced version of t=
his
>> >     is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthread=
)
>> >     does. I was thinking something closer to just carrying two compi=
led
>> >     patterns, and falling back on the ~PCRE2_UTF one if we get a
>> >     PCRE2_ERROR_UTF8_* error.
>>
>> ... lies somewhere along that line.  I think that is very sensible.
>
> I am glad that everybody agrees with my original comment on ab/no-kwset
> where I suggested that we should use our knowledge of the encoding of
> the haystack and convert it to UTF-8 if we detect that the pattern is
> UTF-8 encoded,...

Please do not count me among "everybody", then.  I did not think
that =C3=86var meant to iconv the haystack when I wrote the message you
are responding to, but if that was what he meant, I would not have
said "very sensible".

