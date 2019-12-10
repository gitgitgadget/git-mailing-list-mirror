Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E439C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA7420663
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 11:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfLJLWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:22:46 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:13885 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfLJLWq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 06:22:46 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iedbI-0002mm-83; Tue, 10 Dec 2019 11:22:44 +0000
Subject: Re: [PATCH 3/5] notes: extract logic into set_display_notes()
To:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
 <62543250c4ea0e0327f974cb90b294c60b525982.1575896661.git.liu.denton@gmail.com>
 <CAPig+cToM+sHj-C5N_F2F+5B3LTPLVf39_-kCSih_WkuBOV+mA@mail.gmail.com>
 <20191209191924.GA24159@generichostname>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <95295e75-7d8d-bc6e-c41f-dd52c9826dfe@iee.email>
Date:   Tue, 10 Dec 2019 11:22:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191209191924.GA24159@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Denton

On 09/12/2019 19:19, Denton Liu wrote:
> the "lockstep" thing was what I was going for. That's why I ended
> up using one monolithic function instead of several smaller ones. That
> way, the caller can just blindly pass in values and then use the values
> returned to set its own state (i.e. how 4/5 does it). Also, it would
> ensure that future developers using this function won't forget to set
> the corresponding show_notes variable to whatever value is appropriate.
>
> The reason why we can't accept `revs` is because this series attempts to
> stop depending on `revs` for the notes configuration entirely. That way,
> we can call git_config() before repo_init_revisions() since we won't
> need to have `revs` initialised.
>
> I considered accepting an `int *` instead of using the return value to
> make the intent more explicit but I didn't do that because the return
> value seemed easier to deal with.
Does your explanation: "this series attempts to stop depending on `revs` 
for the notes configuration entirely." need adding adding to the commit 
message? I.e. the "abstract away" phrase probably doesn't carry enough 
information/context.p

Maybe pick out some of the explanations for the commit message for 
future readers?

Philip
