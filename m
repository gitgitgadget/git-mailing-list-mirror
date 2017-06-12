Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F0E20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdFLWcD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:32:03 -0400
Received: from mout.web.de ([212.227.17.11]:64936 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbdFLWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:32:03 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUWBb-1dScbo1xAJ-00RKuZ; Tue, 13
 Jun 2017 00:31:47 +0200
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
 <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
 <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
 <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c7532160-53eb-a0c5-94e6-483aadf0cfc5@web.de>
Date:   Tue, 13 Jun 2017 00:31:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rk8cpjElVr9yi/OlCuKpBtb9XKyM6OW+SRAcAU6ZVW5iu8z+iUi
 Rowji1O44qQGNz/fChx1wBBjyhpbjAY6eGRI2OeTabB3Muv0tUGBn1Z/9HJ7MNJOP0xK5LX
 sSETkSfBFPgfHrkTPRTG5w8omhbldbvjX4oGePeT3IvYDrogcOP1W6vuaAmdO9a4uBFkw7p
 FZexxqvMfNrOlZCYPPmgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yi4aEu++wzw=:X+i1SDIJvkLaR1neq0SHDv
 9CDcmzBWzTt8+yEtxpYl9kqSUrXW2EoUbLzZUnKsTzOWUZvKWk8ZDAWw9xpg6TvdCshAkV25c
 UZ3R8hw8f+bVskS0KxJVxujsKr45JZNlpFouakYPa/6NpNfez/OMV092rqWJ2KEgLVkKMCCm3
 WdyfqJ6WXLsOPfVNQPkJrIuGZ2aDnpflnLwZtkUdWzZOWFLnDS/izW2M/bb9k+ILU0B13JP6x
 oRckHZ0JLKXa6yRwKlwtvh4jwGn1ikPLOqUBUnktoK+ndOlHXV/LOL4uXw9v/1Sgq8olnzPXV
 XoopzRxjzxzyuarwDU3vFGsoDjq1kAqiEr8dwGFIEw+gC3rZ7+Mm/LwtGcgJwdI9R9hPkwjG1
 +1t3hQeZjy9nIA9D4MfrHN2D5rdMwQbN49gefHnXQlBDxg/HOHPpRt+1izxp/Ncv7FJKcl0AT
 0RMAUb4OkSoHp4GM2oTEGh6l2ZIk2LVmkk8LxZPNlkbdXNR1pm+xhPoA5YC3gJh6cTUYYztsf
 /OxQo1qb8BAPEO7wmC12LG1u/r2n/BggohplsiRVNOHFGbUem4b4IpJSZwWX6NCpoFUkXR5IO
 crhyOhH3qvXev1qeALZdZ3R36jDEQPaZiT7EgZAFP4q3wadu4mjoLsH8czr8dBVHlRSZB4NWQ
 peYEDWGzlOHcOM4KiWwNe0SNwC/tffEW3be1Lyj2idBpTYWFbKIyX73BIv3lVPIjCtqw1hA3G
 A4Ks6iofc9RMhNQsvxHtSiKcTqXYLUYsp9zm3J2K60V+eXL7uBQpBHiQ+onW+m8hOc2yzT+EV
 xmDZ0aD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.2017 um 21:02 schrieb Ævar Arnfjörð Bjarmason:
> I only ever use the time offset info to quickly make a mental note of
> "oh +0200, this guy's in Europe", or "oh -0400 America East". Having
> any info at all for %Z would allow me to easily replace that already
> buggy mapping that exists in my head right now with something that's
> at least a bit more accurate, e.g. I remember that +0900 is Japan, but
> I can't now offhand recall what timezones India is at.
> 
> Now, obviously we can't know whether to translate e.g. -0400 to New
> York or Santiago, but for the purposes of human readable output I
> thought it would be more useful to guess than show nothing at all. So
> for that purpose the most useful output of %Z *for me* would be just
> showing a string with the 3 most notable cities/areas, weighted for
> showing locations on different continents, e.g.:
> 
>    +0000 = Iceland, West Africa, Ittoqqortoormiit
>    +0100 = London, Lisbon, Kinshasa
>    ...
>    +0900 = Tokyo, Seul, Manokwari
>    ....
>    -0900 = San Francisco, Vancouver, Tijuana
>    ....
>    -0600 = Denver, Managua, Calgary
> 
> Then I could run:
> 
>      git log --date=format-local:"%Y[...](%Z)"
> 
> And get output like:
> 
>      commit 826c06412e (HEAD -> master, origin/master, origin/HEAD)
>      Author: Junio C Hamano <gitster@pobox.com>
>      Date:   Fri Jun 2 15:07:36 2017 +0900 (San Francisco, Vancouver,
> Tijuana etc.)
> 
>      Fifth batch for 2.14
>      [...]
>      commit 30d005c020
>      Author: Jeff King <peff@peff.net>
>      Date:   Fri May 19 08:59:34 2017 -0400 (New York, Havana, Santiago etc.)
> 
>          diff: use blob path for blob/file diffs
> 
> Which gives me a pretty good idea of where the people who are making
> my colleges / collaborators who are making commits all over the world
> are located, for the purposes of reinforcing the abstract numeric
> mapping with a best-guess at what the location might be, or at least
> something that's close to the actual location.

Half the time this would be off by a zone in areas that use daylight
saving time, or you'd need to determine when DST starts and ends, but
since that depends on the exact time zone it will be tricky.

You could use military time zones, which are nice and easy to convert:
Alpha (UTC+1) to Mike (UTC+12) (Juliet is skipped), November (UTC-1) to 
Yankee (UTC-12), and Zulu time zone (UTC+0).  Downside: Most civilians
don't use them. :)  Also there are no names for zones that have an
offset of a fraction of an hour.

> I'd definitely use a feature like that, and could hack it up on top of
> the current patches if there wasn't vehement opposition to it. Maybe
> the above examples change someone's mind, I can't think of a case
> where someone's relying on %Z now for date-local, or at least cases
> where something like the above wouldn't be more useful in practice
> than just an empty string, but if nobody agrees so be it :)

Personally I don't have a use for time information; dates alone would
suffice for me -- so I certainly won't hold you back.  But I don't see
how it could be done.

René
