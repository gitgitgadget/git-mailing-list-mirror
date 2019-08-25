Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BD21F461
	for <e@80x24.org>; Sun, 25 Aug 2019 14:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfHYOWO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 10:22:14 -0400
Received: from mout.web.de ([212.227.15.4]:48943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfHYOWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 10:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566742916;
        bh=6MWISbjstbt0Zwt4ym0myWGyXu4FQFYC/jCsV/TPp/I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nj7S144HdhT0agoRGACPeKbatzN/KmRqLNoPQ8UVow3TQMcirRlo0tWSxQ05apN+o
         omk8NRWwU2eflkHnV3GFyz0khtj4lS8aDKa7pFpxCr7aQdjDYz7OzredVCG7qp8Zdl
         Y7raGqGuTd8Z+YyNgW4jnulhWDEhAKLW5K7thY1o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1hp1Ft0TzN-00MPNM; Sun, 25
 Aug 2019 16:21:56 +0200
Subject: Re: [PATCH 2/2] fast-import: duplicate into history rather than
 passing ownership
To:     Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20190825080640.GA31453@sigill.intra.peff.net>
 <20190825081055.GB31824@sigill.intra.peff.net>
 <20190825100213.fssjydohathfhhe5@glandium.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <248c5f9f-ba44-6dec-6f30-f7d193bc22bb@web.de>
Date:   Sun, 25 Aug 2019 16:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825100213.fssjydohathfhhe5@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4YeT/IBV3rIcmfLUyxgAXbvAii7nhx7znQfFbFavzmUBeL/oMtW
 z0FBKDYcl6Hj0Dw4Ph+yK6/diuV6eO5dUxftE1GiLd/+Ynu85iKhjLwYbJmw/4jlsZxiuAX
 HJhocufiFhgf59DWMh5OQLBS0BM+R3Iyfo5K6cRjXBaeUAGJfhwdQCAD9cIBH6Udj+CcDfT
 5AzGVxfU/IjzK7ATJ4j6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PvL9C8xAoIU=:Br9Tr02c0UfsmrgnruatfV
 h703NQdFK2Z9nOGdpWdmI/XJ4mWqJJPuexHb+J4cYYhVwaHQm8FiriHgpvH0kNEyx06jq9Sj3
 1uJMkVsxOta2oqVuMkZ9I8udNNRIum3c6fLfirmko1xLRVS/0j8Ju0V8pxnARevT9QXs8lo1G
 TZq2gWqejD3/sdG/ga6Wee9PkLBz6VU7V62nTZsJcCWPcxxVmq0ajvrji1A7n63c0LHxp16yA
 NLXzGeIVonFAG2VKt4TBjZioaxpP3K9pxN4CrgtnCZPo0F+A790K53TNIfNsloqfenCc5WWxh
 OdKNMqbQ0XP40LCcRy4zExFkjTbAI180vSRpsXpU56LSQBCLng3/c59CGy7dJVR/uyek/AHU7
 K5uBG4mhoMe3aKgNP3GhjhvW3VPSLirINxoVWRHWY+UFKz9wqWR9S+RxOmzLM1Dnc9vCnIctL
 X46dfQNkRgBY9fAljjaa1mNNy3EHlfoMNYKv4vMfa15+D+qBFuwhnfWzwh6/3zqyCTalNV5aW
 MXJdvNPXu2NiPCpwnW7hmsEe6WmuXhNhyYOUhFYK4R8ECLOf3UwiZrDIel4bjZXG0E4Hwy8yl
 oZXORnVxfCirMOnaa6xDBcA638Sv8Ke+2FL+lWwdSe7Z4MSFdnFvjXudmfbWVIk7MUWxGuEAL
 9y2j/FZ0RyIOGKzX81ZgUXTKFD/qHZRgE6A/vzo0D17bcOL4eAzrzkUhnePBZDCa7OEBLRoR6
 TCAorcimFVC4LlHUeTpptQrL631KXhzngGHKDUYpL3Ue8MqNId3oDeYeGxAKz0qlbGCAs5GWa
 /8gJ+1TaX8Xqed4oZO/XiGrY743IwjjR5Sk5tAxEDvKz5FXtGebsO65gvxFBxCNvEHD3OZRXW
 0Jvc6KhYWxNkCAOcveFIW/rE9T+hjOciXS18rVb6LWCLx4tNwR5k1kAZy8I+xpnuBK2/08D/Z
 k6Jhxi1lyfPv75mtYloiD0e16KR4gWJmYnBSMNY1G3cofuM5594mKIu6SuE6hoxwIL/nFVPXK
 +QsINX/6hU/HI+G6jNSpyTjfbzWG/noTxgIT5wW0xi0Tdh+oTdS5jpNpfl6hBSLlogDSAELxO
 oYSpVV3fssYz3dBUCaRHXdX9KrZWXluL4+5Co8Wk04q2IZ4DRKSU8IS8Dtxwxegqp13wzReHB
 Ck/hk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.08.19 um 12:02 schrieb Mike Hommey:
> On Sun, Aug 25, 2019 at 04:10:55AM -0400, Jeff King wrote:
>> diff --git a/fast-import.c b/fast-import.c
>> index ee7258037a..1f9160b645 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1763,7 +1763,6 @@ static int read_next_command(void)
>>  		} else {
>>  			struct recent_command *rc;
>>
>> -			strbuf_detach(&command_buf, NULL);
>>  			stdin_eof =3D strbuf_getline_lf(&command_buf, stdin);
>>  			if (stdin_eof)
>>  				return EOF;
>> @@ -1784,7 +1783,7 @@ static int read_next_command(void)
>>  				free(rc->buf);
>>  			}
>>
>> -			rc->buf =3D command_buf.buf;
>> +			rc->buf =3D xstrdup(command_buf.buf);
>
> You could xstrndup(command_buf.buf, command_buf.len), which would avoid
> a hidden strlen.

xstrndup() also searches for NUL, albeit with memchr(3).  xmemdupz()
would copy without checking.

I suspect the simplicity of xstrdup() outweighs the benefits of the
alternatives, but didn't do any measurements..

Ren=C3=A9
