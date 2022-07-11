Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3765BC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 17:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGKRLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKRLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 13:11:42 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BE33A29
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657559481;
        bh=k8R3WpHbimvHyf9Ap1MY4dKcS58sD19UTs4dKGXl/iw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AJO8KVkn8ul4zvGbQoMT6lCnuTiUu+Nw9tKYfXDNbO57FBIwuVMUP3rZbM3+5sLmp
         KGVzn3s6qV4v5ghAhacULfyvcbpvAdpSxBLmpGLKSmE5IaFJN9Qai2ajHU365olTha
         7wGb1gwdLG4g05qlbLYLOXVEikPNQfxWUDoMAlok=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1npNYO1LpB-00maGk; Mon, 11
 Jul 2022 19:11:21 +0200
Message-ID: <e29e424f-c214-a912-fba8-107c5e402b8a@web.de>
Date:   Mon, 11 Jul 2022 19:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH] cocci: avoid normalization rules for memcpy
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
 <95432eb4-e66a-5c04-9267-f71391fbe277@web.de> <xmqqmtdhsf1z.fsf@gitster.g>
 <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
 <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lMKbOsq5gh9PWxqcp6EjnnvYlKRodrTuej18Mz7GT8G8c9edJuA
 Xb9xp7vni4wA87j4UI7GOgsEV0EeNQsNRyZ8G0QSBa8UCfG22MV2DbDg+WrGkyqjfv7YqFx
 N+rE5BamJvoGVtTaKN9fX0whSb/ATua+VmMhdESmOdv7UTBKtrU9faCJmAdPdM/87bx8Y2x
 4oc4+Tga7usfLqcFHH7Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Scxp2f6IxbE=:kvCFuPJZwg3+TiDZQvlpPr
 aY3aBUksct1Z8CoCeoeYWxkKqW8Y68ZRsaBjuW0H2zxvOSgm4/r79EYKWUokNIroER6fYQChB
 /MPWL6O10PdBRp2I8u5WjO2KFiAac0HYrgGgdgvCCMPqLR8CcLWejjAC8TmEhAqxcm8bP9ZXM
 3/1+YpsksXZ/EEEXYExAZQk7vR+92Majk/tJXWW0mUhjA2RcWvAD1f1l2i2RYsly8yRyUxxNn
 /1Jmr735GahbK5SM7YQHhjewdyhmI4aSn7dirtVV6i8QnSM/UYRlPK8RhH+HRmrW/fBjse0Zs
 IVR+gusSfaGr8SFtqbw2emlpYLRkUtgbVBJbwXjj4sLo9QV0ZxMWNff9zfNpq62r2Lg0QHjJ1
 F1F3TNjt8693Byf8duZMSG6yzNsBSyvUdEk37vgJjNoqzLOdD6gNKBcthLndOo4F//cu7T5Yy
 xD0jWFQnuMvVc5koT79nScAN85auFGWhpyYJBoEbk6Qt9bKsBZVAjk0q0pvH0C1Jh037AbiXj
 l+aQUyL8n8UP6PcdeKmLYyooLPVXuZpc1bC+6pIZpAxu93WIYIwFRZ1R52QqxohfDNi1cNn8W
 R3y+sLfnmAZzGevx3tj65qRFZgewBanGsQR1H2t0QGuj62J0jlNJ/sI+3sPFiKz2aSTBLw7Ui
 ppm9s0cN39nOUU72JFeHb2upXvJ1Oer9Q7T2mdbtKNbBFtsrbtQwtX9k39/FBWoDcwbV8UfDO
 B9u2Bcu441IsFxcQEzd3mkPWyAn0uW+IsiVwWQQW9CXSPoheA8HgY0afW1j6xdFpZ29K4e7ky
 GrVeyBVf1sKrlQI1tURLh5FmglwldtRewi52qGCWc1DI64j8gYz0GaHD4zKRlmtoO6dTt01/A
 9ThoXC3hK1hOOqxWUrrFQAoe9PRPh+EdN/9AGIlHNX0dIQn2cL3ssuV+tVwG2dsjUR6cz8Ytr
 FbCQn2PgJxqOFXhfSkT9NFoDJv4Hd8bmwhJwzopMF6OBcoV5o9+nnSVp7vO2M0UBTsJLTsK4f
 yAt9htUfbky8nvqnb9z7kXiev9TZ2X057o7ujyJY1mO+ompcsTASqGh44YVwrxdhe/Ik+tQEF
 60apAxbZLUDAL/ZCQFG1/mwZYWq9OeDn1y1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.22 um 16:45 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Jul 10 2022, Ren=C3=A9 Scharfe wrote:
>
>> Some of the rules for using COPY_ARRAY instead of memcpy with sizeof ar=
e
>> intended to reduce the number of sizeof variants to deal with.  They ca=
n
>> have unintended side effects if only they match, but not the one for th=
e
>> COPY_ARRAY conversion at the end.
>
> Since ab/cocci-unused is marked for "next" it would be really nice to
> have this based on top so we can add tests for these transformations
> (the topic adds a way to do that).

Testing semantic patches sounds like a good idea.  We can add tests later,
once that feature landed.

