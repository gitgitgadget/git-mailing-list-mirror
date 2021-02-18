Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF20C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9D764D73
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBRW2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:28:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54260 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRW2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:28:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7134B9AA87;
        Thu, 18 Feb 2021 17:27:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gkEwPNbAQulV
        j+2OCqIyxWFpvOc=; b=Ytx03B/RAaiZKTKL/MkCxLg0lhVdmo1d+pP/ym5Rvy3y
        1nGaNjAkIfTcb0vwuDdxWVxa98HLHcI7YaycXk1cwctFs9A204ZOWrtfYUmo+zCS
        wwya2D3Qp8Z1GzTMDKXaANhQKKDCCK1Gk0UT1Hf2YZ0u/+dUCYVA22kFsblZE1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xwimhA
        /G0ouxWIaEifcyrRGllBe/PZSEV6hIuSNevSrRXuWGpZGLZvxeNvSg9b7pkoBINg
        9qKhl/lYTkEPPFMeB0imcQB3FQkQo9Reov7WpLmnbT8MfOixSvphURfsD9Bj9Ll0
        1eOJgAQHEvMckZeUPJPXnJn30eWoCSDd25mVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69E799AA86;
        Thu, 18 Feb 2021 17:27:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E58AA9AA85;
        Thu, 18 Feb 2021 17:27:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 06/10] fsck.h: move
 FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-7-avarab@gmail.com>
        <YC7FcTnduQiaF+W5@coredump.intra.peff.net>
Date:   Thu, 18 Feb 2021 14:27:51 -0800
In-Reply-To: <YC7FcTnduQiaF+W5@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 18 Feb 2021 14:52:17 -0500")
Message-ID: <xmqqy2flc8pk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89BD5F80-7238-11EB-9B95-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 18, 2021 at 11:58:36AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Move the FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} defines into a new
>> fsck_msg_type enum.
>
> Makes sense. As with my previous comment, I wonder if "severity" is a
> more descriptive term.
>
>> diff --git a/fsck.h b/fsck.h
>> index 0c75789d219..c77e8ddf10b 100644
>> --- a/fsck.h
>> +++ b/fsck.h
>> @@ -3,10 +3,13 @@
>> =20
>>  #include "oidset.h"
>> =20
>> -#define FSCK_ERROR 1
>> -#define FSCK_WARN 2
>> -#define FSCK_IGNORE 3
>> -
>> +enum fsck_msg_type {
>> +	FSCK_INFO =3D -2,
>> +	FSCK_FATAL =3D -1,
>> +	FSCK_ERROR =3D 1,
>> +	FSCK_WARN,
>> +	FSCK_IGNORE
>> +};
>
> You kept the values the same as they were before, which is good in a
> refactoring step, but...wow, the ordering is weird and confusing.
>
> In FATAL/ERROR/WARN/IGNORE the number increases as severity decreases.
> Maybe reversed from how I'd do it, but at least the order makes sense.
> But somehow INFO is on the far side of FATAL?
>
> Again, not something to address in this patch, but I hope something we
> could maybe deal with in the longer term (perhaps along with fixing the
> weird "INFO is a warning from the user's perspective, but WARNING is
> generally an error" behavior).
>
> I also know that this is assigning WARN and IGNORE based on
> counting-by-one from ERROR, so it's correct. But I think it would be
> more obvious if you simply filled in the values manually, so a reader
> does not have to wonder why some are assigned and some are not.

I had the same reaction, plus "Wow, we had FSCK_* constants in two
different places and without colliding?  Have we been lucky?
Declaring it in one place, whether we use enum or not (as enum is
not very useful in C as a type checking vehicle), makes a lot of
sense but why does this come this late in the series, instead of
being at the front as a trivial low-hanging fruit?"

Thanks.
