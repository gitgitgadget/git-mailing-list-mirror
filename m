Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DBFC43217
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 11:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiC1L0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbiC1LYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 07:24:09 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746956224
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 04:21:48 -0700 (PDT)
Received: from host81-151-89-225.range81-151.btcentralplus.com ([81.151.89.225] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nYnRS-000213-4R;
        Mon, 28 Mar 2022 12:21:46 +0100
Message-ID: <1cb32296-6b46-0a0e-76c6-3d9fbbf7b21d@iee.email>
Date:   Mon, 28 Mar 2022 12:21:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Possible issue with rebase's --rebase-merges option
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Joel Marshall <joelmdev@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
 <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com>
 <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
 <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
 <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet>
 <CAK1xKQpTUqLLZkYuFEOx7zy8wOib_ohwmiqt89qoj-rK8tnZ4A@mail.gmail.com>
 <CAK1xKQqGTmgGBH4TY2mpHZLit_49FDoEq2EewDE-v_fc2=ikYA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203241440130.388@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2203241440130.388@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On 24/03/2022 13:42, Johannes Schindelin wrote:
> Hi Joel,
>
> please reply inline. What you did is called "top-posting" on this list and
> is regularly discouraged.
>
> On Tue, 22 Mar 2022, Joel Marshall wrote:
>
>> I have confirmed that this is still an issue under certain
>> circumstances. --rebase-merges works as expected if it is being used
>> with simple feature branches, ie one commit after the other, no
>> merges. Where things go off of the rails is when there are branches
>> and merges coming off of and going into a feature branch. At that
>> point using the --rebase-merges flag with rebase will create a similar
>> mess to the images of the logs I attached back in July of 2022.
> I wonder what happened to my suggestions to use
> `--rebase-merges=rebase-cousins` or `git fast-export --anonymize`. They
> seem to have faded without any echo.
>
> Ciao,
> Johannes
>

The rebasing of merges can be confusing, with the different perspectives 
(mental models) about which line of development the merges arrive from.

In support of Johannes' note, the stack overflow Q&A [1] does contain 
some nice diagrams showing the different ways that a history can be 
interpreted, and the effect that "cousins" have on the picture 
(understanding not helped by many colloquial familial uses of 'cousins' 
that are not technically correct ;-).

Your case of two parallel lines of development, with merges from one to 
the other, being rebased from the original fork-point, does look to fit 
that 'difference of mental model' confusion.

Does that SO Q&A help clarify the situation. If you are able to create a 
similar simplified hierarchy (e.g. cut out the long linear sections) of 
your scenario then it becomes easier to help.

Philip
[1] 
https://stackoverflow.com/questions/56529435/what-is-the-behavior-of-the-cousins-options-in-git-rebase-rebase-merges
>> On Wed, Dec 8, 2021 at 3:46 PM Joel Marshall <joelmdev@gmail.com> wrote:
>>> Hi all,
>>>
>>> Sorry to drop off on this for so long. I think this is still a
>>> possible outstanding issue, yes? If so I will work on getting you a
>>> copy of the repo as I did archive a copy at the state originally
>>> mentioned in this issue.
>>>
>>> On Mon, Aug 10, 2020 at 10:46 AM Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>> Hi Joel,
>>>>
>>>> On Thu, 23 Jul 2020, Joel Marshall wrote:
>>>>
>>>>> I saved the state of the repo in a copy so I could come back to it if
>>>>> additional examples were needed but I had to clean up my live copy so
>>>>> I could get back to work. I'll get you some additional screenshots in
>>>>> the next few days. In the meantime, I'll try to give you some context
>>>>> around what I'm doing here. The parent branch is my main dev branch
>>>>> which consists of a series of clean branches and merges- the dev
>>>>> branch basically looks like what you're seeing in the
>>>>> --preserve-merges screenshot. I've also got a long running feature
>>>>> branch that branches off of dev, and it also consists of many branches
>>>>> and merges, each a subtask of the story related to the feature branch
>>>>> as a whole. Occasionally to get the feature branch up to date with the
>>>>> newest features I'll rebase the whole thing on top of dev, which
>>>>> should result in an unbroken chain of branches and merges as seen in
>>>>> the --preserve-merges screenshot. While you can't see it in the
>>>>> --rebase-merges screenshot, those merges show no ancestors when viewed
>>>>> in reverse chronological order- they just trail off into oblivion.
>>>> I could imagine that you might want to try this rebase with
>>>> `--rebase-merges=rebase-cousins`.
>>>>
>>>> Otherwise, you might want to export your use case with `git fast-export
>>>> --anonymize` so that others (such as myself) have a chance of helping you.
>>>>
>>>> Ciao,
>>>> Johannes

