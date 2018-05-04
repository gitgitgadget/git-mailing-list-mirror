Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75404200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEDPhG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:37:06 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35619 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbeEDPhF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:37:05 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id Eclaftl90QrTpEclbftUly; Fri, 04 May 2018 16:37:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ZIX5Z0zb c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=1uYjF--Pvy0ss5Jze2YA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <019cce70-c109-496e-e043-c471dcb21e00@ramsayjones.plus.com>
Date:   Fri, 4 May 2018 16:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEfOOyvF0frIQ4dJ+R+z6qRjMJJfr6K/5lvKjoaCA3UspdJk70ATAkzOjeY/AEsV2zEFfasCTcd80xPFDYyLflESM6YmyapHIzLsXCskjm92xUmQzF7A
 KOFY69hyivMaE/ir4NmNMREciUc/9LZsxORjfnglMZfrbh48ujWsR5Mq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/05/18 07:40, Johannes Schindelin wrote:
[snip] 
> BTW I ran `make sparse` for the first time, and it spits out tons of
> stuff. And I notice that they are all non-fatal warnings, but so were the
> ones you pointed out above. This is a bit sad, as I would *love* to
> install a VSTS build job to run `make sparse` automatically. Examples of
> warnings *after* applying your patch:
> 
> connect.c:481:40: warning: incorrect type in argument 2 (invalid types)
> connect.c:481:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
> connect.c:481:40:    got struct sockaddr *ai_addr
> 
> or
> 
> pack-revindex.c:65:23: warning: memset with byte count of 262144
> 
> What gives?

My stock answer, until recently, was that you are using a very
old version of sparse. Which is probably still true here - but
I recently noticed that more up-to-date platforms/gcc versions
also have many problems. (The main sparse contributors tend to
stick with conservative distros and/or don't use sparse on any
software that uses system headers - thus they tend not to notice
the problems caused by new gcc/glibc versions! ;-) )

Since I am on Linux Mint 18.3 (based on the last Ubuntu LTS) and
build sparse from source, the current 'master', 'next' and 'pu'
branches are all 'sparse-clean' for me. (On cygwin, which is
built with NO_REGEX, I have a single sparse warning).

I was just about to say that, unusually for me, I was using a
sparse built from a release tag, but then remembered that I have
some additional patches which fixes a problem on fedora 27!
Using sparse on fedora 27 is otherwise useless. (There are still
many warnings spewed on f27 - but they are caused by incorrect
system headers :( ).

The current release of sparse is v0.5.2, which probably hasn't
been included in any distro yet (I think the previous release
v0.5.1, which should also work for you, is in Debian unstable).
If you wanted to try building a more up-to-date sparse, the repo
is at: git://git.kernel.org/pub/scm/devel/sparse/sparse.git.

Linux Mint 19, which will be released in about a month, will be
using the Ubuntu 18.04 LTS as a base, so I guess it is possible
that I will need to debug sparse again ...

BTW, I spent some time last night playing with 'git-branch-diff'.

First of all - Good Job! This tool will be very useful (thanks
also go to Thomas, of course).

I noticed that there seemed to be an occasional 'whitespace error'
indicator (red background) directly after an +/- change character
which I suspect is an error (I haven't actually checked). However,
this indicator disappears if you add the --dual-color option.

Thanks!

ATB,
Ramsay Jones
