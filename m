Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238C720401
	for <e@80x24.org>; Thu, 15 Jun 2017 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdFOM2w (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 08:28:52 -0400
Received: from mout.web.de ([212.227.15.14]:65263 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbdFOM2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 08:28:52 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejjU-1dAO3N24oy-00OEIW; Thu, 15
 Jun 2017 14:28:25 +0200
Subject: Re: [PATCH v2] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <d578d104-79c6-6c07-db4d-3e4ccb0c0dd9@web.de>
 <22850.28477.715057.441985@a1i15.kph.uni-mainz.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <02cf275a-8eaa-49b9-7c2a-f98424088e1e@web.de>
Date:   Thu, 15 Jun 2017 14:28:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <22850.28477.715057.441985@a1i15.kph.uni-mainz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YLzfto3TtlTjpH8KsEQ6PBxcggShPwQW7qKkm+rPDWzXUyyWsER
 cNsxXgpb2JqomRXmhp6xmU058D06cnOcGDadXqPNoqSFVVxb5/w61Sa2vLxkHbc02fpKQL1
 PRY03ztoD0Ix2SWtuQioB7RymCIKuHIKb4Y8GrWPd+tRrMOGyCAmMmHrYMCvA2wI0AGEb2Y
 FQFNTQJhwk2QWyYKJTETQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P2K61PfYXiE=:l88iE3FhRr2cO76iDVduW/
 fEvLcuekP+gFtcsjgf2DF+ZmfSlQvW8Il1G+70Ct+4mM3sx12KFXp8mm/nUYV9rXoyLgaD/4P
 xjyDqH0TL1xvFcMZ5G8DJN5retVYKb0XMRM36PzLi4I6CBQ4IttxyhWsb8MBvR1nV/LIPNQmp
 uGEvNMDIN+EItpkdFikGLtbmVU53V8jgwCp36pSEZ+7kBDtjTHZNm2PHDPEEWFNJULuWbOstF
 crk5ra5MtGk+iqTmQlIoTpVSAy/ChObU7IOXTc64spnizmNK/bs08k/yI/UKUAUtLf4VqvK5n
 CnJuPzwUJtA4W4nhEyF4Qt7bRSeIvsyX4Quo5rH/s1qN/8tVJYUDXsKVI0OJmWGMAPVvCs2MV
 LtgKE3XYl4BHDoYT0jWhMYTyvGefGbZ9NSQAGdarr/hizsoj/H0OwwnZfyfv/CNKJK1bbEXrC
 4DnZFPtnpnaTBXLR+Miem4az2pJ7Q4lDTw/VgRYRX0+abfwmwdppxZWJG75sQkhfIUHIbuDFa
 NsJ8FIIvDzb/d2zpAfgkKssmVJDtc566pU48av2FDbVEfePbwzHjwaXP5GOnN8Qib1jJgIyCC
 FarWqLbuzvbZKvcCH06936/hiafk+GqKG1iGbZJBbnpUHVrtRlG0ONZX6A1JKVLglJOtw0JjV
 BeVC5sgRyfK2zjfcpbJCHFNuDhnbww2y3Z25suAf53aN8SMFU4Q6/mNaKjph6/WetyKiwqhKE
 uwGWWv6oBxM4+ODaTM8Wwh7i9Q3/0ED1opTIk1tQOlOIXStQ6Q4fBr/TCWm9pJftO9Kr6sn9Y
 63pEJtO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 13:27 schrieb Ulrich Mueller:
>>>>>> On Thu, 15 Jun 2017, René Scharfe wrote:
> 
>> Callers can opt out for %Z by passing NULL as timezone name.  %z is
>> always handled internally -- this helps on Windows, where strftime would
>> expand it to a timezone name (same as %Z), in violation of POSIX.
>> Modifiers are not handled, e.g. %Ez is still passed to strftime.
> 
> POSIX would also allow other things, like a field width:
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/strftime.html
> 
> $ date '+%8z'
> +0000200
> 
> (But I believe that's not very useful, and supporting it might require
> duplicating much of strftime's code.)

Windows doesn't support that (unsurprisingly), but it accepts %#z,
which does the same as %z.  Let's wait for someone to request support
for modifiers and just document the behavior for now.

>> Changes from v1:
>> - Always handle %z internally.
> 
> Minor nitpick: Shouldn't the comment in strbuf.h be updated to reflect
> that change?
> 
>> + * Add the time specified by `tm`, as formatted by `strftime`.  `tz_offset`
>> + * and `tz_name` are used to expand %z and %Z internally, unless `tz_name`
>> + * is NULL.  `tz_offset` is in decimal hhmm format, e.g. -600 means six
>> + * hours west of Greenwich.

Yes, it should.  Thanks for paying attention! :)

René
