Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579C520259
	for <e@80x24.org>; Tue,  6 Dec 2016 23:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbcLFXkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:40:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:54100 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbcLFXkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:40:32 -0500
Received: from [192.168.178.43] ([188.108.240.182]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmKOI-1cnCCP19IA-00ZuHc; Wed, 07
 Dec 2016 00:40:27 +0100
Subject: Re: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function
 in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
 <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net>
 <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <58ab6600-5ac2-9e7d-7cf0-452db40d5f6b@gmx.net>
Date:   Wed, 7 Dec 2016 00:40:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yZLlkU6li+LZcAYJ+0fLeQMBPrjJ6E3eTWeLZpDhn++VIysL87I
 dpeobJOD17vppJzZN1oQak5gJlBq/6e90vvjBSXBNek5eXqhQ5sGKcA54nem1o5RlAx1PxD
 ljQ/uOxY9RUAfKT8oYwhLf28Q31mEPJ2coCfSfihozcQVam2Gno+D5PDs4PADMivGsjvgGD
 1ZrUEoclPmRX5LkGcU6Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PGV9zWc4yYg=:edTb60FJHx0BbusRskbs5l
 /+Z+0Uzcmu5d8Ft2sKvs32KmPFqwdO8ksrBQZ/1c0sTSaivsv4pUMncnSS5zOrZrncanYwTA8
 DvWT+FsMU3pjVhAlM/MTzFn9+qeJX9H6nxYZqsUt5KtvYnNK2x7l9GcXcrtQEksi5fQ04F56g
 5FzPhNVsw2mDO20oSCaLlASS4fTf7mqgF47Q7Uw+4JdsjjtLgP+uA9JaTzals125drzIh17ua
 PCqtExQqbMmxUlX9RK+SoOqeQ5u6J38SSRJubfTPtINjBUOcgFbclE+N3uMtjnKmcmMGCNCK/
 yFgRvMABoZrDuiw/xupIKmjbRj3gAcSrjxwVh40rSP0ogWJue9Id2QJ7HsCxAbt6FoAxJPcif
 5C6CV/a3Uc6Ox7U4n/cY4IwHfiuORk/TU3zqqhTmadb40U51SjRpMr1dci3JUbBXAX0NbnQvE
 5k9afnYen9Q/u8lhRxb7VUy06pTGX9g0iLXI5gnx3TtdIlPd/1mz1qHw8VpJLtc8WcMfGyjHm
 1O9OjDZnx6ML2ro13L8Uq5saWiavgxw+7UfemSbPHjcBZR+BEjxwr3fgUc+lshRIyXv3qGNI/
 6WHs38mCAio4grsJFKTmd+Ra+9mKbuiLrC+yqMbAvB241AbwKrdLQ2Qrs6ttLa1PoXjysbFp3
 omuHZXAMCBJk+RGTTf3nJkziOcbXXcySXGuSkDMK2j1ApZYbAkGptuDdmQ0CIMJJgD4uCOngj
 nzp2cP7e+evxW+VRo9MzGKGliz+qYaWNesgxE9KwH3AVySXElM6YcVg2CqThl+IOtqbRTL+kw
 fu/UK97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit and Christian and Lars ;)

On 12/07/2016 12:02 AM, Pranit Bauva wrote:
> On Tue, Nov 22, 2016 at 6:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> Okay Pranit,
>>
>> this is the last patch for me to review in this series.
>>
>> Now that I have a coarse overview of what you did, I have the general
>> remark that imho the "terms" variable should simply be global instead of
>> being passed around all the time.
> 
> In a personal conversation with my mentors, we thought it is the best
> fit to keep it in a struct and pass it around so that it is easier in
> libification.

I guess you had that conversation at the beginning of the project and I
think that at that stage I would have recommended it that way, too.

However, looking at the v15 bisect--helper.c, it looks like it is rather
a pain to do it that way. I mean, you use the terms like they were
global variables: you initialize them in cmd_bisect__helper() and then
you always pass them around; you update them "globally", never using
restricted scope, never ever use a second instantiation besides the one
of cmd_bisect__helper(). These are all signs that *in the current code*
using (static) global variables is the better way (making the code simpler).

The libification argument may be worth considering, though. I am not
sure if there is really a use-case where you need two different
instantiations of the terms, *except* if the lib allows bisecting with
different terms at the same time (in different repos, of course). Is the
lib "aware" of such use-cases like doing stuff in different repos at the
same time? If that's the case, not using global variables is the right
thing to do. In any other case I can imagine, I'd suggest to use global
variables.

~Stephan
