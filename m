Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3351F991
	for <e@80x24.org>; Thu,  3 Aug 2017 22:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdHCWUI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 18:20:08 -0400
Received: from avasout05.plus.net ([84.93.230.250]:44707 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdHCWUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 18:20:07 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id smL41v00A18PUFB01mL6cX; Thu, 03 Aug 2017 23:20:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=wI-d8nvJRUojRqi51dgA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
 <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
 <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
 <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <50f77fb7-551c-e84b-9fef-5ed5194dc3a4@ramsayjones.plus.com>
Date:   Thu, 3 Aug 2017 23:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/08/17 22:07, Junio C Hamano wrote:
> Sahil Dua <sahildua2305@gmail.com> writes:
> 
>> Ah! I had skipped this reply from Ramsay earlier.
>>
>> On Tue, Aug 1, 2017 at 1:36 AM, Ramsay Jones
>> ...
>>>>  I personally do not think "branch --copy master backup" while on
>>>>  "master" that switches to "backup" is a good UI, and I *will* say
>>>>  "I told you so" when users complain after we merge this down to
>>>>  'master'.
>>>
>>> I wouldn't normally comment on an issue like this because I am
>>> not very good at specifying, designing and evaluating UIs (so
>>> who in their right mind would listen to me). ;-)
>>>
>>> FWIW, I suspect that I would not like using this interface either
>>> and would, therefore, not use it.
>>
>> Does that mean you'd use it when "branch --copy feature-branch
>> new-feature-branch" in the case when you would want to start working
>> on a new branch (to modify or experiment with your current feature
>> branch) on top of a branch keeping intact all the configuration and
>> logs?
> 
> I am not Ramsay, but your choice of branch names in your question,
> i.e. "branch --copy feature new-feature", is what we do not agree
> with in the first place, especially when we are *on* the "feature"
> branch.
> 
> We view "copy A B" as a way to make a back-up of A in B.  I.e. We
> want to keep working on A, but just in case we screw up badly, make
> a backup copy of A in B, so that we can recover by a "branch --move
> B A" later if needed.  So touching B is the last thing we want to do
> after "copy A B" operation---hence we do not want to switch to B.

I couldn't have said this better. ;-)

> That is not to say that you are wrong to wish to create a new
> branch, check it out and start working on it with a single command.
> We already have such a command all Git users are accustomed to,
> which is "git checkout -b new-feature-branch feature-branch".  

Indeed, I wouldn't think of doing anything else. (That may be
because I've been using git too long, of course).

> That existing command does not copy things other than the commit
> object name from "feature-branch", and I do not think it should by
> default.  But I do not think it is wrong to extend it with a new
> option (think of it as "checkout --super-b" ;-) to copy other things
> like branch descriptions etc.

Hmm, I've never felt the lack of copying any attributes from
the origin branch. So, I'm not convinced a "--super-b" is needed
(but if other people feel the need, then why not).

> So from that point of view, your new feature conceptually fits a lot
> better to "git checkout", and does not belong to "git branch".  That
> is why I do not think "git branch --copy A B" while you are on A
> should check out B after creating the copy.

I agree (but lukewarm on the --super-b idea). :-D

ATB,
Ramsay Jones


