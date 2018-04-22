Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38C91F424
	for <e@80x24.org>; Sun, 22 Apr 2018 16:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeDVQgu (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 12:36:50 -0400
Received: from avasout01.plus.net ([84.93.230.227]:42285 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeDVQgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 12:36:50 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id AHypfXUs9Fj1OAHyqfzkoK; Sun, 22 Apr 2018 17:36:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=COIEoyjD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Rjm4DnASR5o6qngI6LYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165618.GA30287@duynguyen.home>
 <a5dc36f7-fc79-46ba-7e73-e9473cf1aec9@ramsayjones.plus.com>
 <CACsJy8Cj57=p5nKH1T2UZmFbDv2d_JRO+GcAo29SAZcSxgKCkw@mail.gmail.com>
 <9303a7ef-5895-a974-84dc-98521be14793@ramsayjones.plus.com>
 <CACsJy8AcTkPgVavDo_nUZkwPAFy335j94BY=BwATHbv5sdvu=w@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9625f486-cbec-634f-10b6-f4b53a341b56@ramsayjones.plus.com>
Date:   Sun, 22 Apr 2018 17:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8AcTkPgVavDo_nUZkwPAFy335j94BY=BwATHbv5sdvu=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH3kNHezILOxx5R0FIVHapgkeY1fNY1ivSUU2skVGzONXJQAVMZRDxG4QM7xTD1uMGRUXActNRSLrNRUA8saVnOTVx1YfKbnvd1qaM4vEcdPgYWhzTMa
 81bwMJZdvNL3PIq3IYzGAftc525WUmL6hyx+84qLuaaVImHeq2yG/3la
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/04/18 17:12, Duy Nguyen wrote:
> On Sun, Apr 22, 2018 at 5:58 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>>> I think you need to try a little harder than this! ;-)
>>>
>>> Yeah. I did think about grepping the output but decided not to because
>>> of gettext poison stuff and column output in "git help". If we do want
>>> to test this, how about I extend --list-cmds= option to take a few
>>> more parameters? --list-cmds=common would output all common commands,
>>> --list-cmds=<category> does the same for other command category. This
>>> way we can verify without worrying about text formatting, paging or
>>> translation.
>>
>> Hmm, my immediate reaction would be to prefer my simple tests.
>> Yes, they are not exactly rigorous and they would be affected
>> by changing the help formatting, but they are effective. ;-)
>>
>> [I don't think the formatting would change that often, or at
>> all - whoever submits that patch would get to update the tests!]
> 
> Hmm.. for non-column output that's true. "git help" with column output
> should probably fine as well because even though we add more and more
> commands every month, these are not marked common (and unlikely so).
> So yeah I agree.
> 
>> What did you think about adding the BUG() checks?
> 
> I was thinking if there was a way to fail the build after running
> ./generate-cmds.sh and generating empty output but it does not sound
> easy to do. So yeah, BUG() checks sound good.

Yeah, failing the build would be preferable, but I didn't get
that far. ;-)

[BTW, I just applied your patch series to the 'next' branch
(I just couldn't be bothered to revert your last series from
the 'pu' branch, etc.) and, as expected, everything built OK,
passed the test-suite and 'git help' is working just fine.]

Thanks!

ATB,
Ramsay Jones

