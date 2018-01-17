Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE40E1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeAQRzZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 12:55:25 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:44751 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753462AbeAQRzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 12:55:24 -0500
Received: by mail-io0-f177.google.com with SMTP id z6so4755462iob.11
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PS0tTFE872bCcsE3DG5yKhaASTPnITweDvYyIcQBtiA=;
        b=lJCZbVlXK3Y9P2oDL0JRCfjo/zi0zdyqSxXzqaCnTz9b0uT+fXigWlQhdkS0MPwviu
         G6/v/+8sLg3xnr82C0Y/FPSJ5mKw70rskiW/w1358ASkbhgQAjjIsZruSxOSFnS6yFkY
         NtQIqAIRSVZwv8Ckfwr9tFtCzlrjvHF+qnEefD1Z92TrPAHMIHm0jyxptYtF9RhMYx2N
         OOCc9bj2KcfWfi94Ph52Wg6yF9KXaItDQfgJuytpB1WZS537JqBDzIGCr8AlbqMS1PAw
         o/QyUMQrBcxs9yyMBVfqC/esqaAxrHqsLqVJZKWVHaAhBcXMkbvtwos9H3YaGWs4YSFw
         L3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PS0tTFE872bCcsE3DG5yKhaASTPnITweDvYyIcQBtiA=;
        b=mequySvy6FWMRQn1MetS1G9DAQHBklrsjRTIcd7Auw5MDTezwJ4/10E9xSX90v49b5
         NJkBICBhVk8Cq2xrQsFVD4sBxxEqGYTYHBTOguy9+ymbghdU3ZWdwh76GWQwD/i+uxZu
         nelVyJErhRWf3aThlOSQc/RuR1pV3n+xWXizX2hMauOGCsGkarITFhCfMXER4tbUMN/p
         PLGsnpPz3PT30Pcl2topKZDC6hoRGB0uLiMhy4/FTiTywD54yOHEHiRBnK0Uag9TYWIg
         wCm5xt7r9E8IV4VexOF7OcLLLNwShYLaNaXDYrkNpbW0cFj4yHqCLNRJRK4ujIIqwbBp
         sd0g==
X-Gm-Message-State: AKwxytfpj+dE2WtLW1YbxxWWp3VWOTaARRT3SVx7fG8JrbW+eVN0Ginh
        VaAxo4xItmFQmoBqomYFFMrx/AQF8yT0ZLOSVdc=
X-Google-Smtp-Source: ACJfBov99q53nGbvFf4UVNMqe6pOD5naxh3mThd4OFwHeYi6OPCMT2/+uKtbzGYUA9BNlENN8+phpVGEePXmwDk6Jy8=
X-Received: by 10.107.17.37 with SMTP id z37mr9423541ioi.282.1516211723055;
 Wed, 17 Jan 2018 09:55:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 09:55:22 -0800 (PST)
In-Reply-To: <b956f893-74c4-3b0e-1f0a-4be1b01dc649@jeffhostetler.com>
References: <20180116071814.19884-1-chriscool@tuxfamily.org>
 <65c81aae-5652-281f-565a-f6116d94abc1@gmail.com> <b956f893-74c4-3b0e-1f0a-4be1b01dc649@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jan 2018 18:55:22 +0100
Message-ID: <CAP8UFD3bH+VqgPs6KNRc9UHLJiTVmHs5XX3fsh8wS+micGdJLQ@mail.gmail.com>
Subject: Re: [PATCH] sha1_file: remove static strbuf from sha1_file_name()
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 8:00 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/16/2018 9:01 AM, Derrick Stolee wrote:
>>
>> On 1/16/2018 2:18 AM, Christian Couder wrote:
>>>
>>> Using a static buffer in sha1_file_name() is error prone
>>> and the performance improvements it gives are not needed
>>> in most of the callers.
>>>
>>> So let's get rid of this static buffer and, if necessary
>>> or helpful, let's use one in the caller.
>>
>>
>> First: this is a good change for preventing bugs in the future. Do not let
>> my next thought deter you from making this change.
>>
>> Second: I wonder if there is any perf hit now that we are allocating
>> buffers much more often.

When I though that the caller might be performance sensitive, I used a
"static struct strbuf" in the caller to avoid any performance
regression.

Yeah, that means that further work is needed if we want to get rid of
all the static buffers, but that is not my goal. I am just concerned
with cleaning up sha1_file_name() before changing it, and avoiding
some possible trouble when using it.

Feel free to improve on that or even take over this series, otherwise
it can be part of the #leftoverbits.

>> Also, how often does get_object_directory() change,
>> so in some cases we could cache the buffer and only append the parts for the
>> loose object (and not reallocate because the filenames will have equal
>> length).

Again feel free to work on this kind of optimizations on top of this series.

>> I'm concerned about the perf implications when inspecting many loose
>> objects (100k+) but these code paths seem to be involved with more
>> substantial work, such as opening and parsing the objects, so keeping a
>> buffer in-memory is probably unnecessary.

Yeah, I also think it is not necessary to optimize too much.

