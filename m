Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB38C001B0
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjGNRH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjGNRH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 13:07:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F506D9
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 10:07:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CBFF18723;
        Fri, 14 Jul 2023 13:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6so7mr1Fpba/to0WP/kGxJ+h5MmJFB8iu/50B1
        e1dc0=; b=kD/g3hq9OnifeTjaW+pci1xZQMx8JDQNKIzH9igG3Ap+l74YXZs6Db
        vpR/4r+pyZ2V8/ZQ2Vl8uwBaUlK4i+T8mDk7/OFEcyWhVEa/+3c5aZXjUzIBsu9A
        eQbS9Pr7EkblOKxm8FNPNRGLOpeQrIYH4RK1P4gre9NcknNmKG9hE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83ADD18722;
        Fri, 14 Jul 2023 13:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2761418721;
        Fri, 14 Jul 2023 13:07:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Mike Hommey <mh@glandium.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Use lowercase includes for some Windows headers
References: <20230604211934.1365289-1-mh@glandium.org>
        <xmqqmt14a36k.fsf@gitster.g>
Date:   Fri, 14 Jul 2023 10:07:19 -0700
In-Reply-To: <xmqqmt14a36k.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        12 Jun 2023 12:30:43 -0700")
Message-ID: <xmqqv8empgl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E52A4C74-2268-11EE-AD32-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> When cross-compiling with the mingw toolchain on a system with a case
>> sensitive filesystem, the mixed case (which is technically correct as
>> per the contents of MS Visual C++) doesn't work (the corresponding mingw
>> headers are all lowercase for some reason).
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>  compat/win32/trace2_win32_process_info.c | 4 ++--
>>  wrapper.c                                | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> ...  The only possible breakage I can think of is if
> different versions of mingw toolchain have these header files in
> different cases---those who have been happily using header files
> like <tlHelp32.h> on their case sensitive filesystem now will find
> their build to fail.  Theoretically, those who _corrected_ their
> header files to mixed case themselves (as it is "technically correct
> as per the contents of MS Visual C++") will be broken the same way,
> but they should be capable of diagnosing and recovering from such a
> breakage, so I'm not worried about that.
>
> Appreciate input from those who builds with mingw toolchain, but in
> the meantime let me queue it on 'seen' so that we won't forget.

And a month has passed.  Unless I hear objections, I'll merge this
change to 'next' in a few days at most.

Thanks.

>
> Thanks.
>
>
>
>
>
>> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
>> index a4e33768f4..438af8f818 100644
>> --- a/compat/win32/trace2_win32_process_info.c
>> +++ b/compat/win32/trace2_win32_process_info.c
>> @@ -3,8 +3,8 @@
>>  #include "../../repository.h"
>>  #include "../../trace2.h"
>>  #include "lazyload.h"
>> -#include <Psapi.h>
>> -#include <tlHelp32.h>
>> +#include <psapi.h>
>> +#include <tlhelp32.h>
>>  
>>  /*
>>   * An arbitrarily chosen value to limit the size of the ancestor
>> diff --git a/wrapper.c b/wrapper.c
>> index 67f5f5dbe1..5dc48e815a 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -17,7 +17,7 @@ static intmax_t count_fsync_hardware_flush;
>>  #ifdef HAVE_RTLGENRANDOM
>>  /* This is required to get access to RtlGenRandom. */
>>  #define SystemFunction036 NTAPI SystemFunction036
>> -#include <NTSecAPI.h>
>> +#include <ntsecapi.h>
>>  #undef SystemFunction036
>>  #endif
