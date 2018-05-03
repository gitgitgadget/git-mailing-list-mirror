Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63F9200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeECXUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:20:36 -0400
Received: from avasout04.plus.net ([212.159.14.19]:58912 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeECXUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:20:35 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id ENWbfEW0hsD7bENWcfYts1; Fri, 04 May 2018 00:20:34 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=2n58R_0RtYmMY4ZSkEsA:9 a=QEXdDO2ut3YA:10
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
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
Date:   Fri, 4 May 2018 00:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHIq+HXFfuVQpAJR8YDRRGYTIjEqLNlOQ2kUC6bCmpOSmnAw0fEmxSfhARh5Yuz50MjVathfKlC6E8v4S1GSls3fdshLP8KOXzIjEcyjzt0u41U0Ezm4
 Fz41g7tL03R4g5AIb0C9H5FWoCYP8uhmh0TXeJuBaONQu57mPZ/NVuLBBFL3P+KmZ6EuapYOYNcnbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/05/18 21:25, Johannes Schindelin wrote:

> On Thu, 3 May 2018, Ramsay Jones wrote:

>> On 03/05/18 16:30, Johannes Schindelin wrote:
[snip]

>>> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
>>> new file mode 100644
>>> index 00000000000..97266cd326d
>>> --- /dev/null
>>> +++ b/builtin/branch-diff.c
>>> @@ -0,0 +1,40 @@
>>> +#include "cache.h"
>>> +#include "parse-options.h"
>>> +
>>> +static const char * const builtin_branch_diff_usage[] = {
>>> +	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
>>
>> s/rebase--helper/branch-diff/
> 
> Whoops!
> 
> BTW funny side note: when I saw that you replied, I instinctively thought
> "oh no, I forgot to mark a function as `static`!" ;-)

Heh, but I hadn't got around to applying the patches and building
git yet! ;-)

Sparse has two complaints:

  >     SP builtin/branch-diff.c
  > builtin/branch-diff.c:433:41: warning: Using plain integer as NULL pointer
  > builtin/branch-diff.c:431:5: warning: symbol 'cmd_branch_diff' was not declared. Should it be static?

I suppressed those warnings with the following patch (on top
of these patches):

  $ git diff
  diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
  index edf80ecb7..1373c22f4 100644
  --- a/builtin/branch-diff.c
  +++ b/builtin/branch-diff.c
  @@ -1,4 +1,5 @@
   #include "cache.h"
  +#include "builtin.h"
   #include "parse-options.h"
   #include "string-list.h"
   #include "run-command.h"
  @@ -430,7 +431,7 @@ static void output(struct string_list *a, struct string_list *b,
 
   int cmd_branch_diff(int argc, const char **argv, const char *prefix)
   {
  -       struct diff_options diffopt = { 0 };
  +       struct diff_options diffopt = { NULL };
          struct strbuf four_spaces = STRBUF_INIT;
          int dual_color = 0;
          double creation_weight = 0.6;
  $ 

The first hunk applies to patch 02/18 (ie this very patch) and
the second hunk should be applied to patch 05/18 (ie, "branch-diff:
also show the diff between patches").

ATB,
Ramsay Jones


