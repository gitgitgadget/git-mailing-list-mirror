Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E715C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B2F20768
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNdoAgkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHJWXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:23:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50128 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgHJWXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:23:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 809ADEB966;
        Mon, 10 Aug 2020 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D3H2GCA2s6xFacWawUN5OTeeyIE=; b=WNdoAg
        kh9TGUftDtT+0M2z9DxX0BFkZq9F3SfZIS9P5c1pPQLhw6bs+TcGD/2II7oHr7lV
        v9OTP+wwx4c1hBQNTSqs/qTcSO+7efQxVBzgh+CQD9KrPaAYvHtit+Vma57DpWHt
        0dEMzWcDz2BLTHTG87X0r+xGuTBe/1eILMir8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+WH6fYvdul+m5Ip7Q94VJJ5NYIB1WQN
        J3EE1T5qtRWU5ZlGwMYw+4EevV386ENrWjwLsB2nH4itXJda5x9uvOUDgo7ALg73
        NXy+Yt7IH2wcglEFcgJtJWB86aIbITGGgNar9LxpGDaHOzZwu2zg5bIGPofbyvH8
        ciiQ8ZBVt6g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79BE4EB965;
        Mon, 10 Aug 2020 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD9AFEB964;
        Mon, 10 Aug 2020 18:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
References: <20200808075323.36041-1-ray@ameretat.dev>
        <20200810085343.43717-1-ray@ameretat.dev>
        <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
        <CAPig+cQCMG3Dx99LWTOAe8wZ2ocdikQAzdDS=-APfYE9HVn+=A@mail.gmail.com>
        <xmqqk0y6b1b0.fsf@gitster.c.googlers.com>
        <CAPig+cSUdRE2=PQhAHXTjJc10meAMSC6FqJ+LEjZYQA4shGURA@mail.gmail.com>
Date:   Mon, 10 Aug 2020 15:22:55 -0700
In-Reply-To: <CAPig+cSUdRE2=PQhAHXTjJc10meAMSC6FqJ+LEjZYQA4shGURA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 10 Aug 2020 18:13:19 -0400")
Message-ID: <xmqqeeoeb0ow.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A7E5926-DB58-11EA-97CB-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 10, 2020 at 6:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > This can be improved by taking advantage of the OID_REGEX variable
>> > defined by the test suite for matching an OID. So something like this
>> > would be even better:
>> >
>> >     cat >expect <<-\EOF &&
>> >     diff --git a/test-file b/test-file
>> >     index OID..OID 100644
>> >     --- a/test-file
>> >     +++ b/test-file
>> >     EOF
>> >     cat blueprint >test-file &&
>> >     git diff --ita-visible-in-index -- test-file >raw &&
>> >     sed "s/$OID_REGEX/OID/g" raw >actual &&
>> >     test_cmp expect actual
>>
>> OID_REGEX is [0-9a-f]{40} while what is used here is [0-9a-f]{1,}.
>> Unless --full-index is in use, they mean different things, no?
>
> You're right, of course. The regex in the original example I gave was
> too loose, matching even single hex letters in words like "index" and
> "test-file", so I wanted to tighten it up, but I botched it with
> OID_REGEX. Anyhow, I hope my examples convey the general idea (which
> needs a bit of tweaking from what I showed).

Yeah, perhaps along the lines of

HEX_RX="_x05*"
sed -e "s/index $HEX_RX..$HEX_RX /index OID..OID /"

