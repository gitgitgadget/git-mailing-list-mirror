Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E24C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0FA2071C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDYM4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:56:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:51539 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYM4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:56:18 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSKLu-0009Ml-7K; Sat, 25 Apr 2020 13:56:14 +0100
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email>
Date:   Sat, 25 Apr 2020 13:56:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 25/04/2020 05:09, Sibi Siddharthan wrote:
> On Sat, Apr 25, 2020 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>>
>>> The goal would be to maintain a CMake build for Git keeping it in sync
>>> with the Makefile.
>>> The Makefile is not going to be replaced at all. The CMake script for
>>> now only supports Linux and Windows.
>>> It does not support BSD, Solaris and others, whereas the Makefile does
>>> support them.
>> So you are doing (1).  I already said that I feel that engineering
>> burden to divert resources for CMake support would be unacceptably
>> high.
>>
>> Whenever any of our developers need to add source files, Makefile
>> configuration knobs that people can add to config.mak, etc., you are
>> forcing them to figure out where in the CMakefile to add them or
>> devise ways to allow builders who do not use config.mak (because
>> they use CMake) to do similar tweaks.
>>
> Adding source files to the CMakefile is going to just as long as
> adding it to the Makefile,
> anyone can figure this out and this is not going to take much time at all.
While figuring these things out isn't /hard/ it can be tedious and time
consuming for those who are not familiar with the particular tool set
(as evidenced, in my mind, by the poor dev support for Git for Windows
because of the need to understand two operating systems and their
awkward interactions) - those that are familiar and understand the/their
whole tool set are usually the x10 folks.
>
> As for the configuration knobs I agree that adding the same to CMake
> is going to a bit longer.
> But anyone who is hacking Git is going to do it with the Makefile or
> (if accepted)CMake script, but not both while hacking.
> So they will continue to make progress with the system they feel comfortable in.
> They will only run into an issue when they try for a PR. Currently the
> CMake script is only used for generating the visual studio solution.
> We can add a (continue-on-error) to vs-build job to make this process
> less of a hindrance.
> If people take the time to hack Git, figuring out how to do the
> configuration knobs in the CMake script is not going to that much take
> time
> compared to the time they spend making Git better.
>
>
>> Any patch that is acceptable to the current project would become
>> unacceptable because they lack updates to CMake part, but I suspect
>> we do not have enough people who are so much devoted to give a good
>> review if updates to CMake part are added.  And it is unclear why it
>> would be beneficial to slow our existing developers down by forcing
>> them to become familiar with CMake.
>>
>> So..., I am not just "still not convinced", but I am even more
>> convinced that we do not want this series, after thinking about it
>> longer.
>>
>> Thanks.
>>

Is there a middle way, given that IIUC there is most benefit on the
Windows side, that on the git.git side the Makefile could contain a
suitable comment directing those interested in CMake to the relevant
part of Git-for-Windows. Is there a part that could hold, and track, the
matching changes to the primary Makefile? 

Are there tools that track and compare CMake and Make variants, or at
least indicate any divergences to help separately maintaining the CMake
series?
> Thank You,
> Sibi Siddharthan
--
Philip
