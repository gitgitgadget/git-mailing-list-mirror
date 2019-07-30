Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F1A1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfG3Rzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 13:55:40 -0400
Received: from mout.web.de ([212.227.15.3]:35323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfG3Rzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 13:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564509318;
        bh=7hsP632mACvJm1hPxKxQlmV1BBM4IHngywDiIHnJ7zc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MHmM7cuhH9ebmgySH6nXbnS8/iZNYVoeLSa6SivP7x8RnBSbXDjxejZ2wQKoRZGjX
         959ntsKU7MilHrzY7HocQP+NmuLWOasHj9XMyljLnZ6Xl8d+1VYJOsIIZOzPtNuLH7
         bUWGEtp/o/u9ed0ju5Z2dzGJLscsG02n4YSM4k7Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDPYb-1i9Lrv1ky5-00Gpnn; Tue, 30
 Jul 2019 19:55:18 +0200
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
To:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        sandals@crustytoothpaste.net, dev+git@drbeat.li,
        Johannes.Schindelin@gmx.de
References: <20190728235427.41425-1-carenas@gmail.com>
 <20190729105955.44390-1-carenas@gmail.com>
 <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de>
 <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
 <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <22b9cf06-ebbb-a0c1-2cc9-7f09d61d3d9b@web.de>
Date:   Tue, 30 Jul 2019 19:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g5GBYv9ywI3ODWnRZTz+GQhu2y7cII2ARDZIDJjZ8xBbKzNh9pP
 pu3go6SXjxAxaMAII55iVyz7RFDLt5SCvKkJlHooIKdRMIiBUtazplovNYSXpu7Eo+sEFz4
 dRK+rijvDI1o/erDZaIl4jr9o7Xxw3BsYbOEHaarw+s7Jx5V5GbvgokrVf/TUc3Uj1dqqwt
 bB0FMOfMnNV6AylC2ildg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dy4IH3XhjT0=:JFB30cIvhy6tC6r/HhGmx5
 DZpH0Lvi32NKmLLi+FSaEcxnqFg8v7lFLu/bowNutgU2FYvIZEIr5WTwd9HacBP0P3Fcqa5uF
 5bxZQZMhAEmHaA0uWdw/OXSJUU37JuaZIavy5XJTN7nDuSIDU4K6jS9s9c6+dfZCHVhj2oTj3
 c6RzRlPYEpgWF8QAxKu+aZSLWjr5v0mmkNsXc4gZTkEgQAOowb1U9+JMovb2INi0UUVgAJJD7
 elKJTU1ZB8RVuPMI3QSKkO5IdvfKZbQ1qXdIDr68iK/tLTJnUK9cdWOy5xW9Q3iDoDs2sDr+s
 G4QI1JXVNfrSYXEJJ8+hVtkBMmrbtWxxwBjfhvrcRl90gUuN6MjWsi0jt0djLTtojNPF6RnuJ
 RTjWi9uzoJSxEkf3866A4zMHLTPwwdJa4/JujOYu/44iaI0Zh/tpsa31+1tLxOtJ/HlX8iQ/B
 NgPUrwfHQnarJL3luQGHVT7BBvylQCQKmZc+p6Zus9Os1S+pKzpaFGFAGCmcLvp5TiYwav8/P
 mwlvSP3yLhLN9j5lWWGwVjqEXsCHg761QeoCSXW8UhC+ec67ueCl4m6ZIp57ltf9M4Z1jk5iA
 I42lXjiaWbk/DkBI/cUIJR8ajzvyN/+PeDLoVHuHB8+YUNoH+CaZLU6ODOVsg/UmfqNmWyqzS
 inAD48GXSS5rngwMF5/EG389PXSbbZHncquQlewTbVC/ATPWEcubfwT6QufUlXSvdWsSkEIAJ
 xr5eSnCcjFdyv2s1w3dWPR5qYlreSzjD8vhPhTpsrW0Yt/w0GD2Oc+oP7PnLEWk5YNYI2P+S4
 5WK8Wl1/o40NgF28MOYKGsOFPCBL+HKAzgpGJd+fBgKN8EPvF9oJjDV2amb/bv0HamhwDGcHX
 GWLTESfA+IOurIqOPSB37QAuBVUzyjVgVbsTVQKYwnJAYuzXIWziGjzb5NtxwEsDnJN4us3ZK
 rLu7rCALLy5xQBj2NpzoQt3v8gKoaUyqe6l+erKBxRTsnXXiGKSbwXYpqgc02e0qwk/emVqRS
 z5/fMfQnI3NjShVUKy2DSzjsjEzec5uHFqLB3RGN9LqOr5ZdpSoPZuPlsg0xHKww9+B7YKJhh
 9RwjVu0cwoY4e4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.07.19 um 02:49 schrieb Carlo Arenas:
> On Mon, Jul 29, 2019 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>> +pcre.jit::
>>>> +    If set to false, disable JIT when using PCRE.  Defaults to
>>>> +    true.
>>>> +    if set to -1 will try first to use JIT and fallback to the
>>>> +    interpreter instead of returning an error.
>>>
>>> Why not implement only -1, without adding this config setting?
>>
>> ... nor command line option.  If we have an auto-fallback, I would
>> think that makes the most sense.  IIRC the first iteration with only
>> the configuration was really about working around the (non-working)
>> pcre-jit---if we can self-detect and skip a non-working case, that
>> would allow us to drop end-user facing knobs, which is ideal.
>
> because that was proposed earlier[1] and wasn't accepted ;)

So you add all those knobs for =C3=86var?

Users on OpenBSD would get an error whenever they used -P?  And they
are expected to discover an option for turning off said error?  That
could be handled automatically?

This sounds like bullying to me.  I simply wouldn't use -P anymore if
that happened to me.  If that error was returned without -P, I'd
contemplate switching to the Silver Searcher or a similar tool.

> the main pushback though I got was that doing the fallback would degrade
> performance and so it was suggested[2] that keeping the error should be
> possible somehow (with the implication it will add yet another macro)

The slowdown by the fallback should be minimal -- just the extra
wasted time to compile the pattern to machine code.  Compilation time is
probably (hopefully?) dwarfed by search time.

IIUC, =C3=86var's concern was more about being able to discover when JIT i=
s
not available for some reason.  Printing a warning with --debug or
=2D-verbose could help with that.

Personally I don't care about JIT at all and wouldn't want to see such a
warning and certainly prefer not to get any error message about it,
even more so since there is nothing I can do about it.  (Disabling
security features to get faster search sounds sounds like a no-go.)

> since living without grep -P was a reasonable tradeoff at that time got
> punted, but the need to find a solution for this become more urgent once
> it was announced[3] PCRE2 would be used also used outside -P

Right.

> Obviously I am biased, but I kind of like the knob as it allows the user
> more flexibility to tweak the internals of grep and because we had
> made those internals already visible (ex: not handling any library
> errors ourselves and just aborting with a pcre error), but without any
> flexibility to fix those problems themselves (unless they open the code
> and rebuild, in most cases)
>
> the comment from the user that reported[4] a regression with GNU grep
> because of JIT stack size and that I quote below is representative of ho=
w
> that layering violation affect users, and while git users are more likel=
y
> than grep users to do the code tweaking needed, they could use some
> help.

So JIT can cause other problems, and some of them we don't (or can't)
handle in our code?  Turning on an unstable feature without a way to
disable it sounds like a bad idea indeed.  Is it really that bad?  Can
we grow the stack on demand, for example, as GNU grep does now in
response to the bug you mentioned (http://bugs.gnu.org/19833)?  Are
there more such examples?

> making JIT optional at runtime is therefore the title of this patch and =
as
> I mentioned in some other thread it might be even useful to us for our
> own tests.

Testability is a valid concern, especially if the JIT code is
considered, well, unfinished.

Ren=C3=A9
