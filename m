Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47661C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 01:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhLWBYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 20:24:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50873 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLWBYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 20:24:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCEFE10F9BC;
        Wed, 22 Dec 2021 20:24:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zpR+l6cJpyA1
        UDpuKQ9fbxswLfJu9plSdAerSDgCcm8=; b=U9QLVcYznomWnDE3kpBSr0GdKJWO
        cqOZoMpElmEzSvhtu4zRZqk321CsNBJQtNRTQo0zvVDYpMSc9qDtlHVPyXWAfzmR
        4JnkXN6JYFWzoQiyHNQrTqctgH87RVWuk+xzidTV7jGk85UTdzLIttQCZnqYOvCr
        iL+XbRzKyCFj8BI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E68610F9BB;
        Wed, 22 Dec 2021 20:24:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCC6010F9BA;
        Wed, 22 Dec 2021 20:24:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] fetch-pack: parameterize message containing 'ready'
 keyword
References: <20211222075805.19027-1-bagasdotme@gmail.com>
        <211222.86a6gtoyg2.gmgdl@evledraar.gmail.com>
Date:   Wed, 22 Dec 2021 17:24:03 -0800
In-Reply-To: <211222.86a6gtoyg2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 22 Dec 2021 09:06:30 +0100")
Message-ID: <xmqqtuf0cdvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 048962C0-638F-11EC-AA04-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 34987a2c30..51385cb3c9 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -1415,9 +1415,17 @@ static int process_ack(struct fetch_negotiator =
*negotiator,
>>  	 * otherwise.
>>  	 */
>>  	if (*received_ready && reader->status !=3D PACKET_READ_DELIM)
>> -		die(_("expected packfile to be sent after 'ready'"));
>> +		/*
>> +		 * TRANSLATORS: The parameter will be 'ready', a protocol
>> +		 * keyword.
>> +		 */
>> +		die(_("expected packfile to be sent after '%s'"), "ready");
>>  	if (!*received_ready && reader->status !=3D PACKET_READ_FLUSH)
>> -		die(_("expected no other sections to be sent after no 'ready'"));
>> +		/*
>> +		 * TRANSLATORS: The parameter will be 'ready', a protocol
>> +		 * keyword.
>> +		 */
>> +		die(_("expected no other sections to be sent after '%s'"), "ready")=
;
>> =20
>>  	return 0;
>>  }
>>
>> base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
>
> This version (and earlier ones, really) looks good to me. Thanks!

Trusting your ack wasted me one integration cycle by not looking at
it myself X-<.

There is "no" missing from the latter message.

Back to finishing today's (belated) integration cycle.  Hopefully I
can finish before dinner.

Thanks.
