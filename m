Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECDC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E684661278
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhFHX2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:28:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57694 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhFHX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:28:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 806A9142E3A;
        Tue,  8 Jun 2021 19:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cLIWrP+RtpHH
        4AU9e6JxGVCCB0vnENZUJqi4OEowJgU=; b=ehtksC8UaFMb38jKOb9dPOG3lPbE
        uI2Sj+tL3NTiSLCtlYhleaCPmWt3fxgnng86hG7Ck9ekbQepLy3WNiJzP8VshXGK
        2Voy2X91vws8FSUEGZSKGPDsUUxpeU4+a5TNCQMEKCMkYyFuyxkqRH3AStC8YIcc
        NVnomsrYxxALRag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79410142E39;
        Tue,  8 Jun 2021 19:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1135142E35;
        Tue,  8 Jun 2021 19:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/4] test-tool: split up "read-cache" tool
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
        <xmqqr1hdthla.fsf@gitster.g> <87tum838u8.fsf@evledraar.gmail.com>
Date:   Wed, 09 Jun 2021 08:26:19 +0900
In-Reply-To: <87tum838u8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 08 Jun 2021 13:14:36 +0200")
Message-ID: <xmqq8s3kndk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EEBC29D8-C8B0-11EB-867B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>>   test-tool: split up test-tool read-cache
>>>   test-tools: migrate read-cache-perf to parse_options()
>>>   test-tools: migrate read-cache-again to parse_options()
>>>   read-cache perf: add a perf test for refresh_index()
>>
>> Is the contrast between tool and tools deliberate?
>
> Yes, I figured "test-tool:" describes the main entry point of the
> "test-tool somecmd", so if I split up "somecmd" into "othercmd" that's =
a
> "test-tool" change.
>
> But "test-tools:" when I'm modifying particular tools, I can change 2/4
> and 3/4 it to "test-tool read-cache-perf:" and "test-tool
> read-cache-again" (or another thing you suggest) if you think this
> warrants a re-roll.

I actually meant s/test-tools:/test-tool:/ and nothing else, as
changes to read-cache-perf and changes to read-cache-again both fall
into the same test-tool umbrella.  It's not like we benefit from
having two separate <area> (as in "<area>: <description>")
designators for read-cache-perf and read-cache-again---in a larger
picture, they are both things around test-tool helper.

Thanks.


