Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8F4201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758374AbdEORQz (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:16:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33392 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdEORQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:16:54 -0400
Received: by mail-io0-f194.google.com with SMTP id m4so12212681ioe.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=baudFDmUt6xvk+2jCxgkfHQOb/2hatFX6TL1c1XIh9M=;
        b=IV0ZD5dTJItB7qm3hBAL9YUU2Ty4BC4foA4QkoLG3OHagIMLoxvqvRwS7CfSdlqioL
         TQvLcTfK6oyvxwGjTsVyyfVX3eILUJliRcnHuJr9OjRrdTzBkPx0VzFYxlCYAzipWFnL
         5gQE8qNLiVTfeAKvNgu6vWZIYXpp68OQpjzDkYsN9dS6KFMp2ODN60h1EY5QNdiZCkw2
         3zmQGPS32fcXGyMewzyQxiHskRsrm8aWGDp5qji3gBgnf5EufKYTOWbHTqkf7pg0ZuIf
         oBJuevsEz5PpCqVZdiuntu6YKRfRS48HyE5u6wYfeeKXQ3uF7sfAtu+7x5LZ+YGbV5fG
         31Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=baudFDmUt6xvk+2jCxgkfHQOb/2hatFX6TL1c1XIh9M=;
        b=OqqBk3VhBBt66qnOVfoJvCokj5fTNZaDRAQLwbwW8SZcMIwW/YXScCjYFsdsxGcOUv
         vQPydcV560tvaJiUTL//6PD4GxLa3E5HSYPRlPlnxC841OrTgr7/92UH0V+JDD2QNNbt
         gfzsSUGa1MVUsnb9aWqibjQEe3W9GPBFhpYT85KSY81K6kidNtob6F8d+uTQqLgP8FC1
         I4UZJOo/9CNGQzbIDjvpK1Fe1tdHGP+9maJ2XcCNBU9m7hT7rZXxFLMoUppYLTp+PzRU
         f/C3J2UPHtmnIANCneUVFJCEp8jvjpUKxjz1l5X+dNMdCvyRZtm2SFs9Sgznejdzb2Oi
         0AZQ==
X-Gm-Message-State: AODbwcADOjRI9jihpyT/35K2Qby1qom6n354SF0lH9CzbhjTKXbvexxm
        aiJK/cY90H7AmqTPzyg6eol4LF8Okg==
X-Received: by 10.107.201.131 with SMTP id z125mr6155449iof.160.1494868613524;
 Mon, 15 May 2017 10:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 10:16:32 -0700 (PDT)
In-Reply-To: <xmqqfug6v6l3.fsf@gitster.mtv.corp.google.com>
References: <20170513231509.7834-1-avarab@gmail.com> <20170513231509.7834-28-avarab@gmail.com>
 <xmqqfug6v6l3.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 19:16:32 +0200
Message-ID: <CACBZZX61W_MxJJ=YFEGLCk-ktb9xj=D-_jet02McriKJHiHO9g@mail.gmail.com>
Subject: Re: [PATCH v2 27/29] pack-objects: fix buggy warning about threads
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a buggy warning about threads under NO_PTHREADS=3DYesPlease. Due to
>> re-using the delta_search_threads variable for both the state of the
>> "pack.threads" config & the --threads option, setting "pack.threads"
>> but not supplying --threads would trigger the warning for both
>> "pack.threads" & --threads.
>>
>> Solve this bug by resetting the delta_search_threads variable in
>> git_pack_config(), it might then be set by --threads again and be
>> subsequently warned about, as the test I'm changing here asserts.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/pack-objects.c | 4 +++-
>>  t/t5300-pack-object.sh | 3 +--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 0fe35d1b5a..f1baf05dfe 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -2472,8 +2472,10 @@ static int git_pack_config(const char *k, const c=
har *v, void *cb)
>>                       die("invalid number of threads specified (%d)",
>>                           delta_search_threads);
>>  #ifdef NO_PTHREADS
>> -             if (delta_search_threads !=3D 1)
>> +             if (delta_search_threads !=3D 1) {
>>                       warning("no threads support, ignoring %s", k);
>> +                     delta_search_threads =3D 0;
>> +             }
>>  #endif
>>               return 0;
>>       }
>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index 1629fa80b0..0ec25c4966 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -445,8 +445,7 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-=
objects --threads=3DN or pack.
>>       git -c pack.threads=3D2 pack-objects --stdout --all </dev/null >/d=
ev/null 2>err &&
>>       cat err &&
>>       grep ^warning: err >warnings &&
>> -     test_line_count =3D 2 warnings &&
>> -     grep -F "no threads support, ignoring --threads" err &&
>> +     test_line_count =3D 1 warnings &&
>>       grep -F "no threads support, ignoring pack.threads" err &&
>>       git -c pack.threads=3D2 pack-objects --threads=3D4 --stdout --all =
</dev/null >/dev/null 2>err &&
>>       grep ^warning: err >warnings &&
>
> Commenting on both 26 and 27.
>
> The usual way we document a known breakage to be fixed is to write a
> test that checks for the desired outcome with test_expect_failure,
> and when a patch corrects the behaviour we just flip it to expect
> success instead.  On the other hand, when we document a behaviour
> that is accepted/acceptable we would have a test that checks for the
> then-accepted behaviour with test_expect_success, and a patch that
> improves the behaviour would update the expectation.
>
> This follows the second pattern, even though the log message for the
> patches claim this is about an existing bug and its fix.
>
> Now, I am not saying (at least not yet) that 26 & 27 violates the
> established practice and they must be changed to expect seeing only
> one line of output in warnings with test_expect_failure in patch 26
> which is flipped to test_expect_success in patch 27.  Yes, it does
> not follow the usual pattern, but it gives a good food-for-thought.
>
> Perhaps our usual pattern may be suboptimal in illustrating in what
> way the current behaviour is not desirable, and the way these two
> patches document the current breakage and then documents the fixed
> behaviour may be a better example to follow?  With our usual way, it
> is not apparent until you actually run the tests with the current
> code what the questionable current behaviour is, but with the way
> patch 26 is written, we can tell that two warnings are given,
> instead of one.
>
> I dunno.  What do others think?

I think it makes sense to make use of test_expect_failure here. I'll
do that in v3.
