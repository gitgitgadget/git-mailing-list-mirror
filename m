Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0278E2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcGASkq (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:40:46 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33641 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbcGASko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:40:44 -0400
Received: by mail-io0-f170.google.com with SMTP id t74so107637745ioi.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 11:40:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5F6ymkVdVz9CpiluBw/jXyboQfTaWsVkk6aLX1J73Z4=;
        b=niExP2F4XiYgQZBTp/5JLP/g3DDdrQqb2hzN23OYGG6rAXl6qSCG+PUVmjq2FmtyXA
         c1LvKplQyaPl8U/wPnBRKaMgXHgv45DNW5n+XEMDMk24k1L6dYNI2N58CX7Ss/NrkuJS
         lLGcdiaof1mouvfxUVGAjkb5ZCxodST6hfGK+72Qog/ilQTySP8RTrRxCyPUyhDfDyzT
         ZeAJorXi4VJ43eyLMDYBCTG4EZTzXsa2T9B/hTQI85I6/y7A8njrpdnS3kNzdn5Zd4Lz
         kjo9o3e9Y36jNZX9DHE1YYU6vg+b16nHokftWSgF42xblEDBwUam9NGlUAxiMb5Fo7aG
         4p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5F6ymkVdVz9CpiluBw/jXyboQfTaWsVkk6aLX1J73Z4=;
        b=fzp8aApWmZPs9exD0E39mAFAfohVzPTo3ivD4eZwUIGZ1L2lyJ9T4xgWW1Y7rw7qf7
         RvSY64omPmc854bRMxrdtdGNmuReRnnDj/r6j+hL4hVv0j0DPc5mZTAtfCR7Llw83xBi
         a7oh0WdA5CSRrIyvQfubyaoSwdX047LTNoKB5JIyQF7PoZ+vk4pClKZmktpexNb0/EC9
         0gjQrqI80Dety9edTulIb+gtE2sGef6aR30TDhc7s4vpWy3TLB38L7KXhiJnd1GWFwpH
         HGHegrz+A2Bm92CpWjsgil2OJuBty1SydKAK8v7aCMzC2csFP9uddJWkQe+kosUaUjwu
         fBbw==
X-Gm-Message-State: ALyK8tIHuRf3c/kNFC4huaFElbbmxiY4OV2ARVtY7UEt7jFaFLCIC7d0vOArVmHUaRaia0TexssM3D3tFVbFNZ/P
X-Received: by 10.107.178.4 with SMTP id b4mr21371740iof.83.1467398403277;
 Fri, 01 Jul 2016 11:40:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 11:40:02 -0700 (PDT)
In-Reply-To: <20160701175950.GB16235@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net> <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
 <20160701175950.GB16235@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 11:40:02 -0700
Message-ID: <CAGZ79kZqB7bs1pyo4sn-_L1sbVRu4hiyFoduYDyZQ62hi9bbCg@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 10:59 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 01, 2016 at 10:20:32AM -0700, Stefan Beller wrote:
>
>> >> The rationale for keeping the actual options inside a file instead of
>> >> putting them directly into an environment variable has multiple reasons:
>> >
>> > Thanks for including this rationale; my first thought on seeing the
>> > patch was "wouldn't this be much more convenient for a hook if each
>> > value had its own environment variable?".
>>
>> That's what I thought as well. Office discussion ensued and I am still
>> offended by this solution, but it sucks less than multiple environment variables
>> (I tried writing a script to construct and evaluate the environment
>> variables and
>> that doesn't look nice)
>
> If you give up on having multiple incarnations of each variable, then I
> think:
>
>   GIT_PUSH_VAR_foo=value_for_foo
>   GIT_PUSH_VAR_bar=value_for_bar
>
> is quite elegant, and easy to use from hooks. It just cannot represent
> multiple such "foo" variables.

I see! Then you can have a single check for one feature

    if $GIT_PUSH_VAR_foo = "value_for_foo" ; then
        foo "bar"
    elif $GIT_PUSH_VAR_foo != "" ; then
        free_form_foo $GIT_PUSH_VAR_foo
    fi

and no worries about parsing.

Mind that we now put a user provided thing into the variable again.
Which we may be fine with.

The question I still have is how much of enforcement we want to do?
Does the client reject a push option if it doesn't contain a '=', such that
the server doesn't try setting a weird "GIT_PUSH_VAR_bar_baz".

Mind that a different server may not handle these in environment variables,
but read it off the wire and handle it in memory.

>
>> If we did not have a GIT_PUSH_OPTIONS_COUNT and GIT_PUSH_OPTION_<N>
>> but rather GIT_PUSH_OPTIONS_VARIABLES that contains the other variables,
>> it may be easier to handle, but whether you read from a file or evaluate the
>> environment variable is only a minor step, the indirection is there anyway
>> and this would be very close to what we have above.
>
> It makes the server implementation a bit uglier. You have to create the
> temporary file, and you have to clean it up. What process is responsible
> for cleaning up stale files? Obviously receive-pack would try to clean
> up after itself, but what happens when it is "kill -9"'d, or the system
> goes down, etc? We clean up stale tmp files like tmp_obj_* in git-gc; I
> think we'd want something like that here.

Yeah that is one of the weaknesses with the file based solution.

>
> -Peff

> Jeff writes:
>> Junio writes:
>> It still is not clear to me why the option to pass _COUNT and _VAR_<N> is
>> rejected.
> The "count" method gives you the flexibility to parse multiple keys as
> lists, last-one-wins, or whatever scheme you want. But it also gives you
> the _responsibility_ to do the parsing yourself, which is a pain when
> you want to do the simple thing.

We could ship Git with a default parser in the example hook that takes care of
the responsibility in an opinionated way (like Git does with "multiple
options are
allowed", and "last option wins").

If we do that, then the _COUNT method may be favorable?
