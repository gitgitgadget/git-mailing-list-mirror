Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A71F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFKPQv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:16:51 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:32367 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbeFKPQu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:16:50 -0400
Received: from [192.168.2.240] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SOYpfBTVMpXFjSOYpf2wDk; Mon, 11 Jun 2018 16:16:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528730208;
        bh=oLfittG90sOpSd6N4clqxQcJrmJxsFStmXSXjUQeZLE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E0hyRAPxkDB+ZZX20pcWlUKG0O0ZQon86FarE5IQ01ZwxTqCEEO73yC4ILVr/XLTO
         V3Sn64wMmY13cQ0C14ZZ4D9SX1rIq0B6Tb9iAqczgTXNzXHLu/swktV1tcaZNbcUgL
         hniPWk/GZRjckuPncQcQFLw523V1qQKuckR7BwJE=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=pGLkceISAAAA:8 a=tt_xURjNAmxIXQZeC1wA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-rebase.sh: handle keep-empty like all other options
To:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050747.19726-1-newren@gmail.com>
 <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
 <CABPp-BF7POrGTRbVOZ-AGjRHKcpExMQcA4uSPvrRONbnG2CE8w@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7e3d71e6-ae97-f47b-382c-085f6a281792@talktalk.net>
Date:   Mon, 11 Jun 2018 16:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF7POrGTRbVOZ-AGjRHKcpExMQcA4uSPvrRONbnG2CE8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOpIyw8AkPywuQJLHY/ZvTXCDqZpENcawBtUJURIJte0oOE2JG1AgYU5cYmyECila3s8qz1FGH2qr6rCJCAPvC+S9Wmo7hqHgunahI9WdoexBgrWB99K
 yXy1oAALaCLOGfb020tPEHaQlsfW4V96xxza55HklSmGfYTHU6S6QhOdzAqwTJeNfg73DF5R0LtCfWXOlpBivC+Z+Xsu+l52sSUE5CI39tWIPoNOAigSZuCi
 OnTV/r/N4/BmqRCvPc4wBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/06/18 15:42, Elijah Newren wrote:
> Hi Phillip,
> 
> On Sun, Jun 10, 2018 at 12:26 PM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> On 07/06/18 06:07, Elijah Newren wrote:
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>    git-rebase.sh | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/git-rebase.sh b/git-rebase.sh
>>> index 40be59ecc4..a56b286372 100755
>>> --- a/git-rebase.sh
>>> +++ b/git-rebase.sh
>>> @@ -276,6 +276,7 @@ do
>>>                  ;;
>>>          --keep-empty)
>>>                  keep_empty=yes
>>> +               test -z "$interactive_rebase" &&
>>> interactive_rebase=implied
>>
>>
>> I think you need to wait until all the options have been parsed before
>> setting the implied interactive rebase in case the user specifies has
>> '--keep-empty' in an alias and specifies '--no-keep-empty' with some am
>> options on the command line.
> 
> Ah, indeed you are right.  Let's drop this patch then.
> 
> However, we have a bigger problem with empty commits, in that there
> are really three modes rather than two:
>    * Automatically drop empty commits (default for am-based rebase)
>    * Automatically keep empty commits (as done with --keep-empty)
>    * Halt the rebase and tell the user how to specify if they want to
> keep it (default for interactive rebases)
> 
> Currently, only the first option is available to am-based rebases, and
> only the second two options are available to interactive-based
> rebases.  

I'm not sure that's the case, my understanding is that for an 
interactive rebase unless you give '--keep-empty' then any empty commits 
will be commented out in the todo list and therefore dropped unless 
they're uncommented when editing the list. The third case happens when a 
commit becomes empty when it's rebased (i.e. the original commit is not 
empty), I'm not sure what the am backend does for this. cherry-pick has 
'--keep-redundant-commits' for this case but that has never been added 
to rebase.

Best Wishes

Phillip

But if we want to make all three available to
> interactive-based rebases, what should the command line option look
> like?  --empty={drop,ask,keep}?
> 
> (And deprecate but continue to support --[no-]keep-empty?)
> 
> And should the two rebase modes really have a different default?  What
> should the default be?
> 

