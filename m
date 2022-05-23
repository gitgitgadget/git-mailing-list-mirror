Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DAC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiEWPTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiEWPTg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:19:36 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0715DA2F
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:19:34 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nt9qF-0004NN-Bw;
        Mon, 23 May 2022 16:19:32 +0100
Message-ID: <96cd59ea-ea75-e33e-758f-abe16f9cca0f@iee.email>
Date:   Mon, 23 May 2022 16:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Git commands version documentation
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
 <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email> <xmqqr14l87jp.fsf@gitster.g>
 <3067d8e3-15a7-75fc-20d7-90de0fc3fee6@iee.email>
 <220523.861qwkz8kp.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220523.861qwkz8kp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 23/05/2022 14:08, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 23 2022, Philip Oakley wrote:
>
>> Hi Junio,
>>
>> On 23/05/2022 00:35, Junio C Hamano wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>> One manual method is to look at the history (blame) for the respective
>>>> man pages to see when the man page was initially committed, and when
>>>> appropriate options were added.
>>>>
>>>> Maybe use one of the hosting providers GUI if that is your choice e.g.
>>>> https://github.com/git/git/blame/master/Documentation/git-gc.txt
>>> I got an impression that blame/log is an overkill for the request,
>>> which asks for "what tagged version?", to which the answer would be
>>> to compare the manual pages for each release (or scan the release
>>> notes), perhaps?
>>>
>>>
>> I was also concerned as to which way the problem was being addressed:
>> was it a need for a cross reference table for all commands, or was it 
>> for just a select few?
>>
>> For me, who likes a good UI, I found the GitHub blame UI quite useful
>> when looking at files from the latter direction. It was much easier to 
>> scan the blame for the command's documentation page than try and scan
>> through the endless release notes. Obviously this does expect that our 
>> documentation is fairly complete, at least at the 'mention an option'
>> level, even if the occasional nuance didn't reach the docs.
>>
>>
>> I can see that a cli terminal representation is likely to be harder to
>> scan, and that some hosters don't provide a blame page, so it would be
>> a 'horses for courses' choice.
> I think asking a git user to use "git blame" on our own source code is a
> non-starter in terms of where we'd like to eventually get. 

"we?"
> It's not very
> friendly, especially in the case of something like the log-family where
> option parsing is implemented over more than one file.

I think you've picked up the wrong essence of my answer, which was to
Hrushikesh's question that asked "how could _they_ find out when various
_particular_ maintenance commands (and by implication some options) were
released?". It wasn't any all-singing all-dancing solution to some other
problem, as I understood it.
>
> Likewise some built-ins don't map to builtin/<name>.c, and all that is
> assuming a lot about the user knowing where to look.
>
> I think what the OP here really would like is something similar to
> Perl's "corelist(1)" but for Git. I.e. a meta-command you can ask to
> tell you what version introduced a given git sub-command, or even option
> for that command etc.

corelist(1) is not something I'm familiar with, but looks like it might form the basis for a discussion about such a UX interface.

>
> Alternatively (or perhaps in addition to that) we could aim to document
> this sort of thing, e.g. have an "INTRODUCED IN" section or similar in
> the command documentation, or a similar blurb when we discuss various
> options.
>
> I have tried to add these sorts of mentions for some past changes,
> e.g. the "<refspec>" section in git-fetch(1) is one example (search for
> "Git version 2.20").
>
> I think we could do with more of that sort of thing. One difficulty with
> doing this in git in particular is that (moreso than most other
> projects) when you submit a patch you can't be very certain about what
> release it's going to be in, i.e. it might end up cooking for many weeks
> & past a release window.
>
> But in any case, I think adding this as a first-class feature (perhaps
> to "git help") would be very useful, and it could be done in some way
> that wouldn't be a pain to maintain.

That "wouldn't be a pain to maintain" is probably the core of any such
design..
>
> E.g. we could carry a text file in our sources with a list of what
> commands existed at what versions, and what options they had (as
> extracted from the parse-options reflection mechanism). Rather than
> manually maintain such a list we could carry a script to that would
> attempt to build past releases, for any that were missing we'd attempt
> to build them and fill in the gaps.

Implicit in this is the choice between parsing the code, or the
documentation, to determine when options started appearing.
>
> We could thus make this something (if Junio were willing) that would be
> a relatively small addition to pre-release preparations.
>
> For releases that couldn't be built anymore we could either manually
> fill in the data, or just not care. What exact version older than 1.8
> introduced some command or option is something probably nobody cares
> about at this point.
>
> But it is *really useful* when scripting against git to know what
> recent-ish release something was introduced in, especially so if we'd
> helpfully annotate which releases were known to have been part of major
> distro releases, such as RHEL major releases, or OSX's Apple Git etc.
In some ways it sounds very similar to the i18n efforts where the
'database' grows with every release. Though capturing the historic
release progression is probably the hardest part.

--
Philip