>
> But if you don't feel like  doing that this is fine too.
>
>> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.=
cocci
>> index 9a4f00cb1b..aa75937950 100644
>> --- a/contrib/coccinelle/array.cocci
>> +++ b/contrib/coccinelle/array.cocci
>> @@ -1,60 +1,58 @@
>> -@@
>> -expression dst, src, n, E;
>> -@@
>> -  memcpy(dst, src, n * sizeof(
>> -- E[...]
>> -+ *(E)
>> -  ))
>> -
>> -@@
>> -type T;
>> -T *ptr;
>> -T[] arr;
>> -expression E, n;
>> -@@
>> -(
>> -  memcpy(ptr, E,
>> -- n * sizeof(*(ptr))
>> -+ n * sizeof(T)
>> -  )
>> -|
>> -  memcpy(arr, E,
>> -- n * sizeof(*(arr))
>> -+ n * sizeof(T)
>> -  )
>> -|
>> -  memcpy(E, ptr,
>> -- n * sizeof(*(ptr))
>> -+ n * sizeof(T)
>> -  )
>> -|
>> -  memcpy(E, arr,
>> -- n * sizeof(*(arr))
>> -+ n * sizeof(T)
>> -  )
>> -)
>> -
>>  @@
>>  type T;
>>  T *dst_ptr;
>>  T *src_ptr;
>> -T[] dst_arr;
>> -T[] src_arr;
>>  expression n;
>>  @@
>> -(
>> -- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
>> +- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(T)
>> +-                                \| sizeof(*(dst_ptr))
>> +-                                \| sizeof(*(src_ptr))
>> +-                                \| sizeof(dst_ptr[...])
>> +-                                \| sizeof(src_ptr[...])
>> +-                                \) )
>>  + COPY_ARRAY(dst_ptr, src_ptr, n)
>> -|
>> -- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
>> +
>> +@@
>> +type T;
>> +T *dst_ptr;
>> +T[] src_arr;
>> +expression n;
>> +@@
>> +- memcpy(dst_ptr, src_arr, (n) * \( sizeof(T)
>> +-                                \| sizeof(*(dst_ptr))
>> +-                                \| sizeof(*(src_arr))
>> +-                                \| sizeof(dst_ptr[...])
>> +-                                \| sizeof(src_arr[...])
>> +-                                \) )
>>  + COPY_ARRAY(dst_ptr, src_arr, n)
>> -|
>> -- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
>> +
>> +@@
>> +type T;
>> +T[] dst_arr;
>> +T *src_ptr;
>> +expression n;
>> +@@
>> +- memcpy(dst_arr, src_ptr, (n) * \( sizeof(T)
>> +-                                \| sizeof(*(dst_arr))
>> +-                                \| sizeof(*(src_ptr))
>> +-                                \| sizeof(dst_arr[...])
>> +-                                \| sizeof(src_ptr[...])
>> +-                                \) )
>>  + COPY_ARRAY(dst_arr, src_ptr, n)
>> -|
>> -- memcpy(dst_arr, src_arr, (n) * sizeof(T))
>> +
>> +@@
>> +type T;
>> +T[] dst_arr;
>> +T[] src_arr;
>> +expression n;
>> +@@
>> +- memcpy(dst_arr, src_arr, (n) * \( sizeof(T)
>> +-                                \| sizeof(*(dst_arr))
>> +-                                \| sizeof(*(src_arr))
>> +-                                \| sizeof(dst_arr[...])
>> +-                                \| sizeof(src_arr[...])
>> +-                                \) )
>>  + COPY_ARRAY(dst_arr, src_arr, n)
>> -)
>>
>>  @@
>>  type T;
>
> Hrm, this seems like a lot of repetition, it's here in the rules you're
> editing already, but these repeated "sizeof" make it a lot more verbose.
>
> Isn't there a way to avoid this by simply wrapping this across lines, I
> didn't test, but I think you can do this sort of thing in the cocci
> grammar:
>
> - memcpy(
> - COPY_ARRAY(
>   (
>   dst_arr
>   |
>   dst_ptr
>   )
>   ,
>   (
>   src_arr
>   |
>   src_ptr
>   )
>   ,
>   (n) *
> -  [your big sizeof alternate here]
>   )

Hmm, that would match many more combinations, e.g. this one:

void f(int *a, int *b, long n, int c[1]) {
	memcpy(a, b, n * sizeof(*c));
}

The elements of a, b and c have the same type, so replacing c with a
(which a conversion to COPY_ARRAY would do) would produce the same
object code.  I can't come up with a plausible scenario like above and
where a type change of c down the line would cause problems, but I
also can't convince myself that no such thing can exist.  Tricky.

And I can't get it to format the whitespace around the third argument
of COPY_ARRAY nicely in all cases.

And it takes 37% longer on my machine.

But it sure is more compact. :)

@@
type T;
T *dst_ptr;
T *src_ptr;
T[] dst_arr;
T[] src_arr;
expression n;
@@
- memcpy
+ COPY_ARRAY
  (
  \( dst_ptr \| dst_arr \) ,
  \( src_ptr \| src_arr \) ,
- (n) *  \( sizeof(T)
-        \| sizeof(*(dst_ptr))
-        \| sizeof(*(dst_arr))
-        \| sizeof(*(src_ptr))
-        \| sizeof(*(src_arr))
-        \| sizeof(dst_ptr[...])
-        \| sizeof(dst_arr[...])
-        \| sizeof(src_ptr[...])
-        \| sizeof(src_arr[...])
-        \)
+ n
  )

>
> I.e. you want to preserve whatever we match in the 1st and 2nd
> arguments, but only want to munge part of the 3rd argument. The cocci
> grammar can "reach into" lines like that, it doesn't need to be limited
> to line-based diffs.
>
> But I didn't try it in this caes, and maybe there's a good reason for
> why it can't happen in this case...
>
> I also wonder if that won't be a lot faster, i.e. if you can condense
> this all into one rule it won't need to match this N times, but maybe
> the overall complexity of the rules makes it come out to the same thing
> in the end...
