Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8762EC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E26611AC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhE3P0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 11:26:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39142 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhE3P0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 11:26:33 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lnNJ7-0000xI-7K; Sun, 30 May 2021 16:24:53 +0100
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Matt Rogers <mattr94@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
 <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
 <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
 <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
 <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
 <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e33bd72f-2095-f32d-5f4f-6137f6a12d22@iee.email>
Date:   Sun, 30 May 2021 16:24:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/05/2021 15:29, Sibi Siddharthan wrote:
> On Sun, May 30, 2021 at 6:52 PM Matt Rogers <mattr94@gmail.com> wrote:
>
>> I think the best middle of the line solution would be to just provide a manual
>> knob for turning vcpkg support on/off here and offer configurations in
>> CMakePresets.json for both situations.  The only downside here is that I believe
>> a lot of IDE's are aggressive about running the cmake configuration step and may
>> try to install vcpkg even if it is unnecessary.  But automatic
>> generation can generally
>> be turned off by users I guess.
> I agree. I would suggest vcpkg should be used by default for Windows platforms.
> This way IDE's won't complain and command line users can straight up
> disable this behaviour.
>
> Thank You,
> Sibi Siddharthan
I think so as well.

I'd started writing (draft) in reply to Matt

"I'd agree that knowledgable users should be able to control the
settings, however I'm against forcing less knowledgable users being
required to add extra control option for knobs they don't yet
understand, hence the desire to ensure a consistent (though possible
old-fashioned/backward-compatible) settings 'that just work' that do not
set in stone those choices, which would be the worst of both worlds!

It maybe that in some ways we may have missed the boat as those project
based CMakePresets.json presets (setting back to old defaults) could
'annoy' the (potentially) experienced users who are simply using the new
defaults. This doesn't affect (*) truly experience users who are setting
their desired options directly as they would/should override the presets."

My other consideration is that the build process should generate enough
of the right artefacts (e.g. a .sln etc). This is so that other typical
tools and extensions e.g. Sourcetrail which expects the .sln, but maybe
they'll also cope with Ninja/Cmake builds soon...

I'll have a go, though I'll be off-line for a while from ~Tuesday.

Philip

(*) - affect/effect?
https://www.londonschool.com/nordic/blogg/whats-difference-between-affect-and-effect-and-when-should-they-be-used/
