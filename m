Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39808C3F6B0
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiG1VAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiG1VAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:00:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A078DC1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:59:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A479819E646;
        Thu, 28 Jul 2022 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yYpvuY+wNjmr
        OsTQ9gPs6ZKYxgL+J5U6WCfwYWVh9zs=; b=uyLokpBMy5cdp+upWnBv65Z2rUvW
        LQZQnq1OmLXQHGDjAPTDyvCxnNButcODCShx7wAK9pdIEkfyNzLRuhrhC0+cfRzC
        /9IW008e2/Vo9ZuwI2/KPqd2//eOB7K0QGgyIi1b7MIuSkmxtKwmRwVLz42p0tcM
        KX9kQ9hHojcwa9w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D14019E644;
        Thu, 28 Jul 2022 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F71F19E641;
        Thu, 28 Jul 2022 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>
Subject: Re: [PATCH] format-patch: clarify --creation-factor=<factor>
References: <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <20220728174953.66964-1-sunshine@sunshineco.com>
        <220728.867d3xj6s0.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Jul 2022 13:59:06 -0700
In-Reply-To: <220728.867d3xj6s0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jul 2022 22:55:31 +0200")
Message-ID: <xmqqv8rh9co5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1ED05812-0EB8-11ED-AB3D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-fo=
rmat-patch.txt
>> index be797d7a28..e06475abcd 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -27,7 +27,7 @@ SYNOPSIS
>>  		   [--[no-]encode-email-headers]
>>  		   [--no-notes | --notes[=3D<ref>]]
>>  		   [--interdiff=3D<previous>]
>> -		   [--range-diff=3D<previous> [--creation-factor=3D<percent>]]
>> +		   [--range-diff=3D<previous> [--creation-factor=3D<factor>]]
>>  		   [--filename-max-length=3D<n>]
>>  		   [--progress]
>>  		   [<common diff options>]
>> @@ -321,7 +321,7 @@ product of `format-patch` is generated, and they a=
re not passed to
>>  the underlying `range-diff` machinery used to generate the cover-lett=
er
>>  material (this may change in the future).
>> =20
>> ---creation-factor=3D<percent>::
>> +--creation-factor=3D<factor>::
>>  	Used with `--range-diff`, tweak the heuristic which matches up commi=
ts
>>  	between the previous and current series of patches by adjusting the
>>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
>
> Looks good as far as it goes, looks like both of your patches need to
> also tweak this bit though:
>
> 	$ git -P grep 'percentage.*creation' -- '*.c'
> 	builtin/log.c:                      N_("percentage by which creation i=
s weighted")),
> 	builtin/range-diff.c:                       N_("percentage by which cr=
eation is weighted")),
>
> Probably just s/percentage/factor/ in for those -h strings?

Thanks for being extra careful.

Eric, I am not sure if the other patch for the range-diff command as
a standalone patch is worth it.  Perhaps you can help me by
submitting a single combined patch to cover the above as well as
what we wrote in the two patches, with you marked as the primary
author and with Helped-by: that credits =C3=86var?

Thanks.
