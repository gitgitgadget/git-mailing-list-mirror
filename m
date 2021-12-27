Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA0C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 16:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhL0QnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 11:43:13 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:60530 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhL0QnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 11:43:12 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n1t5a-000Cgb-CN; Mon, 27 Dec 2021 16:43:11 +0000
Message-ID: <456ef68c-dd01-e781-6ff1-e351c39671f1@iee.email>
Date:   Mon, 27 Dec 2021 16:43:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Git internal command line parser
Content-Language: en-GB
To:     =?UTF-8?Q?Jo=c3=a3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Lemuria <nekadek457@gmail.com>, git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
 <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
 <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
 <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi João  & Lemuria,

On 25/12/2021 02:55, João Victor Bonfim wrote:
>> If you are on Windows, it gets even more interesting because all the
>> individual sub-commands are just hard links back to the single git.exe
>> that then links to those sub-command's code.
> That seems undesirable...
> I know operating otherwise would be even more complicated and might create undue complexity or diminish performance, but I guess that, if it works, don't mess with it.

The original question didn't say which OS was in use, and had hints that
roughly matched a common Windows user misunderstanding about how the Git
executables coped with the change of OS [1].

My description was a hint, rather than a detailed exposition about what
was happening there. As you note, performance is important.

>> And I likely will consider this "front-end to many separate
> executable apps" approach for my future large projects.
>
> Lemuria, please consider those points as, sometimes, what is great at performance might not help with scalability and other matters, therefore, as the designer/engineer of a software system, a choice must be made and an evaluation of the properties of each possibility is a necessity.
>
> Do with that what you will.
>
>> I'm also a beginner to C, not quite an expert at it.
> Practice programming a lot and never forget two things: [1] you are working with a man made machine, therefore its limitations and capabilities are by design, so you must consider them every step of the way when developing (like how computers send information, how computers process informations, how machine behaviour can be altered, abused or exploited through alteration of the environment or mechanism and through the use of sleight of hand). [2] Your code always has real life consequences and it is your moral responsibility to consider them and make sure that prejudice isn't codified into them.
>
> Those are my two tid bits about being a responsible and effective programmer.
>
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
>
> Em sexta-feira, 24 de dezembro de 2021 às 15:36, Philip Oakley <philipoakley@iee.email> escreveu:
>
>> On 24/12/2021 18:30, Lemuria wrote:
>>
>>> On 25/12/2021 2:13 am, Philip Oakley wrote:
>>>
>>>> On 24/12/2021 14:38, Lemuria wrote:
>>>>
>>>>> #=< TLDR: Where's the code for git's internal command line parser?
>>>>>
>>>>>> ===#
>>>>> I'm interested in the internals of git, more specifically it's command
>>>>>
>>>>> line parser.
>>>> One place to start is https://github.com/git/git/blob/master/git.c
>>> Wait, is all of Git just one big executable or are there many
>>>
>>> executables and `git` is just the front-end for accessing the
>>>
>>> separate git executables, such as say, the one for processing
>>>
>>> commits?
>> Yes, `git` is a front end.
>>
>> If you are on Windows, it gets even more interesting because all the
>>
>> individual sub-commands are just hard links back to the single git.exe
>>
>> that then links to those sub-command's code.

This (over simplified) explanation relates to the differences between
the OS approaches to the performance issues when creating new processes
and the like on Windows. Each OS has strengths and weaknesses.

>>
>>>>> Does Git use a library like getopt for it's command line handling, or
>>>>>
>>>>> does it use a custom parser?
>>>>>
>>>>> If possible, I would appreciate being redirected to the source code
>>>>>
>>>>> files that handle this.
>>>>>
>>>>> Sincerely,
>>>>>
>>>>> Lemuria
>>>> Philip
[1]
https://github.com/git-for-windows/build-extra/blob/main/ReleaseNotes.md?plain=1#L25

