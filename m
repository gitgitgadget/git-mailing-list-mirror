Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7191520966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934473AbdC3SCP (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:02:15 -0400
Received: from mout.web.de ([212.227.15.14]:62420 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934007AbdC3SCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:02:14 -0400
Received: from [192.168.178.36] ([79.237.59.215]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqSB-1d2lLW1gxv-009hBI; Thu, 30
 Mar 2017 20:01:53 +0200
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
 <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
 <20170328214930.bj4etqn5qecv45im@sigill.intra.peff.net>
 <CAP8UFD1wqW221qxWqMz1jHxDLKCg71a2VBh+wUdV8sMSEN2aZw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4a25d1f4-a744-9135-93af-7e675680b91e@web.de>
Date:   Thu, 30 Mar 2017 20:01:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1wqW221qxWqMz1jHxDLKCg71a2VBh+wUdV8sMSEN2aZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8R9q9UdGjY06Yc/3+BPv2pfK2FLlE3ZB9XPlOc+KUdiw74vLiwR
 c+UFUJurY3Bey+vlYKuRedSaSw0QD1MK4OxaQB20DYTTnYQ0NctGF8WAma7e42CRHZwyHbn
 aTsnXo5i1CsFnb8/1s/YQCB3I6sWHfGONac9efGd80Q22blN6b24oVEWEmu46LoVWHSu2iX
 sO6M29u0UP0p2jJ1j2vLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eZy/UJ7lrrc=:rCBtcK2w5EroCWk63V/8Xw
 XuR0BpTx9lr0xHSg7mnafYT78sRJ4t1nd/fWV7Z8BubbThM6n3ofUmmz0RW0oL7FJiCCgr6EV
 eZxxos3ZOXDaZx6sGaCyJujLtqB1Zf60kQNKqDCxe7omYH71sLTBs0uiNpHSLnpf/imqfoE/d
 iQ1O5LZ9qqeR4rR6Xt73xQo+Sy8ndsewPVyFR5FZ60v2rPNe2/GapZQZw5swGwKgEv1H0f2em
 Buy+4krgi3cM9cDFG50P31Siae7rWXR1MZs035EjAbzzzn6J8r7hUlhbS/9O4n6PIzwd02k4W
 L60AHJMEJcGT+fOK3vTQyuHgl4qkmplMS11gwdSbM1h2dEHz1ro+b45qoAEgg/d1xnz8NRUUc
 A48/wr05cUMtmPJPqyWFP/lR4F39aNc7UoxAYQeAd6Io9xJrThha+pn9Lk/ws8OiFKUr+AsLA
 YXSHxWcep3Hp3btl5aOO6/NfjxaLk68yIB2qDD+zQk5mPko144WLm1KCeyGidUFJVs0yNBnUv
 APui58QXge0u9CmRrcm+MLr83eEv0F9ZeC7b6ajpuhDndZsBN7c35C4YN1r7ZZX3oN45PhtYC
 37ke6QmJpDMX9YKWsKPcQdUUI8O6B+ev+9/g2By23XTe2oRzO+kdQlMaLe3WtXfjAMdpzQ+Li
 NUs3AAjzbquCdUiSUKmoEBBmUY+T6u7YssZzAaijt7/YM5KUoNWxpKltEpgAXc2HYguKxw9NJ
 H9Ej6tSU2SfwSuJgAjEwrMoteX+D1vLAMcR68gzIyPAEsOHk8IVfn4Ii55+jjwmOD8I+kRFOP
 KTTOS9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.03.2017 um 06:54 schrieb Christian Couder:
> On Tue, Mar 28, 2017 at 11:49 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 28, 2017 at 11:15:12PM +0200, Christian Couder wrote:
>>
>>> On Sun, Mar 26, 2017 at 3:43 PM, René Scharfe <l.s.r@web.de> wrote:
>>>> FreeBSD implements getcwd(3) as a syscall, but falls back to a version
>>>> based on readdir(3) if it fails for some reason.  The latter requires
>>>> permissions to read and execute path components, while the former does
>>>> not.  That means that if our buffer is too small and we're missing
>>>> rights we could get EACCES, but we may succeed with a bigger buffer.
>>>>
>>>> Keep retrying if getcwd(3) indicates lack of permissions until our
>>>> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
>>>> syscall on FreeBSD anyway.  This way we do what we can to be able to
>>>> benefit from the syscall, but we also won't loop forever if there is a
>>>> real permission issue.
>>>
>>> Sorry to be late and maybe I missed something obvious, but the above
>>> and the patch seem complex to me compared with something like:
>>>
>>> diff --git a/strbuf.c b/strbuf.c
>>> index ace58e7367..25eadcbedc 100644
>>> --- a/strbuf.c
>>> +++ b/strbuf.c
>>> @@ -441,7 +441,7 @@ int strbuf_readlink(struct strbuf *sb, const char
>>> *path, size_t hint)
>>>  int strbuf_getcwd(struct strbuf *sb)
>>>  {
>>>         size_t oldalloc = sb->alloc;
>>> -       size_t guessed_len = 128;
>>> +       size_t guessed_len = PATH_MAX > 128 ? PATH_MAX : 128;
>>>
>>>         for (;; guessed_len *= 2) {
>>>                 strbuf_grow(sb, guessed_len);
>>
>> I think the main reason is just that we do not have to pay the price to
>> allocate PATH_MAX-sized buffers when they are rarely used.
>>
>> I doubt it matters all that much in practice, though.
>
> Yeah, I can understand that.

Right, using PATH_MAX as initial size (no ?: operator needed) is the 
easiest fix.  And yes, I wanted to avoid wasting memory just to fix an 
odd special case.

Given that the function isn't called very often the impact is probably 
not that high either way, but increasing memory usage by 3200% on Linux 
just didn't sit right with me -- even though 4KB isn't much in absolute 
terms, of course.

> But I also wonder if René's patch relies on PATH_MAX being a multiple
> of 128 on FreeBSD and what would happen for a path between 129 and
> PATH_MAX if PATH_MAX was something like 254.

We can use any value bigger than zero to initialize guessed_len. 
getcwd() won't have any problems fitting e.g. a path with a length of 
130 bytes into a buffer of 256 bytes in the second round of the loop.

René
