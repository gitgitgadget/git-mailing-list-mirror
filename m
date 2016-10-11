Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85951F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbcJKS4N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:56:13 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36053 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbcJKS4G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:56:06 -0400
Received: by mail-qk0-f172.google.com with SMTP id o68so49723462qkf.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cgYJ8fw5bX50HLwwKmeInd/f5yGffpbTDgn2Jgpt/kY=;
        b=SxQB5lbIlm5iebWjduW46ZXimniBcFjCbd5vxjNf+Y/8HQy7uqtOCmaq9aP6TqzMJf
         gbqiGAy9wbSMcAFelScK6XL0WXsNhVQgba9zdz9Bcm6NC4BAq/eSVfoshjJB8xCLNpEj
         PqHHpHKg/NTrTu+3BcIc4RNMT989usOHyIyfM+O1q6MAzpb21S2H8WeDdUUjWYGGNZsZ
         lka8lAhKmEmSjSVze2qOFPGWE2OcH3/wof/jAdNuMnl5GMWK2LJMybII6eI85sSz9Tsf
         /aZli38cZhWU+Rz6bBAW3qQ5eQyAYhRbh6xBCOjSim+y9NLU7WfyMRpPeFQ2jw/Lsatg
         9nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cgYJ8fw5bX50HLwwKmeInd/f5yGffpbTDgn2Jgpt/kY=;
        b=cPvTQd52IklONcX1lWU5IA2CQwYD56XJ5emTbRh8QUhDv4HYTV0aBmcZipWDo6BzfC
         CbyYOEslXdYScA4dtv6YGS1ktRV1/aveMhPDeg4JwRCVZ7GRanz9ve8X0Il9pLX5gchz
         qdrAEottqDEQtP775mFW6gxLulPG1sEF1YelCIEv5gqjmtitgC/Y5wjbmxP50M2CJG9X
         Ah3z5GJv+Go1P+VrxxE0NZ3iff5Lt2fEqq8pCkMqgOs5EVKfUzbeApTOwyarFlHhSxpb
         ClCvxjABa1OLAeVSKTSeBvAVx9I4kpC8uvfiQrHa1IoAKry4Ikzc2X+OOfkWduGH4mR2
         MIFg==
X-Gm-Message-State: AA6/9RnGXES47j7GBByn9SvIcZo+N5YJnGpp31L5LD3TqSY2rU0UlTAeIe5wWnnBdkzEi9WRJPVQlM0FGZ09kxOe
X-Received: by 10.55.56.11 with SMTP id f11mr4451690qka.255.1476212165100;
 Tue, 11 Oct 2016 11:56:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 11:56:04 -0700 (PDT)
In-Reply-To: <xmqqa8eaagoq.fsf@gitster.mtv.corp.google.com>
References: <20161011002115.23312-1-sbeller@google.com> <20161011002115.23312-29-sbeller@google.com>
 <xmqqmviaaina.fsf@gitster.mtv.corp.google.com> <CAGZ79kaQKDdJfMOjDKEK_dZJhgj+R7rByQS++B3OOBy6uO1x2w@mail.gmail.com>
 <xmqqa8eaagoq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 11:56:04 -0700
Message-ID: <CAGZ79kbdvs88Gt_XW801DPs7rj8kvcfPqCV7kjL_Jz9XiVn7fg@mail.gmail.com>
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 11:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I find this description a bit confusing.  At least the way I
>>> envisioned was that when this piece of code is run by multiple
>>> people at the same time,
>>>
>>>         static struct git_attr_check *check = NULL;
>>>         git_attr_check_initl(&check, ...);
>>>
>>> we won't waste the "check" by allocated by the first one by
>>> overwriting it with another one allocated by the second one.  So
>>> "the same arguments" does not come into the picture.  A single
>>> variable is either
>>>
>>>  * already allocated and initialised by the an earlier call to
>>>    initl() by somebody else, or
>>>
>>>  * originally NULL when you call initl(), and the implementation
>>>    makes sure that other people wait while you allocate, initialise
>>>    and assign it to the variable, or
>>>
>>>  * originally NULL when you call initl(), but the implementation
>>>    notices that somebody else is doing the second bullet point
>>>    above, and you wait until that somebody else finishes and then
>>>    you return without doing anything (because by that time, "check"
>>>    is filled by that other party doing the second bullet point
>>>    above).
>>>
>>> There is no need to check for "the same arguments".
>>>
>>
>> I see. So we assume that there are no different arguments at the same time,
>> i.e. all threads run the same code when it comes to attrs.
>
> Sorry, but I fail to see how you can jump to that conclusion.
> Puzzled.
>
> You can have many different callsites (think: hits "git grep" finds)
> that call git_attr_check_initl() and they all may be asking for
> different set of attributes.  As long as they are using different
> "check" instance to receive these sets of attributes, they are OK.

Right, but that requires a mutex per callsite; up to now I imagined
a global mutex only, which is how I came to the conclusion.

>
> It is insane to use the same "check" variable to receive sets of
> attributes for different attributes,

I agree.

> be it from the same call or
> different one, it is insane to do this:
>
>         func(char *anotherattr)
>         {
>                 static struct git_attr_check *check = NULL;
>                 git_attr_check_initl(&check, "one", anotherattr, ...);
>
>                 ... use "check" to ask question ...
>         }
>
> The whole point of having a static, initialize-once instance of
> "check" is so that initl() can do potentially heavy preparation just
> once and keep reusing it.  Allowing a later caller of func() to pass
> a value of anotherattr that is different from the one used in the
> first call that did cause initl() to allocate-initialise-assign to
> "check" is simply insane, even there is no threading issue.

I was imagining a file.c like that:

static struct git_attr_check *check = NULL;

void one_func()
{
    git_attr_check_initl(&check, "one", ...);
    ...
}

void two_func()
{
    git_attr_check_initl(&check, "two", ...);
    ...
}


int foo_cmd(const char *prefix int argc, char **argv)
{
    foreach_path(get_paths(...))
        one_func();
    check = NULL;
    foreach_path(get_paths(...))
        two_func();
}

This is correct single threaded code, but as soon as you want to
put phase one,two into threads, as they can be parallelized, this
goes horribly wrong.


>
> And in a threaded environment it is even worse; the first thread may
> call initl() to get one set of attributes in "check" and it may be
> about to ask the question, while the second call may call initl()
> and by your definition it will notice they have different sets of
> attributes and returns different "check"?  Either the earlier one is
> leaked, or it gets destroyed even though the first thread hasn't
> finished with "check" it got.
>
> It is perfectly OK to drop "static" from the above example code.
> Then it no longer is insane--it is perfectly normal code whose
> inefficiency cannot be avoided because it wants to do dynamic
> queries.

I think we had a misunderstanding here, as I was just assuming a
single mutex later on.
