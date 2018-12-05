Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FF3211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 06:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeLEG5J (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:57:09 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:16245 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeLEG5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:57:09 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 438qKZ5Yldz5tlL;
        Wed,  5 Dec 2018 07:57:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6226020A8;
        Wed,  5 Dec 2018 07:57:06 +0100 (CET)
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com>
 <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
 <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
Date:   Wed, 5 Dec 2018 07:57:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.18 um 07:20 schrieb Elijah Newren:
> On Tue, Dec 4, 2018 at 7:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> Gah, when I was rebasing on your patch I adopted your sentence rewrite
>>> but forgot to remove the "sometimes".  Thanks for catching; correction:
>>
>>>
>>> -- 8< --
>>> Subject: [PATCH v2] git-rebase.txt: update note about directory rename
>>>   detection and am
>>>
>>> In commit 6aba117d5cf7 ("am: avoid directory rename detection when
>>> calling recursive merge machinery", 2018-08-29), the git-rebase manpage
>>> probably should have also been updated to note the stronger
>>> incompatibility between git-am and directory rename detection.  Update
>>> it now.
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>   Documentation/git-rebase.txt | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index 41631df6e4..ef76cccf3f 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -569,8 +569,12 @@ it to keep commits that started empty.
>>>   Directory rename detection
>>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> -The merge and interactive backends work fine with
>>> -directory rename detection.  The am backend sometimes does not.
>>> +The merge and interactive backends work fine with directory rename
>>
>> I am not sure "work fine" a fair and correct label, as rename is
>> always heuristic.
>>
>>      The "directory rename detection" heuristic in "merge" and the
>>      "interactive" backends can take what happened to paths in the
>>      same directory into account when deciding if a disappeared path
>>      was "renamed" and to which other path.  The heuristic produces
>>      incorrect result when the information given is only about
>>      changed paths, which is why it is disabled when using the "am"
>>      backend.
>>
>> perhaps.
> 
> The general idea sounds good.  Does adding a few more details help
> with understanding, or is it more of an information overload?  I'm
> thinking of something like:
> 
>       The "directory rename detection" heuristic in the "merge" and
>       "interactive" backends can take what happened to paths in the
>       same directory on the other side of history into account when
>       deciding whether a new path in that directory should instead be
>       moved elsewhere.  The heuristic produces incorrect results when
>       the only information available is about files which were changed
>       on the side of history being rebased, which is why directory
>       rename detection is disabled when using the "am" backend.

Please let me deposit my objection. This paragraph is not the right 
place to explain what directory renme detection is and how it works 
under the hood. "works fine" in the original text is the right phrase 
here; if there is concern that this induces expectations that cannot be 
met, throw in the word "heuristics".

Such as:
    Directory rename heuristics work fine in the merge and interactive
    backends. It does not in the am backend because...

-- Hannes