>>> diff --git a/sha1_file.c b/sha1_file.c
>>> index 3da70ac650..f66c21b2da 100644
>>> --- a/sha1_file.c
>>> +++ b/sha1_file.c
>>> @@ -321,15 +321,11 @@ static void fill_sha1_path(struct strbuf *buf,
>>> const unsigned char *sha1)
>>>       }
>>>   }
>>> -const char *sha1_file_name(const unsigned char *sha1)
>>> +void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
>>>   {
>>> -    static struct strbuf buf = STRBUF_INIT;
>>> -
>>> -    strbuf_reset(&buf);
>>> -    strbuf_addf(&buf, "%s/", get_object_directory());
>>> +    strbuf_addf(buf, "%s/", get_object_directory());
>>> -    fill_sha1_path(&buf, sha1);
>>> -    return buf.buf;
>>> +    fill_sha1_path(buf, sha1);
>>>   }
>>
>>
>> Could you change this to use strbuf_addstr(buf, get_object_directory())
>> followed by a strbuf_addch(buf, '/')? This format string is unnecessary and
>> could become slow if this method is called in a tight loop.
>
> Yes, an _addstr() and _addch() would avoid a sprintf and
> we've seen perf problems with this before.
>
> Could we also add seed the initial buffer size to avoid
> any need to realloc as the buffer is filled in?
>
> Something like:
>         size_t len = strlen(get_object_directory()) + GIT_MAX_HEXSZ + 3;
>         strbuf_reset(&buf);
>         if (len > strbuf_avail(&buf))
>                 strbuf_grow(&buf, len);
>         strbuf_addstr(&buf, ...);

Ok, I did something like that in another patch on top of the first
patch which is just about using a "struct strbuf *" passed as an
argument instead of a static buffer.

>>>   struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
>>> @@ -710,7 +706,12 @@ int check_and_freshen_file(const char *fn, int
>>> freshen)
>>>   static int check_and_freshen_local(const unsigned char *sha1, int
>>> freshen)
>>>   {
>>> -    return check_and_freshen_file(sha1_file_name(sha1), freshen);
>>> +    static struct strbuf buf = STRBUF_INIT;
>>> +
>>> +    strbuf_reset(&buf);
>>> +    sha1_file_name(&buf, sha1);
>>> +
>>> +    return check_and_freshen_file(buf.buf, freshen);
>>>   }
>
> Does "buf" really need to be static here?  Doesn't this just move the
> problem from sha1_file_name() to here?

Yes, but maybe check_and_freshen_local() is performance sensitive, so
I think it is safer performance wise to still use a static buf.

If there is a consensus that it is ok to not use one here, I am ok to
change that. On the other hand the change could also be part of
another patch on top of this one...

>>>   static int check_and_freshen_nonlocal(const unsigned char *sha1, int
>>> freshen)
>>> @@ -866,8 +867,12 @@ static int stat_sha1_file(const unsigned char *sha1,
>>> struct stat *st,
>>>                 const char **path)
>>>   {
>>>       struct alternate_object_database *alt;
>>> +    static struct strbuf buf = STRBUF_INIT;
>>> +
>>> +    strbuf_reset(&buf);
>>> +    sha1_file_name(&buf, sha1);
>>> +    *path = buf.buf;
>>> -    *path = sha1_file_name(sha1);
>>>       if (!lstat(*path, st))
>>>           return 0;
>
> Again, making "buf" static here feels wrong.  Perhaps, change the signature
> of the static function to drop the const on the "path" and strbuf_detach
> buf.buf
> and give it to the caller (if path is not NULL) and otherwise release it
> here.

I don't think it is a good idea to do too many things in this patch,
so I think it should be part of another patch to change the way
stat_sha1_file() works.

>>> @@ -891,8 +896,12 @@ static int open_sha1_file(const unsigned char *sha1,
>>> const char **path)
>>>       int fd;
>>>       struct alternate_object_database *alt;
>>>       int most_interesting_errno;
>>> +    static struct strbuf buf = STRBUF_INIT;
>>> +
>>> +    strbuf_reset(&buf);
>>> +    sha1_file_name(&buf, sha1);
>>> +    *path = buf.buf;
>>> -    *path = sha1_file_name(sha1);
>>>       fd = git_open(*path);
>>>       if (fd >= 0)
>>>           return fd;
>
> Same comment here about the static strbuf.

Same comment for me too.

>> The check_and_freshen_nonlocal() and open_sha1_file() method comments

Actually I think it is stat_sha1_file() and open_sha1_file() that have
those comments.

>> warn
>> about the 'path' pointer and how it could be overwritten with another call
>> to sha1_file_name(). Your patch fixes that issue, so the comments can be
>> removed.
>
> Wait, we've eliminated the static buffer inside sha1_file_name(), but
> all of these callers currently define their own static buffers, so the
> comments still apply, right?

Yeah right, that's why I didn't change the comments.

> There is also an effectively static buffer in each of the alternates
> that is used by alt_sha1_path().

Yeah and I didn't change that, so anyway, if you want to get rid of
all the static buffers, other work than just this patch is needed.

>> Since these methods are currently being extra careful about the 'path'
>> parameter, perhaps these are candidates to keep a static buffer around?
>
> If I have multiple threads (as part of say a threaded checkout), we're
> still going to stumble over these static loose object pathname buffers,
> right?

I agree but again getting rid of all the static buffers is not the
goal of this patch series.

[...]

>> Thanks for this cleanup!
>
> Yes, thanks for digging into this!

Thanks for your comments,
Christian.
