Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35301F855
	for <e@80x24.org>; Wed,  3 Aug 2016 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbcHCGtC (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 02:49:02 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35431 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbcHCGs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 02:48:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so435025348wmi.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 23:48:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NCDoAh5pPjsEGg/2OUYmlpjyVE8J5FQZRmKoBIiCwBI=;
        b=MkCizvdiKr09p7eAqCJrbwXd/SyKt3nHoZ5K03AxFfLQdULD+XFXcqKAC+TIdP1j2/
         lFI6vKltKPHgd3JPpJMmvkxW1zwL3u3Q/YwMGLDp1PUWIK8PY+yfc+IP731IDNuZBd8O
         vMNNiaWPjNMk8Ngves3VrOy9AwCUXCII/CsaLn1nVugA4bgwIeuK1m4qd3qfF8PAEVcS
         QpFhy3ou4TOAPV+CTfpI1kCCaWHk680cve6SATlD1bfDekjhdvwueNapZhJJidlJplKB
         h8CTB6DeoFiL2Ko7LuAH3aV366JK7t/RLJpIaiahSAAvXRe9le45PLL6Na59pfe68Ltk
         bmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NCDoAh5pPjsEGg/2OUYmlpjyVE8J5FQZRmKoBIiCwBI=;
        b=fOHx60ehhbWsAccG524FulKmRXarKzYw2CiGWZtbg2+XGlO3fjZyVwGVq7NyKgeaiQ
         S06Yoz08ZFRFY96yoLYOZb7yaIAhpD+og6OK05pdygPpczkCycYR4YVc2N2jZrXqfU7U
         OFxXnhFlIWKdrwVcf9HNQo2qPC1DNFx400MsMeg8IP+sXr5Tshw6SYbysP4PyT1iwB9G
         wFrUCb6Z3hU9RNa0agfwCCo5S3oUxvdRnItgi9uLYQqZU1TjbR9RZRIFYf/7e5q7oysv
         JYpJXA6hN+dHFpEhQk/DPXS1JJy10FCaCvat1EbDMa1u+8u2EKDtSsht+MRVaI4BAopv
         prmw==
X-Gm-Message-State: AEkoouuDs0t1Wt4WYsvOU/SpeC+/ub4lrFh5B32ioGg3rqzVb99t/vv6mFAekBHmPk8kH+wvZa/Ma0OL+HJbmQ==
X-Received: by 10.194.164.9 with SMTP id ym9mr57553885wjb.78.1470206513675;
 Tue, 02 Aug 2016 23:41:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 2 Aug 2016 23:41:52 -0700 (PDT)
In-Reply-To: <CAGZ79kYzxCq6M49Zmf_4J7xTdXHMunvgPuFaLnV7fXtuTbEogQ@mail.gmail.com>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
 <20160730172509.22939-34-chriscool@tuxfamily.org> <CAGZ79kYzxCq6M49Zmf_4J7xTdXHMunvgPuFaLnV7fXtuTbEogQ@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 3 Aug 2016 08:41:52 +0200
Message-ID: <CAP8UFD1d0P_mZQcHOpq7Kki5jngKwBdyZ0n_dWzkmWzOOOxhRA@mail.gmail.com>
Subject: Re: [PATCH v9 33/41] environment: add set_index_file()
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 7:24 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Jul 30, 2016 at 10:25 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>
> I have reviewed briefly all 41 patches and generally they look good to me.
> There were some nits, which should not stop us from proceeding, though.
> This one however is not one of the nits.

Ok, thanks for your review. I will take another look at improving the
comments related to this patch.

>> And yeah this is a short cut and this new function should not be used
>> by other code.
>
>> + * Yeah, the libification of 'apply' took a short-circuit by adding this
>> + * technical debt; please do not call this function in new codepaths.
>> + */
>
> How much effort would it take to not introduce this technical debt?
> Do you consider getting rid of it anytime in the future?

I don't know exactly how much effort it would take to reduce this
technical debt. I discussed that with Duy already:

https://public-inbox.org/git/CAP8UFD1SSjSGV%2B1e%2BzP4s%3Dp%2BohgSz6mct3EhPXqbde_y48ST7g%40mail.gmail.com/

and both Duy and Junio thought that it is ok to add this small
technical debt now.

My opinion is that most of this technical debt already exists as the
apply code and a lot of other "libified" code already call functions
like read_cache(), discard_cache() and cache_name_pos() instead of
functions like read_index_from(), discard_index() and
index_name_pos().

And it is not as simple as just changing these functions in apply.c,
as these functions can be called by other "libified" code that can
indirectly be called by apply code.

For example cache_name_pos() is used in dir.c and diff.c, and then
dir.h and diff.h are included in many other "libified" *.c files
(including "apply.c"). So it is very difficult to make sure that apply
code doesn't indirectly call any of the problematic functions.

And even if it was possible to make sure that now apply.c doesn't
indirectly call any of these functions, how could we make sure that
later a refactoring in other "libified" code will not change a
function that is indirectly called by apply.c to make it call another
function that indirectly calls a problematic function?

That's why I think it's a different project to remove calls to
problematic functions (like read_cache(), discard_cache(),
cache_name_pos() and so on) in all the libified code.

> Can you clarify in the commit message why you introduce this technical
> debt and justify why the reviewers should be fine with it?

Ok, I will add some of the above in the commit message.

> ("It is better than before, because ..." instead of "Yeah I know it's bad".
> Tell us why it is bad, and why it is not as bad as we thought?)
>
> In cache.h we have a NO_THE_INDEX_COMPATIBILITY_MACROS,
> and lots of
>   #define foo_bar(..) frob_bar(&the_index, (..))
>
> Could you operate on the raw functions that take pointers to &the_index
> and point these to a temporary index?

As explained above this is not enough.
If I did only that, it could even give a false sense of security.

>> +/*
>> + * Temporarily change the index file.
>> + * Please save the current index file using get_index_file() before changing
>> + * the index file. And when finished, reset it to the saved value.
>
> Should this warning go inside cache.h?

Ok, I will add one there too.

> Or should we make that implicit by providing a stack for the user
>
>     extern void push_new_index_file(const char *index);
>     extern int pop_index_file_redirection();
>
> ?

I don't think this is necessary. It could even encourage using these functions.

Thanks,
Christian.
