Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD171F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbdFLQ6w (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 12:58:52 -0400
Received: from mout.web.de ([212.227.15.4]:57826 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753838AbdFLQ6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 12:58:50 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm9T7-1dtnYE47Qv-00ZkL3; Mon, 12
 Jun 2017 18:58:16 +0200
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d7e3abd9-0fac-8336-de34-dbd9aad39bd9@web.de>
Date:   Mon, 12 Jun 2017 18:58:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:O+JKyUClq+kiwXfgcbJ8INwJM98lDVZPt9YgOQBHZpJVFqftlU6
 Wi9K4VgLTdmMVeSjEarlycXUSd+6SanIhgDYC+JKrMP07O0f837Hh+ORiPZdDQIsydSurRi
 xY2K3FPkjV0/aLyzfR0HemDmEwVM37vC/V8aNH8MK78LW9eURKGiKDsWeD1/gK7bGMxRQ2u
 04Zqzt/KawYmB6u/lFd3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P5Rqh4ex5nM=:iUn2gh6jAvpC4SGqKXJ1WF
 Tyv1L6NIdQF2Nt0qVChUY82l2SRvC8eGNeFZcyyHklnK2242EGF9Oeqptc+7xm9nBdzvC8rHq
 gv0DMKcX3Lv1CFp6JwRP6kRg4exUl//crMH+Rq7bi6OdmOtVrYD2mCw9N6QKbC19xUPsYNwaa
 IFxoLnujflzpdOwrEkpnumYL7XVB5+/8/9h0n+LP2nRISJDZgdNzZW6c7MRrIKkek3yhQClMC
 tumLcutZrSWXTK0gZmwC/CFKQl/i9BDW9Daz6HbTMVT9ayXol/6MQZq8ANKy2Qxh89wVKsO4g
 lDW7O3rOu9NBdSPqXfk8wrSdNRpbqnUOfFWp0qWwTen+r9hFQSUk1IzmPCBdliKkSCq3y1kOP
 lHE4LuYXwHS1FgyY6jJoOUBACSh+YBvcKzUb+ku0qkyt4Nahe7I4VLNCyA7Y9vgHx0H6fjExx
 wbyQ+kQ9ugfb35x66OELQK5o05cJBcf7eHGOuKy5mO/AmRJ6+I5Rkr/uNyRyvnUVt1UGXHdlZ
 XHJgcQoYoTKHd6t3dvTYAvsOyeIppOJWRSY+lposLEm5pJ4Qm3r0yIJP3B6nN2QsOuxOl3O7M
 JiWdzWDCn8XnqZL56yZpN9EG1XD4Q3N0bzH1PeoKNnfp/yO10oeRO+WnIP3kzUJcKfJzdiFR4
 2qjT3u0EUOqJFLIlIymB+s6E6inrQsY8fswwuHWIbE/JzNV5D2r6XbuPZ7CIJj0jzfxz+BRfm
 wxMcovzj3LfFCPn5agSqL6DOagUnSgwYuiMaZFTTfr5Cr6uXOLh7okYf3w9/ysDRbtp9LpNG7
 tb4Xnyo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.2017 um 18:16 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, Jun 12, 2017 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Am 07.06.2017 um 10:17 schrieb Jeff King:
>>>> On Sat, Jun 03, 2017 at 12:40:34PM +0200, René Scharfe wrote:
>>>>> Duplicates strbuf_expand to a certain extent, but not too badly, I
>>>>> think.  Leaves the door open for letting strftime handle the local
>>>>> case.
>>>>
>>>> I guess you'd plan to do that like this in the caller:
>>>>
>>>>     if (date->local)
>>>>       tz_name = NULL;
>>>>     else
>>>>       tz_name = "";
>>>>
>>>> and then your strftime() doesn't do any %z expansion when tz_name is
>>>> NULL.
>>>
>>> Yes, or you could look up a time zone name somewhere else -- except we
>>> don't have a way to do that, at least for now.
>>
>> Is that only "for now"?  I have a feeling that it is fundamentally
>> impossible with the data we record.  When GMTOFF 9:00 is the only
>> thing we have for a timestamp, can we tell if we should label it as
>> JST (aka Asia/Tokyo) or KST (aka Asia/Seoul)?

We could track the time zone on commit, e.g. in a new header.  I doubt
that the need for showing time zone names will be strong enough to go to
that length, though.

> It's obviously not perfect for all the reasons mentioned in this
> thread, but we already have a timezone->offset mapping in the
> timezone_names variable in date.c, a good enough solution might be to
> simply reverse that lookup when formatting %Z
> 
> Of course we can never know if you were in Tokyo or Seul from the info
> in the commit object, but we don't need to, it's enough that we just
> emit JST for +0900 and anyone reading the output has at least some
> idea what +0900 maps to.

I suspect that there will be different opinions, for cultural and
political reasons.

> We could also simply replace "%Z" with the empty string, as the the
> POSIX strftime() documentation allows for:
> http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
> ("Replaced by the timezone name or abbreviation, or by no bytes if no
> timezone information exists.").

Yes, that's what the patch does.

René
