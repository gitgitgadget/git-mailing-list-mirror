Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D451F406
	for <e@80x24.org>; Tue, 19 Dec 2017 18:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdLSS0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 13:26:21 -0500
Received: from mout.web.de ([217.72.192.78]:54465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbdLSS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 13:26:20 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfYn9-1ecXoK0xA3-00P7kX; Tue, 19
 Dec 2017 19:26:07 +0100
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
 <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
 <20171208212832.GC7355@sigill.intra.peff.net>
 <f1584860-d0d6-db82-0a49-021924c3e2b7@web.de>
 <20171219113855.GA24558@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f79ae9a3-de47-c41e-fea6-6a0fedf4ef63@web.de>
Date:   Tue, 19 Dec 2017 19:26:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171219113855.GA24558@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jEBEAY1u8ZtC7cuRJBt77aL3rRi31qLoHfCdEg1UlSGwTUI6Urj
 bIsxCtpIPo2HV9xu3ivlwBloqtEFjjKZnGL4D0PLXrO0tjpV/2vPcWINtezw60P+s2adQog
 P7uPlFZ+XbfUutYKPFRkRWSrXXPY5hI9ffjgx1JwwY4uHXe0B2jvpfrZrkakCfOMWSfEHlM
 qXF4nvYJw8tQcxerGfScQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OH4IbX5uAXY=:yCDqOfgOpcLNG4bYmfVRse
 Z4K3sZXgYeHQRnfIAzkpgbjB3RsHneSGerGZOvg7SvyMiLBZAnJAaxS1gy4JgVEVFHdAaKVlw
 fLXqNroSb1tcKzv+I0U/pju18kRNs5lzfHSFOndE8mwhg9swLX5gWoxRKEpCY6ovaWwHJ1Zfy
 /3L0oKQssnF8763JtMuGfuGdn4T891JZB+mHGQnGbgSsLqVVoep4H/LCa3UDwuGbRlvGjadet
 ioG+CvrvQGIT4Mnyyuo252VrMtI0qk0mceFLnwmrSS6LjP4q1sW+1TY1jsReRvDwocyFWn49r
 baqgi/5WVUv2wM/tTAtUemj4uwzTfHpKuzpvFnKWRFwvRVHJdJQDk0Fy0X2/His6k+oihzSxf
 I7qZra46UmybnVbXDVYxVs2VQY2a3hyq2g0WZ/tjd4HLSBA+rJCmrehZxg8ULC6hqZ8vLtJ3Q
 mWvKB2Xu/HWdWfxir0rTqkg8UcC+hWSBQrbUclQ+w1fMBBGhDHbq6w0kXSiDM8LR90oZLff9Q
 KTQoNNLKnzJo3V6pS/KWQuGMxOHCKvy9bXNq50UhYNV3RpT33fZhfNUYbvzll9l7y7QDAmea5
 jdJJY40l36iuUX68RBJPmrf9DVx5327RgTCQQvfiRXH8/IMRwztUSfZ+5ZNLa4nZ0SQY51BpA
 35KYAHV2YqhvFFcmtiZon+gRRVBaT/XLvlpW6yHmqxatJV1RNvYts5pyzH2zWXPBohgidI+Hj
 DyEeqm4ZoTIpDjP3xJYduoQqChBVE1vE1BfkxXnJ2UtMI6tUgeAhLGOuPFDoKRsh3iAx82VFN
 7KZj1WFKIpwypNitasFnGtwQEEKHxlWz1SSVFx8dhxw2Mj1bUs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.12.2017 um 12:38 schrieb Jeff King:
> On Mon, Dec 18, 2017 at 08:18:17PM +0100, René Scharfe wrote:
> 
>>> I'd actually argue the other way: the simplest interface is one where
>>> the string list owns all of its pointers. That keeps the
>>> ownership/lifetime issues clear, and it's one less step for the caller
>>> to have to remember to do at the end (they do have to clear() the list,
>>> but they must do that anyway to free the array of items).
>>>
>>> It does mean that some callers may have to remember to free a temporary
>>> buffer right after adding its contents to the list. But that's a lesser
>>> evil, I think, since the memory ownership issues are all clearly
>>> resolved at the time of add.
>>>
>>> The big cost is just extra copies/allocations.
>>
>> An interface requiring callers to allocate can be used to implement a
>> wrapper that does all allocations for them -- the other way around is
>> harder.  It can be used to avoid object duplication, but duplicates
>> functions.  No idea if that's worth it.
> 
> Sure, but would anybody actually want to _use_ the non-wrapped version?

Not sure, but cases that currently use STRING_LIST_INIT_NODUP probably
apply.  Apropos: apply.c::write_out_results() looks like it might, too.

Another question is how much it would cost to let them duplicate strings
as well in order to simplify the code.

> That's the same duality we have now with string_list.

Hmm, I thought we *were* discussing string_list?

>>> Having a "format into a string" wrapper doesn't cover _every_ string you
>>> might want to add to a list, but my experience with argv_array_pushf
>>> leads me to believe that it covers quite a lot of cases.
>>
>> It would fit in with the rest of the API -- we have string_list_append()
>> as a wrapper for string_list_append_nodup()+xstrdup() already.  We also
>> have similar functions for strbuf and argv_array.  I find it a bit sad
>> to reimplement xstrfmt() yet again instead of using it directly, though.
> 
> I dunno, I think could provide some safety and some clarity. IOW, why
> _don't_ we like:
> 
>    string_list_append_nodup(list, xstrfmt(fmt, ...));
> 
> ? I think because:
> 
>    1. It's a bit long and ugly.
> 
>    2. It requires a magic "nodup", because we're violating the memory
>       ownership boundary.
> 
>    3. It doesn't provide any safety for the case where strdup_strings is
>       not set, making it easy to leak accidentally.

Right, and at least 2 and 3 would be solved by having distinct types for
the plain and the duplicating variants.  The plain one would always
"nodup" and would have no flags that need to be checked.

> Doing:
> 
>    string_list_appendf(list, fmt, ...);
> 
> pushes the memory ownership semantics "under the hood" of the
> string_list API. And as opposed to being a simple wrapper, it could
> assert that strdup_strings is set (we already do some similar assertions
> in the split functions).

Yes, that check would guard against leaks.

Having few functions that can be combined looks like a cleaner interface
to me than having additional shortcuts for specific combinations -- less
duplication, smaller surface.

That said I'm not against adding string_list_appendf(); we already have
similar functions for other types.

René
