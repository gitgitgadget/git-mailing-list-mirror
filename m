Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA22C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJKNty (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJKNtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:49:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093413F1D
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:49:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y14so14376893ejd.9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tOW/hG8rPCDQwAVwfMzLklkPfcsdxJTONXTkG45JqI8=;
        b=Ppn1WZGqjjPzbhtVCY2TWlzLkAS3HCQFvxf4gooBA9zI1Xa8q9n1evRDIiJZfd6h03
         e2IlOWHCNqOL//DyBrBZ9/nZAyTlO1m3TE04SH1lwCOKjVir5HJD8J+JmPRUz7o9vhOG
         aLEOu1CFNgYy63JdQeADBp9yuG3rR5GtMs5OHehseRutjE+kRCmk0aOxXFMmJ307lAlS
         KahjzAQznIO04yx54gvJf47GxrXr76cUXLtl+vzy3w97vhUYVNaZiDwrQ0+cH5apVZT+
         qh3WLpJ85Fr4lpJNLpve4Ou7G3GTRdV+eeqgk6baUKiJJB9HVSn2QAyG4UQfQNQjSa7O
         CVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOW/hG8rPCDQwAVwfMzLklkPfcsdxJTONXTkG45JqI8=;
        b=6LvCiXe0h/jAabaaHIug2NWs+Eyw0NQT8zZjMA1lxHN0frK1zP2mpV76aV1985IweV
         7Q3hZqm8OYrEd2glNLzjVrNyoG2wf7S5hkrop0Cm5Z+mlmXJx04slStALC2B1a23denK
         H0C42wGy0d2pMqqn6J/3bdjmZOlCltaXr7X1VpQjhFz2gALPpVqk+MHxyVwbirBwIjwG
         PT7G/8n/oEph9Xolr7czEki7imh7/GWytCL1j5Gn+Vmlfa17BEa5vBDeteuoEKlint4R
         UCDYMheR1n41PuyGIAmuXwlYxpFtyNOnJAdMzJGicrpQsREisZP/Oqp2KMRVMSZaHXn7
         dFMA==
X-Gm-Message-State: ACrzQf0Pt/VyK+LL8a6FnrYYog31w6tqpmStPoCqivH7w5hLp+tPhBJ6
        kmfYlE/kmjMPFhg+6ASnFvo=
X-Google-Smtp-Source: AMsMyM460Jr0KeJWFMqtvByDD+C6xmQPGegAl5QXRQB+Ul439OtCQD7m08g5GamAcuxLPEC19hulxQ==
X-Received: by 2002:a17:907:7607:b0:78d:66e8:c746 with SMTP id jx7-20020a170907760700b0078d66e8c746mr17473097ejc.220.1665496187462;
        Tue, 11 Oct 2022 06:49:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b0074182109623sm7099211ejc.39.2022.10.11.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:49:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiFdh-003vH5-0g;
        Tue, 11 Oct 2022 15:49:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
Date:   Tue, 11 Oct 2022 15:31:10 +0200
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
 <xmqqo7uoh1q0.fsf@gitster.g> <221007.865ygvrjs7.gmgdl@evledraar.gmail.com>
 <afc73d87-b2d9-72e9-1be5-156f37102747@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <afc73d87-b2d9-72e9-1be5-156f37102747@jeffhostetler.com>
Message-ID: <221011.86h70ao4g6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Jeff Hostetler wrote:

> On 10/7/22 6:03 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Oct 06 2022, Junio C Hamano wrote:
>>=20
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> A cleaned up version of the test code I had on top of "master", RFC
>>>> because I may still be missing some context here. E.g. maybe there's a
>>>> plan to dynamically construct these thread names?
>>>
>>> That's nice to learn, indeed.
>>>
>>>> +void jw_object_string_thread(struct json_writer *jw, const char *thre=
ad_name,
>>>> +			     int thread_id)
>>>> +{
>>>> +	object_common(jw, "thread");
>>>> +	strbuf_addch(&jw->json, '"');
>>>> +	jw_strbuf_add_thread_name(&jw->json, thread_name, thread_id);
>>>> +	strbuf_addch(&jw->json, '"');
>>>> +}
>>>
>>> ...
>>>
>>>> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_na=
me,
>>>>   	}
>>>>     	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
>>>> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
>>>> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
>>>> -		    event_name);
>>>> +	oldlen =3D buf->len;
>>>> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
>>>> +	padlen =3D TR2_MAX_THREAD_NAME - (buf->len - oldlen);;
>>>> +	strbuf_addf(buf, "%-*s | %-*s | ", padlen, "",
>>>> +		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
>>>
>>> Having to do strbuf_addf() many times may negatively affect perf_*
>>> stuff, if this code is invoked in the hot path.  I however tend to
>>> treat anything that involves an I/O not performance critical, and
>>> this certainly falls into that category.
>> Yes, and that function already called strbuf_addf() 5-7 times, this
>> adds
>> one more, but only if "thread_id" is > 0.
>> The reason I added jw_object_string_thread() was to avoid the
>> malloc() &
>> free() of a temporary "struct strbuf", it would have been more
>> straightforward to call jw_object_string() like that.
>> I don't think anyone cares about the raw performance of the "perf"
>> output, but the "JSON" one needs to be fast(er).
>> But even that output will malloc()/free() for each line it emits,
>> and
>> often multiple times within one line (e.g. each time we format a
>> double).
>> So if we do want to optimize this in terms of memory use the lowest
>> hanging fruit seems to be to just have a per-thread "scratch" buffer
>> we'd write to, we could also observe that we're writing to a file and
>> just directly write to it in most cases (although we'd need to be
>> careful to write partial-and-still-invalid JSON lines in that case...).
>>=20

I left more extensive commentary in the side-thread in
https://lore.kernel.org/git/221011.86lepmo5dn.gmgdl@evledraar.gmail.com/,
just a quick reply here.

> WRT optimizing memory usage.  We're talking about ~25 byte buffer
> per thread.  Most commands execute in 1 thread -- if they read the
> index they may have ~10 threads (depending on the size of the index
> and if preload-index is enabled).  So, I don't think we really need
> to optimize this.  Threading is used extensively in fsmonitor-daemon,
> but it creates a fixed thread-pool at startup, so it may have ~12
> threads.  Again, not worth optimizing for the thread-name field.

Yes, I agree it's not worth optimizing.

The reason for commenting on this part is that it isn't clear to me why
your proposed patch then isn't doing the more obvious "it's not worth
optimizing" pattern, per Junio's [1] comment on the initial version.

The "flex array" method is seemingly taking pains to reduce the runtime
memory use of these by embedding this string in the space reserved for
the struct.

So it's just meant as a question for you & the proposed patch.

> Now, if you want to optimize over all trace2 events (a completely
> different topic), you could create a large scratch strbuf buffer in
> each thread context and use it so that we don't have to malloc/free
> during each trace message.  That might be worth while.

*nod*

> We must not do partial writes to the trace2 files as we're
> constructing fields.  The trace2 files are opened with O_APPEND
> so that we get the atomic lseek(2)+write(2) so that lines get
> written without overwrites when multiple threads and/or processes
> are tracing.
>
> Also, when writing to a named pipe, we get "message" semantics
> on write() boundaries, which makes post-processing easier.

*nod*

1. https://lore.kernel.org/git/xmqq8rwcjttq.fsf@gitster.g/
2. https://lore.kernel.org/git/RFC-patch-1.1-8563d017137-20221007T010829Z-a=
varab@gmail.com/
