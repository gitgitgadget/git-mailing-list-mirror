Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973971F404
	for <e@80x24.org>; Wed, 18 Apr 2018 18:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRSEF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 14:04:05 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:30037 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeDRSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 14:04:04 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 8rR3fhtLDLjjA8rR3fWYsj; Wed, 18 Apr 2018 19:04:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524074643;
        bh=SiJppld6vUuSGTmTGByS0IuxZdHX6yzG1ZISgU+NLgI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cdu4yCRt37MYmj9Hfl4AmpeDUqjWREI/ZqLpnxUOXhpY66fd3BHJN2/lqexav/2bs
         OYgx+H8zqFDuGXaks1zUaXzBelYyGUmI5oAYygec8a9/UO00/oiad0F3TBdvD6tUcR
         wgrq2z+9bpBVozdBSX/Wg3r4y9rdnZ0jorrP1T9s=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=dJwqgKVgLEQAiJrPjcgA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 05/15] sequencer: introduce the `merge` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <8a5ae61f603df8d8cb19268e1b8470f0a4993445.1523362469.git.johannes.schindelin@gmx.de>
 <55216d0b-cb37-6514-7f80-91f4617c105d@talktalk.net>
 <85232331-97a0-7989-e095-854ed962c7a0@talktalk.net>
 <nycvar.QRO.7.76.6.1804140248110.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <66b0b2e6-11b6-20f9-da6b-211c9c4dc758@talktalk.net>
Date:   Wed, 18 Apr 2018 19:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804140248110.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOg4bmK4vRrQ1dRv10Ag2+7QIWvcPDMp4M56IjYXOrCoVE/nlVnFBuKCo/bZg+fkZoTDe/gp9F/Uw1q9ZdP6RJmV11BY33iCsbuhDoaUZs3L/PhkXaai
 jRSWtAYVPlTr+Z00S3YlpOQtxOqJ9eWA6G2M4K2pwSHBRNSGRqxXYq2dcfOct2X5anGei0YvEmwCBnN9yFtiLkAg+Hh+lrUi7y+xcs3fHXOdm6XkTEq3TgIO
 85pv3l6zW8cM5Le9UgnVybOPPJ6gfm9QA1geSdB50ZN0egVpfl53vMtIDmEJCyp4bPncESjjGOvBt+QtggGfzjWFI624WVcAoHpp9M2YCS20cFIF325+/wiN
 IIbo3IV5Cy1QgevIq0kYpcSoHA5L9B1VdE8Q0CjikjLVnFDp1Y5nNNZcFaxla9I0o/pIha9UJv/XVYxj7Gfj5mHT9JwhnYDrYhzNJcVUqyoFRRkbyeVq330g
 Bt5lM/uP6EgZHRrRRRVce9XkZHhxcWgIVW624g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/18 01:51, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 13 Apr 2018, Phillip Wood wrote:
> 
>> On 13/04/18 11:12, Phillip Wood wrote:
>>> @@ -3030,7 +3029,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>>>  			return error(_("unknown command %d"), item->command);
>>>  
>>>  		if (res < 0 && (item->command == TODO_LABEL ||
>>> -				item->command == TODO_RESET)) {
>>> +				item->command == TODO_RESET ||
>>> +				item->command == TODO_MERGE)) {
>>
>> Unfortunately it's not as simple as that - we only want to reschedule if
>> merge_recursive() fails, not if run_git_commit() does.
> 
> Correct. How about introducing a flag `reschedule` that is passed to
> do_label(), do_reset() and do_merge()?

That would work (I was thinking about using return codes but having a
parameter is a better idea). Do you want me to re-roll the fixups or are
you happy to make the changes in your next version?

> 
> Seeing as do_reset() and do_merge() already have a replay_opts parameter,
> we could add a field `needs_rescheduling` and pass the replay_opts also to
> do_label().

I'm slightly wary of putting state in an options structure but maybe it
doesn't matter.

Best Wishes

Phillip

> Ciao,
> Dscho
> 

