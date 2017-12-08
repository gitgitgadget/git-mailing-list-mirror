Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C68120C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdLHR3n (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:29:43 -0500
Received: from mout.web.de ([212.227.17.12]:52239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdLHR3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:29:41 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LopeB-1eyMJf2vz1-00gqF8; Fri, 08
 Dec 2017 18:29:36 +0100
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
Date:   Fri, 8 Dec 2017 18:29:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171208101455.GC1899@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KzXaFebwpklG2mQMv8BhZcmrZzNSLQD7R17f62ebjB0BQkcH6Nf
 oGKRMX4zNKYMcm21cpqutQM9TXveKzVI7QShYltuylAgWdICRxzO5pad3Imkr+YU/M7td1Y
 bz8jF9srW6d8wl8t/Gk/0epLV+TbqUaQ2puzpcM5wUcUXji+KXkD/DaVyq6ZKtW8gnD6U2t
 gk3qIxcRTCDs3WUEeIx2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ppjM9SaIdqw=:ZdfjeOlw9opkXNeU8gUnOb
 lI/mFlKTKqZWntq0fuoh7nQEyJDQomSS9aOppuMvowj+h7UwSAqzGaexidIDZ8W9MJHm6icOV
 q/Pv5ZDpBpsQ63w92uzdPREFra+fe1gWu1Mb4Cu+LVEBR32XmGjcRn6lYIsYJTG68IbUvuLEK
 LWWlwpHi1KA+kfe8XahDYxmMEVQp8k1ygEtV+PGNN/owPNo1HE39jfJT6Z8o+umpCM5FYWaPZ
 X8EMSUTHfMAJ1jTLVomQsGEwJHsy6joJJd9+wLEdKH393olWIbqqTolNxLFgPxlps0Dacsg6a
 /40JLwKgjSk4r4ZcQU3qbv6DqJ5guxmZ4evIJLGXGX4HUS/4Uqv3/0ZdC+Qk8conRcVRwXwsD
 9o74Mz3K8PjlmpKsZBK/A4HyUh0qEfOjsh3SIm1D4Xs0VFfepUGUZWXBDVMu+Ki95x9W3FxZ7
 dS1KPWFNSpkNmAc7/4xNmdi+LRzoLGc1Cbc05HSAUDsFDG6lfCawojiX57kQxsoAJH0xsDPVD
 HXCOlgkJvK8HXAZNSPp7+Enh7SwqdaKZRCaCx5FEO3m9iR7BbHnm9uhjcZdZvbNgjrUMXbkeP
 R1CmurQJ5GqWzvOM6J17uhmc0WTaZ1+y0s6taZDm8FnAca6Mzqx6uRID4Jr74a2gbt6lB56Wy
 X+hUJuDqzcy2L5Ksgfh3r9jziHl3YyxLV+E5515Nao1ekN4cbKa7BxKb1yIjMdXau96iMC3nR
 IlrkNGBlUdcBGYNaMxZ70P1+1lt7806b80ly2076qM9rLdyRKiyW5nj1JKQ25Yq+n2XWBKYZH
 3NsMdxJzlEnW6059Umv7484xvxmAZuaCjiQJMFuIB+p7C79lok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.12.2017 um 11:14 schrieb Jeff King:
> On Thu, Dec 07, 2017 at 01:47:14PM -0800, Junio C Hamano wrote:
> 
>>> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
>>> index 22034f87e7..8e8a15ea4a 100644
>>> --- a/builtin/fmt-merge-msg.c
>>> +++ b/builtin/fmt-merge-msg.c
>>> @@ -377,7 +377,8 @@ static void shortlog(const char *name,
>>>   			string_list_append(&subjects,
>>>   					   oid_to_hex(&commit->object.oid));
>>>   		else
>>> -			string_list_append(&subjects, strbuf_detach(&sb, NULL));
>>> +			string_list_append_nodup(&subjects,
>>> +						 strbuf_detach(&sb, NULL));
>>>   	}
>>>   
>>>   	if (opts->credit_people)
>>
>> What is leaked comes from strbuf, so the title is not a lie, but I
>> tend to think that this leak is caused by a somewhat strange
>> string_list API.  The subjects string-list is initialized as a "dup"
>> kind, but a caller that wants to avoid leaking can (and should) use
>> _nodup() call to add a string without duping.  It all feels a bit
>> too convoluted.
> 
> I'm not sure it's string-list's fault. Many callers (including this one)
> have _some_ entries whose strings must be duplicated and others which do
> not.
> 
> So either:
> 
>    1. The list gets marked as "nodup", and we add an extra xstrdup() to the
>       oid_to_hex call above. And also need to remember to free() the
>       strings later, since the list does not own them.
> 
> or
> 
>    2. We mark it as "dup" and incur an extra allocation and copy, like:
> 
>         string_list_append(&subjects, sb.buf);
>         strbuf_release(&buf);

The two modes (dup/nodup) make string_list code tricky.  Not sure
how far we'd get with something simpler (e.g. an array of char pointers),
but having the caller do all string allocations would make the code
easier to analyze.

> So I'd really blame the caller, which doesn't want to do (2) out of a
> sense of optimization. It could also perhaps write it as:
> 
>    while (commit = get_revision(rev)) {
> 	strbuf_reset(&sb);
> 	... maybe put some stuff in sb ...
> 	if (!sb.len)
> 		string_list_append(&subjects, oid_to_hex(obj));
> 	else
> 		string_list_append(&subjects, sb.buf);
>    }
>    strbuf_release(&sb);
> 
> which at least avoids the extra allocations.

Right, we'd just have extra string copies in that case.

> By the way, I think there's another quite subtle leak in this function.
> We do this:
> 
>    format_commit_message(commit, "%s", &sb, &ctx);
>    strbuf_ltrim(&sb);
> 
> and then only use "sb" if sb.len is non-zero. But we may have actually
> allocated to create our zero-length string (e.g., if we had a strbuf
> full of spaces and trimmed them all off). Since we reuse "sb" over and
> over as we loop, this will actually only leak once for the whole loop,
> not once per iteration. So it's probably not a big deal, but writing it
> with the explicit reset/release pattern fixes that (and is more
> idiomatic for our code base, I think).

It's subtle, but I think it's not leaking, at least not in your example
case (and I can't think of another way).  IIUC format_subject(), which
handles the "%s" part, doesn't touch sb if the subject is made up only
of whitespace.

René
